//
//  PSRxOrderDetailViewController.h
//  PocketScript
//
//  Created by Andrew Brandt on 10/8/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RxOrder;

@interface PSRxOrderDetailViewController : UIViewController

@property (nonatomic, strong) RxOrder *order;

@end
