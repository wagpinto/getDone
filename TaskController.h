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
#import "GroupTask.h"
#import "Status.h"

@interface TaskController : NSObject

+ (TaskController *)sharedInstance;

- (NSArray *)loadTasks;
- (NSArray *)loadAssingedTasks;
- (void)addTaskWithName:(NSString *)taskName
                   Desc:(NSString *)description
                DueDate:(NSDate *)dueDate
                  Owner:(PFUser *)owner
               Assignee:(PFUser *)taskAssignee
              Important:(BOOL)important
                Current:(BOOL)recurring
                Address:(NSString *)address
                 Status:(Status *)status
                  Group:(GroupTask *)group;

- (void)deleteTask:(Task *)task;
- (void)assignTask:(Task *)task ToUser:(User *)user;
- (NSArray *)selectUserWithName:(NSString *)username;
- (void)createGroupWithName:(NSString *)groupName Desc:(NSString *)groupDescr;
- (NSArray *)loadAllUser;
- (NSArray *)loadGroup:(GroupTask *)group;

@property(nonatomic,strong) Task *recentlyCreatedTask;

@property NSString *taskCreated;

@end
