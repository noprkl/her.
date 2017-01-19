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
- (void)show;
- (void)dismiss;
@end
