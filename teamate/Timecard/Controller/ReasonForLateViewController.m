//
//  ReasonForLateViewController.m
//  teamate
//
//  Created by Jizan on 2016/11/1.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "ReasonForLateViewController.h"


#import "NHCustomPlaceHolderTextView.h"
#import "NHPublishDraftBottomView.h"
#import "NHPublishDraftPictureView.h"
#import "NSNotificationCenter+Addition.h"
#import "UIBarButtonItem+Addition.h"
#import "TZImagePickerController.h"

#define kMaxInputLimitLength 300
#define kBottomViewH 80
#define kMaxImageCount 9
@interface ReasonForLateViewController () <NHCustomPlaceHolderTextViewDelegate, NHPublishDraftBottomViewDelegate, TZImagePickerControllerDelegate, NHPublishDraftPictureViewDelegate>
/** 输入框*/
@property (nonatomic, weak) NHCustomPlaceHolderTextView *placeHolderTextView;

/** 底部视图*/
@property (nonatomic, weak) NHPublishDraftBottomView *bottomView;
@property (nonatomic, weak) NHPublishDraftPictureView *pictureView;
/** bottomView的y值*/
@property (nonatomic, assign) CGFloat bottomViewY;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *picArray;

@end

@implementation ReasonForLateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. 设置导航栏
    [self setUpItems];
    

    
    // 2. 设置子视图
    [self setUpViews];
    
    // 3. 添加通知
    [self setUpNotis];

}


// 设置导航栏
- (void)setUpItems {
    self.navigationItem.title = @"补充迟到理由";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rigthItemClick)];
}

// 设置子视图
- (void)setUpViews {
    // 设置占位文字
    self.placeHolderTextView.placehoder = @"迟到了，请说明一下理由";
    
    self.placeHolderTextView.placeholderFont = kFont(13);
    
    // 设置底部视图
    self.bottomViewY = kScreenHeight - kTopBarHeight - kBottomViewH;
    self.bottomView.limitCount = kMaxInputLimitLength;
    self.bottomView.backgroundColor = kWhiteColor;
}

// 添加通知
- (void)setUpNotis {
    [NSNotificationCenter addObserver:self action:@selector(keyBoardWillHiddenNoti:) name:UIKeyboardWillHideNotification];
    [NSNotificationCenter addObserver:self action:@selector(keyBoardWillShowNoti:) name:UIKeyboardWillShowNotification];
}


- (void)leftItemClick{
    [self dismiss];
}

- (void)rigthItemClick{
    [self dismiss];
    
}
// 键盘下落
- (void)keyBoardWillHiddenNoti:(NSNotification *)noti {
    [self configKeyBoardWithHidden:YES userInfo:noti.userInfo];
}

// 键盘生起
- (void)keyBoardWillShowNoti:(NSNotification *)noti {
    [self configKeyBoardWithHidden:NO userInfo:noti.userInfo];
}

- (void)configKeyBoardWithHidden:(BOOL)hidden userInfo:(id)userInfo {
    if (userInfo == nil) return ;
    CGRect endRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomViewY = kScreenHeight - kTopBarHeight - kBottomViewH - (hidden ? 0 : endRect.size.height);
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(kBottomViewH);
        make.top.mas_equalTo(weakSelf.bottomViewY);
    }];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.picArray.count == 0) {
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.placeHolderTextView.bottom + 10);
    } else {
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.pictureView.bottom + 10);
    }
}

#pragma mark - NHCustomPlaceHolderTextViewDelegate
- (void)customPlaceHolderTextViewTextDidChange:(NHCustomPlaceHolderTextView *)textView {
    NSString *text = textView.text;
    
    if (text.length > kMaxInputLimitLength) {
        textView.text = [textView.text substringToIndex:kMaxInputLimitLength];
        self.bottomView.limitCount = 0;
    } else {
        self.bottomView.limitCount = kMaxInputLimitLength - text.length;
    }
}

#pragma mark - NHPublishDraftBottomViewDelegate
- (void)publishDraftBottomView:(NHPublishDraftBottomView *)bottomView didClickItemWithType:(NHPublishDraftBottomViewItemType)type {
    
    switch (type) {
        case NHPublishDraftBottomViewItemTypePicture: { // 添加图片
            [self.placeHolderTextView resignFirstResponder];
            [self addImage];
        }
            break;
            
        case NHPublishDraftBottomViewItemTypeVideo: { // 添加视频
            [self.placeHolderTextView resignFirstResponder];
            [self addVideo];
        }
            break;
    }
}

#pragma mark - NHPublishDraftPictureViewDelegate
- (void)publishDraftPictureView:(NHPublishDraftPictureView *)pictureView picArrayDidChange:(NSArray *)picArray {
    self.picArray = picArray;
}

#pragma mark - NHPublishDraftPictureViewDelegate
- (void)publishDraftPictureViewAddImage:(NHPublishDraftPictureView *)pictureView {
    [self addImage];
}

- (void)addImage {
    WeakSelf(weakSelf);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:kMaxImageCount - self.picArray.count delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        if (photos.count) {
            if (weakSelf.picArray.count > 0) { // 继续添加
                [weakSelf.pictureView addImages:photos];
            } else { // 从无到有
                weakSelf.pictureView.pictureArray = photos.mutableCopy;
                weakSelf.picArray = photos;
            }
        }
    }];
    [self presentVc:imagePickerVc];
}

- (void)addVideo {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [self presentVc:imagePickerVc];
}



#pragma mark - lazy

- (NHPublishDraftPictureView *)pictureView {
    if (!_pictureView) {
        NHPublishDraftPictureView *pic = [[NHPublishDraftPictureView alloc] init];
        [self.scrollView addSubview:pic];
        _pictureView = pic;
        pic.delegate = self;
        WeakSelf(weakSelf);
        [pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view);
            make.width.mas_equalTo(weakSelf.view.width);
            make.top.mas_equalTo(weakSelf.placeHolderTextView.mas_bottom);
            make.height.mas_equalTo(kScreenWidth);
        }];
    }
    return _pictureView;
}

- (NHCustomPlaceHolderTextView *)placeHolderTextView {
    if (!_placeHolderTextView) {
        NHCustomPlaceHolderTextView *placeHolderTextView = [[NHCustomPlaceHolderTextView alloc] init];
        [self.scrollView addSubview:placeHolderTextView];
        _placeHolderTextView = placeHolderTextView;
        placeHolderTextView.placeholderFont = kFont(14);
        placeHolderTextView.del = self;
        WeakSelf(weakSelf);
        [placeHolderTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view);
            make.width.mas_equalTo(weakSelf.view.width);
            make.top.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(200);
        }];
    }
    return _placeHolderTextView;
}

- (NSArray *)picArray {
    if (!_picArray) {
        _picArray = [NSArray new];
    }
    return _picArray;
}

- (NHPublishDraftBottomView *)bottomView {
    if (!_bottomView) {
        NHPublishDraftBottomView *bottomView = [[NHPublishDraftBottomView alloc] init];
        [self.view addSubview:bottomView];
        _bottomView = bottomView;
        bottomView.delegate = self;
        WeakSelf(weakSelf);
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(kBottomViewH);
            make.top.mas_equalTo(kScreenHeight - kTopBarHeight - kBottomViewH);
        }];
    }
    return _bottomView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *sc = [[UIScrollView alloc] init];
        [self.view addSubview:sc];
        _scrollView = sc;
        
        [sc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, kBottomViewH, 0));
        }];
        sc.showsVerticalScrollIndicator = NO;
        sc.showsHorizontalScrollIndicator = NO;
        sc.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

@end
