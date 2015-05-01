//
//  SettingsViewController.h
//  getDone
//
//  Created by Wagner Pinto on 3/29/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SettingsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationBarDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userPictureView;

@end
