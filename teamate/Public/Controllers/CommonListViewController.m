#import "ApprovalTableViewController.h"
#import "TimecardTabeViewCell.h"
#import "Cell_1.h"
#import "Cell_2.h"
#import "FormCell_2.h"
#import "FormCell_1.h"
#import "Model_1.h"
#import "CommonListViewController.h"
#import "ContentAndPictureCell.h"

@interface CommonListViewController ()

@end

@implementation CommonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"请选择...";
    [self setUpItems];
    
}
// 设置导航栏
- (void)setUpItems {
    //self.navigationItem.title = @"写日志";
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
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
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return 10;
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
    
    Cell_2 *celler = [Cell_2 cellWithTableView:self.tableView];
    celler.leftIconImage.image = [UIImage imageNamed:@"default"];
    celler.leftMainTitle.text = @"类型";
    celler.rightLabel.text = @"已选";
    return celler;
    
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    
    NSLog(@"选中行后，标记已选。如果为单选，则返回上一页；如果为多选，则需确认后再返回上页。");
}
@end
