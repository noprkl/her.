//
//  FindAnimationView.m
//  her.
//
//  Created by 李祥起 on 2017/2/6.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "FindAnimationView.h"

@interface FindAnimationView ()

@property (nonatomic, strong) UIControl *overLayer; /**< 背景 */

@property (nonatomic, strong) UIImageView *findImgView; /**< 图片 */

@end

@implementation FindAnimationView

#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)overLayer {
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overLayer.backgroundColor = [UIColor clearColor];
    }
    return _overLayer;
}
- (void)show {
    
    CGFloat width = 250;
    CGFloat height = 50;
    CGFloat x = (SCREEN_WIDTH - width) / 2;
    CGFloat y = (SCREEN_HEIGHT - height) / 2;
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.overLayer.frame = CGRectMake(x, y, width, height);
    
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];
    
#pragma mark
#pragma mark - 设置当前view的frame
    
    CGRect rect = self.frame;
    rect = CGRectMake(x, y, width, height);
    
    self.frame = rect;
    
    // 约束
//    [self setUP];
    
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss {
    //返回时调用
    [self fadeOut];
}
- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut {
    [UIView animateWithDuration:0.5 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
    }];
}


@end
