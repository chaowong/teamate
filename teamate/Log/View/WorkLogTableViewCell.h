//
//  WorkLogTableViewCell.h
//  teamate
//
//  Created by Jizan on 2016/10/31.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SDWeiXinPhotoContainerView.h"
#import "WorkLogModel.h"
typedef NS_ENUM(NSUInteger, NHHomeTableViewCellItemType) {
    /** 转发*/
    NHHomeTableViewCellItemTypeLike = 1,
    /**评论 */
    NHHomeTableViewCellItemTypeComment,
    /** 查看*/
    NHHomeTableViewCellItemTypeDontLike,
};
@class WorkLogTableViewCell;
@protocol WorkLogTableViewCellDelegate <NSObject>


/** 点击底部item*/
- (void)homeTableViewCell:(WorkLogTableViewCell *)cell didClickItemWithType:(NHHomeTableViewCellItemType)itemType;

@end

@interface WorkLogTableViewCell : BaseTableViewCell
@property (nonatomic ,strong)UIImageView *headImage;

@property (nonatomic ,strong)UIImageView *duringImage;


@property (nonatomic ,strong)UILabel *nameLabel;

@property (nonatomic ,strong)UILabel *timeLabel;

@property (nonatomic ,strong)UILabel *duringLabel;

@property (nonatomic ,strong)UILabel *contentLabel;

@property (nonatomic ,strong)UIButton *shareBtn;

@property (nonatomic ,strong)UIButton *comment;

@property (nonatomic ,strong)UIButton *check;
@property (nonatomic ,strong)WorkLogModel *model;


@property (nonatomic ,strong)SDWeiXinPhotoContainerView *picContainerView;
@property (nonatomic, weak) id <WorkLogTableViewCellDelegate> delegate;

@end
