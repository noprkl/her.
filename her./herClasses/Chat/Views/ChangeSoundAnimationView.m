//
//  ChangeSoundAnimationView.m
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#define kWaveWidth ((WAVE_HEIGHT/tan(KWaveAngle)) * 2 - 15)

#import "ChangeSoundAnimationView.h"
#import "WaverAnimationView.h"

@interface ChangeSoundAnimationView ()
{
    CADisplayLink *_link;
    CAShapeLayer *_layer1;
    CAShapeLayer *_layer2;
    CAShapeLayer *_layer3;
    CAShapeLayer *_layer4;
    CGFloat _offset;
}
@property (nonatomic, strong) WaverAnimationView *greenWave; /**< 绿色 */
@property (nonatomic, strong) WaverAnimationView *blueWave; /**< 蓝色 */
@property (nonatomic, strong) WaverAnimationView *orangeWave; /**< 橙色 */
@property (nonatomic, strong) WaverAnimationView *redWave; /**< 红色 */
@end

@implementation ChangeSoundAnimationView
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initLayerAndProperty];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initLayerAndProperty];
    }
    return self;
}
- (void)initLayerAndProperty
{
    _layer1 = [CAShapeLayer layer];
    _layer1.opacity = 0.5;
    _layer1.frame = self.bounds;
    
    _layer2 = [CAShapeLayer layer];
    _layer2.frame = self.bounds;
    _layer2.opacity = 0.5;
    
    _layer3 = [CAShapeLayer layer];
    _layer3.opacity = 0.5;
    _layer3.frame = self.bounds;
    
    _layer4 = [CAShapeLayer layer];
    _layer4.frame = self.bounds;
    _layer4.opacity = 0.5;
    
    [self.layer addSublayer:_layer1];
    [self.layer addSublayer:_layer2];
    [self.layer addSublayer:_layer3];
    [self.layer addSublayer:_layer4];
}
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)doAnimtion
{
    _offset += _speed;
    
    _layer1.path = (__bridge CGPathRef _Nullable)([self getPathWithColor:HEXColor(@"#5bd3bc") height:[self fundaction:_offset]]);
    _layer2.path = (__bridge CGPathRef _Nullable)([self getPathWithColor:HEXColor(@"#ffa11a") height:[self fundaction:_offset] + 50 ]);
    _layer3.path = (__bridge CGPathRef _Nullable)([self getPathWithColor:HEXColor(@"#7AC5CD") height:[self fundaction:_offset] + 100]);
    _layer4.path = (__bridge CGPathRef _Nullable)([self getPathWithColor:HEXColor(@"#1E90FF") height:[self fundaction:_offset] + 150]);

}
// 得到高度
- (CGFloat)fundaction:(CGFloat)width {
    CGFloat f = width / kWaveWidth;
    NSInteger f2 = width / kWaveWidth;
    
    if (f2 % 2 == 0) {
        return tan(KWaveAngle) * kWaveWidth*(f-f2);
    }else {
        return -tan(KWaveAngle) * kWaveWidth*(f-f2) + tan(KWaveAngle) * kWaveWidth;
    }
}
- (UIBezierPath *)getPathWithColor:(UIColor *)color height:(CGFloat)kHeight {
#pragma mark - 左边的
    // 偏移量  高度*tan(角度)
    CGFloat kWidth = 10;
    CGFloat kBegin = 0;
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
    [[color colorWithAlphaComponent:0.4] setFill];
    
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
    [[color colorWithAlphaComponent:0.4] setFill];
    
    // 绘制
    [bezierPath1 fill];

    return bezierPath1;
}
#pragma mark
#pragma mark - 动画效果

- (void)startAnimation {
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(doAnimtion)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)stopAnimation {
    [_link invalidate];
    _link = nil;
}
#pragma mark
#pragma mark - 懒加载
- (WaverAnimationView *)greenWave {
    if (!_greenWave) {
        _greenWave = [[WaverAnimationView alloc] initWithFrame:CGRectMake(0, 0, 195/2, WAVE_HEIGHT)];
        _greenWave.color = HEXColor(@"#5bd3bc");
        _greenWave.backgroundColor = BackGround_Color;
    }
    return _greenWave;
}
- (WaverAnimationView *)blueWave {
    if (!_blueWave) {
        _blueWave = [[WaverAnimationView alloc] initWithFrame:CGRectMake(kWaveWidth, 0, kWaveWidth, WAVE_HEIGHT)];
        _blueWave.color = HEXColor(@"#ffa11a");
        _blueWave.backgroundColor = BackGround_Color;
        
    }
    return _blueWave;
}
- (WaverAnimationView *)orangeWave {
    if (!_orangeWave) {
        _orangeWave = [[WaverAnimationView alloc] initWithFrame:CGRectMake(2*kWaveWidth, 0, kWaveWidth, WAVE_HEIGHT)];
        _orangeWave.color = HEXColor(@"#7AC5CD");
        _orangeWave.backgroundColor = BackGround_Color;
        
    }
    return _orangeWave;
}
- (WaverAnimationView *)redWave {
    if (!_redWave) {
        _redWave = [[WaverAnimationView alloc] initWithFrame:CGRectMake(3*kWaveWidth, 0, kWaveWidth, WAVE_HEIGHT)];
        _redWave.color = HEXColor(@"#1E90FF");
        _redWave.backgroundColor = BackGround_Color;
    }
    return _redWave;
}
@end
