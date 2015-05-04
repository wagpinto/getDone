//
//  AssingedToMeTableViewCell.h
//  getDone
//
//  Created by Wagner Pinto on 4/21/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssingedToMeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *taskAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userPicView;


@end
