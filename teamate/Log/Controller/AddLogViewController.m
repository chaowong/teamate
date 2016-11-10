//
//  AddLogViewController.m
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "AddLogViewController.h"
#import "AddLogTableViewCell.h"
#import "CategoryViewController.h"
#import "ContentAndPictureCell.h"
#import "MKComposePhotosView.h"
#import "MKMessagePhotoView.h"
#import "TZImagePickerController.h"
#import "PhotoCollectionViewCell.h"
#import "CustomCell.h"
#import "PickerChoiceView.h"
#import "ValuePickerView.h"
#import "DepartmentModel.h"
#import "PickerChoiceView.h"

@interface AddLogViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MKMessagePhotoViewDelegate,TZImagePickerControllerDelegate,TFPickerDelegate>
{
    NSNumber *hour;
}

@property (nonatomic ,strong)ContentAndPictureCell *mycell;
@property (nonatomic, strong) ValuePickerView *pickerView;
@property (nonatomic, strong) MKMessagePhotoView *photosView;
@property (nonatomic, strong)UICollectionView *collectionV;
//上传图片的个数
@property (nonatomic, strong)NSMutableArray *photoArrayM;
@property (nonatomic ,strong)NSMutableArray *departmentArray;
@property (nonatomic ,strong)NSMutableArray *categoryArray;
@property (nonatomic ,strong) AddLogTableViewCell *cell;
@property (nonatomic ,strong) AddLogTableViewCell *cell2;
@property (nonatomic ,strong)CustomCell *cell3;

@end

@implementation AddLogViewController
#pragma mark - lazy

- (NSMutableArray *)categoryArray{
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}
-(NSMutableArray *)departmentArray{
    if (!_departmentArray) {
        _departmentArray = [NSMutableArray array];
    }
    return _departmentArray;
}
- (NSMutableArray *)photoArrayM{
    if (!_photoArrayM) {
        _photoArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _photoArrayM;
}

#pragma mark - basic
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor =BG;
    self.mycell.photosView.delegate =self;
    [self setUpItems];
    [self requestDepartmentListData];
    [self requestLogCategoryListDataWithType:@"worklog"];
}

#pragma mark - UI
// 设置导航栏
- (void)setUpItems {
    self.navigationItem.title = @"写日志";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rigthItemClick)];
}

#pragma mark - action
- (void)leftItemClick{
    [self.mycell.textView resignFirstResponder];
    [self dismiss];
}

- (void)rigthItemClick{
    [self.mycell.textView resignFirstResponder];
    [self addWorkLog];
}

