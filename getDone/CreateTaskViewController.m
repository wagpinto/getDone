//
//  CreateTaskViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/31/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "CreateTaskViewController.h"
#import "TaskController.h"

@interface CreateTaskViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *taskNameField;
@property (weak, nonatomic) IBOutlet UITextField *taskDescriptionField;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextField *taskAddressField;
@property (weak, nonatomic) IBOutlet UITextField *dueDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *dueTimeLabel;

@property (weak, nonatomic) IBOutlet UISwitch *importantButton;
@property (weak, nonatomic) IBOutlet UISwitch *recurrentButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *dateSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hourSegment;

@end

@implementation CreateTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set the current values:
    self.statusLabel.text = @"Created";
    
    
}
- (IBAction)SaveTask:(id)sender {
    
    //combine date and hour for dueDate value
    //set NSString to a NSDate:
    NSString *taskDueDate = [NSString stringWithFormat:@"%@ - %@",self.dueDateLabel.text, self.dueTimeLabel.text];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss + 0000"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:taskDueDate];

    //Teste date Format
    NSLog(@"date formated from String to NSDate: %@ NSDate %@", dateFromString, [NSDate date]);
    
    if (self.taskNameField.text != nil) {
        //save task
        [[TaskController sharedInstance]addTaskWithName:self.taskNameField.text
                                                   Desc:self.taskDescriptionField.text
                                                DueDate:[NSDate date]
                                                  Owner:[PFUser currentUser]
                                               Assignee:[PFUser currentUser]
                                              Important:self.importantButton.state
                                                Current:self.recurrentButton.state
                                                Address:self.taskAddressField.text
                                                 Status:nil];
        
        //create a custom delegate to allow the close button to dismiss the view.
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Task Name" message:@"You need a task name in order to save" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [error show];
    }
    
} //create the task and sabe in backgroun
- (IBAction)Cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
} //dismiss the screen in case of canceling the action

#pragma mark - SegmentControllers
- (NSDate *)formatDate:(NSInteger)days {
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = days;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];

    return nextDate;

}
- (IBAction)dateSegment:(id)sender {

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *today = [NSDate date];
   
    switch (self.dateSegment.selectedSegmentIndex) {
        case 0:{
            [dateFormat setDateFormat:@"E-MM/dd"];
            NSString *todayString = [dateFormat stringFromDate:today];
            self.dueDateLabel.text = todayString;
            }
            break;
        case 1:{
            today = [self formatDate:1];
            [dateFormat setDateFormat:@"E-MM/dd"];
            NSString *todayString = [dateFormat stringFromDate:today];
            self.dueDateLabel.text = todayString;
        }
            break;
        case 2:{
            today = [self formatDate:3];
            [dateFormat setDateFormat:@"E-MM/dd"];
            NSString *todayString = [dateFormat stringFromDate:today];
            self.dueDateLabel.text = todayString;
        }
            break;
        default:{
            today = [self formatDate:7];
            [dateFormat setDateFormat:@"E-MM/dd"];
            NSString *todayString = [dateFormat stringFromDate:today];
            self.dueDateLabel.text = todayString;
        }
            break;
    }
}
- (IBAction)timeSegment:(id)sender {
    
    switch (self.hourSegment.selectedSegmentIndex) {
        case 0:
            self.dueTimeLabel.text = @"9:00 AM";
            break;
        case 1:
            self.dueTimeLabel.text = @"12:00 PM";
            break;
        case 2:
            self.dueTimeLabel.text = @"3:00 PM";
            break;
        default:
            self.dueTimeLabel.text = @"6:00 PM";
            break;
    }
}

# pragma mark - TextFieldDelegate:
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}//dismiss the keyboard.
    

@end
