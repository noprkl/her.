//
//  SelectReportSenderCell.m
//  her.
//
//  Created by 李祥起 on 2017/3/20.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "SelectReportSenderCell.h"

@interface SelectReportSenderCell ()
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation SelectReportSenderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = BackGround_Color;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}
- (void)setSenderModel:(EaseMessageModel *)senderModel {
    _senderModel = senderModel;
    if (senderModel.bodyType == EMMessageBodyTypeText) {
        self.messageLabel.text = senderModel.text;
    }else{
        self.messageLabel.text = @"【语音】";
    }
}
- (void)setIshidSelectbtn:(BOOL)ishidSelectbtn {
    _ishidSelectbtn = ishidSelectbtn;
    self.selectBtn.hidden = ishidSelectbtn;
}
- (IBAction)clickSelectBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_senderBolck) {
        _senderBolck(_senderModel);
    }
}
- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.selectBtn.selected = isSelected;
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
