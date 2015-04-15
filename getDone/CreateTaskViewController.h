//
//  CreateTaskViewController.h
//  getDone
//
//  Created by Wagner Pinto on 3/31/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "User.h"

@interface CreateTaskViewController : UITableViewController

@property (nonatomic,strong) User *assignedUser;


@end
