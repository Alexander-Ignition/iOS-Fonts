//
//  AIViewController.h
//  iOS Fonts
//
//  Created by Александр Игнатьев on 26.07.14.
//  Copyright (c) 2014 Alexander Ignition. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AIViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSString *fontName;
@property (strong, nonatomic) NSString *familyFontName;

@end
