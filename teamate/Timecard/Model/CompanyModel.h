//
//  CompanyModel.h
//  teamate
//
//  Created by Jizan on 2016/11/3.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
/*
 "id": 1,
 "name": "瑞宁智远",
 "logo": "https://imgs.bipush.com/article/cover/201502/10/114135990219.jpg?imageView2/1/w/300/h/300/imageMogr2/strip/interlace/1/quality/85/format/jpg",
 "description": "我是公司的描述信息",
 "address": "https://www.huxiu.com/article/163553.html",
 "industryid": "虎嗅",
 "createdon": 1432544975,
 "createdby": 10000000
 */
@interface CompanyModel : JSONModel


/**
 *  时间
 */
@property (nonatomic ,copy)NSString *name;

@property (nonatomic ,copy)NSString *Logo;

@end
