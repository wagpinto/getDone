//
//  myTaskDetailViewController.h
//  getDone
//
//  Created by Wagner Pinto on 4/6/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskController.h"
#import "FindFriendViewController.h"

@interface myTaskDetailViewController : UITableViewController <FindFriendsDelegate, UITextFieldDelegate>

@property (nonatomic,strong) User *assignedUser;

- (void)updateWithTask:(Task *)task;

@end
