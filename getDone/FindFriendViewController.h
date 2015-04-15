//
//  SecondViewController.h
//  getDone
//
//  Created by Wagner Pinto on 3/25/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TaskController.h"
#import "User.h"

@protocol FindFriendsDelegate;

@interface FindFriendViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate>

@property (nonatomic, strong) id <FindFriendsDelegate> delegate;

@end

@protocol FindFriendsDelegate <NSObject>

- (void)didSelectFriend:(User *)user;


@end