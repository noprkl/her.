//
//  SelectReportAcceptCell.m
//  her.
//
//  Created by 李祥起 on 2017/3/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "SelectReportAcceptCell.h"

@interface SelectReportAcceptCell ()
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@end

@implementation SelectReportAcceptCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = BackGround_Color;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}
- (void)setAcceptModel:(EaseMessageModel *)acceptModel {
    _acceptModel = acceptModel;
    if (acceptModel.bodyType == EMMessageBodyTypeText) {
        self.messageLabel.text = acceptModel.text;
    }else{
        self.messageLabel.text = @"【语音】";
    }
}
- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.selectedBtn.selected = isSelected;
}
- (IBAction)clickselectButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_acceptBolck) {
        _acceptBolck(_acceptModel);
    }
}
/** 返回cell的高度*/
-(CGFloat)cellHeghit{
    //1.重新布局子控件
    [self layoutIfNeeded];
    
    return 5 + 10 + self.messageLabel.bounds.size.height + 10 + 5;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
