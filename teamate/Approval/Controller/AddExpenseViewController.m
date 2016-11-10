#import "ApprovalTableViewController.h"
#import "TimecardTabeViewCell.h"
#import "Cell_1.h"
#import "Cell_2.h"
#import "FormCell_2.h"
#import "FormCell_1.h"
#import "Model_1.h"
#import "AddExpenseViewController.h"
#import "AddLeaveViewController.h"
#import "CommonListViewController.h"

@interface AddExpenseViewController ()

@end

@implementation AddExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新增报销单";
    [self setUpItems];
    
}
// 设置导航栏
- (void)setUpItems {
    //self.navigationItem.title = @"写日志";
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
}

#pragma mark - action
- (void)leftBtnClick{
    //    [self.mycell.textView resignFirstResponder];
    [self dismiss];
    NSLog(@"left...");
}

- (void)rightBtnClick{
    //    [self.mycell.textView resignFirstResponder];
    //    [self addWorkLog];
    NSLog(@"right...");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)nh_numberOfSections {
    return 3;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    if (section ==1) {
        return 6;
    }
    if (section==2) {
        return 2;
    }
    return 1;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

-(CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section{
    if (section == 1) {
        return DEFUALT_MARGIN_SIDES;
    }
    return DEFUALT_MARGIN_SIDES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, DEFUALT_MARGIN_SIDES)];
    view.backgroundColor = BG;
    return view;
}

-(BaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FormCell_2 *celler = [FormCell_2 cellWithTableView:self.tableView];
        NSDictionary *dict = @{@"imageUrl":@"default",@"mainTitle":@"标题",@"placeHolder":@"请填写单据标题..."};
        celler.model = [Model_1 initDataWithDictionary:dict];
        return celler;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
            celler.leftIconImage.hidden = YES;
            celler.leftMainTitle.text = @"请选择消费记录";
            celler.rightLabel.text = @"4";
            celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return celler;
        }else if (indexPath.row == 5) {
            Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
            celler.leftIconImage.hidden = YES;
            celler.leftMainTitle.text = @"合计金额";
            celler.rightLabel.text = @"￥454.00";
            return celler;
        }else{
            Cell_1 *celler = [Cell_1 cellWithTableView:self.tableView];
            celler.leftIconImage.image = [UIImage imageNamed:@"traffic"];
            celler.leftMainTitle.text = @"济南出差打车费";
            celler.leftSubTitle.text = @"2016-11-08";
            celler.rightLabel.text = @"￥59.00";
            return celler;
        }
    }else{
        if (indexPath.row == 1){
            FormCell_2 *celler = [FormCell_2 cellWithTableView:self.tableView];
            NSDictionary *dict = @{@"imageUrl":@"default",@"mainTitle":@"备注",@"placeHolder":@"请填写补助的备注信息..."};
            celler.model = [Model_1 initDataWithDictionary:dict];
            return celler;
        }else{
            FormCell_2 *celler = [FormCell_2 cellWithTableView:self.tableView];
            NSDictionary *dict = @{@"imageUrl":@"default",@"mainTitle":@"补助",@"placeHolder":@"若有补助，请填写金额（元）..."};
            celler.model = [Model_1 initDataWithDictionary:dict];
            return celler;
        }
    }
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            CommonListViewController *leaveVC =[[CommonListViewController alloc] init];
            [self pushVc:leaveVC];
        }
    }
}
@end
