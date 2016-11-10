//
//  Model_1.h
//  teamate
//
//  Created by MacBook on 2016/11/9.
//  Copyright © 2016年 reining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_1 : NSObject
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *mainTitle;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,copy) NSString *placeHolder;

- (id)initWithDictionary:(NSDictionary *)dict;
+ (id)initDataWithDictionary:(NSDictionary *)dict;

@end
