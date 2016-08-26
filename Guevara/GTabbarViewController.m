//
//  GTabbarViewController.m
//  Guevara
//
//  Created by 陈达尔 on 16/8/25.
//  Copyright © 2016年 dahl.chen. All rights reserved.
//

#import "GTabbarViewController.h"
#import "MTTabBarButton.h"
#import "UIColor+Hex.h"
#import "GFirstViewController.h"
#import "GSecondViewController.h"
#import "MyViewController.h"
#import "TabbarAnimation.h"

#define SCREENHIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface GTabbarViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) MTTabBarButton *curButton;

@end

@implementation GTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    [self setupViewControllers];
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    [super setViewControllers:viewControllers];
    [self initTabBarButton];
    self.curButton = [self.buttons objectAtIndex:self.selectedIndex];
    self.curButton.selected = YES;
}

- (void)setupViewControllers
{
    self.selectedImages = @[@"ic_main_2_",@"ic_tool_2_",@"ic_me_2_"];
    self.images = @[@"ic_main_1_",@"ic_tool_1_",@"ic_me_1_"];
    
    GFirstViewController * controller1 = [[GFirstViewController alloc] init];
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:controller1];
    
    GSecondViewController * controller2 = [[GSecondViewController alloc] init];
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:controller2];
    
    MyViewController * controller3 = [[MyViewController alloc] init];
    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:controller3];

    self.titles = @[@"首页",@"工具",@"我"];
    self.viewControllers = @[nav1,nav2,nav3];
    self.selectedIndex = 0;
    [self tabBarButtonAction:self.buttons.firstObject];
}

- (void)initTabBarButton
{
    UIView * tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewControllers.count * 50 + 55, self.tabBar.frame.size.height)];
    tabbarView.backgroundColor = [UIColor whiteColor];
    tabbarView.layer.masksToBounds = YES;
    [self.tabBar addSubview:tabbarView];
    
    NSMutableArray *btns = [NSMutableArray array];
    for (int i = 0; i < self.viewControllers.count; i++) {
        CGFloat width = SCREENWIDTH / self.viewControllers.count;
        CGFloat height = self.tabBar.frame.size.height;
        MTTabBarButton *btn = [[MTTabBarButton alloc]initWithFrame:CGRectMake(i * 50, 0, 100, height)];
        btn.image = [UIImage imageNamed:[self.images objectAtIndex:i]];
        btn.selectedImage = [UIImage imageNamed:[self.selectedImages objectAtIndex:i]];
        btn.title = [self.titles objectAtIndex:i];
        btn.textColor = [UIColor colorWithHexString:@"283c42"];
        btn.backgroundColor = [UIColor clearColor];
        btn.selectedTextColor = [UIColor colorWithHexString:@"283c42"];
        btn.index = i;
        //        if (i == 2) {
        //            CGRect frame = CGRectMake(0, 0, 55, 55);
        ////            frame.size.height = height + 12;
        //            frame.origin.y = - 5.5;
        //            frame.origin.x = btn.center.x-27.5;
        //            btn.frame = frame;
        //            btn.backgroundImage = [UIImage imageNamed:@"icon_tab_ride_nor"];
        ////            btn.selectedImage = [UIImage imageNamed:@"icon_tab_ride_nor"];
        //            btn.selectedTextColor = [UIColor colorWithRed:37.0f/255.0f green:130.0f/255.0f blue:225.0f/255.0f alpha:1];;
        //            btn.textColor = [UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1];;
        //        }
        [btn addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:btn];
        [btns addObject:btn];
    }
    self.buttons = btns;

}

- (void)tabBarButtonAction:(MTTabBarButton *)sender
{
    
    [self.curButton setSelected:NO];
    self.curButton = sender;
    sender.selected = YES;
    self.selectedIndex = sender.index;
    if (sender.index == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.curButton.frame = CGRectMake(0, -14, 100, self.tabBar.frame.size.height);
            [self.buttons enumerateObjectsUsingBlock:^(MTTabBarButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx>0) {
                    obj.frame = CGRectMake(idx*50+50, -14, 100, self.tabBar.frame.size.height);
                }
            }];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            [self.buttons enumerateObjectsUsingBlock:^(MTTabBarButton* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx>sender.index) {
                    obj.frame = CGRectMake(idx*50+50, -14, 100, self.tabBar.frame.size.height);
                } else {
                    obj.frame = CGRectMake(idx*50, -14, 100, self.tabBar.frame.size.height);
                }
            }];
        }];
    }
    //    [self.tabBar setSelectedItem:[self.tabBar.items objectAtIndex:[_buttons indexOfObject:sender]]];
}

- (void)setBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index
{
    MTTabBarButton *btn = [self.buttons objectAtIndex:index];
    btn.badge = badgeValue;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    if (self.viewControllers) {
        UIButton *sender = [self.buttons objectAtIndex:selectedIndex];
        [self.curButton setSelected:NO];
        self.curButton = (MTTabBarButton *)sender;
        sender.selected = YES;
        [self tabBarController:self didSelectViewController:[self.viewControllers objectAtIndex:[_buttons indexOfObject:sender]]];
    }
}

#pragma mark - TabBarViewController Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //    if (![viewController isEqual:tabBarController.viewControllers[1]]) {
    //        UINavigationController *controller = tabBarController.viewControllers[1];
    //        [(SummaryViewController *)controller.topViewController hideNotificationList];
    //        [(SummaryViewController *)controller.topViewController hideGroupList];
    //    }
    //    if (![viewController isEqual:tabBarController.viewControllers[2]]) {
    //        UINavigationController *controller = tabBarController.viewControllers[2];
    //        [(RankViewController *)controller.topViewController hideBikeTeamList];
    //    }
}

- (nullable id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return (id)[TabbarAnimation new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
