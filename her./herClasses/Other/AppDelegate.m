//
//  AppDelegate.m
//  her.
//
//  Created by ma c on 17/1/18.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AppDelegate+ThirdFrameDelegate.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
@interface AppDelegate ()

@property (nonatomic, strong) BMKMapManager *mapManager;
@property (nonatomic, strong) NSDate *lastPlaySoundDate; /**< <#注释#> */

@end
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#pragma mark
#pragma mark - 地图

    //请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"6SsHM2EdIfo86CTBFC1iXTpFwpYixCv2"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
#pragma mark
#pragma mark - 环信
    
    [AppDelegate setEaseMobSDK:application launchOptions:launchOptions];
    //添加监听在线推送消息
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
  
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController *mainVc = [[MainViewController alloc] init];
    UINavigationController *tabbc = [[UINavigationController alloc] initWithRootViewController:mainVc];
    
    self.window.rootViewController = tabbc;
    
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)didReceiveMessages:(NSArray *)aMessages
{
#if !TARGET_IPHONE_SIMULATOR
//    [self playSoundAndVibration];
    
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
//        [self showNotificationWithMessage:[aMessages firstObject]];
    }
#endif
}
- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}
- (void)showNotificationWithMessage:(EMMessage *)message{
    NSString *messageStr = nil;
    switch (message.body.type) {
        case EMMessageBodyTypeText:
        {
            messageStr = [EaseConvertToCommonEmoticonsHelper
                          convertToSystemEmoticons:((EMTextMessageBody *)message.body).text];
        }
            break;
        case EMMessageBodyTypeImage:
        {
            messageStr = @"[图片]";
        }
            break;
        case EMMessageBodyTypeLocation:
        {
            messageStr = @"[位置]";
        }
            break;
        case EMMessageBodyTypeVoice:
        {
            messageStr = @"[音频]";
        }
            break;
        case EMMessageBodyTypeVideo:{
            messageStr = @"[视频]";
        }
            break;
        default:
            break;
    }
//    NSDictionary *dict = @{
//                           @"uid":message.from
//                           };
//    [HTTPTool getRequestWithPath:Api_getotheruserinfo params:dict success:^(id successJson) {
//        NSLog(@"%@", successJson);
//        //发送本地推送
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        notification.fireDate = [NSDate date]; //触发通知的时间
//        
//        NSString *title = [successJson[@"data"] objectForKey:@"nickName"];
//        
//        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
//        notification.alertAction = @"打开";
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        
//        //发送通知
//        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//        UIApplication *application = [UIApplication sharedApplication];
//        application.applicationIconBadgeNumber += 1;
//        
//    } error:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [AppDelegate setEaseMobEnterBackground:application];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [AppDelegate setEaseMobEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
