#import "MainTabbarViewController.h"
#import "BaseNavigationViewController.h"
#import "MineViewController.h"
#import "LogViewController.h"
#import "ApproveTableViewController.h"
#import "TimecardTableViewController.h"
@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController


+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 2);
    
    
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = UIColorARGB(1, 10, 142, 214);

    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllerWithClassname:[TimecardTableViewController description] imagename:@"attendance" title:@"考勤"];
    [self addChildViewControllerWithClassname:[LogViewController description] imagename:@"journal" title:@"日志"];
    [self addChildViewControllerWithClassname:[ApproveTableViewController description] imagename:@"approval" title:@"审批"];
    [self addChildViewControllerWithClassname:[MineViewController description]imagename:@"mine" title:@"我的"];
    
//    NHServiceListRequest *request = [NHServiceListRequest nh_request];
//    request.nh_url = kNHHomeServiceListAPI;
//    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
//        
//        
//        if (success) {
//            
//            NHBaseNavigationViewController *homeNav = (NHBaseNavigationViewController *)self.viewControllers.firstObject;
//            NHHomeViewController *home = (NHHomeViewController *)homeNav.viewControllers.firstObject;
//            home.models = [NHServiceListModel modelArrayWithDictArray:response];
//        }
//    }];
}

// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
     self.tabBar.tintColor = UIColorARGB(1, 2, 142, 214);
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_h"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [self addChildViewController:nav];
}

@end
