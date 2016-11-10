//
//  TimecardTableViewController.m
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "TimecardTableViewController.h"
#import "RecordViewController.h"
#import "BaseNavigationViewController.h"
#import "TimecardTabeViewCell.h"
#import "OutworkCardViewController.h"
#import "ReasonForLateViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface TimecardTableViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    NSString *latitude;// jing
    NSString *longitude;// wei
    NSString *address;//
    CLLocation *loca;
}
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic ,strong)TimecardTabeViewCell *cell;
@property (nonatomic ,strong)TimecardTabeViewCell *cell1;
@property (nonatomic ,strong)TimecardTabeViewCell *cell2;
@property (nonatomic ,strong)MKMapView *mapView;
@property (nonatomic ,strong)UIImageView *headerView;
@property (nonatomic ,strong) MBProgressHUD *hud;

@end

@implementation TimecardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"考勤";
    

    self.tableView.backgroundColor = BG;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rigthItemClick)];

    
    [self setupHeaderView];
    [self requestBackimage];
    [self location];
}

- (void)requestBackimage{
    [[HttpTool shareManager] GET:URL_BackIng_show parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = responseObject[@"msg"];
        NSString *imageUrl = [NSString stringWithFormat:@"%@/masters/%@",BASE_URL,str];
    
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"backImage"] completed:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)location{
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        
        [locationManager requestWhenInUseAuthorization];
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.distanceFilter = 5.0;
        [locationManager startUpdatingLocation];
    }
}
#pragma mark -  定位代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *loc = [locations objectAtIndex:0];
    
    loca = loc;
    latitude = [NSString stringWithFormat:@"%f",loc.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f",loc.coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            address = [NSString stringWithFormat:@"%@%@%@%@",placeMark.locality,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
        }
    }];
   
}

- (CLLocation *)constructWithCoordinate:(CLLocationCoordinate2D)coordinate {
    return [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}
#pragma mark - UI
- (void)rigthItemClick{
    RecordViewController *record  = [[RecordViewController alloc] init];
    [self pushVc:record];
}

- (void)setupHeaderView{

    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 150)];
    self.headerView.image = [UIImage imageNamed:@"backImage.jpg"];
//    [self.headerView sd_setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#> completed:<#^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)completedBlock#>];
    
    UILabel *weakLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 200, 50)];
    weakLabel.textColor = kWhiteColor;
    weakLabel.textAlignment = NSTextAlignmentLeft;
    weakLabel.font= kFont(37);
    [self.headerView addSubview:weakLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(weakLabel.frame), 200, 20)];
    self.timeLabel.textColor = kWhiteColor;
    self.timeLabel.font= kFont(17);
    self.timeLabel.textAlignment = NSTextAlignmentLeft;

    [self.headerView addSubview:self.timeLabel];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *timeStr = [formatter stringFromDate:date];
    self.timeLabel.text = timeStr;
    NSString *week = [self getweekDayStringWithDate:date];
    weakLabel.text = week;
    

    
    self.tableView.tableHeaderView = self.headerView;
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];

}



- (NSString *) getweekDayStringWithDate:(NSDate *) date

{
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    // 1 是周日，2是周一 3.以此类推
    NSNumber * weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    NSString *weekDayString;
    switch (weekInt) {
        case 1:{
            weekDayString = @"星期日";
        }
            break;
        case 2:{
            weekDayString = @"星期一";
        }
            break;
        case 3:{
            weekDayString = @"星期二";
        }
            break;
        case 4:{
            weekDayString = @"星期三";
        }
            break;
        case 5:{
            weekDayString = @"星期四";
        }
            break;
        case 6:{
            weekDayString = @"星期五";
        }
            break;
        case 7:{
            weekDayString = @"星期六";
        }
            break;
        default:
            break;
    }
    return weekDayString;
    
}

-(void)refreshTime{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *timeStr = [formatter stringFromDate:date];
        self.timeLabel.text = timeStr;
        
        //计算时间差
        self.timeInterval = [self countTimeIntervalWithCurrentTime:timeStr];
        
    });
    
}

