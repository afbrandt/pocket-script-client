//
//  PSWebRequestHelper.h
//  PocketScript
//
//  Created by Andrew Brandt on 10/24/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class RxOrder;

@interface PSWebRequestHelper : NSObject<NSURLSessionDelegate>

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

- (void)postNewRxOrder: (RxOrder *)order;
+ (instancetype)sharedInstance;

@end
