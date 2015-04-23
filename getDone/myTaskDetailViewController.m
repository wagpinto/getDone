//
//  myTaskDetailViewController.m
//  getDone
//
//  Created by Wagner Pinto on 4/6/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//
//******************************
// Create a custom TableViewCell for the cell that I want to change color and create a
//property for ON and OFF and set its valur through a method.


#import "myTaskDetailViewController.h"
#import "Constants.h"

@interface myTaskDetailViewController () 

@property (nonatomic, strong) Task *task;

@property (weak, nonatomic) IBOutlet UITextField *taskTitleField;
@property (weak, nonatomic) IBOutlet UITextField *taskAddressField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionField;
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *assignedUserLabel;
@property (weak, nonatomic) IBOutlet UIButton *completeTaskButton;

//@property (nonatomic, assign) BOOL important;
@property (weak, nonatomic) IBOutlet UISwitch *importantSwitch;

@end

@implementation myTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewController];
}
- (void)setupViewController {
    //setup the picture image:
    self.userPhotoImageView.layer.cornerRadius = self.userPhotoImageView.frame.size.height / 2;
    self.userPhotoImageView.clipsToBounds = YES;
    
    self.taskTitleField.text = self.task.taskName;
    self.taskAddressField.text = self.task.taskAddress;
    self.taskDescriptionField.text = self.task.taskDescription;
    if (self.task.taskImportant == YES) {
        [self.importantSwitch setOn:YES];
    }else {
        [self.importantSwitch setOn:NO];
    }
    
    if ([self.task.Status isEqual: @"Completed"]) {
        [self.completeTaskButton setTitle: @"COMPLETED" forState: UIControlStateNormal];
        self.completeTaskButton.backgroundColor = [UIColor darkGrayColor];
    }
    
    
    [self.tableView reloadData];
}
- (void)updateWithTask:(Task *)task {
    
    self.task = task;
    
}
- (IBAction)cancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)CompleteTask:(id)sender {
    [[TaskController sharedInstance]updateTask:self.task andStatus:StatusCompleted];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)save:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    Task *saveTask = [query getObjectWithId:self.task.objectId];
    
    saveTask.taskName = self.taskTitleField.text;
    saveTask.taskAddress = self.taskAddressField.text;
    saveTask.taskDescription = self.taskDescriptionField.text;
    saveTask.taskAssignee = self.assignedUser;

    //Save status upon selection
    if (self.assignedUser != nil) {
        saveTask.Status = StatusAssigned;
    }else {
        saveTask.Status = StatusCreated;
    }
    //UISwitch value save.
    if ([self.importantSwitch isOn]) {
        saveTask.taskImportant = YES;
    }else {
        saveTask.taskImportant = NO;
    }
    
    [saveTask pinInBackground];
    [saveTask save];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"shareTask"]) {
        FindFriendViewController *friendsVC = [segue destinationViewController];
        friendsVC.delegate = self;
    }

}
# pragma mark - Custom Delegate (Find Friend)
- (void)didSelectFriend:(User *)user {
    self.assignedUser = user;
} //custom delegate

#pragma mark - TABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
