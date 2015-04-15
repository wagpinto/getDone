//
//  Task.h
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <Parse/Parse.h>
#import "Status.h"
#import "User.h"
#import "GroupTask.h"

@interface Task : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSString *taskDescription;
@property (nonatomic, strong) NSDate *taskDueDate;
@property (nonatomic, strong) PFUser *taskOwner;
@property (nonatomic, strong) User *taskAssignee;
@property (nonatomic, assign) BOOL taskImportant;
@property (nonatomic, strong) NSString *taskLocation;
@property (nonatomic, strong) Status *TaskStatus; // >>> This one should be pointer:
@property (nonatomic, strong) GroupTask *taskGRoup;
@property (nonatomic, assign) BOOL taskRecurring;
@property (nonatomic, strong) NSString *taskAddress;

+ (NSString *)parseClassName;

@end
