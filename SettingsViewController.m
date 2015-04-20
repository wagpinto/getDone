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
@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.pictureImage.layer.cornerRadius = self.pictureImage.frame.size.height / 2;
    self.pictureImage.clipsToBounds = YES;
    self.pictureImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.pictureImage.layer.borderWidth = 0.5f;
    
    
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
- (IBAction)logout:(id)sender {
    [PFUser logOut];
}
- (IBAction)takePicture:(id)sender {



}

@end
