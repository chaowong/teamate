//
//  LogDetailViewController.m
//  teamate
//
//  Created by Jizan on 2016/11/1.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "LogDetailViewController.h"
#import "WorkLogTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface LogDetailViewController ()

@end

@implementation LogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = BG;
    self.view.backgroundColor = BG;
    self.title = @"工作日志";
}
#pragma mark - Delegate
-(BaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        // 1. 创建cell
        WorkLogTableViewCell *cell = [WorkLogTableViewCell cellWithTableView:self.tableView];
        
        cell.model = self.model;
        cell.tag = indexPath.row;
        cell.sd_tableView = self.tableView;
        cell.sd_indexPath = indexPath;

        return cell;
        
    }else{

    // 1. 创建cell
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:self.tableView];
    
    cell.textLabel.text = @"评论内容";
    return cell;
    }
    
    
}
- (NSInteger)nh_numberOfSections {
    return 2;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }
    return DEFUALT_MARGIN_SIDES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 30)];
    view.backgroundColor = BG;
    if (section == 1) {
        

        
        UILabel *lable =[[ UILabel alloc] initWithFrame:CGRectMake(DEFUALT_MARGIN_SIDES, 0, kWidth, 30)];
        lable.text = @"评论列表";
        lable.font = GZFontWithSize(15);
        [view addSubview:lable];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    WorkLogModel *model = _model;
    
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[WorkLogTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    }else{
        return 64;
        
    }
    
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
   
    
    [self pop];
}


@end
