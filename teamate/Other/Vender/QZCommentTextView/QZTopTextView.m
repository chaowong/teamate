//
//  QZTopTextView.m
//  circle_iphone
//
//  Created by MrYu on 16/8/17.
//  Copyright © 2016年 ctquan. All rights reserved.
//

#import "QZTopTextView.h"
#import "CommonDef.h"

@interface QZTopTextView()
{
    UIButton *_issueBtn;
    UIView *_bgView;
    UITapGestureRecognizer *_tap;
}
@end

@implementation QZTopTextView

+ (instancetype)topTextView
{
    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ConvertTo6_H(316)*CT_SCALE_Y);
        self.lpTextView.scrollsToTop = NO;
        self.backgroundColor = UIColorFromRGB(0xf8f8f8);
        [self makeSubView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - 监听键盘
- (void)keyboardWillAppear:(NSNotification *)notif
{
    if ([self.lpTextView isFirstResponder]) {
        NSDictionary *info = [notif userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keyboardSize = [value CGRectValue].size;
        [UIView animateWithDuration:2 animations:^{
            self.y = kHeight - 216 - 157.5-64-40;
            
            NSLog(@"yyy = %f",self.y);
        }];
        [self.superview addSubview:_bgView];
        [self.superview addSubview:self];
    }
}
- (void)keyboardWillDisappear:(NSNotification *)notif
{
    
    [UIView animateWithDuration:2 animations:^{
        self.y = SCREEN_HEIGHT;
    }];
    [_bgView removeFromSuperview];
}
#pragma mark - 非通知调用键盘消失方法
- (void)keyboardWillDisappear
{
    [self.lpTextView resignFirstResponder];
}


-(void)makeSubView
{
    self.lpTextView.frame = CGRectMake(ConvertTo6_W(30)*CT_SCALE_X, 10, SCREEN_WIDTH - 2 * ConvertTo6_W(30)*CT_SCALE_X, ConvertTo6_H(200)*CT_SCALE_Y);
    self.lpTextView.placeholderText = @"请留下你的评论...";
    self.lpTextView.font = [UIFont systemFontOfSize:14];
    self.lpTextView.textColor = UIColorFromRGB(0x333333);
    self.lpTextView.layer.borderWidth = 0.5;
    self.lpTextView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    self.lpTextView.layer.cornerRadius = 2;
    self.lpTextView.clipsToBounds = YES;
    [self addSubview:self.lpTextView];
    
    _issueBtn = [[UIButton alloc] init];
    _issueBtn.width = ConvertTo6_W(114)*CT_SCALE_X;
    _issueBtn.height = ConvertTo6_H(54)*CT_SCALE_Y;
    // 右边对齐输入框
    _issueBtn.x = self.lpTextView.x + self.lpTextView.width - _issueBtn.width;
    _issueBtn.y = self.lpTextView.y + self.lpTextView.height + 10;
    [_issueBtn setTitle:@"提交" forState:UIControlStateNormal];
    _issueBtn.backgroundColor = UIColorFromRGB(0x00a0ff);
    _issueBtn.layer.cornerRadius = 2;
    _issueBtn.clipsToBounds = YES;
    [_issueBtn addTarget:self action:@selector(issueBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_issueBtn];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgView.backgroundColor = UIColorFromRGB(0x000000);
    _bgView.alpha = 0.5;
    
    _tap = [[UITapGestureRecognizer alloc] init];
    [_tap addTarget:self action:@selector(keyboardWillDisappear)];
    [_bgView addGestureRecognizer:_tap];
}

#pragma mark - 点击发布按钮
- (void)issueBtnClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendComment)]) {
        [self.delegate sendComment];
    }
    self.lpTextView.text = @"";
    [self.lpTextView resignFirstResponder];
}

- (LPlaceholderTextView *)lpTextView
{
    if (!_lpTextView) {
        LPlaceholderTextView *lpTextView=[[LPlaceholderTextView alloc] init];
        _lpTextView = lpTextView;
    }
    return _lpTextView;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_bgView removeGestureRecognizer:_tap];
}
@end
