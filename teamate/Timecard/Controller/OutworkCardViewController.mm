//
//  OutworkCardViewController.m
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "OutworkCardViewController.h"
#import "TimecardTabeViewCell.h"
#import "CategoryViewController.h"
#import "MapViewCell.h"
#import "CustomCell.h"
#import "TakePictureCell.h"
#import "NoteTableviewCell.h"
#import "NSNotificationCenter+Addition.h"
#import "MKMessagePhotoView.h"
#import "TZImagePickerController.h"
#import "PhotoCollectionViewCell.h"
#import "CompanyModel.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <CoreLocation/CoreLocation.h>

#define kBottomViewH 200

@interface OutworkCardViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MKMessagePhotoViewDelegate,TZImagePickerControllerDelegate,BMKGeoCodeSearchDelegate,CLLocationManagerDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKPointAnnotation  *pointAnnotation;
    BMKUserLocation     *userCurrentLocation;
    UIWebView * callWebview;
}
@property (nonatomic, strong) BMKGeoCodeSearch *geoCode;        // 地理编码

@property (nonatomic ,strong)UIButton *logOutButton;
@property (nonatomic, assign) CGFloat bottomViewY;
@property (nonatomic, strong) MKMessagePhotoView *photosView;

@property (nonatomic, strong)UICollectionView *collectionV;
//上传图片的个数
@property (nonatomic, strong)NSMutableArray *photoArrayM;
@property (nonatomic ,strong)TakePictureCell *mycell;
@property (nonatomic ,strong)TimecardTabeViewCell *cell;
@property (nonatomic ,strong)CustomCell *companycell;
@property (nonatomic ,strong) CLLocationManager *locationManager;
@property (nonatomic ,strong) MBProgressHUD *hud;


@end

@implementation OutworkCardViewController
- (BMKGeoCodeSearch *)geoCode
{
    if (!_geoCode) {
        _geoCode = [[BMKGeoCodeSearch alloc] init];
        _geoCode.delegate = self;
    }
    return _geoCode;
}

- (BMKLocationService *)locService
{
    if (!_locService) {
        // 初始化BMKLocationService
        _locService = [[BMKLocationService alloc]init];
        // 启动LocationService
        [_locService startUserLocationService];
    }
    
    return _locService;
}


- (NSMutableArray *)photoArrayM{
    if (!_photoArrayM) {
        _photoArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _photoArrayM;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLogOutButton];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"外勤";
    [self setUpNotis];
    [self loction];
    self.tableView.scrollEnabled = NO;
    [self requestCompany];

}
- (void)requestCompany{
    [[HttpTool shareManager] POST:URL_COMPANY_List parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *data = responseObject[@"data"];
        for (NSDictionary *dict  in data) {
//                            NSError* err=nil;
//                            CompanyModel *model = [[CompanyModel alloc]initWithDictionary:dict error:&err];
            NSString *departmentName = dict[@"name"];
            [self.dataArray addObject:departmentName];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loction{
    // 初始化反地址编码选项（数据模型）
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    //    BMKGeoCodeSearchOption *add = [[BMKGeoCodeSearchOption alloc] init];
    //    add.address = @"山东省济南市高新区舜华路2000号舜泰广场2号楼32层3202D";
    // 将TextField中的数据传到反地址编码模型
    option.reverseGeoPoint = CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);
    NSLog(@"%f - %f", option.reverseGeoPoint.latitude, option.reverseGeoPoint.longitude);
    // 调用反地址编码方法，让其在代理方法中输出
    [self.geoCode reverseGeoCode:option];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8)
    {
        /** 只在前台开启定位 */
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
    
    [self.locationManager startUpdatingLocation];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if(![CLLocationManager locationServicesEnabled]){
    }

}
// 添加通知
- (void)setUpNotis {
    [NSNotificationCenter addObserver:self action:@selector(keyBoardWillHiddenNoti:) name:UIKeyboardWillHideNotification];
    [NSNotificationCenter addObserver:self action:@selector(keyBoardWillShowNoti:) name:UIKeyboardWillShowNotification];
}
// 键盘下落
- (void)keyBoardWillHiddenNoti:(NSNotification *)noti {
    self.tableView.contentOffset  = CGPointMake(0, 0);
}

// 键盘生起
- (void)keyBoardWillShowNoti:(NSNotification *)noti {
    self.tableView.contentOffset  = CGPointMake(0, 250);
}
#pragma mark 代理方法返回反地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        NSLog(@"%@ - %@", result.address, result.addressDetail.streetNumber);
        self.address = result.address;
    }else{
    }
}

#pragma mark 代理方法返回地理编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        NSLog(@"%@", result.address);
    }else{
    }
}

