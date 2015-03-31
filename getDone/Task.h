//
//  Task.h
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <Parse/Parse.h>

@interface Task : PFObject <PFSubclassing>

//@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSString *taskDescription;
@property (nonatomic, strong) NSDate *taskDueDate;
@property (nonatomic, strong) PFUser *taskOwner;
@property (nonatomic, strong) PFUser *taskAssignee;
@property (nonatomic, assign) BOOL taskImportant;
@property (nonatomic, strong) NSString *taskLocation; //get location of the task

+ (NSString *)parseClassName;

@end
