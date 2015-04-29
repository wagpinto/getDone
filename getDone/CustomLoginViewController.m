//
//  CustomLoginViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/25/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "CustomLoginViewController.h"

@interface CustomLoginViewController () <UITextFieldDelegate>

@end

@implementation CustomLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
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
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please try again and check your network connection" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:nil];
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

# pragma mark - TextFieldDelegate:
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userNameLogin resignFirstResponder];
    [self.passwordLogin resignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}//dismiss the keyboard.

@end
