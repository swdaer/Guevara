//
//  GFirstViewController.m
//  Guevara
//
//  Created by 陈达尔 on 16/8/25.
//  Copyright © 2016年 dahl.chen. All rights reserved.
//

#import "GFirstViewController.h"
#import "GFirstCell.h"
#import "GNextViewController.h"
#import "PushAnimation.h"
#import "PopAnimation.h"

@interface GFirstViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property (nonatomic, strong) PushAnimation * push;
@property (nonatomic, strong) PopAnimation * pop;
@end

@implementation GFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;        
    }
    _push = [PushAnimation new];
    _pop = [PopAnimation new];
    
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdetify = @"GFirstCellIdetify";
    GFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GFirstCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GFirstCell * cell = (GFirstCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect imgRect = CGRectMake(8, 10+rectInTableView.origin.y+64, 62.5, 60);
    [_push setStartRect:imgRect finishRect:CGRectMake(([UIScreen mainScreen].bounds.size.width-220)/2, 8+64, 220, 212) cellImg:cell.img];
    [_pop setStartRect:CGRectMake(([UIScreen mainScreen].bounds.size.width-220)/2, 8+64, 220, 212)  finishRect:imgRect cellImg:cell.img];
    GNextViewController * controller = [GNextViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark UINavigationControllerDelegate
- (nullable id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return (id)_push;
    } else if (operation == UINavigationControllerOperationPop){
        return (id)_pop;
    }
    return nil;
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
