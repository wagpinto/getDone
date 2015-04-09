//
//  DateFormat.m
//  getDone
//
//  Created by Wagner Pinto on 4/8/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "DateFormat.h"

@implementation DateFormat


- (void)formatDate:(NSDate *)date andTime:(NSDate *)time {

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                   fromDate:[NSDate date]];
    
//    [components]

    
}


@end
