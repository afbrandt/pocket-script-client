//
//  PSRxOrderTableViewCell.h
//  PocketScript
//
//  Created by Andrew Brandt on 10/13/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSRxOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *timestamp;
@property (nonatomic, strong) IBOutlet UILabel *status;

@end
