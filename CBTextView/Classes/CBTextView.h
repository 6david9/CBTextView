//
//  CBTextView.h
//  CBTextView
//
//  Created by ly on 13-9-18.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBTextView : UITextView

/** 没有用户输入的文字时的占位文字 */
@property (strong, nonatomic) NSString *placeholder;

/** 占位文字的颜色 */
@property (strong, nonatomic) UIColor *placeholderColor;

/** 编辑开始时调用此方法
 * 如果你清楚次方法的原理，不要直接调用此方法
 */
- (void)beginEditing;

/** 编辑已经结束后调用此方法
 * 如果你清楚次方法的原理，不要直接调用此方法
 */
- (void)endEditing;

/** 编辑框中的实际的文字 包括 placeholder */
- (NSString *)realText;

@end