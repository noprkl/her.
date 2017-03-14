//
//  WaverAnimationView.h
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//  波浪线--三角形

#import <UIKit/UIKit.h>

@interface WaverAnimationView : UIView

@property (nonatomic, assign) BOOL isLeft; /**< 是否向右斜 */

@property (nonatomic, strong) UIColor *color; /**< 颜色 */
@property (nonatomic, assign) CGFloat speed; /**< 速度 */
@end
