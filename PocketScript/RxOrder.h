//
//  RxOrder.h
//  PocketScript
//
//  Created by Andrew Brandt on 10/8/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RxOrder : NSManagedObject

@property (nonatomic, retain) NSString * deviceTokenString;
@property (nonatomic, retain) NSNumber * hasInsurance;
@property (nonatomic, retain) NSData * insuranceImageBack;
@property (nonatomic, retain) NSData * insuranceImageFront;
@property (nonatomic, retain) NSData * rxImageBack;
@property (nonatomic, retain) NSData * rxImageFront;
@property (nonatomic, retain) NSDate * submitTimestamp;
@property (nonatomic, retain) NSNumber * orderStatusInt;
@property (nonatomic, retain) NSString * orderId;

@end
