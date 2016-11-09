//
//  CategoryViewController.h
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewController.h"
typedef void(^passStringBlock)(NSString *name);

@interface CategoryViewController : BaseTableViewController
@property (nonatomic ,strong)NSString *pagetitle;
@property (nonatomic ,strong)NSArray *arr;
@property(nonatomic ,copy)passStringBlock passString;

@end
