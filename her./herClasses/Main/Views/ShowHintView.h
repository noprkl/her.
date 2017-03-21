//
//  ShowHintView.h
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//  提示文字

#import "BaseView.h"

@interface ShowHintView : BaseView
@property (nonatomic, strong) NSString *alertStr; /**< 提示文字 */
@property (nonatomic, assign) CGFloat offsetY; /**< y偏移量 0在顶部 */

@property (nonatomic, assign) CGFloat width; /**< 提示框宽度 */
@property (nonatomic, strong) UIColor *fontColor; /**< 字体颜色 */
@property (nonatomic, assign) CGFloat fontSize; /**< 字体大小 */

@property (nonatomic, strong) UIColor *backGroundColor; /**< 背景颜色 */

- (void)show;
- (void)dismiss;

@end
