#import "ApprovalTableViewController.h"
#import "TimecardTabeViewCell.h"
#import "Cell_1.h"
#import "Cell_2.h"
#import "FormCell_2.h"
#import "FormCell_1.h"
#import "Model_1.h"
#import "AddLeaveViewController.h"
#import "AddExpenseViewController.h"
#import "AddTravelViewController.h"
#import "AddExpenseCalendarViewController.h"
#import "BaseNavigationViewController.h"

@interface ApprovalTableViewController ()

@end

@implementation ApprovalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"审批";
    [self setUpItems];
    
}
// 设置导航栏
- (void)setUpItems {
    //self.navigationItem.title = @"写日志";
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)nh_numberOfSections {
    return 2;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 3;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row ==1) return 64;
    return 64;
}

//-(CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section{
//    if (section == 1) {
//        return DEFUALT_MARGIN_SIDES;
//    }
//    return 0;
//}

-(CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section{
    return DEFUALT_MARGIN_SIDES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, DEFUALT_MARGIN_SIDES)];
    view.backgroundColor = BG;
    return view;
}

-(BaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
            celler.leftIconImage.image = [UIImage imageNamed:@"expense"];
            celler.leftMainTitle.text = @"我的报销记录";
            celler.rightLabel.text = @"4";
            celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return celler;
        }else{
            Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
            celler.leftIconImage.image = [UIImage imageNamed:@"leave"];
            celler.leftMainTitle.text = @"我的请假记录";
            celler.rightLabel.text = @"3";
            celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return celler;
        }
    }else{
        if (indexPath.section == 1){
            if (indexPath.row == 0) {
                Cell_1 *celler = [Cell_1 cellWithTableView:self.tableView];
                celler.leftIconImage.image = [UIImage imageNamed:@"expense"];
                celler.leftMainTitle.text = @"报销申请";
                celler.leftSubTitle.text = @"请先添加消费记录再填写报销申请";
                celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return celler;
            }else if(indexPath.row==1){
                Cell_1 *celler = [Cell_1 cellWithTableView:self.tableView];
                NSDictionary *dict = @{@"imageUrl":@"leave",@"mainTitle":@"请假申请",@"subTitle":@"按照公司管理制度填写请假单"};
                celler.model = [Model_1 initDataWithDictionary:dict];
                celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return celler;
            }
            else{
                Cell_1 *celler = [Cell_1 cellWithTableView:self.tableView];
                NSDictionary *dict = @{@"imageUrl":@"travel",@"mainTitle":@"出差申请",@"subTitle":@"出差申请功能简介"};
                celler.model = [Model_1 initDataWithDictionary:dict];
                celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return celler;
            }
        }else{
            Cell_1 *celler = [Cell_1 cellWithTableView:self.tableView];
            celler.leftIconImage.image = [UIImage imageNamed:@"go-out"];
            celler.leftMainTitle.text = @"---";
            celler.leftSubTitle.text = @"---";
            celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return celler;
        }
    }
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            AddExpenseViewController *leaveVC =[[AddExpenseViewController alloc] init];
            [self pushVc:leaveVC];
        }else if(indexPath.row ==1){
            AddLeaveViewController *expenseVC =[[AddLeaveViewController alloc] init];
            [self pushVc:expenseVC];
        }else{
            AddTravelViewController *travelVC =[[AddTravelViewController alloc] init];
            [self pushVc:travelVC];
        }
    }
}

-(void)rightBtnClick{
    AddExpenseCalendarViewController *expenseCalVC = [[AddExpenseCalendarViewController alloc] init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:expenseCalVC];
    [self presentVc:nav];
}
@end
