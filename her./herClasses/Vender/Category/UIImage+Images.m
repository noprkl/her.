//
//  UIImage+Images.m
//  her.
//
//  Created by ma c on 17/1/19.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "UIImage+Images.h"

@implementation UIImage (Images)

+ (UIImage *)originalImageNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
@end
