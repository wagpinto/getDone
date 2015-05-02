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

@interface myTaskViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation myTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefreshControl];
    

    
}
- (void)viewDidAppear:(BOOL)animated {
//   [self setupRefreshControl];
    
    [[TaskController sharedInstance] loadTasks:^(BOOL completion) {
        [self reloadTableView];
    }];
    [[TaskController sharedInstance] loadCompletedTasks:^(BOOL completion) {
        [self reloadTableView];
    }];
    [[TaskController sharedInstance] loadSharedTasks:^(BOOL completion) {
        [self reloadTableView];
    }];
    
}
- (IBAction)addNewTask:(id)sender {
    //create and present a small view on top of the current view.
    //instaciate the new view as the one created on the storyboard.
    CreateTaskViewController *createVC = [self.storyboard instantiateViewControllerWithIdentifier:@"createTask"];
    
    //present the new view (from storyboard) modal and Over Current Context
    createVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [createVC.view setBackgroundColor:[UIColor clearColor]];
    
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
                    cell.sharedIcon.layer.cornerRadius = cell.sharedIcon.frame.size.height / 2;
                    cell.sharedIcon.clipsToBounds = YES;
                    cell.sharedIcon.contentMode = UIViewContentModeScaleAspectFit;
                    cell.sharedIcon.layer.borderColor = [UIColor orangeColor].CGColor;
                    cell.sharedIcon.layer.borderWidth = 0.8f;

                    [task.taskAssignee[@"UserPicture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        if (!error) {
                            UIImage *image = [UIImage imageWithData:data];
                            cell.sharedIcon.image = image;
                        }
                    }];
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
                cell.taskNameLabel.tintColor = [UIColor grayColor];
                cell.userLabel.text = @"";
                cell.dueDateLabel.text = @"DONE";
                cell.dueTimeLabel.text = @"";
                cell.dueTimeLabel.backgroundColor = [UIColor whiteColor];
                cell.importantIcon.image = nil;
                cell.sharedIcon.image = nil;
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
        default:
            return @"DONE";
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return [TaskController sharedInstance].loadMyTask.count;
            break;
        case 1:
            return [TaskController sharedInstance].loadSharedTask.count;
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
            {case 2:
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
