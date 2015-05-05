//
//  TaskController.m
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "TaskController.h"
#import "Settings.h"

@interface TaskController ()


@end

@implementation TaskController
@synthesize loadMyTask = _loadMyTask;

+ (TaskController *)sharedInstance {
    static TaskController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [TaskController new];
    });
    return sharedInstance;
}


#pragma mark - TASK CONTROLLER
- (void)loadTasks:(void (^)(BOOL completion))completion { //loads current user tasks ordered by dueDate.
    PFQuery *query = [Task query];
    [query whereKey:@"taskOwner" equalTo:[PFUser currentUser]];
    [query whereKey:@"Status" equalTo:StatusCreated];
    [query orderByAscending:@"taskDueDate"];
    
    __block NSArray * loadedMyTasks = [[NSArray alloc]init];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
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
- (void)loadSharedTasks:(void (^)(BOOL completion))completion {
    PFQuery *query = [Task query];
    [query whereKey:@"taskOwner" equalTo:[PFUser currentUser]];
    [query whereKey:@"Status" equalTo:StatusAssigned];
    [query orderByAscending:@"taskDueDate"];
    
    __block NSArray *loadSharedTasks = [[NSArray alloc]init];
    [query includeKey:@"taskAssignee"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (Task *task in objects) {
                loadSharedTasks = [loadSharedTasks arrayByAddingObject:task];
            }
            [TaskController sharedInstance].loadSharedTask = loadSharedTasks;
            completion (YES);
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}
- (void)loadCompletedTasks:(void (^)(BOOL completion))completion {
    PFQuery *doneTasks = [Task query];
    [doneTasks whereKey:@"Status" equalTo:StatusCompleted];
    [doneTasks orderByDescending:@"taskDueDate"];

    __block NSArray *loadCompletedTasks = [NSArray new];
    
    [doneTasks findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (Task *task in objects) {
                loadCompletedTasks = [loadCompletedTasks arrayByAddingObject:task];
            }
            [TaskController sharedInstance].loadCompletedTask = loadCompletedTasks;
            completion(YES);
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
- (void)loadAssingedTasks:(void (^)(BOOL completion))completion {
    PFQuery*query = [Task query];
    [query whereKey:@"taskAssignee" equalTo:[PFUser currentUser]];
    [query whereKey:@"Status" equalTo:StatusAssigned];

    __block NSArray *loadAssignedTasks = [NSArray new];
    [query includeKey:@"taskOwner"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (Task *task in objects) {
                loadAssignedTasks = [loadAssignedTasks arrayByAddingObject:task];
            }
            [TaskController sharedInstance].loadAssignedTask = loadAssignedTasks;
            completion(YES);
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
- (void)loadAcceptedTasks:(void (^)(BOOL completion))completion {
    PFQuery*query = [Task query];
    [query whereKey:@"taskOwner" equalTo:[PFUser currentUser]];
    [query whereKey:@"Status" equalTo:StatusAccepted];
    
    __block NSArray *loadTasks = [NSArray new];
    [query includeKey:@"taskAssignee"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (Task *task in objects) {
                loadTasks = [loadTasks arrayByAddingObject:task];
            }
            [TaskController sharedInstance].loadAcceptedTask = loadTasks;
            completion(YES);
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
- (void)loadDeniedTasks:(void (^)(BOOL completion))completion {
    PFQuery*query = [Task query];
    [query whereKey:@"taskAssignee" equalTo:[PFUser currentUser]];
    [query whereKey:@"Status" equalTo:StatusDenied];
    
    __block NSArray *loadTasks = [NSArray new];
    [query includeKey:@"taskOwner"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (Task *task in objects) {
                loadTasks = [loadTasks arrayByAddingObject:task];
            }
            [TaskController sharedInstance].loadDeniedTask = loadTasks;
            completion(YES);
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)addTaskWithName:(NSString *)taskName
                   Desc:(NSString *)description
                DueDate:(NSDate *)dueDate
                  Owner:(PFUser *)owner
               Assignee:(User *)taskAssignee
              Important:(BOOL)important
                Current:(BOOL)recurring
                Address:(NSString *)address
                 Status:(NSString *)status {
    
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
    
    self.recentlyCreatedTask = newTask;

    [newTask saveInBackground];
    [newTask save];
    
}
- (void)updateTask:(Task *)task andStatus:(NSString *)status {
    
    if ([status isEqual:StatusCreated]) {
        task.Status = StatusCreated;
        task.taskAssignee = nil;
    }else {
        task.Status = status;
    }
    
    [task saveInBackground];
    [task save];
}
- (void)deleteMyTask:(NSInteger)index andCompletion:(void (^)(BOOL completion))completion {
    [[[TaskController sharedInstance].loadMyTask objectAtIndex:index] deleteInBackground];
    completion(YES);
}
- (void)deleteSharedTask:(NSInteger)index andCompletion:(void (^)(BOOL completion))completion {
    [[[TaskController sharedInstance].loadSharedTask objectAtIndex:index] deleteInBackground];
    completion(YES);
}
- (void)deleteCompletedTask:(NSInteger)index andCompletion:(void (^)(BOOL completion))completion {
    [[[TaskController sharedInstance].loadCompletedTask objectAtIndex:index] deleteInBackground];
    completion(YES);
}

#pragma mark - USER CONTROLLER
- (void)updateUserWithName:(User *)user andName:(NSString *)userName andPic:(PFFile *)Picture {
    
    user.userFullName = userName;
    user.userPic = Picture;
    
    [user saveInBackground];
    [user save];
}
- (void)loadAllUser:(void (^)(BOOL completion))completion {
    PFQuery *queryUser = [PFUser query];
    [queryUser orderByAscending:@"updatedAt"];
    
    __block NSArray *loadUsers = [NSArray new];
    [queryUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (User *user in objects) {
                loadUsers = [loadUsers arrayByAddingObject:user];
            }
            [TaskController sharedInstance].loadAllUser = loadUsers;
            completion (YES);
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
- (NSArray *)selectUserWithName:(NSString *)username{
    
    PFQuery *findUsers = [PFQuery queryWithClassName:@"User"];
    [findUsers whereKey:@"username" equalTo:username];
    
    return [findUsers findObjects];
}

@end
