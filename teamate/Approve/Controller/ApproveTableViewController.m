//
//  ApproveTableViewController.m
//  teamate
//
//  Created by MacBook on 2016/11/9.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "ApproveTableViewController.h"
#import "TimecardTabeViewCell.h"
@interface ApproveTableViewController ()
@property (nonatomic ,strong)TimecardTabeViewCell *cell;
@property (nonatomic ,strong)TimecardTabeViewCell *cell1;
@property (nonatomic ,strong)TimecardTabeViewCell *cell2;
@end

@implementation ApproveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"审批";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)nh_numberOfSections {
    return 2;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
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
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, DEFUALT_MARGIN_SIDES)];
    view.backgroundColor = BG;
    return view;
}
-(BaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.cell = [TimecardTabeViewCell cellWithTableView:self.tableView];
            [self.cell.signButton addTarget:self action:@selector(signin:) forControlEvents:(UIControlEventTouchUpInside)];
            self.cell.signButton.tag = indexPath.row;
            self.cell.signinLabel.hidden = YES;
            self.cell.noteBtn.hidden = YES;
            self.cell.signButton.backgroundColor = kOrangeColor;
            [self.cell.noteBtn addTarget:self action:@selector(noteBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            return self.cell;
        }else{
            self.cell1 = [TimecardTabeViewCell cellWithTableView:self.tableView];
            self.cell1.timecardImage.image = [UIImage imageNamed:@"go-off-work"];
            self.cell1.onwork.text = @"下班";
            self.cell1.time.text = @"18:00";
            self.cell1.noteBtn.hidden = YES;
            self.cell1.signButton.backgroundColor = PRIMARY_COLOR;
            [self.cell1.signButton setTitle:@"签退" forState:(UIControlStateNormal)];
            [self.cell1.signButton addTarget:self action:@selector(signout:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.cell1.signButton setTintColor:kWhiteColor];
            return self.cell1;
        }
    }else{
        if (indexPath.section == 1){
            self.cell2 = [TimecardTabeViewCell cellWithTableView:self.tableView];
            self.cell2.timecardImage.image = [UIImage imageNamed:@"go-out"];
            self.cell2.noteBtn.hidden = YES;
            self.cell2.onwork.sd_resetLayout
            .leftSpaceToView(self.cell.timecardImage,DEFUALT_MARGIN_SIDES)
            .centerYEqualToView(self.cell.timecardImage)
            .widthIs(50)
            .heightIs(15);
            self.cell2.time.hidden =YES;
            self.cell2.signButton.hidden =YES;
            self.cell2.onwork.text = @"外勤";
            self.cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return self.cell2;
        }
        
    }
    // 3. 返回cell
    return self.cell;
    
    
}
@end
