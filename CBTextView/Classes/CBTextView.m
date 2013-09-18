//
//  CBTextView.m
//  CBTextView
//
//  Created by ly on 13-9-18.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import "CBTextView.h"

#define SHOW_DEBUG_VIEW     0

#define RGBAlphaColor(r, g, b, a) \
        [UIColor colorWithRed:(r/255.0)\
                        green:(g/255.0)\
                         blue:(b/255.0)\
                        alpha:(a)]

#define OpaqueRGBColor(r, g, b) RGBAlphaColor((r), (g), (b), 1.0)

@interface CBTextView () <UITextViewDelegate>

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

- (void)setup
{
    [self addSubview:self.textView];
    
    self.placeHolderColor = OpaqueRGBColor(199, 200, 201);
    self.textView.delegate = self;
    
#if SHOW_DEBUG_VIEW
    self.textView.backgroundColor = DEBUG_VIEW_ITEM_COLOR;
    self.backgroundColor = DEBUG_VIEW_CONTAINER_COLOR;
#endif
}

#pragma mark - Layout
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGRect aFrame = CGRectZero;
    aFrame.origin = self.bounds.origin;
    aFrame.size = frame.size;
    self.textView.frame = aFrame;
}

#pragma mark - Accessor
- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.textView.text = placeHolder;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    self.textView.textColor = placeHolderColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    defaultTextColor = self.textView.textColor;
    self.textView.textColor = textColor;
}

- (void)setADelegate:(id)aDelegate
{
    _aDelegate = aDelegate;
}

- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _textView;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.aDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.aDelegate textViewShouldBeginEditing:textView];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.aDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.aDelegate textViewShouldEndEditing:textView];
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textView.text = prevText;
    self.textView.textColor = defaultTextColor;
    
    if ([self.aDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.aDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    prevText = self.textView.text;
    if (!prevText || [prevText length]==0) {
        self.textView.text = self.placeHolder;
        self.textView.textColor = self.placeHolderColor;
    }
    
    if ([self.aDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.aDelegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.aDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.aDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.aDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.aDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([self.aDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.aDelegate textViewDidChangeSelection:textView];
    }
}

#pragma mark - Actions
- (BOOL)resignFirstResponder
{
    return [self.textView resignFirstResponder];
}

@end