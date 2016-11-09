//
//  BaseTableHeaderFooterView.h
//  teamate
//
//  Created by Jizan on 2016/10/27.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableHeaderFooterView : UITableViewHeaderFooterView
/**
 *  快速创建一个不是从xib中加载的tableview header footer
 */
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;
/**
 *  快速创建一个从xib中加载的tableview header footer
 */
+ (instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView;
@end
