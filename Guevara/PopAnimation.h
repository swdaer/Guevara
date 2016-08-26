//
//  PopAnimation.h
//  Guevara
//
//  Created by 陈达尔 on 16/8/26.
//  Copyright © 2016年 dahl.chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PopAnimation : NSObject
- (void)setStartRect:(CGRect)sRect finishRect:(CGRect)fRect cellImg:(UIImageView *)img;
@end
