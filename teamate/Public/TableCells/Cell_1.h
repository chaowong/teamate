//
//  TimecardTabeViewCell.h
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewCell.h"
@class Model_1;

@interface Cell_1 : BaseTableViewCell
@property (nonatomic ,strong)UIImageView *leftIconImage;
@property (nonatomic ,strong)UILabel *leftMainTitle;
@property (nonatomic ,strong)UILabel *leftSubTitle;
@property (nonatomic ,strong)UIButton *rightButton;
@property (nonatomic ,strong)UILabel *rightLabel;
//--
@property (nonatomic ,strong)Model_1 *model;
- (instancetype)cellWithTableView:(UITableView *)tableView;
@end
