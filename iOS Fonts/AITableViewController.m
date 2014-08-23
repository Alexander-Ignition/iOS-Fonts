//
//  AITableViewController.m
//  iOS Fonts
//
//  Created by iМас on 29.03.14.
//  Copyright (c) 2014 Alexander Ignition. All rights reserved.
//


#import "AITableViewController.h"
#import "AIViewController.h"


@interface AITableViewController ()

@property (strong, nonatomic) NSArray *fontFamilyNames;
@property (strong, nonatomic) NSArray *sectionIndexChar;
@property (strong, nonatomic) NSArray *sectionIndexTitle;
@property (strong, nonatomic) NSArray *searchResults;

@end


@implementation AITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSDictionary *dict = @{ NSFontAttributeName : [UIFont fontWithName:@"Cochin-Italic" size:21.0], };
//    self.navigationController.navigationBar.titleTextAttributes = dict;
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

- (NSArray *)sectionIndexChar
{
    if (_sectionIndexChar) {
        return _sectionIndexChar;
    }
    NSMutableArray *mArray = [NSMutableArray array];
    [mArray addObject:UITableViewIndexSearch];
    NSMutableArray *mArray2 = [NSMutableArray array];
    for (NSString *familyName in self.fontFamilyNames) {
        NSString *firstChar = [familyName substringToIndex:1];
        if (![mArray containsObject:firstChar]) {
            [mArray addObject:firstChar];
            [mArray2 addObject:familyName];
        }
    }
    self.sectionIndexTitle = mArray2;
    _sectionIndexChar = mArray;
    return _sectionIndexChar;
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
    NSString *familyName;
    if (self.tableView == self.searchDisplayController.searchResultsTableView) {
        familyName = [self.searchResults objectAtIndex:index];
    } else {
        familyName = [self.fontFamilyNames objectAtIndex:index];
    }
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    return [fontNames objectAtIndex:index2];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    } else {
        return [self.fontFamilyNames count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults objectAtIndex:section];
    } else {
        return [self.fontFamilyNames objectAtIndex:section];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *familyName;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        familyName = [self.searchResults objectAtIndex:section];
    } else {
        familyName = [self.fontFamilyNames objectAtIndex:section];
    }
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    return [fontNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *familyName;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        familyName = [self.searchResults objectAtIndex:indexPath.section];
    } else {
        familyName = [self.fontFamilyNames objectAtIndex:indexPath.section];
    }
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    NSString *fontName = [fontNames objectAtIndex:indexPath.row];
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:16];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionIndexChar;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (index == 0) {
        [tableView setContentOffset:CGPointMake(0.0, -tableView.contentInset.top) animated:NO];
        return NSNotFound;
    } else {
        NSString *fontName = [self.sectionIndexTitle objectAtIndex:(index - 1)];
        return [self.fontFamilyNames indexOfObject:fontName];
    }
}


#pragma mark - search

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchString];
    self.searchResults = [self.fontFamilyNames filteredArrayUsingPredicate:resultPredicate];
    
    return YES;
}

@end
