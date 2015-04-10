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
- (NSArray *)loadTasks {
    
    PFQuery *query = [Task query];
    [query whereKey:@"taskOwner" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"taskDueDate"];
    return [query findObjects];
    
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
               Assignee:(PFUser *)taskAssignee
              Important:(BOOL)important
                Current:(BOOL)recurring
                Address:(NSString *)address
                 Status:(NSString *)status{
    
    Task *newTask = [Task new];
    
    newTask.taskName = taskName;
    newTask.taskDescription = description;
    newTask.taskDueDate = dueDate;
    newTask.taskOwner = owner;
    newTask.taskAssignee = taskAssignee;
    newTask.taskImportant = important;
    newTask.taskStatus = status;
    newTask.taskAddress = address;
    newTask.taskRecurring = recurring;
  
    self.recentlyCreatedTask = newTask;
    [newTask pinInBackground];
    [newTask save];
    
}
- (void)deleteTask:(Task *)task {
    [task unpinInBackground];
    [task deleteInBackground];
}

#pragma mark - USER CONTROLLER
- (void)assignTask:(Task *)task ToUser:(User *)username {
    
    task.taskAssignee = username.objectId;

}

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
- (GroupTask *)loadGroupWithName:(NSString *)groupName {
    
    PFQuery *getGroup = [PFQuery queryWithClassName:@"GroupTasl"];
    [getGroup whereKey:@"groupTitle" equalTo:groupName];
    
    return groupName;
}


@end
