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

@end


@implementation AITableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.fontFamilyNames count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.fontFamilyNames objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *familyName = [self.fontFamilyNames objectAtIndex:section];
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
    
    NSString *fontName = [self fontNameForFamilyNameIndex:indexPath.section
                                         andFontNameIndex:indexPath.row];    
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:16];
    
    return cell;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSArray *familyNames = [UIFont familyNames];
//    NSMutableArray *mArray = [NSMutableArray array];
//    
//    for (NSString *familyName in familyNames) {
//        
//        NSString *firstChar = [familyName substringToIndex:1];
//        BOOL containts = [mArray containsObject:firstChar];
//        if (!containts) {
//            [mArray addObject:firstChar];
////            [mArray addObject:@"*"];
//        }
//    }
//    [mArray removeLastObject];
//    NSArray *sortedArray = [mArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
//    return sortedArray;
//}
//
//// tell table which section corresponds to section title/index (e.g. "B",1))
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return 1;
//}

@end
