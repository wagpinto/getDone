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

    //alocate the search results when view load.
    self.searchResults = [[NSArray alloc]init];


}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)selectFriendButton:(id)sender {
    
//    [self.delegate didSelectFriend];
//    [self popoverPresentationController];

}

#pragma mark - SEARCH BAR
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - TABLE VIEW
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate didSelectFriend:[[TaskController sharedInstance].loadAllUser objectAtIndex:indexPath.row]];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    }else {
        return [TaskController sharedInstance].loadAllUser.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }else {
        PFUser *user = [[TaskController sharedInstance].loadAllUser objectAtIndex:indexPath.row];
        NSString *userName = [NSString stringWithFormat:@"%@  (%@)",user[@"userFullName"], user[@"username"]];
        cell.textLabel.text = userName;
    }
    PFUser *user = [[TaskController sharedInstance].loadAllUser objectAtIndex:indexPath.row];
    NSString *userName = [NSString stringWithFormat:@"%@ - (%@)",user[@"userFullName"], user[@"username"]];
    cell.textLabel.text = userName;
    return cell;
    
}




@end