#pragma mark - request data
- (void)addWorkLog{

    NSNumber * nums = @([self.cell3.rightLabel.text integerValue]);
    NSDictionary *dict = @{@"content":self.mycell.textView.text,
                           @"departmentid":self.cell.otherLabel.text,
                           @"duration":nums,
                           @"images":@"https://imgs.bipush.com/article/cover/201607/27/091302249334.jpg?imageView2/1/w/300/h/300/imageMogr2/strip/interlace/1/quality/85/format/jpg",
                           @"categoryid":self.cell2.otherLabel.text,
                           };
        
    [[HttpTool shareManager] POST:URL_WORKLOG_NEW parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
// 请求部门列表信息
- (void)requestDepartmentListData{

    [[HttpTool shareManager] POST:URL_DEPARTMENT_LIST parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *data = responseObject[@"data"];
            for (NSDictionary *dict  in data) {
//                NSError* err=nil;
//                DepartmentModel *model = [[DepartmentModel alloc]initWithDictionary:dict error:&err];
                NSString *departmentName = dict[@"name"];
                [self.departmentArray addObject:departmentName];
            }
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 请求部门列表信息
- (void)requestLogCategoryListDataWithType:(NSString *)type{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",URL_CATEGORY_LIST,type];
    [[HttpTool shareManager] GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *data = responseObject[@"data"];
        for (NSDictionary *dict  in data) {
           
            NSString *departmentName = dict[@"name"];
            [self.categoryArray addObject:departmentName];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Delegate
-(BaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    // 1. 创建cell
    self.cell = [AddLogTableViewCell cellWithTableView:self.tableView];
    self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 1) {
        self.cell2 = [AddLogTableViewCell cellWithTableView:self.tableView];

        self.cell2.timecardImage.hidden = YES;
        self.cell2.onwork.hidden = YES;
        self.cell2.time.sd_resetLayout
        .centerYEqualToView(self.cell2.contentView)
        .leftSpaceToView(self.cell2.contentView,DEFUALT_MARGIN_SIDES)
        .widthIs(150)
        .heightIs(20);
        
        self.cell2.time.text = @"所属分类";
        self.cell2.otherLabel.text = @"其他类型";
        self.cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return self.cell2;
    }
    if (indexPath.section == 2) {
        self.mycell = [ContentAndPictureCell cellWithTableView:self.tableView];
        [self setUpPhotosView];
        return self.mycell;

    }
    if (indexPath.section == 3) {
        self.cell3 = [CustomCell cellWithTableView:self.tableView];
        self.cell3.leftLabel.text = @"耗用时间";
        self.cell3.rightLabel.text = @"请选择...";
        self.cell3.accessoryType = UITableViewCellAccessoryNone;
        return self.cell3;
    }
    return self.cell;
    
    
}
- (NSInteger)nh_numberOfSections {
    return 4;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 170;
    }
    return 64;
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
    CategoryViewController *categoryVC =[[ CategoryViewController alloc] init];

    if (indexPath.section == 0) {
        categoryVC.pagetitle = @"其他部门";
        categoryVC.arr =  self.departmentArray;
        categoryVC.passString = ^(NSString *str){
            AddLogTableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
            cell.otherLabel.text = str;
        };

        [self pushVc:categoryVC];

    }else if (indexPath.section == 1){
        categoryVC.pagetitle = @"问题分类";
        categoryVC.arr =  self.categoryArray;
        categoryVC.passString = ^(NSString *str){
            AddLogTableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
            cell.otherLabel.text = str;
        };
        [self pushVc:categoryVC];

    }else if (indexPath.section == 3){
        self.pickerView = [[ValuePickerView alloc]init];
        self.pickerView.dataSource = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
        self.pickerView.pickerTitle = @"小时";
        self.pickerView.defaultStr = @"0.0";
        __weak typeof(self) weakSelf = self;
        self.pickerView.valueDidSelect = ^(NSString *value){

            CustomCell *cell = [weakSelf.tableView cellForRowAtIndexPath: indexPath];;
            cell.rightLabel.text = [NSString stringWithFormat:@"%@小时",value];
            
        };
        [self.pickerView show];
    }
}

// ---

//实现代理方法
-(void)addPicker:(UIImagePickerController *)picker{
    
    [self presentViewController:picker animated:YES completion:nil];
}

//实现代理方法
-(void)addPickers:(UIImagePickerController *)picker{
    
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)addUIImagePicker:(UIImagePickerController *)picker{
    
    [self presentViewController:picker animated:YES completion:nil];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
}
#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    [self.mycell.photoArrayM addObject:image];
    //选取完图片之后关闭视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

// -------------



#pragma mark -相册视图
-(void)setUpPhotosView
{
    if (!self.photosView){
        self.photosView = [[MKMessagePhotoView alloc]initWithFrame:CGRectMake(5,100,kWidth, 80)];
        [self.mycell addSubview:self.photosView];
        self.photosView.delegate = self;
    }
}

#pragma mark 上传图片UIcollectionView
-(void)addCollectionViewPicture{
    //创建一种布局
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc]init];
    //设置每一个item的大小
    flowL.itemSize = CGSizeMake((self.view.frame.size.width - 60) / 5 , (self.view.frame.size.width - 60) / 5 );
    flowL.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    //列
    flowL.minimumInteritemSpacing = 10;
    //行
    flowL.minimumLineSpacing = 10;
    //创建集合视图
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, ([UIScreen mainScreen].bounds.size.width - 60) / 5 + 10) collectionViewLayout:flowL];
    _collectionV.backgroundColor = [UIColor whiteColor];
    // NSLog(@"-----%f",([UIScreen mainScreen].bounds.size.width - 60) / 5);
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    //添加集合视图
    [self.mycell addSubview:_collectionV];
    
    //注册对应的cell
    [_collectionV registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark CollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_photoArrayM.count == 0) {
        return 0;
    }
    else{
        return _photoArrayM.count;
    }
}

//返回每一个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.deleBt addTarget:self action:@selector(delePhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.deleBt.tag  = indexPath.row;
    cell.photoV.image = self.photoArrayM[indexPath.item];
    return cell;
}

@end
