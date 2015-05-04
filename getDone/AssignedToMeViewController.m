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
#import "Constants.h"

@interface AssignedToMeViewController ()

@property (nonatomic, strong) NSString *assignedStatus;

@end

@implementation AssignedToMeViewController

- (void)viewDidLoad {
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
    [self.tableView reloadData];

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
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
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
    UIImage *userOFFPic = [UIImage imageNamed:@"User-off-50"];
    Task *task = [Task new];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E-MM/dd"];
    NSDateFormatter *timeFormat = [NSDateFormatter new];
    [timeFormat setDateFormat:@"hh:mm a"];


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
                NSString *timeString = [timeFormat stringFromDate:task.taskDueDate];
                cell.dueTimeLabel.text = timeString;
                
                if (!task.taskOwner[@"UserPicture"]) {
                    [cell.userPicView setImage:userOFFPic];
                }else {
                    [task.taskOwner[@"UserPicture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        if (!error) {
                            UIImage *image = [UIImage imageWithData:data];
                            cell.userPicView.image = image;
                        }
                    }];
                }
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

                NSString *timeString = [timeFormat stringFromDate:task.taskDueDate];
                cell.dueTimeLabel.text = timeString;
                
                if (!task.taskOwner[@"UserPicture"]) {
                    [cell.userPicView setImage:userOFFPic];
                }else {
                    [task.taskOwner[@"UserPicture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        if (!error) {
                            UIImage *image = [UIImage imageWithData:data];
                            cell.userPicView.image = image;
                        }
                    }];
                }
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

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Let's Help!?"  message:@"Please make a selection" preferredStyle:UIAlertControllerStyleActionSheet];
    Task *task = [Task new];
    
    switch (indexPath.section) {
        case 0:{
            task = [TaskController sharedInstance].loadAcceptedTask[indexPath.row];
            [alertController addAction:[UIAlertAction actionWithTitle:@"DONE" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[TaskController sharedInstance]updateTask:task andStatus:StatusCompleted];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self viewDidLoad];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }]];

        }break;
        case 1:{
            task = [TaskController sharedInstance].loadAssignedTask[indexPath.row];
            [alertController addAction:[UIAlertAction actionWithTitle:@"ACCEPT TASK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[TaskController sharedInstance]updateTask:task andStatus:StatusAccepted];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self viewDidLoad];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"DENY" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[TaskController sharedInstance]updateTask:task andStatus:StatusCreated];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self viewDidLoad];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }]];

        }break;
        default:{
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }]];
        }break;
    }
        [self presentViewController:alertController animated:YES completion:nil];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 111;
}

@end
