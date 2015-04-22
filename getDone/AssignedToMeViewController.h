//
//  AssignedToMeViewController.h
//  getDone
//
//  Created by Wagner Pinto on 4/21/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignedToMeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
