//
//  ChatPeopleView.m
//  her.
//
//  Created by 李祥起 on 2017/3/16.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "ChatPeopleView.h"

@interface ChatPeopleView ()

@end

@implementation ChatPeopleView

- (void)createChatPeopleWithArray:(NSArray *)names {
    NSArray *array = self.subviews;
    for (UIView *view in array) {
        [view removeFromSuperview];
    }
    if (names.count == 1) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        UIImageView *otherIconView = [[UIImageView alloc] init];
        otherIconView.image = [UIImage imageNamed:@"The-boy-picture"];
        UILabel *otherNameLabel = [[UILabel alloc] init];
        otherNameLabel.text = [names firstObject];
        otherNameLabel.font = [UIFont boldSystemFontOfSize:21];
        otherNameLabel.tintColor = HEXColor(@"#1a1a1a");
        [self addSubview:button];
        [button addSubview:otherIconView];
        [button addSubview:otherNameLabel];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(self.centerX);
        }];
        [otherIconView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button.centerY);
            make.left.equalTo(button.left).offset(20);
            make.size.equalTo(CGSizeMake(40, 40));
        }];
        
        [otherNameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button.centerY);
            make.left.equalTo(otherIconView.right).offset(5);
        }];
//        [button addTarget:self action:@selector(clickFirstBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }else if(names.count == 2){
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];

        UIImageView *otherIconView = [[UIImageView alloc] init];
        otherIconView.image = [UIImage imageNamed:@"The-boy-picture"];
        UILabel *otherNameLabel = [[UILabel alloc] init];
        otherNameLabel.text = [names firstObject];
        otherNameLabel.font = [UIFont boldSystemFontOfSize:21];
        otherNameLabel.tintColor = HEXColor(@"#1a1a1a");
        [self addSubview:button];
        [button addSubview:otherIconView];
        [button addSubview:otherNameLabel];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(self.centerX);
        }];
        [otherIconView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button.centerY);
            make.left.equalTo(button.left).offset(20);
            make.size.equalTo(CGSizeMake(40, 40));
        }];
        
        [otherNameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button.centerY);
            make.left.equalTo(otherIconView.right).offset(5);
        }];
        [button addTarget:self action:@selector(clickFirstBtnAction) forControlEvents:(UIControlEventTouchDown)];

        UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];

        UIImageView *otherIconView2 = [[UIImageView alloc] init];
        otherIconView2.image = [UIImage imageNamed:@"The-boy-picture"];
        UILabel *otherNameLabel2 = [[UILabel alloc] init];
        otherNameLabel2.text = [names lastObject];
        otherNameLabel2.font = [UIFont boldSystemFontOfSize:21];
        otherNameLabel2.tintColor = HEXColor(@"#1a1a1a");
        [self addSubview:button2];
        [button2 addSubview:otherIconView2];
        [button2 addSubview:otherNameLabel2];
        [button2 makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self);
            make.left.equalTo(self.centerX);
        }];
        [otherNameLabel2 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button2.centerY);
            make.right.equalTo(button2.right).offset(5);
        }];
        [otherIconView2 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button2.centerY);
            make.right.equalTo(otherNameLabel2.left);
            make.size.equalTo(CGSizeMake(40, 40));
        }];
        
        [button2 addTarget:self action:@selector(clickSecondBtnAction) forControlEvents:(UIControlEventTouchDown)];

    }
}

- (void)clickFirstBtnAction {
    if (_firstBlock) {
        _firstBlock();
    }
}
- (void)clickSecondBtnAction {
    if (_secondBlock) {
        _secondBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
