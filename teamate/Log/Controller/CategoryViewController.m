//
//  CategoryViewController.m
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.pagetitle;
}

#pragma mark - Delegate
-(BaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    // 1. 创建cell
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:self.tableView];
    
    cell.textLabel.text = self.arr[indexPath.row];;
    
    return cell;
    
    
}
- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section{
    return DEFUALT_MARGIN_SIDES;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, DEFUALT_MARGIN_SIDES)];
    view.backgroundColor = BG;
    
    return view;
}

-(void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    NSString *sss = _arr[indexPath.row];
    _passString(sss);
    [self pop];
}
@end
