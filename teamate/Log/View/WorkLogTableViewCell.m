//
//  WorkLogTableViewCell.m
//  teamate
//
//  Created by Jizan on 2016/10/31.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "WorkLogTableViewCell.h"
#import "CompareTime.h"

@implementation WorkLogTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        [self setUpSubViews];
        // 添加约束
        [self addConstraint];
    }
    return self;
}
- (void)setUpSubViews{
    [self.contentView addSubview:self.headImage];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.duringImage];

    [self.contentView addSubview:self.duringLabel];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.picContainerView];
    [self.contentView addSubview:self.shareBtn];
    [self.contentView addSubview:self.comment];
    [self.contentView addSubview:self.check];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线，
    CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width , 0));
    //下分割线
    CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 0));
}
- (void)setModel:(WorkLogModel *)model{
    _model = model;
    
    _contentLabel.text = model.content;
    _duringLabel.text =[NSString stringWithFormat:@"%@ 小时",model.duration] ;

    NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:[model.createdon intValue]];
    NSString *time2 = [CompareTime comparesCurrentTime:currentTime ];
    self.timeLabel.text = time2;

    NSArray *tags;
    if ( model.images.length == 0) {
        
    }else{
//        tags = [ model.images componentsSeparatedByString:@","];
        tags = @[model.images];
    }
    
    _picContainerView.picPathStringsArray = tags;
    
    CGFloat picContainerTopMargin = 0;
    if (tags.count) {
        picContainerTopMargin = 10;
    }
    
    self.picContainerView.sd_layout.topSpaceToView(_contentLabel, picContainerTopMargin);
    
    [self setupAutoHeightWithBottomView:self.shareBtn bottomMargin:0];

    
}
- (void)addConstraint{

    self.headImage.sd_layout
    .topSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .widthIs(40)
    .heightIs(40);
    self.headImage.sd_cornerRadiusFromHeightRatio = @(0.5); // 设置view0的圆角半径为自身高度的0.5倍

    self.nameLabel.sd_layout
    .leftSpaceToView(self.headImage,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.headImage)
    .widthIs(100)
    .heightIs(15);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .heightIs(13);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:100];

    
    
    self.duringLabel.sd_layout
    .topSpaceToView(self.timeLabel,5)
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .widthIs(50)
    .heightIs(15);
//    [self.duringLabel setSingleLineAutoResizeWithMaxWidth:100];

    
    self.duringImage.sd_layout
    .centerYEqualToView(self.duringLabel)
    .rightSpaceToView(self.duringLabel,0)
    .widthIs(8)
    .heightIs(14);
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.headImage,DEFUALT_MARGIN_SIDES)
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .autoHeightRatio(0);

    self.picContainerView.sd_layout
    .leftEqualToView(_contentLabel); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置

    UIView *sepLineone = [[UIView alloc] init];
    [self.contentView addSubview:sepLineone];
    sepLineone.backgroundColor = SEPARATOR_LINE_COLOR;
    sepLineone.sd_layout
    .topSpaceToView(self.picContainerView,DEFUALT_MARGIN_SIDES)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(0.5);
    
    self.shareBtn.sd_layout
    .topSpaceToView(sepLineone,0)
    .leftSpaceToView(self.contentView,0)
    .widthIs(kWidth/3)
    .heightIs(40);
    
    
    UIView *sepLinetwo = [[UIView alloc] init];
    [self.contentView addSubview:sepLinetwo];
    sepLinetwo.backgroundColor = SEPARATOR_LINE_COLOR;
    sepLinetwo.sd_layout
    .centerYEqualToView(self.shareBtn)
    .leftSpaceToView(self.shareBtn,0.5)
    .widthIs(0.5)
    .heightIs(25);

    
    self.comment.sd_layout
    .topEqualToView(self.shareBtn)
    .leftSpaceToView(self.shareBtn,1)
    .widthIs(kWidth/3)
    .heightIs(40);
    
    UIView *sepLinethree = [[UIView alloc] init];
    [self.contentView addSubview:sepLinethree];
    sepLinethree.backgroundColor = SEPARATOR_LINE_COLOR;
    sepLinethree.sd_layout
    .centerYEqualToView(self.comment)
    .leftSpaceToView(self.comment,0.5)
    .widthIs(0.5)
    .heightIs(25);
    
    self.check.sd_layout
    .topEqualToView(self.shareBtn)
    .leftSpaceToView(self.comment,1)
    .widthIs(kWidth/3)
    .heightIs(40);
    
    [self setupAutoHeightWithBottomView:self.shareBtn bottomMargin:0];

}

#pragma mark - lazy
- (UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"head"];
    }
    return _headImage;
}
- (UIImageView *)duringImage{
    if (!_duringImage) {
        _duringImage = [[UIImageView alloc]init];
        _duringImage.image = [UIImage imageNamed:@"2hour"];
    }
    return _duringImage;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.text = @"1小时前";
        _timeLabel.font = GZFontWithSize(13);
        _timeLabel.textColor = kLightGrayColor;
    }
    return _timeLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"研发部-某某";
        _nameLabel.font = GZFontWithSize(15);
    }
    return _nameLabel;
}
- (UILabel *)duringLabel{
    if (!_duringLabel) {
        _duringLabel = [[UILabel alloc] init];
        _duringLabel.textAlignment = NSTextAlignmentRight;
        _duringLabel.font = GZFontWithSize(13);
        _duringLabel.textColor = TXT_MAIN_COLOR;

    }
    return _duringLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = GZFontWithSize(15);
        _contentLabel.text = @"工作日志：完成工作完成工作完成工作完成工作完成工作完成工作完成工作完成工作";
    }
    return _contentLabel;
}

- (SDWeiXinPhotoContainerView *)picContainerView{
    if (!_picContainerView) {
        _picContainerView = [[SDWeiXinPhotoContainerView alloc] init];
    }
    return _picContainerView;
}

- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_shareBtn setTitleColor:TXT_MAIN_COLOR forState:(UIControlStateNormal)];
        _shareBtn.titleLabel.font = GZFontWithSize(14);
        [_shareBtn setTitle:@"转发" forState:(UIControlStateNormal)];
        _shareBtn.tag = 11;
        [_shareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _shareBtn;
}
- (UIButton *)comment{
    if (!_comment) {
        _comment = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_comment setTitleColor:TXT_MAIN_COLOR forState:(UIControlStateNormal)];
        _comment.titleLabel.font = GZFontWithSize(14);
        [_comment addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _comment.tag = 12;
        [_comment setTitle:@"评论" forState:(UIControlStateNormal)];
    }
    return _comment;
}

- (UIButton *)check{
    if (!_check) {
        _check = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_check setTitleColor:TXT_MAIN_COLOR forState:(UIControlStateNormal)];
        _check.titleLabel.font = GZFontWithSize(14);
        [_check setTitle:@"查看" forState:(UIControlStateNormal)];
        _check.tag = 13;
        [_check addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _check;
}

- (void)btnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(homeTableViewCell:didClickItemWithType:)]) {
        [self.delegate homeTableViewCell:self didClickItemWithType:btn.tag - 10];
    }
}

@end
