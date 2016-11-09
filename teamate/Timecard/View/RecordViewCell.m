//
//  RecordViewCell.m
//  teamate
//
//  Created by Jizan on 2016/11/2.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "RecordViewCell.h"

@implementation RecordViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"messageCell";
    // 1.缓存中取
    RecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (!cell) {
        cell = [[RecordViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

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
    [self.contentView addSubview:self.remarkLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.creatonLabel];

}

- (void)addConstraint{
    _remarkLabel.sd_layout
    .topEqualToView(self.contentView)
    .widthIs(kWidth/2)
    .heightIs(20)
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES);
    
    _addressLabel.sd_layout
    .bottomSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .heightIs(20)
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES);
    
    _creatonLabel.sd_layout
    .topEqualToView(self.contentView)
    .widthIs(kWidth/2)
    .heightIs(20)
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES);
    
}

- (void)setModel:(RecordModel *)model{
    _model = model;
    _remarkLabel.text = model.remark;
    _addressLabel.text = model.address;

    NSDate *currentTime = [NSDate dateWithTimeIntervalSince1970:[model.createdon intValue]+28800];
    NSString *time = [NSString stringWithFormat:@"%@",currentTime];
    NSArray *timeRarr = [time componentsSeparatedByString:@"+"];

    _creatonLabel.text = timeRarr[0];
  
}
- (UILabel *)remarkLabel{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.textAlignment  = NSTextAlignmentLeft;
        _remarkLabel.font = GZFontWithSize(13);
        _remarkLabel.textColor = TXT_COLOR;
    }
    return _remarkLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textAlignment  = NSTextAlignmentLeft;
        _addressLabel.font = GZFontWithSize(15);
        _addressLabel.textColor = TXT_MAIN_COLOR;
    }
    return _addressLabel;
}

- (UILabel *)creatonLabel{
    if (!_creatonLabel) {
        _creatonLabel = [[UILabel alloc] init];
        _creatonLabel.textAlignment  = NSTextAlignmentRight;
        _creatonLabel.font = GZFontWithSize(13);
        _creatonLabel.textColor = TXT_COLOR;
    }
    return _creatonLabel;
}
@end
