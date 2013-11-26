//
//  CBViewController.m
//  CBTextView
//
//  Created by ly on 13-9-18.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import "CBViewController.h"

@interface CBViewController ()

@end

@implementation CBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textView.placeholder = @"快来说点什么";
    self.textView.placeholderColor = [UIColor redColor];
    self.textView.textAlignment = NSTextAlignmentCenter;
}

- (IBAction)finish:(id)sender
{
    [self.textView resignFirstResponder];
}

- (IBAction)clear:(id)sender
{
    self.textView.text = nil;
}

@end
