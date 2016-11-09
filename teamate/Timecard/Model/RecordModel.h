//
//  RecordModel.h
//  teamate
//
//  Created by Jizan on 2016/11/3.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
/*
 
 "id": 42,
 "position": "39.986379,116.308852",
 "address": "北京市海淀区中关村北大街151号燕园大厦903国际汉语教师协会iclta北京大学报名中心",
 "remark": "测试上班签退",
 "categoryid": "off",
 "createdby": 10000012,
 "createdon": 1478075631
 */
@interface RecordModel : JSONModel
@property (nonatomic ,copy)NSString *position;


/**
 *  address
 */
@property (nonatomic ,copy)NSString *address;


/**
 *  remark
 */
@property (nonatomic ,copy)NSString *remark;


/**
 *  时间
 */
@property (nonatomic ,copy)NSString *createdon;

@end
