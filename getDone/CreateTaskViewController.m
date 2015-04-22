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
#import "Constants.h"
#import "NSDate+CombiningDates.h"

@interface CreateTaskViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, FindFriendsDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taskNameField;
@property (weak, nonatomic) IBOutlet UITextField *taskDescriptionField;
@property (weak, nonatomic) IBOutlet UITextField *taskAddressField;
@property (weak, nonatomic) IBOutlet UITextField *dueDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *dueTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *assignedLabel;

@property (nonatomic) NSDate *DueDate;

@property (weak, nonatomic) IBOutlet UISwitch *importantButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dateSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hourSegment;

@property (strong, nonatomic) NSDate *dayDate;
@property (strong, nonatomic) NSDateComponents *timeDate;
@property (nonatomic,strong) NSString *status;

@end

@implementation CreateTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewController];
    self.taskNameField.delegate = self;
    self.taskDescriptionField.delegate = self;
    self.timeDate = [[NSDateComponents alloc] init];
    self.dayDate = [NSDate date];
    

}
- (void)setupViewController {
    
    //set the dates:
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *today = [NSDate date];
    [dateFormat setDateFormat:@"E-MM/dd"];
    NSString *todayString = [dateFormat stringFromDate:today];
    self.dueDateLabel.text = todayString;
    self.dueTimeLabel.text = @"9:00 am";
    
    if (!self.assignedUser) {
        self.assignedLabel.text = @"Not Assinged";
    }else {
        self.assignedLabel.text = self.assignedUser.userFullName;
    }
    
    
} //setup all the properties as the view load.
- (IBAction)SaveTask:(id)sender {
    
    //combine date and hour for dueDate value
    //set NSString to a NSDate:
    NSString *taskDueDate = [NSString stringWithFormat:@"%@ %@",self.dueDateLabel.text, self.dueTimeLabel.text];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"e-mm/dd - hh:mm a"]; //this format needs to match Parse Date Format.
    
    NSDate *dateFromString = [dateFormatter dateFromString:taskDueDate];
//    dateFromString = [dateFormatter dateFromString:taskDueDate];
    
    NSDate *date1 = dateFromString;
    NSDate *date2 = dateFromString; // Made up to get some random date, basically
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = 9;
    NSDate *combinedDate = [NSDate dateByCombiningDay:[NSDate date] time:[[NSCalendar currentCalendar] dateFromComponents:components]];
    NSLog(@"%@ %@ combined: %@", date1, date2, combinedDate);
    
    //set the status
    if (self.assignedUser == nil) {
        self.status = StatusCreated;
    }else {
        self.status = StatusAssigned;
    }
    
    //set important state:
    BOOL importantValue;
    
    if ([self.importantButton isOn]) {
        importantValue = YES;
    }else {
        importantValue = NO;
    }
    
    //save task
    if (![self.taskNameField.text isEqual: @""]) {
        [[TaskController sharedInstance]addTaskWithName:self.taskNameField.text
                                                   Desc:self.taskDescriptionField.text
                                                DueDate:dateFromString
                                                  Owner:[PFUser currentUser]
                                               Assignee:self.assignedUser
                                              Important:importantValue
                                                Current:nil
                                                Address:self.taskAddressField.text
                                                 Status:self.status
                                                  Group:nil];
        //create a custom delegate to allow the close button to dismiss the view.
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Task Name" message:@"You need a task name in order to save" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [error show];
    }
    
} //create the task and sabe in backgroun
- (IBAction)Cancel:(id)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
    
} //dismiss the screen in case of canceling the action

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 3;
            break;
            
        default:
            return 4;
            break;
    }
}

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
            self.dayDate = today;
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
            self.dueTimeLabel.text = @"9:00 am";
            self.timeDate.hour = 9;
            break;
        case 1:
            self.dueTimeLabel.text = @"12:00 pm";
            break;
        case 2:
            self.dueTimeLabel.text = @"3:00 pm";
            break;
        default:
            self.dueTimeLabel.text = @"6:00 pm";
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FindFriendViewController *friendsVC = [segue destinationViewController];
    friendsVC.delegate = self;
}

# pragma mark - Custom Delegate (Find Friend)
- (void)didSelectFriend:(User *)user {
    self.assignedUser = user;
} //custom delegate


# pragma mark - TextFieldDelegate:
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}//dismiss the keyboard.

@end
