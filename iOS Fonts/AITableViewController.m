//
//  AITableViewController.m
//  iOS Fonts
//
//  Created by iМас on 29.03.14.
//  Copyright (c) 2014 Alexander Ignition. All rights reserved.
//


#import "AITableViewController.h"


@interface AITableViewController ()

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


#pragma mark - UIFont

- (NSArray *)fontNamesForFamilyNameIndex:(NSInteger)index
{
    NSArray *familyNames = [UIFont familyNames];
    NSArray *sortedArray = [familyNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    NSString *familyName = [sortedArray objectAtIndex:index];
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    return fontNames;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *familyNames = [UIFont familyNames];
    NSArray *sortedArray = [familyNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    return [sortedArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *familyNames = [UIFont familyNames];
    NSArray *sortedArray = [familyNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    return [sortedArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
    NSArray *familyNames = [UIFont familyNames];
    NSString *familyName = [familyNames objectAtIndex:section];
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    return [fontNames count];
     */
    return [[self fontNamesForFamilyNameIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    /*
    NSArray *familyNames = [UIFont familyNames];
    NSString *familyName = [familyNames objectAtIndex:indexPath.section];
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    
    NSString *fontName = [fontNames objectAtIndex:indexPath.row];
    */
    
    NSString *fontName = [[self fontNamesForFamilyNameIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ рус", fontName];
    
    UIFont *font1 = [UIFont fontWithName:fontName size:16];
    cell.textLabel.font = font1;
    
    return cell;
}

//- (NSArray *) sectionIndexTitlesForTableView: (UITableView *) tableView {
//    NSArray *familyNames = [UIFont familyNames];
//    NSArray *sortedArray = [familyNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
//    return sortedArray;
//}

@end
