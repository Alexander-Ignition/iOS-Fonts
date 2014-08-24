//
//  AITableViewController.m
//  iOS Fonts
//
//  Created by iМас on 29.03.14.
//  Copyright (c) 2014 Alexander Ignition. All rights reserved.
//

#import "AITableViewController.h"
#import "AIViewController.h"
#import "AITableViewDataSource.h"
#import "AISearchDisplayDelegate.h"


@interface AITableViewController ()

@property (strong, nonatomic) NSArray *fontFamilyNames;
@property (strong, nonatomic) AITableViewDataSource *tableViewDataSource;
@property (strong, nonatomic) AITableViewDataSource *searchResultsTableViewDataSource;
@property (strong, nonatomic) AISearchDisplayDelegate *searchDisplayDelegate;

@end


@implementation AITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSDictionary *dict = @{ NSFontAttributeName : [UIFont fontWithName:@"Cochin-Italic" size:21.0], };
//    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.tableViewDataSource = [[AITableViewDataSource alloc] initWithItems:self.fontFamilyNames];
    self.tableView.dataSource = self.tableViewDataSource;
    
    self.searchResultsTableViewDataSource = [[AITableViewDataSource alloc] init];
    self.searchDisplayController.searchResultsTableView.dataSource = self.searchResultsTableViewDataSource;
    
    self.searchDisplayDelegate = [[AISearchDisplayDelegate alloc] initWithItems:self.fontFamilyNames];
    self.searchDisplayController.delegate = self.searchDisplayDelegate;
}


#pragma mark - Getters

- (NSArray *)fontFamilyNames
{
    if (_fontFamilyNames) {
        return _fontFamilyNames;
    }
    NSArray *familyNames = [UIFont familyNames];
    _fontFamilyNames = [familyNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    return _fontFamilyNames;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        AIViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detail"];
        NSString *familyFontName = [self.searchResultsTableViewDataSource.fontFamilyNames objectAtIndex:indexPath.section];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyFontName];
        NSString *fontName = [fontNames objectAtIndex:indexPath.row];
        controller.fontName = fontName;
        controller.familyFontName = familyFontName;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *familyFontName = [self.fontFamilyNames objectAtIndex:indexPath.section];
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyFontName];
    NSString *fontName = [fontNames objectAtIndex:indexPath.row];
    AIViewController *controller = segue.destinationViewController;
    controller.fontName = fontName;
    controller.familyFontName = familyFontName;
}

@end
