//
//  TaskController.m
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "TaskController.h"

@implementation TaskController

+ (TaskController *)sharedInstance {
    static TaskController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [TaskController new];
        [sharedInstance loadTasks];
        
    });
    return sharedInstance;
}

#pragma mark - TASK CONTROLLER
- (NSArray *)loadTasks { //loads current user tasks ordered by dueDate.
    
    PFQuery *query = [Task query];
    [query whereKey:@"taskOwner" equalTo:[PFUser currentUser]];
    [query orderByAscending:@"taskDueDate"];
    
    return [query findObjects];
    
}
- (NSArray *)loadSharedTasks {
    PFQuery *sharedTasks = [Task query];
    [sharedTasks whereKey:@"Status" equalTo:@"Assigned"];
    [sharedTasks orderByDescending:@"taskDueDate"];
    return [sharedTasks findObjects];
}

- (NSArray *)loadCompledTasks {
    PFQuery *doneTasks = [Task query];
    [doneTasks whereKey:@"Status" equalTo:@"Completed"];
    [doneTasks orderByDescending:@"taskDueDate"];
    return [doneTasks findObjects];
}

- (NSArray *)loadAssingedTasks {
    
    PFQuery*query = [Task query];
    [query whereKey:@"taskAssingee" equalTo:[PFUser currentUser]];
    return [query findObjects];
}
- (void)addTaskWithName:(NSString *)taskName
                   Desc:(NSString *)description
                DueDate:(NSDate *)dueDate
                  Owner:(PFUser *)owner
               Assignee:(User *)taskAssignee
              Important:(BOOL)important
                Current:(BOOL)recurring
                Address:(NSString *)address
                 Status:(NSString *)status
                  Group:(GroupTask *)group {
    
    Task *newTask = [Task new];
    
    newTask.taskName = taskName;
    newTask.taskDescription = description;
    newTask.taskDueDate = dueDate;
    newTask.taskOwner = owner;
    newTask.taskAssignee = taskAssignee;
    newTask.taskImportant = important;
    newTask.Status = status;
    newTask.taskAddress = address;
    newTask.taskRecurring = recurring;
    newTask.taskGRoup = group;
    
    self.recentlyCreatedTask = newTask;
    //    [newTask pinInBackground];
    [newTask save];
    
}
- (void)deleteTask:(Task *)task {
    //    [task unpinInBackground];
    [task deleteInBackground];
}

#pragma mark - USER CONTROLLER
- (NSArray *)loadAllUser {
    
    PFQuery *query = [PFUser query];
    return [query findObjects];
}
- (NSArray *)selectUserWithName:(NSString *)username{
    
    PFQuery *findUsers = [PFQuery queryWithClassName:@"User"];
    [findUsers whereKey:@"username" equalTo:username];
    
    return [findUsers findObjects];
}

#pragma mark - GROUP CONTROLLER
- (void)createGroupWithName:(NSString *)groupName Desc:(NSString *)groupDescr {
    
    GroupTask *group = [GroupTask new];
    
    group.groupTitle = groupName;
    group.groupDescription = groupDescr;
    
    [group saveInBackground];
    [group save];
    
}
- (NSArray *)loadGroup:(GroupTask *)group {
    
    PFQuery *getGroup = [PFQuery queryWithClassName:@"GroupTask"];
    return [getGroup findObjects];
}


@end
