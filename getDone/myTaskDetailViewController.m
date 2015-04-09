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

@end

@implementation myTaskDetailViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.taskTitleField.text = self.task.taskName;
    self.taskAddressField.text = self.task.taskAddress;
    self.taskDescriptionField.text = self.task.taskDescription;
    [self.tableView reloadData];
}

- (void)updateWithTask:(Task *)task{

    self.task = task;
    
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)save:(id)sender {
    
    
    [[TaskController sharedInstance]updateTask:self.task];
}
- (IBAction)shareTask:(id)sender {

}
- (IBAction)addDate:(id)sender {
    
}
- (IBAction)addHour:(id)sender {
    
}

@end
