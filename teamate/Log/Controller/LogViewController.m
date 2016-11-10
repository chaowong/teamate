//
//  LogViewController.m
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "LogViewController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "LogDetailViewController.h"
#import "AddLogViewController.h"
#import "BaseNavigationViewController.h"
#import "WorkLogTableViewCell.h"
#import "shareManager.h"
#import "shareManager+shareView.h"
#import "QZTopTextView.h"
#import "WorkLogModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface LogViewController ()<WorkLogTableViewCellDelegate,QZTopTextViewDelegate>
{
    shareManager *shareView;
    QZTopTextView * _textView;

}
@property (nonatomic ,strong) MBProgressHUD *hud;

@property (nonatomic ,strong)NSMutableArray *workLogArray;
@end

@implementation LogViewController

#pragma mark - lazy
- (NSMutableArray *)workLogArray{
    if (!_workLogArray) {
        _workLogArray = [NSMutableArray array];
    }
    return _workLogArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}
#pragma mark - basic
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"日志";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = BG;
    WeakSelf(weakSelf);
    shareView = [[shareManager alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self nh_setUpNavRightItemTitle:@"写日志" handle:^(NSString *rightItemTitle) {
        AddLogViewController *addlogVC = [[AddLogViewController alloc] init];
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:addlogVC];
        [weakSelf presentVc:nav];
    }];

    [self setupMJRefreshHeader];
    [self requestWorkLogList];
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
#pragma mark - request


- (void)setupMJRefreshHeader{
    [self.dataArray removeAllObjects];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新数据" forState:MJRefreshStateIdle];
    [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"全部加载完成" forState:MJRefreshStateNoMoreData];
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.stateLabel.textColor = [UIColor grayColor];
    self.tableView.mj_header = header;
}

- (void)refreshMoreData
{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"全部加载完成" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor grayColor];
    self.tableView.mj_footer = footer;
    
}
//上拉加载更多数据
- (void)loadMore
{
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    if (ability.currentReachabilityStatus == ReachableViaWiFi || ability.currentReachabilityStatus == ReachableViaWWAN) {

        
    }else{

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }
}


- (void)loadNewDatas{
    [self.workLogArray removeAllObjects];
    [self getNetWork];
}
- (void)getNetWork{
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    if (ability.currentReachabilityStatus == ReachableViaWiFi || ability.currentReachabilityStatus == ReachableViaWWAN) {
        [self requestWorkLogList];

    }else{

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }
}



- (void)requestWorkLogList{
    [[HttpTool shareManager] POST:URL_WORKLOG_LIST parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSMutableArray *data = responseObject[@"data"];
        
        NSLog(@"@-----%@--",responseObject);
        for (NSDictionary *dict  in data) {
            NSError* err=nil;
            WorkLogModel *model = [[WorkLogModel alloc]initWithDictionary:dict error:&err];
            [self.workLogArray addObject:model];
        }
        [self.tableView reloadData];
        [self.hud removeFromSuperview];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - Delegate
-(BaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    // 1. 创建cell
    WorkLogTableViewCell *cell = [WorkLogTableViewCell cellWithTableView:self.tableView];
    
    cell.model = _workLogArray[indexPath.section];
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.sd_tableView = self.tableView;
    cell.sd_indexPath = indexPath;
    return cell;    
}


// cell 代理方法
- (void)homeTableViewCell:(WorkLogTableViewCell *)cell didClickItemWithType:(NHHomeTableViewCellItemType)itemType {
    switch (itemType) {
        case NHHomeTableViewCellItemTypeLike: {
            [shareView show];

        } break;
            
        case NHHomeTableViewCellItemTypeDontLike: {
            LogDetailViewController *detailVC = [[LogDetailViewController alloc] init];
            
            detailVC.model = _workLogArray[cell.tag];

            [self pushVc:detailVC];
        } break;
            
        case NHHomeTableViewCellItemTypeComment: {
            _textView =[QZTopTextView topTextView];
            _textView.delegate = self;
            [_textView.lpTextView becomeFirstResponder];

            [self.view addSubview:_textView];
  
        } break;
            
        default:
            break;
    }
}

- (NSInteger)nh_numberOfSections {
    return _workLogArray.count;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section{
    return DEFUALT_MARGIN_SIDES;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, DEFUALT_MARGIN_SIDES)];
    view.backgroundColor = BG;
    
    return view;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    LogDetailViewController *detailVC = [[LogDetailViewController alloc] init];
    detailVC.model = _workLogArray[indexPath.section];
    [self pushVc:detailVC];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkLogModel *model = self.workLogArray[indexPath.section];

    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[WorkLogTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    
//    return 150;
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

- (void)hudWithTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    [hud hideAnimated:YES afterDelay:1.f];
}
@end
