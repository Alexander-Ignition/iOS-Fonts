//
//  AISearchDisplayDelegate.m
//  iOS Fonts
//
//  Created by iМас on 23.08.14.
//  Copyright (c) 2014 Alexander Ignition. All rights reserved.
//

#import "AISearchDisplayDelegate.h"
#import "AITableViewDataSource.h"


@interface AISearchDisplayDelegate ()

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSArray *searchResult;
@property (strong, nonatomic) NSOperationQueue *operationQueue;

@end


@implementation AISearchDisplayDelegate

- (instancetype)initWithItems:(NSArray *)items
{
    if (self = [super init]) {
        self.items = items;
    }
    return self;
}


#pragma mark - Getters

- (NSOperationQueue *)operationQueue
{
    if (_operationQueue) {
        return _operationQueue;
    }
    _operationQueue = [[NSOperationQueue alloc] init];
    [_operationQueue setMaxConcurrentOperationCount:1];
    return _operationQueue;
}


#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
//    [self.operationQueue cancelAllOperations];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchString];
        NSArray *searchResults = [self.items filteredArrayUsingPredicate:resultPredicate];
        AITableViewDataSource *tableViewDataSource = (AITableViewDataSource *)controller.searchResultsTableView.dataSource;
        tableViewDataSource.fontFamilyNames = searchResults;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [controller.searchResultsTableView reloadData];
        }];
        
    }];
    [self.operationQueue addOperation:operation];
    
    return NO;
}

@end
