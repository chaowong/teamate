//
//  ContentAndPictureCell.m
//  teamate
//
//  Created by Jizan on 2016/10/31.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "ContentAndPictureCell.h"
#import "PhotoCollectionViewCell.h"

#import "MKComposePhotosView.h"
#import "MKMessagePhotoView.h"
#import "TZImagePickerController.h"

@interface ContentAndPictureCell ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MKMessagePhotoViewDelegate,TZImagePickerControllerDelegate>


@end
@implementation ContentAndPictureCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self addSubview:self.textView];
//        [self setUpPhotosView];
    }
    return self;
}

- (NSMutableArray *)photoArrayM{
    if (!_photoArrayM) {
        _photoArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _photoArrayM;
}
#pragma mark - lazy
-(PlaceholderTextView *)textView{
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(10, 0, kWidth-2*DEFUALT_MARGIN_SIDES , 90)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.tag = 1001;
        _textView.tintColor = PRIMARY_COLOR;
        _textView.placeholderColor = TXT_COLOR;
        _textView.placeholder = @" 日志内容...";
    }
    return _textView;
}
//


@end
