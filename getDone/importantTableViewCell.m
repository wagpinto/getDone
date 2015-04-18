//
//  importantTableViewCell.m
//  getDone
//
//  Created by Wagner Pinto on 4/18/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "importantTableViewCell.h"


@implementation importantTableViewCell

- (void)setImportantValue:(BOOL)important {
    
    if (self.importantCell == important) {
        self.backgroundColor = [UIColor greenColor];
        self.importantCell = YES;
    }else {
        self.backgroundColor = [UIColor grayColor];
        self.importantCell = NO;
    }
    
}

- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
