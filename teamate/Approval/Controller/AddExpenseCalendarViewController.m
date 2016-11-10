#import "ApprovalTableViewController.h"
#import "TimecardTabeViewCell.h"
#import "Cell_1.h"
#import "Cell_2.h"
#import "FormCell_2.h"
#import "FormCell_1.h"
#import "Model_1.h"
#import "AddExpenseCalendarViewController.h"
#import "AddLeaveViewController.h"

@interface AddExpenseCalendarViewController ()

@end

@implementation AddExpenseCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新增消费记录";
    [self setUpItems];
    
}
// 设置导航栏
- (void)setUpItems {
    //self.navigationItem.title = @"写日志";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
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
    if (section <2) {
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
        if (indexPath.row == 0) {
            FormCell_2 *celler = [FormCell_2 cellWithTableView:self.tableView];
            NSDictionary *dict = @{@"imageUrl":@"default",@"mainTitle":@"金额",@"placeHolder":@"¥请填写金额..."};
            celler.model = [Model_1 initDataWithDictionary:dict];
            return celler;
        }else {
            FormCell_2 *celler = [FormCell_2 cellWithTableView:self.tableView];
            NSDictionary *dict = @{@"imageUrl":@"default",@"mainTitle":@"备注",@"placeHolder":@"请填写备注信息..."};
            celler.model = [Model_1 initDataWithDictionary:dict];
            return celler;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
            celler.leftIconImage.image = [UIImage imageNamed:@"default"];
            celler.leftMainTitle.text = @"消费类型";
            celler.rightLabel.text = @"4";
            celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return celler;
        }else{
            Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
            celler.leftIconImage.image = [UIImage imageNamed:@"default"];
            celler.leftMainTitle.text = @"消费时间";
            celler.rightLabel.text = @"2016-09-12";
            celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return celler;
        }
    }else{
        
        Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
        celler.leftIconImage.image = [UIImage imageNamed:@"camera"];
        celler.leftMainTitle.text = @"票据照片";
        celler.rightLabel.text = @"2张";
        return celler;
    }
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            AddLeaveViewController *leaveVC =[[AddLeaveViewController alloc] init];
            [self pushVc:leaveVC];
        }else{
            AddExpenseCalendarViewController *leaveVC =[[AddExpenseCalendarViewController alloc] init];
            [self pushVc:leaveVC];
        }
    }
}
@end
