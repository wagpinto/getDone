//
//  GroupTask.h
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <Parse/Parse.h>

@interface GroupTask : PFObject

@property (nonatomic, strong) NSString *groupTitle;
@property (nonatomic, strong) NSString *groupDescription;

+ (NSString *)parseClassName;

@end
