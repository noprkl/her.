//
//  SliderCutSongView.h
//  her.
//
//  Created by 李祥起 on 2017/2/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwipeViewBlock)();
@interface SliderCutSongView : UIView

@property (nonatomic, strong) SwipeViewBlock swipBlock; /**< 左右滑动 */

- (void)show;
- (void)dismiss;

@end


