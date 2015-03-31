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
        //[sharedInstance loadTasks];
        
    });
    return sharedInstance;
}

#pragma mark - TASK CONTROLLER
- (NSArray *)loadTasks {
    
    PFQuery *query = [Task query];
    [query whereKey:@"taskOwner" equalTo:[PFUser currentUser]];
    return [query findObjects];
    
    
//    NSMutableArray *tasksArray = [NSMutableArray new];
//        PFQuery *loadTask = [Task query];
//        [loadTask whereKey:@"taskOwner" equalTo:[PFUser currentUser]];
//        
//        [loadTask findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            for (Task *task in objects) {
//                [tasksArray addObject:task];
//                NSLog(@"user:%@, -- taskName:%@",[PFUser currentUser].username,task.objectId);
//            }
//        }];
//        return tasksArray;
    
}
- (NSArray *)loadAssingedTasks {

    NSMutableArray *tasks = [NSMutableArray new];
    
    PFQuery *loadTask = [Task query];
    [loadTask whereKey:@"taskAssingee" equalTo:[PFUser currentUser]];
    [loadTask findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (Task *task in objects) {
            //[task pin];
            //TDD - testing the userName requirement
            [tasks addObject:task];
            NSLog(@"Assignee:%@, taskName:%@",[PFUser currentUser].username,task.taskName);
        }
    }];
    return tasks;
}
- (void)addTaskWithName:(NSString *)taskName
                   Desc:(NSString *)description
                DueDate:(NSDate *)dueDate
                  Owner:(PFUser *)owner
               Assignee:(PFUser *)taskAssignee
              Important:(BOOL)important {
    
    
    Task *newTask = [Task new];
    
    newTask.taskName = taskName;
    newTask.taskDescription = description;
    newTask.taskDueDate = dueDate;
    newTask.taskOwner = owner;
    newTask.taskAssignee = taskAssignee;
    newTask.taskImportant = important;
//    newTask.taskLocation = //location services
  
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
