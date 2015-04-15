//
//  CreateTaskViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/31/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "CreateTaskViewController.h"
#import "TaskController.h"
#import "FindFriendViewController.h"

@interface CreateTaskViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, FindFriendsDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taskNameField;
@property (weak, nonatomic) IBOutlet UITextField *taskDescriptionField;
@property (weak, nonatomic) IBOutlet UITextField *taskAddressField;
@property (weak, nonatomic) IBOutlet UITextField *dueDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *dueTimeLabel;

@property (weak, nonatomic) IBOutlet UISwitch *importantButton;
@property (weak, nonatomic) IBOutlet UISwitch *recurrentButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *dateSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hourSegment;

//@property (nonatomic, strong) Status *status;

@end

@implementation CreateTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)didSelectFriend:(User *)user{
    
    self.assignedUser = user;
    
    NSLog(@"DELEGATE CUSTOM");
}


- (IBAction)SaveTask:(id)sender {
    
    //combine date and hour for dueDate value
    //set NSString to a NSDate:
    NSString *taskDueDate = [NSString stringWithFormat:@"%@ - %@",self.dueDateLabel.text, self.dueTimeLabel.text];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"e-mm/dd - hh:mm a"]; //this format needs to match Parse Date Format.
    
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:taskDueDate];
    
    //set task status as Created or Assinged:
    PFQuery *Created = [PFQuery queryWithClassName:@"TaskStatus"];
    [Created whereKey:@"StatusName" equalTo:@"Created"];
    
    PFQuery *Assigned = [PFQuery queryWithClassName:@"TaskStatus"];
    [Assigned whereKey:@"StatusName" equalTo:@"Assigned"];
    Status *status = [Status new];
    
    if (self.assignedUser == nil ) {
        [status isEqual:Created];
    }else {
        [status isEqual:Assigned];
    }
    
    //save task
    if (![self.taskNameField.text  isEqual: @""]) {
        [[TaskController sharedInstance]addTaskWithName:self.taskNameField.text
                                                   Desc:self.taskDescriptionField.text
                                                DueDate:dateFromString
                                                  Owner:[PFUser currentUser]
                                               Assignee:self.assignedUser
                                              Important:self.importantButton.state
                                                Current:self.recurrentButton.state
                                                Address:self.taskAddressField.text
                                                 Status:status//[queryStatus valueForKey:@"ObjectId"] // <<<< POINTER of the STATUS CLASS in PARSE
                                                  Group:nil]; // <<<< POINTER of the STATUS CLASS in PARSE
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FindFriendViewController *friendsVC = [segue destinationViewController];
    friendsVC.delegate = self;
}

# pragma mark - TextFieldDelegate:
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}//dismiss the keyboard.
    

@end
