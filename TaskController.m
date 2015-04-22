//
//  TaskController.m
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "TaskController.h"
#import "Constants.h"

@interface TaskController ()


@end

@implementation TaskController
@synthesize loadMyTask = _loadMyTask;

+ (TaskController *)sharedInstance {
    static TaskController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [TaskController new];
//        sharedInstance.loadMyTask = [[NSArray alloc]init];
    });
    return sharedInstance;
}

//- (NSArray *)loadMyTasks {
//    
//    [self loadTasks:^(BOOL completion) {
//        self.loadMyTask = self.loadedMyTasks;
//    }];
//    return self.loadMyTask;
//}

#pragma mark - TASK CONTROLLER
- (void)loadTasks:(void (^)(BOOL completion))completion
{ //loads current user tasks ordered by dueDate.
    
    PFQuery *query = [Task query];
    [query whereKey:@"taskOwner" equalTo:[PFUser currentUser]];
    [query whereKey:@"Status" equalTo:StatusCreated];
    [query orderByAscending:@"taskDueDate"];
    
    __block NSArray * loadedMyTasks = [[NSArray alloc]init];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            for (Task *task in objects) {
                loadedMyTasks = [loadedMyTasks arrayByAddingObject:task];
            }
            
            [TaskController sharedInstance].loadMyTask = loadedMyTasks;
            completion(YES);
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (NSArray *)loadSharedTasks {
    PFQuery *sharedTasks = [Task query];
    [sharedTasks whereKey:@"Status" equalTo:StatusAssigned];
    [sharedTasks whereKey:@"TaskOwner" equalTo:[PFUser currentUser]];
    [sharedTasks orderByDescending:@"taskDueDate"];
    return [sharedTasks findObjects];
}

- (NSArray *)loadCompledTasks {
    PFQuery *doneTasks = [Task query];
    [doneTasks whereKey:@"Status" equalTo:StatusCompleted];
    [doneTasks orderByDescending:@"taskDueDate"];
    return [doneTasks findObjects];
}

- (NSArray *)loadAssingedTasks {
    PFQuery*query = [Task query];
    [query whereKey:@"taskAssignee" equalTo:[PFUser currentUser]];
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
- (void)updateTask:(Task *)task andStatus:(NSString *)status {
    
    task.Status = status;
    
    [task saveInBackground];
    [task save];
}
- (void)deleteTask:(NSInteger)index andCompletion:(void (^)(BOOL completion))completion {
    //    [task unpinInBackground];
    [[[TaskController sharedInstance].loadMyTask objectAtIndex:index] deleteInBackground];
    completion(YES);
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
