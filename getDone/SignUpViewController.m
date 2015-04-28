//
//  SignUpViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/26/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "SignUpViewController.h"
#import <UIKit/UIKit.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];

}
- (void)keyboardWillShow {
    // Animate the current view out of the way
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, -160, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
- (void)keyboardWillHide {
    // Animate the current view back to its original position
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
- (IBAction)SignIn:(id)sender {

    if (self.confirmPassSingIn.text != nil &&
        self.emailSignIn.text != nil &&
        self.passwordSignIn.text != nil &&
        self.userNameSignIn.text != nil){
        
        [self.confirmPassSingIn resignFirstResponder];
        [self.passwordSignIn resignFirstResponder];
        [self.emailSignIn resignFirstResponder];
        
        [self registerNewUser];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Must enter all user information to continue." message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (void)registerNewUser {
    
    // Passwords match
    if ([self.passwordSignIn.text isEqualToString:self.confirmPassSingIn.text]){
        
        // Create new user
        PFUser *user = [PFUser user];
        // Set user properties to text fields
        user[@"userFullName"] = self.fullNameSignIn.text;
        user.username = self.userNameSignIn.text;
        user.email = self.emailSignIn.text;
        user.password = self.passwordSignIn.text;
        
        // SignUp new user
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded == YES){
                [PFUser logInWithUsernameInBackground:user.username password:user.password];
                [self performSegueWithIdentifier:@"signedUp" sender:nil];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Signing Up" message:@"Please double check your user information and try again" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
                NSLog(@"Error Signing Up: %@", error);
            }
        }];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Passwords do not match!" message:@"Please retype password fields." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        
        self.passwordSignIn.text = @"";
        self.confirmPassSingIn.text = @"";
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (IBAction)cancelSignIn:(id)sender {
    [self performSegueWithIdentifier:@"cancel" sender:self];
}

# pragma mark - TextFieldDelegate:
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}//dismiss the keyboard.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userNameSignIn resignFirstResponder];
    [self.fullNameSignIn resignFirstResponder];
    [self.emailSignIn resignFirstResponder];
    [self.passwordSignIn resignFirstResponder];
    [self.confirmPassSingIn resignFirstResponder];
}

@end
