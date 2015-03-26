//
//  SignUpViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/26/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)SignIn:(id)sender {

    [self.userNameSignIn resignFirstResponder];
    [self.passwordSignIn resignFirstResponder];
    [self.emailSignIn resignFirstResponder];
    
    [self registerNewUser];
    
}

-(void)registerNewUser {
    
    PFUser *user = [PFUser user];
    
    user.username = self.userNameSignIn.text;
    user.email = self.emailSignIn.text;
    user.password = self.passwordSignIn.text;
//    user.userFullName = self.fullNameSignIn.text;
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error){
            [self performSegueWithIdentifier:@"signedUp" sender:self];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Username and Password must be greater then 5 characters" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:nil];
            [alert show];
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
        }
    }];
}

- (IBAction)cancelSignIn:(id)sender {
    [self performSegueWithIdentifier:@"cancel" sender:self];
}
@end
