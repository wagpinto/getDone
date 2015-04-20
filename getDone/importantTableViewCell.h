//
//  importantTableViewCell.h
//  getDone
//
//  Created by Wagner Pinto on 4/18/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface importantTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL importantCell;

- (void)setImportantValue:(BOOL)important;

@end
