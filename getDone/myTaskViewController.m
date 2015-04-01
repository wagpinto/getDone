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

@end

@implementation myTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    ;}

- (IBAction)deleteTask:(id)sender {

//    PFQuery *loadTask = [Task query];
//    [loadTask whereKey:@"objectId" equalTo:@"85d11qz593"];
//
//    [[TaskController sharedInstance]deleteTask:loadTask];
    
}
- (IBAction)loadAllTasksFromUser:(id)sender {
    
    [[TaskController sharedInstance]loadTasks];

}
- (IBAction)loadAssignedTasks:(id)sender {

    [[TaskController sharedInstance]loadAssingedTasks];
    
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

#pragma mark - TABLEVIEW TADASOURCE
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    Task *task = [TaskController sharedInstance].loadTasks[indexPath.row];
    
    //format date on the taskDueDate:
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd"];
    NSString *dateString = [dateFormat stringFromDate:task.taskDueDate];
    
    cell.taskNameLabel.text = task.taskName;
    cell.taskDescriptionLabel.text = task.taskDescription;
    cell.dueDateLabel.text = dateString;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //loadSelectedTask
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [TaskController sharedInstance].loadTasks.count;
}

@end
