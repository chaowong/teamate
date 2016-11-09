//
//  OutworkCardViewController.h
//  teamate
//
//  Created by Jizan on 2016/10/28.
//  Copyright © 2016年 jizan. All rights reserved.
//

#import "BaseTableViewController.h"
#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface OutworkCardViewController : BaseTableViewController

@property (nonatomic ,strong)BMKMapView* mapView;
@property (nonatomic ,strong)BMKLocationService* locService;
@property (nonatomic ,copy)NSString *address;
@property (nonatomic ,copy)NSString *position;

@property (nonatomic ,copy)NSString *latitude;
@property (nonatomic ,copy)NSString *longitude;

@end
