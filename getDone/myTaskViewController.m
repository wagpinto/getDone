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
@property (nonatomic, strong) Task *selectedTask;

@end

@implementation myTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefreshControl];
    [[TaskController sharedInstance] loadTasks:^(BOOL completion) {
        [self reloadTableView];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [[TaskController sharedInstance] loadTasks:^(BOOL completion) {
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

#pragma mark - TABLEVIEW TADASOURCE
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    Task *task = [TaskController sharedInstance].loadMyTask[indexPath.row];
    
    if (cell != nil) {
        //format date on the taskDueDate:
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"E-MM/dd"];
        NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.taskNameLabel.text = task.taskName;
        cell.dueDateLabel.text = dateString;
        
        //set the cell icons to reflect the importance and status:
        if (task.taskImportant == YES) {
            cell.importantIcon.highlighted = YES;
        }
        if ([task.Status isEqual:@"Assigned"] || [task.Status isEqual:@"Accepted"]){
            cell.sharedIcon.highlighted = YES;
        }
        if (task.taskRecurring == YES) {
//            cell.
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 69;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"MY TASKS";
            break;
        case 1:
            return @"ASSIGNED";
            break;
        default:
            return @"COMPLETED";
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
        default:
            return 0;
            break;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [[TaskController sharedInstance] deleteTask:indexPath.row andCompletion:^(BOOL completion) {
            [[TaskController sharedInstance] loadTasks:^(BOOL completion) {
                [self reloadTableView];
            }];
        }];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}//segue push to detail view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {
    
    if ([segue.identifier isEqualToString:@"selectTask"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        myTaskDetailViewController *detailViewController = [segue destinationViewController];
        // Pass any objects to the view controller here, like...
        [detailViewController updateWithTask:[TaskController sharedInstance].loadMyTask[indexPath.row]];
    }
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
