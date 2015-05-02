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

- (void)loadTasks:(void (^)(BOOL completion))completion;
- (void)loadSharedTasks:(void (^)(BOOL completion))completion;
- (void)loadCompletedTasks:(void (^)(BOOL completion))completion;
- (void)loadAssingedTasks:(void (^)(BOOL completion))completion;
- (void)loadAllUser:(void (^)(BOOL completion))completion;

- (void)addTaskWithName:(NSString *)taskName
                   Desc:(NSString *)description
                DueDate:(NSDate *)dueDate
                  Owner:(PFUser *)owner
               Assignee:(User *)taskAssignee
              Important:(BOOL)important
                Current:(BOOL)recurring
                Address:(NSString *)address
                 Status:(NSString *)status;

- (void)updateTask:(Task *)task andStatus:(NSString *)status;
- (void)deleteMyTask:(NSInteger)index andCompletion:(void (^)(BOOL completion))completion;
- (void)deleteSharedTask:(NSInteger)index andCompletion:(void (^)(BOOL completion))completion;
- (void)deleteCompletedTask:(NSInteger)index andCompletion:(void (^)(BOOL completion))completion;
- (void)loadAcceptedTasks:(void (^)(BOOL completion))completion;
- (void)loadDeniedTasks:(void (^)(BOOL completion))completion;

- (void)updateUserWithName:(User *)user andName:(NSString *)userName andPic:(PFFile *)Picture;
- (NSArray *)selectUserWithName:(NSString *)username;

@property(nonatomic,strong) Task *recentlyCreatedTask;
@property (nonatomic,strong) NSArray * loadMyTask;
@property (nonatomic,strong) NSArray * loadSharedTask;
@property (nonatomic,strong) NSArray * loadCompletedTask;

@property (nonatomic,strong) NSArray * loadAllUser;

@property (nonatomic,strong) NSArray * loadAssignedTask;
@property (nonatomic,strong) NSArray * loadAcceptedTask;
@property (nonatomic,strong) NSArray * loadDeniedTask;

@property NSString *taskCreated;

@end
