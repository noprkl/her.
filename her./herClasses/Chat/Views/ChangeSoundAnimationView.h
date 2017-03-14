//
//  ChangeSoundAnimationView.h
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//  切歌动画视图

#import <UIKit/UIKit.h>

@interface ChangeSoundAnimationView : UIView
@property (nonatomic, assign) CGFloat speed; /**< 速度 */

// 开始动画
- (void)startAnimation;
- (void)stopAnimation;

@end
