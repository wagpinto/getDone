//
//  CustomTableViewCell.h
//  getDone
//
//  Created by Wagner Pinto on 4/1/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (weak, nonatomic) IBOutlet UIView *customCell;
@property (weak, nonatomic) IBOutlet UIImageView *importantIcon;
@property (weak, nonatomic) IBOutlet UIImageView *sharedIcon;

@end
