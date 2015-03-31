//
//  CreateTaskViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/31/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "CreateTaskViewController.h"
#import "TaskController.h"

@interface CreateTaskViewController ()

@end

@implementation CreateTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)submitPressed:(id)sender {
    
    [self SaveTask];
    //create a custom delegate to allow the close button to dismiss the view.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)SaveTask {
    [[TaskController sharedInstance]addTaskWithName:@"TEST 1" Desc:@"this is a creation test" DueDate:[NSDate date] Owner:[PFUser currentUser] Assignee:nil Important:YES];
} //working =)

@end
