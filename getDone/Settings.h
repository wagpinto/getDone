//
//  Constants.h
//  getDone
//
//  Created by Wagner Pinto on 4/16/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"

extern NSString *const StatusCreated;
extern NSString *const StatusAssigned;
extern NSString *const StatusAccepted;
extern NSString *const StatusDenied;
extern NSString *const StatusCompleted;


@interface Settings : NSObject

+ (void)setupUserImage:(UIImageView *)userImage;
+ (void)getUserImage:(User *)userPic toImageView:(UIImageView *)imageView;

@end
