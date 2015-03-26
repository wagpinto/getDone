//
//  CustomLoginViewController.h
//  getDone
//
//  Created by Wagner Pinto on 3/25/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface CustomLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameLogin;
@property (weak, nonatomic) IBOutlet UITextField *passwordLogin;
- (IBAction)Login:(id)sender;

@end
