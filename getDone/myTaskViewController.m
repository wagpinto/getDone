//
//  FirstViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/25/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "myTaskViewController.h"
#import "myTaskDetailViewController.h"
#import "CreateTaskViewController.h"
#import "TaskController.h"
#import "Settings.h"

@interface myTaskViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation myTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefreshControl];
    
}
- (void)viewDidAppear:(BOOL)animated {    
    [[TaskController sharedInstance] loadTasks:^(BOOL completion) {
        [self reloadTableView];
    }];
    [[TaskController sharedInstance] loadCompletedTasks:^(BOOL completion) {
        [self reloadTableView];
    }];
    [[TaskController sharedInstance] loadSharedTasks:^(BOOL completion) {
        [self reloadTableView];
    }];
    [[TaskController sharedInstance] loadAcceptedTasks:^(BOOL completion) {
        [self reloadTableView];
    }];
    
}
- (IBAction)addNewTask:(id)sender {
    CreateTaskViewController *createVC = [self.storyboard instantiateViewControllerWithIdentifier:@"createTask"];
    [self.parentViewController presentViewController:createVC animated:YES completion:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {
    
    if ([segue.identifier isEqualToString:@"selectTask"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        myTaskDetailViewController *detailViewController = [segue destinationViewController];
        
        switch (indexPath.section) {
            case 0:
                [detailViewController updateWithTask:[TaskController sharedInstance].loadMyTask[indexPath.row]];
                break;
            case 1:
                [detailViewController updateWithTask:[TaskController sharedInstance].loadSharedTask[indexPath.row]];
                break;
            case 2:
                [detailViewController updateWithTask:[TaskController sharedInstance].loadAcceptedTask[indexPath.row]];
                break;
            default:
                [detailViewController updateWithTask:[TaskController sharedInstance].loadCompletedTask[indexPath.row]];
                break;
        }
    }
}

- (void)setupDateTime {
    
}

#pragma mark - TABLEVIEW TADASOURCE
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    Task *task = [Task new];

    //set user image to OFF:
    UIImage *userOFFPic = [UIImage imageNamed:@"User-off-50"];
    
    //format date on the taskDueDate:
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"E-MM/dd"];
    NSDateFormatter *timeFormat = [NSDateFormatter new];
    [timeFormat setDateFormat:@"hh:mm a"];
    
    switch (indexPath.section) {
        case 0:
            if (cell != nil) {
                task = [TaskController sharedInstance].loadMyTask[indexPath.row];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.taskNameLabel.text = task.taskName;
                cell.userLabel.text = @"";
                [cell.sharedIcon setImage:userOFFPic];
                
                NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];
                cell.dueDateLabel.text = dateString;
                
                NSString *timeString = [timeFormat stringFromDate:task.taskDueDate];
                cell.dueTimeLabel.text = timeString;
                
                //set the cell icons to reflect the importance and status:
                if (task.taskImportant == YES) {
                    cell.importantIcon.highlighted = YES;
                }else {
                    cell.importantIcon.highlighted = NO;
                }
            }
            break;
        case 1:
            if (cell != nil) {
                task = [TaskController sharedInstance].loadSharedTask[indexPath.row];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.taskNameLabel.text = task.taskName;
                cell.userLabel.text = task[@"taskAssignee"][@"userFullName"];
                
                if (!task.taskAssignee[@"UserPicture"]) {
                    [cell.sharedIcon setImage:userOFFPic];
                }else {
                    [Settings getUserImage:task.taskAssignee toImageView:cell.sharedIcon];
                    [Settings setupUserImage:cell.sharedIcon];
                }
                
                NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];
                cell.dueDateLabel.text = dateString;
                
                NSString *timeString = [timeFormat stringFromDate:task.taskDueDate];
                cell.dueTimeLabel.text = timeString;
                
                //set the cell icons to reflect the importance and status:
                if (task.taskImportant == YES) {
                    cell.importantIcon.highlighted = YES;
                }else {
                    cell.importantIcon.highlighted = NO;
                }
            }
            break;
        case 2:
            if (cell != nil) {
                task = [TaskController sharedInstance].loadAcceptedTask[indexPath.row];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.taskNameLabel.text = task.taskName;
                cell.userLabel.text = task[@"taskAssignee"][@"userFullName"];
                
                if (!task.taskAssignee[@"UserPicture"]) {
                    [cell.sharedIcon setImage:userOFFPic];
                }else {
                    [Settings getUserImage:task.taskAssignee toImageView:cell.sharedIcon];
                    [Settings setupUserImage:cell.sharedIcon];
                }
                
                NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];
                cell.dueDateLabel.text = dateString;
                
                NSString *timeString = [timeFormat stringFromDate:task.taskDueDate];
                cell.dueTimeLabel.text = timeString;
                
                //set the cell icons to reflect the importance and status:
                if (task.taskImportant == YES) {
                    cell.importantIcon.highlighted = YES;
                }else {
                    cell.importantIcon.highlighted = NO;
                }
            }
            break;
        default: {
            if (cell != nil) {
                task = [TaskController sharedInstance].loadCompletedTask[indexPath.row];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.taskNameLabel.text = task.taskName;
                cell.userLabel.text = @"";
                cell.dueDateLabel.text = @"DONE";
                cell.dueDateLabel.backgroundColor = [UIColor darkGrayColor];
                cell.dueTimeLabel.text = @"";
                cell.dueTimeLabel.backgroundColor = [UIColor clearColor];
                cell.importantIcon.image = nil;
                cell.sharedIcon.image = nil;
                cell.sharedIcon.layer.borderWidth = 0;
            }
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 69;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return @"MY TASKS";
            break;
        case 1:
            return @"SHARED TASKS";
            break;
        case 2:
            return @"ACCEPTED HELP";
            break;
        default:
            return @"DONE";
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return [TaskController sharedInstance].loadMyTask.count;
            break;
        case 1:
            return [TaskController sharedInstance].loadSharedTask.count;
            break;
        case 2:
            return [TaskController sharedInstance].loadAcceptedTask.count;
            break;
        default:
            return [TaskController sharedInstance].loadCompletedTask.count;
            break;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        switch (indexPath.section) {
            {case 0:
                [[TaskController sharedInstance] deleteMyTask:indexPath.row andCompletion:^(BOOL completion) {
                    [[TaskController sharedInstance] loadTasks:^(BOOL completion) {
                        [self reloadTableView];
                    }];
                }];
                break;}
            {case 1:
                [[TaskController sharedInstance] deleteSharedTask:indexPath.row andCompletion:^(BOOL completion) {
                    [[TaskController sharedInstance] loadSharedTasks:^(BOOL completion) {
                        [self reloadTableView];
                    }];
                }];
                break;}
            case 2:{
                UIAlertView *alertDelete = [[UIAlertView alloc]initWithTitle:@"Can't Delete Accepted Messages" message:@"If the task has been accepted by another user, only that user can complete the task" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles: nil];
                [alertDelete show];
            }
                break;
            {default:
                [[TaskController sharedInstance] deleteCompletedTask:indexPath.row andCompletion:^(BOOL completion) {
                    [[TaskController sharedInstance] loadCompletedTasks:^(BOOL completion) {
                        [self reloadTableView];
                    }];
                }];
                break;}
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - Pull-to-Refresh
- (void)setupRefreshControl {
    
    self.refreshControl = [UIRefreshControl new];
    [self setRefreshControl:self.refreshControl];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(reloadTableView) forControlEvents:UIControlEventValueChanged];
    
}
- (void)reloadTableView {
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

@end
