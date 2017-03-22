
//
//  DuelAudioManager.m
//  her.
//
//  Created by 李祥起 on 2017/3/22.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "DuelAudioManager.h"

#import <AudioToolbox/AudioToolbox.h>

@interface DuelAudioManager ()

@property (nonatomic, strong) NSMutableDictionary * dict;

@end

@implementation DuelAudioManager

#pragma mark - public methods

- (void)playSystemSound:(NSString *)filename {
    
    SystemSoundID soundID = [self getSystemSoundID:filename];
    
    AudioServicesPlaySystemSound(soundID);
}

- (void)playAlertSound:(NSString *)filename {
    
    SystemSoundID soundID = [self getSystemSoundID:filename];
    
    NSLog(@"%d",soundID);
    
    AudioServicesPlayAlertSound(soundID);
    
}

#pragma mark - private methods

- (SystemSoundID)getSystemSoundID:(NSString *)filename {
    
    //获取音效
    if ([[self.dict objectForKey:filename] intValue]) {
        return [[self.dict objectForKey:filename] intValue];
    }
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    
    SystemSoundID soundID = 0;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    //存储音效
    [self.dict setObject:@(soundID) forKey:filename];
    
    return soundID;
}


#pragma mark - getters and setters

- (NSMutableDictionary *)dict {
    
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

#pragma mark - life cycle

+ (instancetype)sharedManager {
    
    static DuelAudioManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[DuelAudioManager alloc] init];
    });
    return _manager;
}

@end
