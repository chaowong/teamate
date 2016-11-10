//
//  TimecardTabeViewCell.h
//  teamate
//  左侧标题，右侧文本输入框
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewCell.h"
@class Model_1;

@interface FormCell_2 : BaseTableViewCell
@property (nonatomic ,strong)UILabel *leftMainTitle;
@property (nonatomic ,strong)UITextField *textField;
@property (nonatomic ,strong)UILabel *rightLabel;
//--
@property (nonatomic ,strong)Model_1 *model;
- (instancetype)cellWithTableView:(UITableView *)tableView;
@end
