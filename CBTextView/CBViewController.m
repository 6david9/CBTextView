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
    
    _textView = [[CBTextView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    _aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _aButton.frame = CGRectMake(122, 152, 76, 44);
    [_aButton addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_textView];
    [self.view addSubview:_aButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyboard:(id)sender
{
    [self.textView resignFirstResponder];
}

@end
