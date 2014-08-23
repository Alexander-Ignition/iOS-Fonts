//
//  AITableViewDataSource.h
//  iOS Fonts
//
//  Created by iМас on 23.08.14.
//  Copyright (c) 2014 Alexander Ignition. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AITableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray *fontFamilyNames;

- (instancetype)initWithItems:(NSArray *)fontFamilyNames;

@end
