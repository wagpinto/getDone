//
//  NSDate+CombiningDates.m
//  getDone
//
//  Created by Wagner Pinto on 4/22/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "NSDate+CombiningDates.h"

@implementation NSDate (CombiningDates)

+ (NSDate *)dateByCombiningDay:(NSDate *)dayDate time:(NSDate *)timeDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *timeComponents = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                                   fromDate:timeDate];
    return [calendar dateBySettingHour:timeComponents.hour
                                minute:timeComponents.minute
                                second:timeComponents.second
                                ofDate:dayDate
                               options:0];
}

@end
