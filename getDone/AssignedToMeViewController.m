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


@end

@implementation AssignedToMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TaskController sharedInstance] loadAssingedTasks:^(BOOL completion) {
        [self.tableView reloadData];
    }];}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[TaskController sharedInstance] loadAssingedTasks:^(BOOL completion) {
        [self.tableView reloadData];
    }];

}

#pragma mark - TABLEVIEW DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [TaskController sharedInstance].loadAssignedTask.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    switch (section.index) {
//        case <#constant#>:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssingedToMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assignedTask" forIndexPath:indexPath];
    Task *task = [Task new];
    task = [TaskController sharedInstance].loadAssignedTask[indexPath.row];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E-MM/dd"];
    NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];

    
    if (cell != nil) {
        cell.taskNameLabel.text = task.taskName;
        cell.taskDescriptionLabel.text = task.taskDescription;
        cell.taskAddressLabel.text = task.taskAddress;
        cell.userFullNameLabel.text = task[@"taskOwner"][@"userFullName"];
        cell.usernameLabel.text = task[@"taskOwner"][@"username"];
        cell.dueDateLabel.text = dateString;
    }else {
        NSLog(@"Cell = NIL");
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
