//
//  RecordViewController.m
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordViewCell.h"
#import "RecordModel.h"
@interface RecordViewController ()
@property (nonatomic ,strong) MBProgressHUD *hud;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpItems];
    
    [self requestRecord];
    [self setupProgressHud];
}
- (void)setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view] ;
    self.hud.label.text=@"正在加载...";
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    [_hud showAnimated:YES];
}
// 设置导航栏
- (void)setUpItems {
    self.navigationItem.title = @"考勤记录";
    
}

- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (void)requestRecord{
    [[HttpTool shareManager] POST:URL_WORKCARD_LIST parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *data = responseObject[@"data"];
        for (NSDictionary *dict  in data) {
            NSError* err=nil;
            RecordModel *model = [[RecordModel alloc]initWithDictionary:dict error:&err];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        [self.hud removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Delegate
-(BaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    // 1. 创建cell
    RecordViewCell *cell = [RecordViewCell cellWithTableView:self.tableView];
    cell.model = _dataArray[indexPath.row];

    return cell;
    
    
}



- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

@end
