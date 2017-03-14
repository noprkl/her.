//
//  WaverAnimationView.m
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

//起始X位置
#define kBegin 0


#import "WaverAnimationView.h"

@interface WaverAnimationView ()
{
    CGFloat offset;
    // 高度
    CGFloat kHeight;
    //条纹宽度
    CGFloat kWidth;

}
@end

@implementation WaverAnimationView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        kHeight = WAVE_HEIGHT;
        kWidth = 15;
    }
    return self;
}
- (void)animation {
    offset += _speed;
    
    
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
#pragma mark - 左边的
    // 偏移量  高度*tan(角度)
    CGFloat margin = kHeight / tan(KWaveAngle);
    DLog(@"%lf", margin);
    
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
    [bezierPath1 moveToPoint:CGPointMake(kBegin, kBegin)];//第一个点（左上）
    [bezierPath1 addLineToPoint:CGPointMake(kWidth, kBegin)];//第二个点（右上）
    [bezierPath1 addLineToPoint:CGPointMake(margin, kHeight)];//第三个点（右下）
    [bezierPath1 addLineToPoint:CGPointMake(margin - kWidth, kHeight)];//第四个点（左下）
    /*
     
     **    **
      **  **
       ****
        **
     
     */
    
    bezierPath1.lineCapStyle = kCGLineCapSquare;//线头样式
    bezierPath1.lineJoinStyle = kCGLineJoinRound; //设置线头相交的部分
    
    [bezierPath1 closePath];
    // 填充
    [[_color colorWithAlphaComponent:0.4] setFill];
    
    // 绘制
    [bezierPath1 fill];
    
#pragma mark - 右边的
    bezierPath1 = [UIBezierPath bezierPath];
    [bezierPath1 moveToPoint:CGPointMake(margin - kWidth, kHeight)];//第一个点（左下）
    [bezierPath1 addLineToPoint:CGPointMake(margin, kHeight)];//第二个点（右下）
    [bezierPath1 addLineToPoint:CGPointMake(margin * 2 - kWidth, kBegin)];//第三个点（右上）
    [bezierPath1 addLineToPoint:CGPointMake((margin - kWidth) * 2, kBegin)];//第四个点（左上）
    
    bezierPath1.lineCapStyle = kCGLineCapSquare;//线头样式
    bezierPath1.lineJoinStyle = kCGLineJoinRound; //设置线头相交的部分
    
    [bezierPath1 closePath];
    // 填充
    [[_color colorWithAlphaComponent:0.4] setFill];
    
    // 绘制
    [bezierPath1 fill];
}


@end
