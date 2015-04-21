//
//  CustomTableViewCell.m
//  getDone
//
//  Created by Wagner Pinto on 4/1/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.userLabel.text = @"...";
    
}
- (void)setImageView:(BOOL)important recurring:(BOOL)recurring status:(NSString *)status {
//this method will change the imageview as the parameter is called
    

    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
