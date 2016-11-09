//
//  NoteTableviewCell.m
//  teamate
//
//  Created by Jizan on 2016/10/31.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "NoteTableviewCell.h"

@interface NoteTableviewCell ()<UITextViewDelegate>

@end

@implementation NoteTableviewCell
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
    [self.contentView addSubview:self.textView];

    
}
- (void)addConstraint{
    
    self.leftlabel.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES)
    .heightIs(20)
    .widthIs(80);
    
    self.textView.sd_layout
    .leftSpaceToView(self.leftlabel,0)
    .topSpaceToView(self.contentView,5)
    .bottomSpaceToView(self.contentView,5)
    .rightSpaceToView(self.contentView,DEFUALT_MARGIN_SIDES);
}
#pragma mark - lazy
-(PlaceholderTextView *)textView{
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]init];
        _textView.backgroundColor = BG;
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.tag = 1001;
        _textView.placeholderColor = TXT_COLOR;
//        _textView.placeholder = @"请填写备注说明：";
    }
    return _textView;
}
- (UILabel *)leftlabel{
    if (!_leftlabel) {
        _leftlabel  = [[UILabel alloc] init];
        _leftlabel.font = kFont(15);
        _leftlabel.text = @"备注说明";
    }
    return _leftlabel;
}
@end
