//
//  SecondViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/25/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "FindFriendViewController.h"
#import "CreateTaskViewController.h"
#import "FindFriendsCell.h"

static NSString *cellID = @"cellID";

@interface FindFriendViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation FindFriendViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResults = [[NSArray alloc]init];
    [[TaskController sharedInstance] loadAllUser:^(BOOL completion) {
        [self.tableView reloadData];
    }];
    
}
- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TABLE VIEW
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate didSelectFriend:[[TaskController sharedInstance].loadAllUser objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [TaskController sharedInstance].loadAllUser.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FindFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    User *user = [[TaskController sharedInstance].loadAllUser objectAtIndex:indexPath.row];
    UIImage *noImage = [UIImage imageNamed:@"User-off-50"];

    //set cell properties:
    cell.userPictureView.contentMode = UIViewContentModeScaleAspectFit;
    cell.userPictureView.layer.cornerRadius = cell.userPictureView.frame.size.height / 2;
    cell.userPictureView.clipsToBounds = YES;
    cell.userPictureView.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.userPictureView.layer.borderWidth = 0.8f;
    
    if (user[@"UserPicture"] == nil) {
        [cell.userPictureView setImage: noImage];
    }else {
        [user[@"UserPicture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                [cell.userPictureView setImage: image];
            }
        }];
    }

    cell.userFullNameLabel.text = user[@"userFullName"];
    cell.usernameLabel.text = user.username;

    return cell;
}

@end
