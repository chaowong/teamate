//
//  MapViewCell.m
//  teamate
//
//  Created by Jizan on 2016/10/31.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "MapViewCell.h"

@implementation MapViewCell

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
    [self.contentView addSubview:self.mapView];
       
}
- (void)addConstraint{
    _mapView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
}

- (UIImageView *)mapView{
    if (!_mapView) {
        _mapView = [[UIImageView alloc] init];
        _mapView.backgroundColor = kLightGrayColor;
        
    }
    return _mapView;
    
}

@end
