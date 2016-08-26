//
//  GTabbarViewController.h
//  Guevara
//
//  Created by 陈达尔 on 16/8/25.
//  Copyright © 2016年 dahl.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTabbarViewController : UITabBarController
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *selectedImages;

@end
