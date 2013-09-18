//
//  CBTextView.h
//  CBTextView
//
//  Created by ly on 13-9-18.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBTextView : UIView
{
    UIColor *defaultTextColor;
    NSString *prevText;
}

@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) NSString *placeHolder;

@property (strong, nonatomic) UIColor *placeHolderColor;

@property (weak, nonatomic) id<UITextViewDelegate> aDelegate;

@end