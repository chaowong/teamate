//
//  HttpTool.h
//  cts
//
//  Created by Jizan on 15/11/25.
//  Copyright © 2015年 jizan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface HttpTool : NSObject


+ (AFHTTPSessionManager *)shareManager;


@end
