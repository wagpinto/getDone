//
//  Status.h
//  getDone
//
//  Created by Wagner Pinto on 4/8/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Status : NSObject

@property (nonatomic, strong) NSString * StatusName;

+ (NSString *)parseClassName;

@end
