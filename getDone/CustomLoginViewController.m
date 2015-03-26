//
//  CustomLoginViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/25/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "CustomLoginViewController.h"

@interface CustomLoginViewController ()

@end

@implementation CustomLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];




}
-(void)viewDidAppear:(BOOL)animated {
    if ([PFUser currentUser] != nil){
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    }

}

- (void)Login:(id)sender{
    PFUser *user = [PFUser user];
    user.username = self.userNameLogin.text;
    user.password = self.passwordLogin.text;
    
    [PFUser logInWithUsernameInBackground:user.username password:user.password block:^(PFUser *user, NSError *error) {
        if (!error) {
            [self performSegueWithIdentifier:@"loggedIn" sender:self];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Username and Password must be greater then 5 characters" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:nil];
            [alert show];
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
