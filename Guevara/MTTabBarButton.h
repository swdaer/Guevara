//
//  MTTabBarButton.h
//  MovieTogether
//
//  Created by 嘉宏 卢 on 14/11/17.
//  Copyright (c) 2014年 IPOTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTabBarButton : UIControl

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *badge;

@property (nonatomic, strong) UIImage *backgroundImage;

@end
