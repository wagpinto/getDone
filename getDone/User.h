//
//  User.h
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *passwork;
@property (nonatomic, strong) NSString *userFullName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) PFFile *userPic;

+ (NSString *)parseClassName;

@end
