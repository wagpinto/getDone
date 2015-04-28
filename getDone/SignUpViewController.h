//
//  SignUpViewController.h
//  getDone
//
//  Created by Wagner Pinto on 3/26/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameSignIn;
@property (weak, nonatomic) IBOutlet UITextField *fullNameSignIn;
@property (weak, nonatomic) IBOutlet UITextField *emailSignIn;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignIn;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassSingIn;


- (IBAction)SignIn:(id)sender;
- (IBAction)cancelSignIn:(id)sender;


@end
