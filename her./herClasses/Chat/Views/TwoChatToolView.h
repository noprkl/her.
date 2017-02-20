//
//  TwoChatToolView.h
//  her.
//
//  Created by 李祥起 on 2017/2/7.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TwoChatToolViewDelegate  <NSObject>

@required
- (void)clickBackBtnAction;
- (void)clickFocusBtnAction:(UIButton *)btn;

@end

@interface TwoChatToolView : UIView

@property (nonatomic, strong) id<TwoChatToolViewDelegate> toolDelegate; /**< tool代理 */

@end
