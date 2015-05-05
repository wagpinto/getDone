//
//  Constants.m
//  getDone
//
//  Created by Wagner Pinto on 4/16/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "Settings.h"

NSString *const StatusCreated =      @"Created";
NSString *const StatusAssigned =     @"Assigned";
NSString *const StatusAccepted =     @"Accepted";
NSString *const StatusDenied =       @"Denied";
NSString *const StatusCompleted =    @"Completed";

@interface Settings ()

@property (nonatomic, strong) UIImage *noUserPicture;

@end

@implementation Settings

+ (void)setupUserImage:(UIImageView *)userImage{
    
    //Set the assigned user picture.
    userImage.layer.cornerRadius = userImage.frame.size.height / 2;
    userImage.contentMode = UIViewContentModeScaleAspectFit;
    userImage.clipsToBounds = YES;
    userImage.layer.borderColor = [UIColor redColor].CGColor;
    userImage.layer.borderWidth = 0.8f;
    
}

+ (void)getUserImage:(User *)userPic toImageView:(UIImageView *)imageView {
    UIImage *noImage = [UIImage imageNamed:@"User-off-50"];

    if (!userPic[@"UserPicture"]) {
        [imageView setImage:noImage];
    }else {
        [userPic[@"UserPicture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                imageView.image = image;
            }
        }];
        
    }
}
@end
