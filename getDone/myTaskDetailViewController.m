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
#import "Settings.h"

@interface myTaskDetailViewController () 

@property (nonatomic, strong) Task *task;

@property (weak, nonatomic) IBOutlet UITextField *taskTitleField;
@property (weak, nonatomic) IBOutlet UITextField *taskAddressField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionField;
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *assignedUserLabel;
@property (weak, nonatomic) IBOutlet UIButton *completeTaskButton;
@property (weak, nonatomic) IBOutlet UIButton *shareTaskButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UISwitch *importantSwitch;
@property (nonatomic, strong) NSString *getStatus;

@end

@implementation myTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set the local property as current Status:
    self.getStatus = self.task.Status;
    
    [self setupViewController];
    [self setupTaskStatus];
    [self setupCompletedTask];

}
- (void)viewDidAppear:(BOOL)animated {
    [self setupTaskStatus];
    
}

- (void)setupTaskStatus {
    UIImage *userOFFPic = [UIImage imageNamed:@"User-off-50"];
    
    //set the status labels
    if ([self.getStatus isEqual:StatusCreated]) {
        self.assignedUserLabel.text = @"Not Assinged";
        [self.userPhotoImageView setImage:userOFFPic];
        self.shareTaskButton.backgroundColor = [UIColor blueColor];
        [self.shareTaskButton setTitle:@"FIND USER" forState:UIControlStateNormal];
        self.statusLabel.text = StatusCreated;
        self.statusLabel.backgroundColor = [UIColor lightGrayColor];
    }

    if ([self.getStatus isEqual:StatusAssigned]) {
        [self setupAssignedInfo];
        self.statusLabel.text = StatusAssigned;
        self.statusLabel.backgroundColor = [UIColor orangeColor];
    }
    
    if ([self.getStatus isEqual:StatusAccepted]) {
        [self setupAssignedInfo];
        self.statusLabel.text = StatusAccepted;
        self.statusLabel.backgroundColor = [UIColor blueColor];
    }
    
    if ([self.getStatus isEqual:StatusCompleted]) {
        [self setupAssignedInfo];
        self.statusLabel.text = @"DONE";
        self.statusLabel.backgroundColor = [UIColor blackColor];
    }
    
    
}
- (void)setupAssignedInfo {

    self.assignedUserLabel.text = self.assignedUser[@"userFullName"];
    self.shareTaskButton.backgroundColor = [UIColor redColor];
    [self.shareTaskButton setTitle:@"SHARED" forState:UIControlStateNormal];

    [Settings getUserImage:self.assignedUser toImageView:self.userPhotoImageView];
    [Settings setupUserImage:self.userPhotoImageView];
}


- (void)setupViewController {
    //setup the picture image:
    [Settings setupUserImage:self.userPhotoImageView];
    
    self.taskTitleField.text = self.task.taskName;
    self.taskAddressField.text = self.task.taskAddress;
    self.taskDescriptionField.text = self.task.taskDescription;
    self.assignedUser = self.task.taskAssignee;
    
    if (self.task.taskImportant == YES) {
        [self.importantSwitch setOn:YES];
    }else {
        [self.importantSwitch setOn:NO];
    }

}
- (void)setupCompletedTask {
    //Task = Satatus = Completed (DONE):
    if ([self.task.Status isEqual:StatusCompleted]) {
        [self.completeTaskButton setTitle: @"COMPLETED" forState: UIControlStateNormal];
        self.completeTaskButton.backgroundColor = [UIColor darkGrayColor];
        self.completeTaskButton.enabled = NO;
        self.shareTaskButton.enabled = NO;
        self.importantSwitch.enabled = NO;
        self.assignedUserLabel.text = @" ";
        self.userPhotoImageView.highlighted = NO;
        self.taskTitleField.enabled = NO;
        self.taskDescriptionField.editable = NO;
        self.taskAddressField.enabled = NO;
        self.saveButton.enabled = NO;
        self.saveButton.title = @"";

        UIAlertView *completeAlert = [[UIAlertView alloc]initWithTitle:@"Alert"message:@"This Task will be removed from your app in 3 days" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [completeAlert show];
    }
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
    
    self.task.taskName = self.taskTitleField.text;
    self.task.taskAddress = self.taskAddressField.text;
    self.task.taskDescription = self.taskDescriptionField.text;
    self.task.taskAssignee = self.assignedUser;

    self.task.Status = self.getStatus;

    //UISwitch value save.
    if ([self.importantSwitch isOn]) {
        self.task.taskImportant = YES;
    }else {
        self.task.taskImportant = NO;
    }
    
    [self.task pinInBackground];
    [self.task save];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"shareTask"]) {
        FindFriendViewController *friendsVC = [segue destinationViewController];
        friendsVC.delegate = self;
    }

}
# pragma mark - Custom Delegate (Find Friend)
//custom delegate
- (void)didSelectFriend:(User *)user {
    
    if ([user.username isEqualToString:@"NONE"]) {
        self.assignedUser = nil;
        self.getStatus = StatusCreated;
    }else {
        self.assignedUser = user;
        self.getStatus = StatusAssigned;
    }
    [self setupTaskStatus];
}

#pragma mark - TABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark - TextFieldDelegate:
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}//dismiss the keyboard.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.taskTitleField resignFirstResponder];
    [self.taskAddressField resignFirstResponder];
    [self.taskDescriptionField resignFirstResponder];
    [self.statusLabel resignFirstResponder];
    [self.assignedUserLabel resignFirstResponder];
}


@end
