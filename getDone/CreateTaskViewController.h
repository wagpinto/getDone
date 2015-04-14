//
//  CreateTaskViewController.h
//  getDone
//
//  Created by Wagner Pinto on 3/31/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CreateTaskViewController : UITableViewController
@property (nonatomic,strong) PFUser *assignedUser;
-(void)updateUserAssigned:(PFUser *)user;

@end
