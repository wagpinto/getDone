//
//  recurringTableViewCell.m
//  getDone
//
//  Created by Wagner Pinto on 4/18/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "recurringTableViewCell.h"

@implementation recurringTableViewCell

- (void)setRecurringValue:(BOOL)recurring {
    
    if (self.recurringCell == recurring) {
        self.backgroundColor = [UIColor greenColor];
        self.recurringCell = YES;
    }else {
        self.backgroundColor = [UIColor grayColor];
        self.recurringCell = NO;
    }
}

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
