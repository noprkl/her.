//
//  DuelAudioManager.h
//  her.
//
//  Created by 李祥起 on 2017/3/22.
//  Copyright © 2017年 LXq. All rights reserved.
//  音效播放

#import <Foundation/Foundation.h>

@interface DuelAudioManager : NSObject

+ (instancetype)sharedManager;

//播放音效
- (void)playSystemSound:(NSString *)filename;

//音效+震动
- (void)playAlertSound:(NSString *)filename;
@end
