//
//  ViewController.m
//  UISearchDisplayControllerDemo
//
//  Created by litt1e-p on 15/12/8.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<UISearchBarDelegate>
{
    UISearchBar *_searchBar ;
    UISearchDisplayController *_resultController;
    NSMutableArray *_searchResults;
    NSArray *_searchOptions;
}

@end

@implementation ViewController

static NSString * const kSearchControllerDefaultCellID = @"kSearchControllerDefaultCellID";
static NSString * const kSearchControllerResultCellID = @"kSearchControllerResultCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SEARCH";
    [self setUpSearchView];
    [self setUpTableView];
}

- (void)setUpTableView
{
    self.tableView.tableHeaderView = _searchBar;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _searchResults                 = [NSMutableArray array];
    _searchOptions                 = [self searchOptions];
    self.searchDisplayController.searchResultsTableView.tableFooterView = [[UIView alloc] init];
}

- (void)setUpSearchView
{
    [self setUpSearchBar];
    _resultController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _resultController.searchResultsDataSource = self;
    _resultController.searchResultsDelegate   = self;
}

- (void)setUpSearchBar
{
    _searchBar           = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _searchBar.tintColor = [UIColor lightGrayColor];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    UIImage *closeImg = [UIImage imageNamed:@"close_white"];
    closeImg          = [closeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setImage:closeImg];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@""];
    _searchBar.delegate       = self;
    _searchBar.exclusiveTouch = YES;
}

#pragma mark UISearchDisplayDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_searchResults addObject:@"result"];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [_resultController setActive:NO animated:NO];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return !_searchResults.count ? 1 : _searchResults.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_searchResults.count) {
        return [UIScreen mainScreen].bounds.size.height * 340 / 959;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_searchResults.count) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchControllerDefaultCellID];
        if (!cell) {
            cell = [[TableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchControllerResultCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kSearchControllerResultCellID];
        }
        cell.textLabel.text = @"sad";
        return cell;
    }
}

#pragma mark - search Results
- (NSMutableArray *)searchOptions
{
    return [NSMutableArray arrayWithObjects:
            @{@"sea" : @"sea_express"},
            @{@"plane" : @"air_express"},
            @{@"car" : @"trailer"},
            nil
            ];
}

@end
