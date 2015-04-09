//
//  DateFormat.h
//  getDone
//
//  Created by Wagner Pinto on 4/8/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#import "TaskController.h"

@interface DateFormat : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *time;


- (void)formatDate:(NSDate *)date andTime:(NSDate *)time;

@end