#pragma mark - Delegate
-(BaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath{
    // 1. 创建cell
    if (indexPath.row == 1) {
        
        self.cell = [TimecardTabeViewCell cellWithTableView:self.tableView];
        self.cell.signButton.hidden = YES;
        self.cell.timecardImage.image = [UIImage imageNamed:@"building"];
        self.cell.noteBtn.hidden = YES;
        self.cell.onwork.sd_resetLayout
        .leftSpaceToView(self.cell.timecardImage,DEFUALT_MARGIN_SIDES)
        .centerYEqualToView(self.cell.timecardImage)
        .rightSpaceToView(self.cell.contentView,DEFUALT_MARGIN_SIDES)
        .heightIs(40);
        self.cell.onwork.numberOfLines = 2;
        self.cell.time.hidden =YES;
        self.cell.signButton.hidden =YES;
        self.cell.onwork.text = self.address;
        self.cell.signButton.backgroundColor = PRIMARY_COLOR;
        return self.cell;
        
    }else if (indexPath.row == 0) {
        MapViewCell *cell = [MapViewCell cellWithTableView:self.tableView];
        
        if (PHONE5S) {
            self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 200)];

        }else{
            self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 300)];

        }
        
        _mapView.showsUserLocation = YES;   // 显示定位图层（用户的位置）
        [cell addSubview:self.mapView];
        
        self.locService.delegate = self;


        return cell;
    }else if (indexPath.row == 2) {
        self.mycell = [TakePictureCell cellWithTableView:self.tableView];
        
        return self.mycell;
    }else if (indexPath.row == 3) {
        self.companycell = [CustomCell cellWithTableView:self.tableView];
        self.companycell.leftLabel.text = @"拜访对象";
        self.companycell.rightLabel.text = @"中航国际";
        
        return self.companycell;
    }else if (indexPath.row == 4) {
        NoteTableviewCell *cell = [NoteTableviewCell cellWithTableView:self.tableView];

        [self setUpPhotosView];
        return cell;
    }
    return nil;
    
    
}
#pragma mark location service delegate
// location 实现相关delegate 处理位置信息更新
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    NSLog(@"heading is %@",userLocation.heading);
}

// 处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    userCurrentLocation = userLocation;
    [_mapView updateLocationData:userLocation];
    
    
    //设置地图的中心点和范围
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = userLocation.location.coordinate;//中心点(当前定位的点)
    region.span.latitudeDelta = 0.05;//经度范围
    region.span.longitudeDelta = 0.05;//纬度范围
    [_mapView setRegion:region animated:YES];
    //获取地理位置(自己写的一个方法，把经纬度传进去得到地理位置)
    //    [self getAddressByCoordinate:userLocation.location.coordinate];
    
    //停止定位
    [_locService stopUserLocationService];
    

}

- (void)signin:(UIButton *)btn{
    btn.hidden = YES;
    self.cell.signinLabel.hidden = NO;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *timeStr = [formatter stringFromDate:date];

    NSString *str2 = [timeStr substringFromIndex:11];//截取掉下标3之后的字符串
    self.cell.signinLabel.textColor = TXT_COLOR;
    self.cell.signinLabel.text = [NSString stringWithFormat:@"已签到 %@",str2];

}
- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        if (PHONE5S) {
            return 200;
            
        }else{

            return 300;
        }

    }
    if (indexPath.row == 1) {
        return 64;
    }
    if (indexPath.row == 2) {
        return 70;
    }
    return 50;
}

-(CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section{
       return 0;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    CategoryViewController *categoryVC =[[ CategoryViewController alloc] init];
    
    if (indexPath.row == 3) {
        categoryVC.pagetitle = @"拜访对象";
        categoryVC.arr = self.dataArray;
        categoryVC.passString = ^(NSString *str){
            CustomCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
            cell.rightLabel.text = str;
        };

        [self pushVc:categoryVC];
    }

}
- (void)setupLogOutButton{
    // 退出按钮
    self.logOutButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.logOutButton.layer.cornerRadius = BTN_CORNER_RADIUS;
    self.logOutButton.layer.masksToBounds = YES;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = view;
    [view addSubview:_logOutButton];
    
    self.logOutButton.sd_layout
    .centerXEqualToView(self.tableView.tableFooterView)
    .topSpaceToView(view,DEFUALT_MARGIN_SIDES+3)
    .leftSpaceToView(view,DEFUALT_MARGIN_SIDES)
    .rightSpaceToView(view,DEFUALT_MARGIN_SIDES)
    .heightIs(40);
    [self.logOutButton setTitle:@"提交" forState:(UIControlStateNormal)];
    [self.logOutButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.logOutButton.titleLabel.font = GZFontWithSize(18);
    self.logOutButton.layer.cornerRadius = BTN_CORNER_RADIUS;
    self.logOutButton.backgroundColor = UIColorARGB(1, 2, 141, 251);
    self.logOutButton.layer.masksToBounds = YES;
    [self.logOutButton addTarget:self action:@selector(clickLogOutButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)clickLogOutButtonAction:(UIButton *)btn{
    
    [self setupProgressHud];
    NSDictionary *dict = @{@"address":_address,
                           @"position":_position,
                           @"image":@"https://imgs.bipush.com/article/cover/201607/27/091302249334.jpg?imageView2/1/w/300/h/300/imageMogr2/strip/interlace/1/quality/85/format/jpg",
                           @"remark":@"外勤签到",
                           @"customerid":self.companycell.rightLabel.text
                           };
    [[HttpTool shareManager] POST:URL_WORKCARD_NEW_OUT parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.hud removeFromSuperview];
        [self pop];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view] ;
    self.hud.label.text=@"打卡中...";
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    [_hud showAnimated:YES];
}

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
    [self.photoArrayM addObject:image];
    //选取完图片之后关闭视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

// -------------



#pragma mark -相册视图
-(void)setUpPhotosView
{
    if (!self.photosView)
    {
        
        self.photosView = [[MKMessagePhotoView alloc]initWithFrame:CGRectMake(100,0,kWidth-120, 40)];
        self.photosView.photoScrollView.width = kWidth-120;
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
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ([UIScreen mainScreen].bounds.size.width - 60) / 5 + 10) collectionViewLayout:flowL];
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
