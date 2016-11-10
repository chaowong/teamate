//
//  TimecardTabeViewCell.h
//  teamate
//  左侧标题，右侧文本多行
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewCell.h"
@class Model_1;
@class JZTextView;
@class MKMessagePhotoView;
//-
@interface FormCell_1 : BaseTableViewCell
//定义枚举类型
typedef enum {
    ENUM_CELL_Single=0,//只显示文本视图
    ENUM_CELL_SingleWithInset,//只显示文本视图，且进行缩进，缩进量为预留标题的宽度
    ENUM_CELL_All//显示标题和文本视图
} FORM_CELL_TYPE;
//定义属性
@property (nonatomic ,strong)UILabel *leftMainTitle;
@property (nonatomic ,strong)JZTextView *textView;
@property (nonatomic ,strong)UILabel *rightLabel;
@property (nonatomic, strong) MKMessagePhotoView *photoView;
//定义其他
@property (nonatomic ,strong)Model_1 *model;
- (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(FORM_CELL_TYPE)type;

//-------in parameters---------------
@property (nonatomic,assign) NSInteger InActionType; //显示类型

@end
