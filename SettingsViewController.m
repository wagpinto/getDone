//
//  SettingsViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/29/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "SettingsViewController.h"
#import "TaskController.h"
#import "User.h"

@interface SettingsViewController ()//<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    User *user = [User new];
    
    self.userNameLabel.text = user.userFullName;
    self.emailLabel.text = user.email;
    
    UISwipeGestureRecognizer *swipeDismiss = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeToClose)];
    swipeDismiss.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeDismiss];
    
}
- (void)SwipeToClose {
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
