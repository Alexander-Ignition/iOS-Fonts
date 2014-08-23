//
//  AIViewController.m
//  iOS Fonts
//
//  Created by Александр Игнатьев on 26.07.14.
//  Copyright (c) 2014 Alexander Ignition. All rights reserved.
//

#import "AIViewController.h"


@interface AIViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end


@implementation AIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationItem.prompt = self.familyFontName;
    self.navigationItem.title = self.fontName;
    
    UIBarButtonItem *itemAction = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                              target:self
                                                                              action:@selector(shareAction:)];
    [self.navigationItem setRightBarButtonItem:itemAction animated:NO];
    
    self.textView.text = self.fontName;
    self.textView.font = [UIFont fontWithName:self.fontName size:20];
    self.textView.textContainerInset = UIEdgeInsetsMake(20.0f, 15.0f, 20.0f, 15.0f);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}


#pragma mark - Actions

- (void)shareAction:(UIBarButtonItem *)itemAction
{
    NSArray *items = @[self.fontName, self.textView.text];
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                           applicationActivities:nil];
    [self presentViewController:activity animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
