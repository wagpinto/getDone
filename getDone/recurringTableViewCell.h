//
//  recurringTableViewCell.h
//  getDone
//
//  Created by Wagner Pinto on 4/18/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recurringTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL recurringCell;

- (void)setRecurringValue:(BOOL)recurring;


@end
