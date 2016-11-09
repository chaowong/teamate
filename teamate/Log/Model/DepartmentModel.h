//
//  DepartmentModel.h
//  teamate
//
//  Created by Jizan on 2016/11/2.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface DepartmentModel : JSONModel
/*
 
 {
 companyid = 1;
 createdby = 10000000;
 createdon = 1432544975;
 description = "\U4ea7\U54c1\U90e8";
 id = 1;
 logo = "https://imgs.bipush.com/article/cover/201502/10/114135990219.jpg?imageView2/1/w/300/h/300/imageMogr2/strip/interlace/1/quality/85/format/jpg";
 name = "\U4ea7\U54c1\U90e8";

 */

//@property (nonatomic ,copy)NSString *companyid;
@property (nonatomic ,copy)NSString *name;
//@property (nonatomic ,copy)NSString *logo;



@end
