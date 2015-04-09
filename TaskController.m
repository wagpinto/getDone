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
    newTask.taskStatus = @"Created";
    newTask.taskAddress = address;
    newTask.taskRecurring = recurring;
  
    [newTask pinInBackground];
    [newTask save];
    
}
- (void)updateTask:(Task *)task {
    [task pinInBackground];
    [task save];
}
- (void)deleteTask:(Task *)task {
    [task unpinInBackground];
    [task deleteInBackground];
}
- (void)assignTask:(Task *)task ToUser:(PFUser *)user {
    
    Task *assingTask = [Task new];
    
    assingTask.taskAssignee = user;
    
    [assingTask pinInBackground];
    [assingTask save];
}

#pragma mark - GROUP CONTROLLER

//create group - get an array of tasks and create a group with Titlle and Description.
//remove task from group - remove one/a number of tasks form a group.

@end
