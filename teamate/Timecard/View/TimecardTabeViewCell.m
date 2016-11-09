//
//  TimecardTabeViewCell.m
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "TimecardTabeViewCell.h"

@implementation TimecardTabeViewCell

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
    [self.contentView addSubview:self.timecardImage];
    [self.contentView addSubview:self.onwork];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.signButton];
    [self.contentView addSubview:self.signinLabel];
    [self.contentView addSubview:self.noteBtn];


}
- (void)addConstraint{
    self.timecardImage.sd_layout
    .centerYEqualToView(self.contentView)
    .widthIs(40)
    .heightIs(40)
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES);
    
    self.onwork.sd_layout
    .leftSpaceToView(self.timecardImage,DEFUALT_MARGIN_SIDES)
    .topEqualToView(self.timecardImage)
    .widthIs(50)
    .heightIs(15);
    
    self.time.sd_layout
    .leftSpaceToView(self.timecardImage,DEFUALT_MARGIN_SIDES)
    .bottomEqualToView(self.timecardImage)
    .widthIs(50)
    .heightIs(15);
    
    self.signButton.sd_layout
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(80)
    .heightIs(35);
    
    self.signinLabel.sd_layout
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(105)
    .heightIs(30);
    
    self.noteBtn.sd_layout
    .rightSpaceToView(self.signinLabel,DEFUALT_MARGIN_SIDES)
    .centerYEqualToView(self.contentView)
    .widthIs(15)
    .heightIs(15);


}

- (UIImageView *)timecardImage{
    if (!_timecardImage) {
        _timecardImage = [[UIImageView alloc] init];
        _timecardImage.image = [UIImage imageNamed:@"go-to-work"];
        _timecardImage.layer.cornerRadius = BTN_CORNER_RADIUS;
        _timecardImage.layer.masksToBounds = YES;
    }
    return _timecardImage;
}

- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"09:00";
        _time.font = kFont(15);

    }
    return _time;
    
}

- (UILabel *)onwork{
    if (!_onwork) {
        _onwork = [[UILabel alloc] init];
        _onwork.font = kFont(15);
        _onwork.text = @"上班";
    }
    return _onwork;

}

- (UIButton *)signButton{
    if (!_signButton) {
        _signButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        _signButton.layer.borderWidth = 0.5;
//        
//        _signButton.layer.borderColor = SEPARATOR_LINE_COLOR.CGColor;
        _signButton.titleLabel.font = GZFontWithSize(15);
        _signButton.layer.cornerRadius = BTN_CORNER_RADIUS;
        _signButton.layer.masksToBounds = YES;
//        [_signButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_signButton setTitle:@"签到" forState:(UIControlStateNormal)];

    }
    return _signButton;
}

- (UILabel *)signinLabel{
    if (!_signinLabel) {
        _signinLabel = [[UILabel alloc] init];
        _signinLabel.textAlignment = NSTextAlignmentRight;
        _signinLabel.font = GZFontWithSize(14);
        _signinLabel.textColor = TXT_COLOR;
    }
    return _signinLabel;
}

- (UIButton *)noteBtn{
    if (!_noteBtn) {
        _noteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_noteBtn setImage:[UIImage imageNamed:@"sign-in"] forState:(UIControlStateNormal)];
    }
    return _noteBtn;
}
@end
