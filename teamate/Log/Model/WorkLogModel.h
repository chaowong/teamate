//
//  WorkLogModel.h
//  teamate
//
//  Created by Jizan on 2016/11/2.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface WorkLogModel : JSONModel
/*
 "id": 1,
 "content": "我是公司的描述信息",
 "images": "https://imgs.bipush.com/article/cover/201502/10/114135990219.jpg?imageView2/1/w/300/h/300/imageMogr2/strip/interlace/1/quality/85/format/jpg",
 "duration": 1.5,
 "categoryid": "研发",
 "departmentid": "研发部",
 "createdon": 1432544975,
 "createdby": 10000000
 */


@property (nonatomic ,copy)NSString *content;

@property (nonatomic ,copy)NSString *images;

@property (nonatomic ,copy)NSString *duration;

@property (nonatomic ,copy)NSString *categoryid;

@property (nonatomic ,copy)NSString *departmentid;

@property (nonatomic ,copy)NSString *createdon;

@end
