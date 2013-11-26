//
//  CBTextViewTests.m
//  CBTextViewTests
//
//  Created by ly on 13-11-26.
//  Copyright (c) 2013年 ly. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CBTextView.h"

@interface CBTextViewTests : XCTestCase

@property (strong, nonatomic) CBTextView *textView;

@end

@implementation CBTextViewTests

- (void)setUp
{
    [super setUp];
    _textView = [[CBTextView alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSettingPlaceholder
{
    NSString *placeholder = @"快来说点什么吧";
    self.textView.placeholder = placeholder;
    
    XCTAssertEqualObjects(self.textView.placeholder, placeholder,
                          @"取出的 placeholder 应与设置的一致");
    XCTAssertEqualObjects([self.textView realText], placeholder,
                          @"没有用户输入的文字时，realText 应该返回 placeholder ");
}

#pragma mark - 测试默认设置

- (void)testDefaultTextColorIsBlack
{
    NSLog(@"%@", self.textView.textColor);
    XCTAssertEqualObjects(self.textView.textColor, [UIColor blackColor],
                          @"默认的文字的颜色为 [UIColor blackColor]");
}

- (void)testDefaultPlaceholderColorIsGray
{
    XCTAssertEqualObjects(self.textView.placeholderColor, [UIColor grayColor],
                          @"默认的 placeholder 颜色为 [UIColor grayColor]");
}

#pragma mark - 测试设置文字功能
- (void)testGetTextMethodIsNotAffectedByPlaceholder
{
    NSString *text = @"正常的文字";
    self.textView.placeholder = @"快来说点什么吧";
    self.textView.text = text;
    XCTAssertEqualObjects(self.textView.text, text, @"返回的文字不受 placeholder 影响");
}

- (void)testExistTextPropertyIsNotAffectedBySettingPlaceholder
{
    NSString *text = @"正常的文字";
    self.textView.text = text;
    self.textView.placeholder = @"快来说点什么吧";
    XCTAssertEqualObjects(self.textView.text, text, @"如果 Text View 中有用户输入的文字，再设置 placeholder 不会影响现有的文字");
    XCTAssertEqualObjects(self.textView.textColor, [UIColor blackColor], @"如果 Text View 中有用户输入的文字，再设置 placeholder color 不会影响现有的文字颜色");
}

#pragma mark - First responder

- (void)testCallingEndEditingAfterSetEmptyStringWillGetEmptyString
{
    NSString *placeholder = @"快来说点什么吧";
    NSString *text = @"正常的文字";
    
    self.textView.placeholder = placeholder;
    self.textView.text = text;
    
    self.textView.text = @"";
    [self.textView endEditing];
    
    XCTAssertEqualObjects(self.textView.text, @"", @"设置空字符串后调用 endEditing 会返回 placeholder");
}

// 如果用户输入的文字为空，调用 beginEdting 后会返回空字符串
- (void)testCallingBeginEditingWithEmptyUserInputedText
{
    NSString *placeholder = @"快来说点什么吧";
    self.textView.placeholder = placeholder;
    
    [self.textView beginEditing];
    
    XCTAssertEqualObjects(self.textView.text, nil,
                          @"用户之前没有输入过文字，调用 beginEditing 会返回空字符串");
    
    XCTAssertEqualObjects(self.textView.textColor, [UIColor blackColor], @"用户之前没有输入过文字，调用 beginEditing 后文字颜色为黑色");
}

// 如果用户输入的文字不为空，调用 beginEditing 后不会影响原有的设置
- (void)testCallingBeginEdtingWithUserStringNotEmpty
{
    NSString *placeholder = @"快来说点什么吧";
    NSString *text = @"正常的文字";
    
    self.textView.placeholder = placeholder;
    self.textView.text = text;
    
    [self.textView beginEditing];
    
    XCTAssertEqualObjects(self.textView.text, text,
                          @"用户之前输入过文字，调用 beginEditing 会返回原有的文字");
    
    XCTAssertEqualObjects(self.textView.textColor, [UIColor blackColor], @"用户之前没有输入过文字，调用 beginEditing 后文字颜色为黑色");
}

// 测试用户输入的文字与 placeholder 相同 endEditing 后文字颜色不变
- (void)testSameTextWithPlaceholderAfterEndEditingTextColorNotChanged
{
    NSString *placeholder = @"快来说点什么吧";
    
    self.textView.placeholder = placeholder;
    self.textView.text = placeholder;
    
    [self.textView endEditing];
    
    XCTAssertEqualObjects(self.textView.textColor, [UIColor blackColor],
                          @"测试用户输入的文字与 placeholder 相同 endEditing 后文字颜色不变");
}

// 要是用户输入的内容为空，endEditing 后文字应为 placeholder， 文字颜色为 placeholder color
- (void)testCallingEndEditingWithEmptyUserText
{
     NSString *placeholder = @"快来说点什么吧";
    self.textView.placeholder = placeholder;
    
    self.textView.text = @"";
    [self.textView endEditing];
    
    XCTAssertEqualObjects(self.textView.realText, placeholder,
                          @"要是用户输入的内容为空，endEditing 后文字应为 placeholder");
    XCTAssertEqualObjects(self.textView.textColor, [UIColor grayColor],
                          @"要是用户输入的内容为空，endEditing 后文字颜色为 placeholder color");
}

// 要是用户输入的内容不为空，endEditing 方法不会影响原有文字内容和颜色
- (void)testIfTextNotEmptyOrNilEndEditingWillDoNothingWithTextViewProperty
{
    NSString *placeholder = @"快来说点什么吧";
    NSString *text = @"正常的文字";
    
    self.textView.placeholder = placeholder;
    self.textView.text = text;
    
    [self.textView endEditing];
    
    XCTAssertEqualObjects(self.textView.text, text,
                          @"原有文字不为空，调用 endEditing 后返回的文字不变");
    XCTAssertEqualObjects(self.textView.textColor, [UIColor blackColor],
                          @"原有文字不为空，调用 endEditing 后文字颜色不变");
}

#pragma mark - 
// 当用户输入的文字为空时，设置 placeholder color 立即生效
- (void)testPlaceholderColorApplyImmediatelyWhenUserTextIsEmpty
{
    self.textView.placeholderColor = [UIColor redColor];
    
    XCTAssertEqualObjects(self.textView.textColor, [UIColor redColor],
                          @"当用户输入的文字为空时，设置 placeholder color 立即生效");
}

@end
