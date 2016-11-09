//
//  AddLogTableViewCell.m
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "AddLogTableViewCell.h"

@implementation AddLogTableViewCell

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
    [self.contentView addSubview:self.otherLabel];

    
}
- (void)addConstraint{
    self.timecardImage.sd_layout
    .centerYEqualToView(self.contentView)
    .widthIs(40)
    .heightIs(40)
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES);
    
//    self.timecardImage.sd_cornerRadius(20);
    
    self.onwork.sd_layout
    .leftSpaceToView(self.timecardImage,DEFUALT_MARGIN_SIDES)
    .topEqualToView(self.timecardImage)
    .widthIs(150)
    .heightIs(15);
    
    self.time.sd_layout
    .leftSpaceToView(self.timecardImage,DEFUALT_MARGIN_SIDES)
    .bottomEqualToView(self.timecardImage)
    .widthIs(50)
    .heightIs(15);
    
    self.otherLabel.sd_layout
    .rightSpaceToView(self.contentView,0)
    .centerYEqualToView(self.contentView)
    .widthIs(100)
    .heightIs(15);

    
}

- (UIImageView *)timecardImage{
    if (!_timecardImage) {
        _timecardImage = [[UIImageView alloc] init];
        _timecardImage.layer.cornerRadius = BTN_CORNER_RADIUS;
        _timecardImage.layer.masksToBounds = YES;
        _timecardImage.image = [UIImage imageNamed:@"peoples"];
    }
    return _timecardImage;
}

- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"研发部";
        _time.font = kFont(15);
        
    }
    return _time;
    
}

- (UILabel *)onwork{
    if (!_onwork) {
        _onwork = [[UILabel alloc] init];
        _onwork.textColor = TXT_COLOR;
        _onwork.font = kFont(13);
        _onwork.text = @"所属部门";
    }
    return _onwork;
    
}

- (UILabel *)otherLabel{
    if (!_otherLabel) {
        _otherLabel = [[UILabel alloc] init];
        _otherLabel.textAlignment = NSTextAlignmentRight;
        _otherLabel.font = kFont(12);
//        _otherLabel.textColor = TXT_COLOR;
        _otherLabel.text = @"其他部门";
    }
    return _otherLabel;
    
}

@end