//计算时间差
-(NSTimeInterval)countTimeIntervalWithCurrentTime:(NSString *)timeStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *zeroTime = @"00:00:00";
    NSDate *zeroDate = [formatter dateFromString:zeroTime];
    NSDate *currentDate = [formatter dateFromString:timeStr];
    
    NSTimeInterval interval = [currentDate timeIntervalSinceDate:zeroDate];
    return interval;
    
}

#pragma mark - Delegate
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
- (void)noteBtnAction:(UIButton *)btn{
    ReasonForLateViewController *outworkCard =[[ ReasonForLateViewController alloc] init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:outworkCard];
    [self presentVc:nav];
    
}

- (void)signin:(UIButton *)btn{
   
    [self setupProgressHud];
    CLLocationCoordinate2D test = CLLocationCoordinate2DMake(loca .coordinate.latitude, loca .coordinate.longitude);
    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
    NSDictionary* testdic;
    //转换GPS坐标至百度坐标
    testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
    
    
    CLLocationCoordinate2D test1 =  BMKCoorDictionaryDecode(testdic);
    NSString *s1 = [NSString stringWithFormat:@"%f",test1.latitude] ;
    NSString *s2 =[NSString stringWithFormat:@"%f",test1.longitude];
    
    
    NSString *position = [NSString stringWithFormat:@"%@,%@",s1,s2];
    NSDictionary *dict = @{      @"address": address,
                                 @"remark": @"测试上班签到",
                                 @"position":position};
    [[HttpTool shareManager] POST:URL_WORKCARD_NEW_ON parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        btn.hidden = YES;
        self.cell.signinLabel.hidden = NO;
        self.cell.noteBtn.hidden = NO;
        NSString *str2 = [self.timeLabel.text substringFromIndex:11];//截取掉下标3之后的字符串
        self.cell.signinLabel.text = [NSString stringWithFormat:@"已签到 %@",str2];
        [self.hud removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)signout:(UIButton *)btn{
    [self setupProgressHud];

    CLLocationCoordinate2D test = CLLocationCoordinate2DMake(loca .coordinate.latitude, loca .coordinate.longitude);
    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
    NSDictionary* testdic;
    //转换GPS坐标至百度坐标
    testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
    CLLocationCoordinate2D test1 =  BMKCoorDictionaryDecode(testdic);
    NSString *s1 = [NSString stringWithFormat:@"%f",test1.latitude] ;
    NSString *s2 =[NSString stringWithFormat:@"%f",test1.longitude];
    
    NSString *position = [NSString stringWithFormat:@"%@,%@",s1,s2];
    NSDictionary *dict = @{      @"address": address,
                                 @"remark": @"测试上班签退",
                                 @"position":position};
    [[HttpTool shareManager] POST:URL_WORKCARD_NEW_OFF parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            btn.hidden = YES;
            self.cell1.signinLabel.hidden = NO;
            self.cell1.noteBtn.hidden = NO;
            NSString *str2 = [self.timeLabel.text substringFromIndex:11];
            self.cell1.signinLabel.text = [NSString stringWithFormat:@"已签退 %@",str2];
        [self.hud removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}

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

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BaseTableViewCell *)cell{
    if (indexPath.section == 1) {
        OutworkCardViewController *outworkCard =[[ OutworkCardViewController alloc] init];
        CLLocationCoordinate2D test = CLLocationCoordinate2DMake(loca .coordinate.latitude, loca .coordinate.longitude);
        //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
        NSDictionary* testdic;
        //转换GPS坐标至百度坐标
        testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
        CLLocationCoordinate2D test1 =  BMKCoorDictionaryDecode(testdic);
        NSString *s1 = [NSString stringWithFormat:@"%f",test1.latitude] ;
        NSString *s2 =[NSString stringWithFormat:@"%f",test1.longitude];
        outworkCard.address = address;
        outworkCard.latitude = s1;
        outworkCard.longitude = s2;
        outworkCard.position = [NSString stringWithFormat:@"%@,%@",s1,s2];
        [self pushVc:outworkCard];
    }
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

@end
