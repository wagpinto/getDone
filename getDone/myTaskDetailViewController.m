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
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *importantLabel;
@property (weak, nonatomic) IBOutlet UILabel *recurringLabel;

@property (nonatomic, assign) BOOL important;
@property (nonatomic, assign) BOOL recurring;
@property (nonatomic, strong) importantTableViewCell * impCell;
@property (nonatomic, strong) recurringTableViewCell * recuCell;

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
    
    //set the important tableViewCell value:
    [self getCellValue];
    
    [self.tableView reloadData];
}
- (void)updateWithTask:(Task *)task {
    
    self.task = task;
    
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)CompleteTask:(id)sender {
    
    [[TaskController sharedInstance]addTaskWithName:self.taskTitleField.text
                                               Desc:self.taskDescriptionField.text
                                            DueDate:[NSDate date]
                                              Owner:[PFUser currentUser]
                                           Assignee:nil
                                          Important:self.important // get the value from tapping the cell.
                                            Current:self.recurring // get the value from tapping the cell.
                                            Address:self.taskAddressField.text
                                             Status:StatusCompleted
                                              Group:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)save:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    Task *saveTask = [query getObjectWithId:self.task.objectId];
    
    saveTask.taskName = self.taskTitleField.text;
    saveTask.taskAddress = self.taskAddressField.text;
    saveTask.taskDescription = self.taskDescriptionField.text;
    saveTask.taskImportant = self.important;
    saveTask.taskRecurring = self.recurring;
    
    [saveTask pinInBackground];
    [saveTask save];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)shareTask:(id)sender {
    
}

#pragma mark - TABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self getCellValue];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getCellValue {
    //get Important Valeu
    if (self.task.taskImportant == YES) {
        [self.impCell setImportantCell:YES];
        self.important = YES;
        self.importantLabel.text = @"IMPORTANT";
    }else{
        [self.impCell setImportantCell:NO];
        self.important = NO;
        self.importantLabel.text = @"TAP FOR IMPORTANT";
    }

    //get Recurring Value
    if (self.task.taskRecurring == YES) {
        [self.recuCell setRecurringCell:YES];
        self.recurring = YES;
        self.recurringLabel.text = @"RECURRING TASK";
    }else {
        [self.recuCell setRecurringCell:NO];
        self.recurring = NO;
        self.recurringLabel.text = @"TAP FOR RECURRING";
    }

}

@end
