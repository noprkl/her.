//
//  DuelAnimationView.h
//  her.
//
//  Created by 李祥起 on 2017/3/22.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "BaseView.h"

typedef void(^VictoryBlock)();

@interface DuelAnimationView : BaseView

@property (nonatomic, strong) VictoryBlock victoryBlock; /**< 胜利 */

- (void)startAnimation;
- (void)stopAnimation;
@end