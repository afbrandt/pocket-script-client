//
//  PSNewRxViewController.m
//  PocketScript
//
//  Created by Andrew Brandt on 10/8/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "PSNewRxViewController.h"
#import "PSWebRequestHelper.h"
#import "AppDelegate.h"
#import "RxOrder.h"

@interface PSNewRxViewController ()

@property (nonatomic, assign) BOOL isCapturingRx;
@property (nonatomic, assign) BOOL isCapturingInsurance;
@property (nonatomic, assign) BOOL isCapturingFront;

@end

@implementation PSNewRxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    self.order = [NSEntityDescription insertNewObjectForEntityForName:@"RxOrder" inManagedObjectContext:self.context];
}

#pragma TODO - validate all images have been provided

- (IBAction)submitRxOrder:(id)sender {
    NSError *error;
    [self.order setSubmitTimestamp:[NSDate date]];
    [self.context insertObject:self.order];
    [self.context save:&error];
    
    //web request initiated here
    [[PSWebRequestHelper sharedInstance] postNewRxOrder:self.order];
}


#pragma mark - Image capture methods

- (IBAction)captureInsuranceCard:(id)sender {
    self.isCapturingFront = YES;
    self.isCapturingInsurance = YES;
    self.isCapturingRx = NO;
    [self useCamera:sender];
}

- (IBAction)captureRxImage:(id)sender {
    self.isCapturingFront = YES;
    self.isCapturingInsurance = NO;
    self.isCapturingRx = YES;
    [self useCamera:sender];
}

- (void) useCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
           UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
           imagePicker.delegate = self;
           imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
           imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
           imagePicker.allowsEditing = NO;
           [self presentViewController:imagePicker animated:YES completion:nil];
     }
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
   NSString *mediaType = info[UIImagePickerControllerMediaType];

   [self dismissViewControllerAnimated:YES completion:nil];

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        if (self.isCapturingRx && !self.isCapturingFront) {
            [self.order setRxImageBack: UIImageJPEGRepresentation(image, 0.05f)];
        }
        else if (self.isCapturingRx && self.isCapturingFront) {
            [self.order setRxImageFront: UIImageJPEGRepresentation(image, 0.05f)];
        }
        if (self.isCapturingInsurance && !self.isCapturingFront) {
            [self.order setInsuranceImageBack: UIImageJPEGRepresentation(image, 0.05f)];
        }
        else if (self.isCapturingInsurance && self.isCapturingFront) {
            [self.order setInsuranceImageFront: UIImageJPEGRepresentation(image, 0.05f)];
        }
        
        //quick and dirty follow up to take back
        if (self.isCapturingFront) {
            self.isCapturingFront = NO;
            [self useCamera:nil];
        }
    }
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
   if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
           initWithTitle: @"Save failed"
           message: @"Failed to save image"
           delegate: nil
           cancelButtonTitle:@"OK"
           otherButtonTitles:nil];
        [alert show];
   }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
   [self dismissViewControllerAnimated:YES completion:nil];
}

@end
