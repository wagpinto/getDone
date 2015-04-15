//
//  User.m
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "User.h"

static NSString * const UserClassName = @"User";

@implementation User

@dynamic userName;
@dynamic userFullName;
@dynamic email;
@dynamic passwork;
@dynamic userPic;

+ (NSString *)parseClassName {
    return UserClassName;
}

+ (void)load {
    [self registerSubclass];
}

@end
