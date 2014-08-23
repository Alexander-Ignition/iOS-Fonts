//
//  AITableViewDataSource.m
//  iOS Fonts
//
//  Created by iМас on 23.08.14.
//  Copyright (c) 2014 Alexander Ignition. All rights reserved.
//

#import "AITableViewDataSource.h"


@interface AITableViewDataSource ()

@property (strong, nonatomic) NSArray *sectionIndexChar;
@property (strong, nonatomic) NSArray *sectionIndexTitle;

@end


@implementation AITableViewDataSource

- (instancetype)initWithItems:(NSArray *)fontFamilyNames
{
    if (self = [super init]) {
        self.fontFamilyNames = fontFamilyNames;
    }
    return self;
}


#pragma mark - Getters

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


#pragma mark - Setters

- (void)setFontFamilyNames:(NSArray *)fontFamilyNames
{
    _fontFamilyNames = fontFamilyNames;
    self.sectionIndexChar = nil;
    self.sectionIndexTitle = nil;
}


#pragma mark - Sections

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.fontFamilyNames count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.fontFamilyNames objectAtIndex:section];
}


#pragma mark - Row

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
    NSString *familyName = [self.fontFamilyNames objectAtIndex:indexPath.section];
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    NSString *fontName = [fontNames objectAtIndex:indexPath.row];
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:16];
    
    return cell;
}


#pragma mark - Section Index

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


@end
