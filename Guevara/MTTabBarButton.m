//
//  MTTabBarButton.m
//  MovieTogether
//
//  Created by 嘉宏 卢 on 14/11/17.
//  Copyright (c) 2014年 IPOTech. All rights reserved.
//

#import "MTTabBarButton.h"
//#import "BTBadgeLabel.h"

#define HEIGHT_PERCENT 0.70
#define FRAME_BADGE_NONE CGRectMake( (int)(self.imageView.frame.size.width * 0.55), 4, 8, 8)
#define FRAME_BADGE_VALUE CGRectMake( (int)(self.imageView.frame.size.width * 0.55), 4, 15, 15)

@interface MTTabBarButton ()

@property (nonatomic, strong) UIButton *imageView;
//@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *backgroundImageView;
//@property (nonatomic, strong) BTBadgeLabel *badgeLabel;

@end

@implementation MTTabBarButton
@synthesize selectedTextColor = _selectedTextColor;
@synthesize textColor = _textColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    self.backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:self.backgroundImageView];
    
    self.imageView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.userInteractionEnabled = NO;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.imageView setTitleColor:self.textColor forState:UIControlStateNormal];
    self.imageView.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.imageView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:self.imageView];
    
//    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    self.label.textColor = self.textColor;
//    self.label.font = [UIFont systemFontOfSize:16];
//    self.label.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:self.label];
    
//    self.badgeLabel = [[BTBadgeLabel alloc]initWithFrame:FRAME_BADGE_VALUE];
//    self.badgeLabel.text = @"99";
//    self.badgeLabel.layer.masksToBounds = YES;
//    self.badgeLabel.layer.cornerRadius = self.badgeLabel.frame.size.height/2;
//    self.badgeLabel.textColor = [UIColor whiteColor];
//    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
//    self.badgeLabel.font = [UIFont systemFontOfSize:10];
//    self.badgeLabel.hidden = YES;
//    [self addSubview:self.badgeLabel];
}

//- (void)setBadge:(NSString *)badge
//{
//    _badge = badge;
//    self.badgeLabel.text = _badge;
//    self.badgeLabel.hidden = NO;
//    if (!_badge.length || _badge.length > 2 || _badge.intValue <= 0 || _badge.intValue > 99) {
//        self.badgeLabel.frame = FRAME_BADGE_NONE;
//        self.badgeLabel.text = @"";
//        if (!_badge) {
//            self.badgeLabel.hidden = YES;
//            return;
//        }
//    }
//    else{
//        self.badgeLabel.frame = FRAME_BADGE_VALUE;
//    }
//    self.badgeLabel.layer.cornerRadius = self.badgeLabel.frame.size.height/2;
//}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.backgroundImageView.frame = self.bounds;
    CGRect fra = self.imageView.frame;
    fra.origin.y = 14;
    self.imageView.frame = fra;
//    fra = self.label.frame;
    fra.origin.y = self.imageView.frame.origin.y + self.imageView.frame.size.height - 2;
//    self.label.frame = fra;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.backgroundImageView.image = backgroundImage;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self setImageBySelected];
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    [self setImageBySelected];
}

- (void)setTextColor:(UIColor *)textColor
{
    if (textColor) {
        _textColor = textColor;
        [self setTextColorBySelected];
    }
}

- (UIColor *)textColor
{
    if (!_textColor) {
        return [UIColor blackColor];
    }
    return _textColor;
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    if (selectedTextColor) {
        _selectedTextColor = selectedTextColor;
        [self setTextColorBySelected];
    }
}

- (UIColor *)selectedTextColor
{
    if (!_selectedTextColor) {
        return [UIColor lightGrayColor];
    }
    return _selectedTextColor;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setTextColorBySelected];
    [self setImageBySelected];
}

- (void)setImageBySelected
{
    if (self.isSelected) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageView setImage:self.selectedImage forState:UIControlStateNormal];
        }];
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageView setImage:self.image forState:UIControlStateNormal];
        }];
    }
}

- (void)setTextColorBySelected
{
    if (self.isSelected) {
//        self.label.textColor = self.selectedTextColor;
    }
    else{
//        self.label.textColor = self.textColor;
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.imageView setTitle:self.title forState:UIControlStateNormal];
//    self.label.text = _title;
}

- (void)tapAction
{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
