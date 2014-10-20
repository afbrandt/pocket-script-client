//
//  PSRxOrderDetailViewController.m
//  PocketScript
//
//  Created by Andrew Brandt on 10/8/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import "PSRxOrderDetailViewController.h"
#import "RxOrder.h"

@interface PSRxOrderDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *rxImageFront;

@end

@implementation PSRxOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rxImageFront.image = [UIImage imageWithData:[self.order rxImageFront]];
}

@end
