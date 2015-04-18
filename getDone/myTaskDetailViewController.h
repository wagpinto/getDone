//
//  myTaskDetailViewController.h
//  getDone
//
//  Created by Wagner Pinto on 4/6/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskController.h"
#import "importantTableViewCell.h"
#import "recurringTableViewCell.h"

@interface myTaskDetailViewController : UITableViewController <UITableViewDelegate>

- (void)updateWithTask:(Task *)task;

@end
