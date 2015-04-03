//
//  FirstViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/25/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "myTaskViewController.h"
#import "TaskController.h"
#import "CreateTaskViewController.h"

@interface myTaskViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

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
- (IBAction)createTask:(id)sender {
    //create and present a small view on top of the current view.
    //instaciate the new view as the one created on the storyboard.
    CreateTaskViewController *createVC = [self.storyboard instantiateViewControllerWithIdentifier:@"createTask"];

    //present the new view (from storyboard) modal and Over Current Context
    createVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [createVC.view setBackgroundColor:[UIColor clearColor]];
    
    [self.parentViewController presentViewController:createVC animated:YES completion:nil];
}
- (void)presentCreateModal {
    CreateTaskViewController *createVC = [self.storyboard instantiateViewControllerWithIdentifier:@"createTask"];
    [self addChildViewController:createVC];
    createVC.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:createVC.view];
    [self parentViewController];
    [UIView animateWithDuration:1.0 animations:^{
        createVC.view.center = self.view.center;
        
    }];
} //check if is necessary

- (IBAction)loadAllTasksFromUser:(id)sender {
    
    [[TaskController sharedInstance]loadTasks];
    
}
- (IBAction)loadAssignedTasks:(id)sender {
    
    [[TaskController sharedInstance]loadAssingedTasks];
    
}



#pragma mark - TABLEVIEW TADASOURCE
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    Task *task = [TaskController sharedInstance].loadTasks[indexPath.row];
    
    if (cell != nil) {
        //format date on the taskDueDate:
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd"];
        NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];
        
        cell.taskNameLabel.text = task.taskName;
        //cell.taskDescriptionLabel.text = task.taskDescription;
        cell.dueDateLabel.text = dateString;

    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //loadSelectedTask
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [TaskController sharedInstance].loadTasks.count;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        Task *task = [TaskController sharedInstance].loadTasks[indexPath.row];
        [[TaskController sharedInstance]deleteTask:task];
        
        [tableView reloadData];
    }
}


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
