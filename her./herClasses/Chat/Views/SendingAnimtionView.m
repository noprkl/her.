//
//  SendingAnimtionView.m
//  her.
//
//  Created by 李祥起 on 2017/3/16.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "SendingAnimtionView.h"

@implementation SendingAnimtionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        imageView.image = [UIImage imageNamed:@"send"];
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
        animation.duration  = 1;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = 0;
        [imageView.layer addAnimation:animation forKey:nil];
    }
    return self;
}
- (void)startAnimating {

}
- (void)stopAnimating {

}
@end
