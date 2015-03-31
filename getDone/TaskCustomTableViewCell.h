//
//  TaskCustomCellTableViewCell.h
//  getDone
//
//  Created by Wagner Pinto on 3/29/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskCustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;

@end
