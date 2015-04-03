//
//  CreateTaskViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/31/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "CreateTaskViewController.h"
#import "TaskController.h"

@interface CreateTaskViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taskNameField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionField;
@property (weak, nonatomic) IBOutlet UISwitch *ImportantToggle;

@end

@implementation CreateTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
}
- (IBAction)SaveTask:(id)sender {
    
    if (self.taskNameField.text != nil) {
        //save task
        [[TaskController sharedInstance]addTaskWithName:self.taskNameField.text Desc:self.taskDescriptionField.text DueDate:[NSDate date] Owner:[PFUser currentUser] Assignee:nil Important:self.ImportantToggle.state];
        
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}//dismiss the keyboard.
    

@end
