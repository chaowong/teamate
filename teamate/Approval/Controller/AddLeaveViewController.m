#import "ApprovalTableViewController.h"
#import "TimecardTabeViewCell.h"
#import "Cell_1.h"
#import "Cell_2.h"
#import "FormCell_2.h"
#import "FormCell_1.h"
#import "Model_1.h"
#import "AddLeaveViewController.h"
#import "ContentAndPictureCell.h"
#import "CommonListViewController.h"

@interface AddLeaveViewController ()

@end

@implementation AddLeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新增请假";
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
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) return 170;
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
        FormCell_1 *celler = [FormCell_1 cellWithTableView:self.tableView cellType:ENUM_CELL_Single];
        NSDictionary *dict = @{@"imageUrl":@"default",@"mainTitle":@"请假申请",@"placeHolder":@"请填写请假事由..."};
        celler.model = [Model_1 initDataWithDictionary:dict];
        return celler;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
            celler.leftIconImage.image = [UIImage imageNamed:@"default"];
            celler.leftMainTitle.text = @"请假类型";
            celler.rightLabel.text = @"4";
            celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return celler;
        }else{
            Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
            celler.leftIconImage.image = [UIImage imageNamed:@"default"];
            celler.leftMainTitle.text = @"请假时间";
            celler.rightLabel.text = @"2016-09-12至2016-09-14";
            celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return celler;
        }
    }else{
        if (indexPath.section == 2){
            Cell_1 *celler = [Cell_1 cellWithTableView:self.tableView];
            NSDictionary *dict = @{@"imageUrl":@"default",@"mainTitle":@"提交到",@"subTitle":@"请按照公司管理制度填写请假单"};
            celler.model = [Model_1 initDataWithDictionary:dict];
            celler.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return celler;
        }else{
            BaseTableViewCell *celler = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
            return celler;
        }
    }
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            CommonListViewController *leaveVC =[[CommonListViewController alloc] init];
            [self pushVc:leaveVC];
        }else{
            CommonListViewController *leaveVC =[[CommonListViewController alloc] init];
            [self pushVc:leaveVC];
        }
    }
}
@end
