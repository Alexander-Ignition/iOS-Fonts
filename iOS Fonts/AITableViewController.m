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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *fontName = [self fontNameForFamilyNameIndex:indexPath.section
                                         andFontNameIndex:indexPath.row];
    NSString *familyFontName = [self.fontFamilyNames objectAtIndex:indexPath.section];
    AIViewController *controller = segue.destinationViewController;
    controller.fontName = fontName;
    controller.familyFontName = familyFontName;
}


#pragma mark - UIFont

- (NSString *)fontNameForFamilyNameIndex:(NSInteger)index andFontNameIndex:(NSInteger)index2
{
    NSString *familyName = [self.fontFamilyNames objectAtIndex:index];
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    return [fontNames objectAtIndex:index2];
}

@end
