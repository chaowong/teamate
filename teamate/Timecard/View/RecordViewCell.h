//
//  RecordViewCell.h
//  teamate
//
//  Created by Jizan on 2016/11/2.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "RecordModel.h"
@interface RecordViewCell : BaseTableViewCell
/**
 *  故障信息
 */
@property (nonatomic ,strong)UILabel *remarkLabel;

@property (nonatomic ,strong)UILabel *addressLabel;


@property (nonatomic ,strong)UILabel *creatonLabel;

@property (nonatomic ,strong)RecordModel *model;

@end
