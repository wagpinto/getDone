//
//  GroupTask.m
//  getDone
//
//  Created by Wagner Pinto on 3/27/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "GroupTask.h"

static NSString * const GroupClassName = @"GroupTask";

@implementation GroupTask

@dynamic groupTitle;
@dynamic groupDescription;

+ (NSString *)parseClassName {
    return GroupClassName;
}

@end
