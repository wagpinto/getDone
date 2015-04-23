//
//  AssignedToMeViewController.m
//  getDone
//
//  Created by Wagner Pinto on 4/21/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "AssignedToMeViewController.h"
#import "AssingedToMeTableViewCell.h"
#import "TaskController.h"

@interface AssignedToMeViewController ()

@property (nonatomic, strong) NSString *assignedStatus;

@end

@implementation AssignedToMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [[TaskController sharedInstance] loadAcceptedTasks:^(BOOL completion) {
        [self.tableView reloadData];
    }];
    [[TaskController sharedInstance] loadAssingedTasks:^(BOOL completion) {
        [self.tableView reloadData];
    }];
    [[TaskController sharedInstance] loadDeniedTasks:^(BOOL completion) {
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    [[TaskController sharedInstance] loadAcceptedTasks:^(BOOL completion) {
        [self.tableView reloadData];
    }];
    [[TaskController sharedInstance] loadAssingedTasks:^(BOOL completion) {
        [self.tableView reloadData];
    }];
    [[TaskController sharedInstance] loadDeniedTasks:^(BOOL completion) {
        [self.tableView reloadData];
    }];

}

#pragma mark - TABLEVIEW DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return [TaskController sharedInstance].loadAcceptedTask.count;
            break;
        case 1:
            return [TaskController sharedInstance].loadAssignedTask.count;
            break;
        default:
            return [TaskController sharedInstance].loadDeniedTask.count;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"ACCEPTED";
            break;
        case 1:
            return @"ASSIGNED TO ME";
            break;
        default:
            return @"DENIED TASKS";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssingedToMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assignedTask" forIndexPath:indexPath];
    Task *task = [Task new];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E-MM/dd"];

    switch (indexPath.section) {
        case 0:
            if (cell != nil) {
                task = [TaskController sharedInstance].loadAcceptedTask[indexPath.row];
                cell.taskNameLabel.text = task.taskName;
                cell.taskDescriptionLabel.text = task.taskDescription;
                cell.taskAddressLabel.text = task.taskAddress;
                cell.userFullNameLabel.text = task[@"taskOwner"][@"userFullName"];
                cell.usernameLabel.text = task[@"taskOwner"][@"username"];

                NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];
                cell.dueDateLabel.text = dateString;
            }
            break;
        case 1:
            if (cell != nil) {
                task = [TaskController sharedInstance].loadAssignedTask[indexPath.row];
                cell.taskNameLabel.text = task.taskName;
                cell.taskDescriptionLabel.text = task.taskDescription;
                cell.taskAddressLabel.text = task.taskAddress;
                cell.userFullNameLabel.text = task[@"taskOwner"][@"userFullName"];
                cell.usernameLabel.text = task[@"taskOwner"][@"username"];

                NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];
                cell.dueDateLabel.text = dateString;
            }
            break;
        default:
            if (cell != nil) {
                task = [TaskController sharedInstance].loadDeniedTask[indexPath.row];
                cell.taskNameLabel.text = task.taskName;
                cell.taskDescriptionLabel.text = task.taskDescription;
                cell.taskAddressLabel.text = task.taskAddress;
                cell.userFullNameLabel.text = task[@"taskOwner"][@"userFullName"];
                cell.dueDateLabel.text = @"DENIED";
            }
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 111;
}

@end
