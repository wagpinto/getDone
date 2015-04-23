//
//  SecondViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/25/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "FindFriendViewController.h"
#import "CreateTaskViewController.h"

static NSString *cellID = @"cellID";

@interface FindFriendViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
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

#pragma mark - SEARCH BAR
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    PFUser *user = [[TaskController sharedInstance].loadAllUser objectAtIndex:indexPath.row];
    NSString *userName = [NSString stringWithFormat:@"%@ - (%@)",user[@"userFullName"], user[@"username"]];
    cell.textLabel.text = userName;
    return cell;
    
}




@end
