//
//  SettingsViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/29/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "SettingsViewController.h"
#import "TaskController.h"

@interface SettingsViewController ()//<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.userNameLabel.text = [PFUser currentUser].username;
    self.emailLabel.text = [PFUser currentUser].email;
    
    UISwipeGestureRecognizer *swipeDismiss = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeToClose)];
    swipeDismiss.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeDismiss];
    
}

- (void)SwipeToClose {
    NSLog(@"Done");
//    [self performSegueWithIdentifier:@"closeSettings" sender:self];
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self dismissViewControllerAnimated:YES completion:nil];
}
                                              

//Method that removes duplicates from an array with NSSet.
- (NSArray *)removeDuplucatesFrom:(NSArray *)array{
    return [[NSSet setWithArray:array]allObjects];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
