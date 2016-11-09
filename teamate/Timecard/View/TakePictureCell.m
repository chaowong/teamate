//
//  TakePictureCell.m
//  teamate
//
//  Created by Jizan on 2016/10/31.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "TakePictureCell.h"

@implementation TakePictureCell

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
    [self.contentView addSubview:self.leftlabel];

}
- (void)addConstraint{
    self.leftlabel.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .widthIs(80)
    .heightRatioToView(self.contentView,1);
}


- (UILabel *)leftlabel{
    if (!_leftlabel) {
        _leftlabel  = [[UILabel alloc] init];
        _leftlabel.font = kFont(15);
        _leftlabel.text = @"拍照上传";
    }
    return _leftlabel;
}
@end
