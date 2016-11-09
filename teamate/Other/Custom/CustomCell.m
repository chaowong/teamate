//
//  CustomCell.m
//  teamate
//
//  Created by Jizan on 2016/10/31.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        [self setUpSubViews];
        // 添加约束
        [self addConstraint];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
- (void)setUpSubViews{
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.rightLabel];

    
}
- (void)addConstraint{
    self.leftLabel.sd_layout
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .widthIs(80)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
    
    self.rightLabel.sd_layout
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .widthIs(120)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
}
- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = kFont(13);
                _rightLabel.textColor = TXT_COLOR;
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}
- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = kFont(15);
        //        _otherLabel.textColor = TXT_COLOR;
        _leftLabel.textAlignment = NSTextAlignmentLeft;

    }
    return _leftLabel;
}
@end
