//
//  NSDate+CombiningDates.h
//  getDone
//
//  Created by Wagner Pinto on 4/22/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CombiningDates)

+ (NSDate *)dateByCombiningDay:(NSDate *)dayDate time:(NSDate *)timeDate;

@end
