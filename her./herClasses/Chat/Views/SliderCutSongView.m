//
//  SliderCutSongView.m
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "SliderCutSongView.h"

@interface SliderCutSongView ()
@property (nonatomic, strong) UIControl *overLayer; /**< 背景 */

@property (nonatomic, strong) UIView *sliderView; /**< 滑动view */
@property (nonatomic, strong) UIImageView *imgView1; /**< 图片1 */
@property (nonatomic, strong) UIImageView *imgView2; /**< 图片2 */
@property (nonatomic, strong) UIImageView *imgView3; /**< 图片3 */
@property (nonatomic, strong) UIImageView *imgView4; /**< 图片4 */
@property (nonatomic, strong) UIImageView *imgView5; /**< 图片5 */
@property (nonatomic, strong) UIImageView *imgView6; /**< 图片6 */
@property (nonatomic, strong) UIImageView *imgView7; /**< 图片7 */
@property (nonatomic, strong) UIImageView *imgView8; /**< 图片8 */
@property (nonatomic, strong) UIImageView *cloudImgView; /**< 云朵 */

@end

@implementation SliderCutSongView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.sliderView];
        [self.sliderView addSubview:self.imgView1];
        [self.sliderView addSubview:self.imgView2];
        [self.sliderView addSubview:self.imgView3];
        [self.sliderView addSubview:self.imgView4];
        [self addSubview:self.cloudImgView];
    }
    return self;
}
- (void)setUP {
    [self.sliderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left);
        make.size.equalTo(KSIZE(SCREEN_WIDTH, 48));
    }];
    [self.imgView4 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sliderView.centerY);
        make.right.equalTo(self.centerX).offset(-85/2);
    }];
    [self.imgView3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sliderView.centerY);
        make.right.equalTo(self.imgView4.left).offset(- 10);
    }];
    [self.imgView2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sliderView.centerY);
        make.right.equalTo(self.imgView3.left).offset(- 10);
    }];
    [self.imgView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sliderView.centerY);
        make.right.equalTo(self.imgView2.left).offset(- 10);
    }];
    DLog(@"%@", NSStringFromCGRect(self.sliderView.frame));
    [self.cloudImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sliderView.bottom).offset(5);
        make.right.equalTo(self.right).offset(-10);
    }];
}
- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction:)];
        swipe.numberOfTouchesRequired = 1;
        // 设置滑动方向为左、右滑
        swipe.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
        [_sliderView addGestureRecognizer:swipe];
    }
    return _sliderView;
}
- (UIImageView *)imgView1 {
    if (!_imgView1) {
        _imgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows20%"]];
    }
    return _imgView1;
}
- (UIImageView *)imgView2 {
    if (!_imgView2) {
        _imgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows40%"]];
    }
    return _imgView2;
}
- (UIImageView *)imgView3 {
    if (!_imgView3) {
        _imgView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows60%"]];
     }
    return _imgView3;
}
- (UIImageView *)imgView4 {
    if (!_imgView4) {
        _imgView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows80%"]];
    }
    return _imgView4;
}
- (UIImageView *)cloudImgView {
    if (!_cloudImgView) {
        _cloudImgView = [[UIImageView alloc] initWithImage:[UIImage originalImageNamed:@"reminder"]];
    }
    return _cloudImgView;
}
- (void)swipeGestureAction:(UISwipeGestureRecognizer *)swipe {
    DLog(@"左右滑动");
    [self dismiss];
    if (_swipBlock) {
        _swipBlock();
    }
}
#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)overLayer {
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overLayer.backgroundColor = [HEXColor(@"#000000") colorWithAlphaComponent:0.3];
    }
    return _overLayer;
}
- (void)show {

    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];
    
#pragma mark
#pragma mark - 设置当前view的frame
    
    CGRect rect = self.frame;
    rect = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.frame = rect;
    // 约束
    [self setUP];
    
    //渐入动画
    [self fadeIn];
}
- (void)dismiss {
    //返回时调用
    [self fadeOut];
//    if (_disBlock) {
//        _disBlock();
//    }
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
