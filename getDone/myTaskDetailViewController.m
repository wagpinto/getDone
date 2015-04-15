//
//  myTaskDetailViewController.m
//  getDone
//
//  Created by Wagner Pinto on 4/6/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "myTaskDetailViewController.h"
#import "TaskController.h"

@interface myTaskDetailViewController ()

@property (nonatomic, strong) Task *task;

@property (weak, nonatomic) IBOutlet UITextField *taskTitleField;
@property (weak, nonatomic) IBOutlet UITextField *taskAddressField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionField;
@property (weak, nonatomic) IBOutlet UISwitch *importantSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *recurringSwitch;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *hourField;
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation myTaskDetailViewController

@synthesize importantSwitch;
@synthesize recurringSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViewController];
    
}

- (void)setupViewController {
    //setup the image:
    self.userPhotoImageView.layer.cornerRadius = self.userPhotoImageView.frame.size.height / 2;
    self.userPhotoImageView.clipsToBounds = YES;
    //self.userPhotoImageView.layer.borderColor = [UIColor redColor].CGColor;
    //self.userPhotoImageView.layer.borderWidth = 1.0f;
    
    self.taskTitleField.text = self.task.taskName;
    self.taskAddressField.text = self.task.taskAddress;
    self.taskDescriptionField.text = self.task.taskDescription;
    [self.importantSwitch setOn:NO];
    [self.recurringSwitch setOn:NO];
    
    [self.tableView reloadData];
}
- (void)updateWithTask:(Task *)task {

    self.task = task;
    
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)save:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    Task *saveTask = [query getObjectWithId:self.task.objectId];
    
    saveTask.taskName = self.taskTitleField.text;
    saveTask.taskAddress = self.taskAddressField.text;
    saveTask.taskDescription = self.taskDescriptionField.text;
    saveTask.taskImportant = self.importantSwitch.state;
    saveTask.taskRecurring = self.recurringSwitch.state;
//    saveTask.taskDueDate =
//    saveTask.taskStatus =
    
    [saveTask pinInBackground];
    [saveTask save];

    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)shareTask:(id)sender {

}
- (IBAction)addDate:(id)sender {
    
}
- (IBAction)addHour:(id)sender {
    
}

@end
