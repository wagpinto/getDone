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
    
    
    
}
- (IBAction)Logout:(id)sender {

    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout"sender:self];
    
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
    Task *task = [TaskController sharedInstance].loadTasks[indexPath.row];

    if (cell != nil) {
        //format date on the taskDueDate:
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"E-MM/dd"];
        NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];
        
        cell.taskNameLabel.text = task.taskName;
        cell.dueDateLabel.text = dateString;

        //set the cell icons to reflect the importance and status:
        if (task.taskImportant == YES) {cell.importantIcon.highlighted = YES;}else {cell.importantIcon.highlighted = NO;}
        if ([task.TaskStatus isEqual:@"31fZP3RC4m"] || [task.TaskStatus isEqual:@"wFq3q8H7Qn"]){
            cell.sharedIcon.highlighted = YES;
        }else{
            cell.sharedIcon.highlighted = NO;
        }
        
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [TaskController sharedInstance].loadTasks.count;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        Task *task = [TaskController sharedInstance].loadTasks[indexPath.row];
        [[TaskController sharedInstance]deleteTask:task];
        
        [tableView reloadData];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}//segue push to detail view controller

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {

    if ([segue.identifier isEqualToString:@"selectTask"]) {
        UINavigationController *navController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        myTaskDetailViewController *detailViewController = (myTaskDetailViewController *)([navController viewControllers][0]);
                // Pass any objects to the view controller here, like...
        [detailViewController updateWithTask:[TaskController sharedInstance].loadTasks[indexPath.row]];
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

//- (void)presentCreateModal {
//    CreateTaskViewController *createVC = [self.storyboard instantiateViewControllerWithIdentifier:@"createTask"];
//    [self addChildViewController:createVC];
//    createVC.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
//    [self.view addSubview:createVC.view];
//    [self parentViewController];
//    [UIView animateWithDuration:1.0 animations:^{
//        createVC.view.center = self.view.center;
//
//    }];
//}
@end
