//
//  TaskController.h
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Task.h"
#import "User.h"

@interface TaskController : NSObject

+ (TaskController *)sharedInstance;

- (NSArray *)loadTasks;
- (NSArray *)loadAssingedTasks;
- (void)addTaskWithName:(NSString *)taskName
                   Desc:(NSString *)description
                DueDate:(NSDate *)dueDate
                  Owner:(PFUser *)owner
               Assignee:(PFUser *)taskAssignee
              Important:(BOOL)important;
- (void)updateTask:(Task *)task;
- (void)deleteTask:(Task *)task;
- (void)assignTask:(Task *)task ToUser:(PFUser *)user;

@end
