//
//  AppDelegate+ThirdFrameDelegate.m
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AppDelegate+ThirdFrameDelegate.h"
#import "EaseUI.h"


@implementation AppDelegate (ThirdFrameDelegate)

// 环信
+ (void)setEaseMobSDK:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions {
    EMOptions *options = [EMOptions optionsWithAppkey:@"1130161214178203#ta"];

#if DEBUG
    NSString *apnsCertName = @"herPushDev";
#else
    NSString *apnsCertName = @"herpushDis";
#endif

    options.apnsCertName = apnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    // 环信登录
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
            EMError *error = [[EMClient sharedClient] loginWithUsername:@"111" password:@"111"];
            if (!error) {
                NSLog(@"登陆成功");
                EMPushOptions *emoptions = [[EMClient sharedClient] pushOptions];
                //设置有消息过来时的显示方式:1.显示收到一条消息 2.显示具体消息内容.
                //自己可以测试下
                emoptions.displayStyle = EMPushDisplayStyleMessageSummary;
                [[EMClient sharedClient] updatePushOptionsToServer];
               // 设置推送昵称
                [[EMClient sharedClient] setApnsNickname:@"111"];
            } else {
                NSLog(@"登陆失败--%@", error.errorDescription);
            }
    }
    // 环信UI调用

    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:@"wangmeikeji#meixiaoer"
                                         apnsCertName:apnsCertName
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    //iOS8以上 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
}
/** 进入后台 */
+ (void)setEaseMobEnterBackground:(UIApplication *)application{

    [[EMClient sharedClient] applicationDidEnterBackground:application];
}
/** 从后台返回 */
+ (void)setEaseMobEnterForeground:(UIApplication *)application{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[EMClient sharedClient] registerForRemoteNotificationsWithDeviceToken:deviceToken completion:^(EMError *aError) {
        if (aError) {
            NSLog(@"%@", aError.errorDescription);
        }else{
            NSLog(@"环信token注册成功");
        }
    }];
    
    // 环信需要注册推送
    [[EMClient sharedClient] bindDeviceToken:deviceToken];
}

@end
