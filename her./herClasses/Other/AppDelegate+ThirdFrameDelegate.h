//
//  AppDelegate+ThirdFrameDelegate.h
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (ThirdFrameDelegate)<EMChatManagerDelegate>

/** 环信SDk */
+ (void)setEaseMobSDK:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions;/** 进入后台 */
+ (void)setEaseMobEnterBackground:(UIApplication *)application;
/** 从后台返回 */
+ (void)setEaseMobEnterForeground:(UIApplication *)application;


@end
