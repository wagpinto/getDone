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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)addFriends:(id)sender {
    
}

#pragma mark - TABLEVIEW DELEGATE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [TaskController sharedInstance].loadAssingedTasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssingedToMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assignedTask" forIndexPath:indexPath];
    Task *task = [Task new];
    task = [TaskController sharedInstance].loadAssingedTasks[indexPath.row];

    if (cell != nil) {
        cell.taskNameLabel.text = task.taskName;
        cell.taskDescriptionLabel.text = task.taskDescription;
        cell.taskAddressLabel.text = task.taskAddress;
        cell.dueDateLabel.text = task.taskDueDate;
    }else {
        NSLog(@"Cell = NIL");
    }
    
    return cell;
}

@end
