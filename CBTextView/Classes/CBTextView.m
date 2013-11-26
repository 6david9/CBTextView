//
//  CBTextView.m
//  CBTextView
//
//  Created by ly on 13-9-18.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import "CBTextView.h"

@interface CBTextView ()

// 用户输入的文字
@property (strong, nonatomic) NSString *userText;

// 用户设置的文字颜色
@property (strong, nonatomic) UIColor  *userTextColor;

@end

@implementation CBTextView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing) name:UITextViewTextDidEndEditingNotification  object:self];
    
    self.userTextColor = [UIColor blackColor];
    self.placeholderColor = [UIColor grayColor];
    self.textColor = self.userTextColor;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Editing
- (void)setUserTextColor:(UIColor *)realTextColor
{
    _userTextColor = realTextColor;
    self.textColor = self.userTextColor;
}

- (void)beginEditing
{
    if (![self.text isEqualToString:self.placeholder])
    {
        [super setText:self.userText];
        self.textColor = self.userTextColor;
    }
    
    // 之前显示的是 placeholder
    if ([self.text isEqualToString:self.placeholder])
    {
        // 设置文字
        [super setText:self.userText];
        
        // 设置颜色
        self.textColor = self.userTextColor;
    }
    
    // 之前显示的是正常的文字
    else if ([self.userText isEqualToString:@""] || self.userText==nil)
    {
        [super setText:@""];
    }
}

- (void)endEditing
{
    if ([self.textColor isEqual:self.userTextColor]) {
        self.userText = [super text];
    }
    
    if (![self.userText isEqualToString:@""] && self.userText!=nil)
    {
        [super setText:self.userText];
        self.textColor = self.userTextColor;
    }
    else
    {
        [super setText:self.placeholder];
        self.textColor = self.placeholderColor;
    }
}

#pragma mark - Setter / Getter
- (void)setText:(NSString *)text
{
    self.userText = text;
    [super setText:text];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    // 没有用户输入的文字
    if ([self.realText isEqualToString:@""] || self.realText==nil)
    {
        [super setText:placeholder];
        self.textColor = self.placeholderColor;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    if ([self.userText isEqualToString:@""] || self.userText==nil)
    {
        self.textColor = placeholderColor;
    }
}

- (NSString *)text
{
    return self.userText;
}

- (NSString *)realText
{
    return [super text];
}

@end