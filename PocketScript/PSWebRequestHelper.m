//
//  PSWebRequestHelper.m
//  PocketScript
//
//  Created by Andrew Brandt on 10/24/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import "PSWebRequestHelper.h"
#import "RxOrder.h"

@implementation PSWebRequestHelper

static PSWebRequestHelper *singleton;
static NSString* const URL_STRING = @"http://10.2.14.247:3000/object/";

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.manager = [AFHTTPRequestOperationManager new];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    return self;
}

- (void)postNewRxOrder: (RxOrder *)order {

    /*
    NSURL *url = [NSURL URLWithString:URL_STRING];
    NSData *payload;
    //needs to build payload from order object
    
    payload = [order rxImageFront];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"POST"];
    //needs content-type
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *dataTask = [urlSession uploadTaskWithRequest:request fromData:payload completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        
        if (responseStatusCode == 200 && data) {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                //notify completion
            });
        }
    }];
    [dataTask resume];
    */
    NSDictionary *parameters = [NSDictionary dictionary];
    
    [self.manager POST:URL_STRING parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:[order rxImageFront] name:@"rxFront" fileName:@"rxFront.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:[order rxImageBack] name:@"rxBack" fileName:@"rxBack.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:[order insuranceImageFront] name:@"insuranceFront" fileName:@"insuranceFront.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:[order insuranceImageBack] name:@"insuranceBack" fileName:@"insuranceBack.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - TODO provide correct dispatch method for singleton initialization

+ (instancetype)sharedInstance {
    if (!singleton) {
        singleton = [PSWebRequestHelper new];
    }
    return singleton;
}

@end
