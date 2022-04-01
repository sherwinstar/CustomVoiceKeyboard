//
//  KeyboardCell.m
//  Univasal
//
//  Created by txy on 2022/3/28.
//

#import "KeyboardCell.h"
@interface KeyboardCell()
@property(nonatomic,strong)UIButton*playbn;
@property(nonatomic,strong)UILabel*name;
@property(nonatomic,strong)UIButton*send;
@end
@implementation KeyboardCell
{
    bool _isplay;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)dic:(NSDictionary *)dic select:(BOOL)select{
    _isplay=select;
    //数据副职
    _name.text=dic[@"name"];
    if (_isplay) {
        [_playbn setImage:[UIImage imageNamed:@"playing"] forState:0];
        [_name setTextColor:HEXCOLORString(@"#FF6D6D")];
    }else{
        [_playbn setImage:[UIImage imageNamed:@"unplay"] forState:0];
        [_name setTextColor:HEXCOLORStringB(@"#FFFFFF", 0.8)];
    }
    _send.userInteractionEnabled=YES;
    [_send setTitle:@"发送" forState:0];
}
-(void)delaysend{
    _send.userInteractionEnabled=NO;
    if (self.delayblock) {
        self.delayblock(nil);
    }
}
- (void)delay:(NSInteger)time{
    if (time==0) {
        [_send setTitle:@"发送" forState:0];
        _send.userInteractionEnabled=YES;
        _isplay=YES;
        [_playbn setImage:[UIImage imageNamed:@"playing"] forState:0];
        [_name setTextColor:HEXCOLORString(@"#FF6D6D")];
    }else{
        _send.userInteractionEnabled=NO;
        _isplay=NO;
        [_send setTitle:[NSString stringWithFormat:@"%ld",time] forState:0];
        [_playbn setImage:[UIImage imageNamed:@"unplay"] forState:0];
        [_name setTextColor:HEXCOLORStringB(@"#FFFFFF", 0.8)];
    }
}
-(void)play{
    //点击播放   unplay playing
    //文字颜色
    _isplay=!_isplay;
    if (_isplay) {
        [_playbn setImage:[UIImage imageNamed:@"playing"] forState:0];
        [_name setTextColor:HEXCOLORString(@"#FF6D6D")];
    }else{
        [_playbn setImage:[UIImage imageNamed:@"unplay"] forState:0];
        [_name setTextColor:HEXCOLORStringB(@"#FFFFFF", 0.8)];
    }
    if (self.block) {
        self.block([NSNumber numberWithBool:_isplay]);
    }
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.playbn];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.send];
        _name.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor clearColor];
        self.contentView.backgroundColor=[UIColor clearColor];
    }
    return self;
}
- (UIButton *)playbn{
    if (!_playbn) {
        _playbn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_playbn setImage:[UIImage imageNamed:@"unplay"] forState:0];
        [_playbn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
        [_playbn setFrameWithPositionNormal:ccp(24, 17+11) anchorPoint:ccp(0, 0.5) size:ccsize(14, 14)];
    }
    return _playbn;
}
- (UILabel *)name{
    if (!_name) {
        UILabel*lb=[UILabel new];
        lb.textColor=HEXCOLORStringB(@"#FFFFFF", 0.8);
        lb.font=FONT_Regular(14);
        lb.backgroundColor=[UIColor clearColor];
        _name=lb;
        [_name setFrameWithPositionNormal:ccp(_playbn.right+8, _playbn.centerY) anchorPoint:ccp(0, 0.5) size:ccsize(mainSizeW-116-_playbn.right-8-70, 22)];
    }
    return _name;
}
- (UIButton *)send{
    if (!_send) {
        _send=[UIButton buttonWithType:UIButtonTypeCustom];
        _send.layer.cornerRadius=11;
        _send.layer.masksToBounds=YES;
        [_send setTitle:@"发送" forState:0];
        _send.titleLabel.font=FONT_Regular(14);
        [_send setTitleColor:HEXCOLORStringB(@"#FFFFFF", 0.8) forState:0];
        _send.layer.borderWidth=0.5;
        _send.layer.borderColor=HEXCOLORStringB(@"#FFFFFF", 0.8).CGColor;
        [_send addTarget:self action:@selector(delaysend) forControlEvents:UIControlEventTouchUpInside];
        [_send setFrameWithPositionNormal:ccp(mainSizeW-116-16, 17+11) anchorPoint:ccp(1, 0.5) size:ccsize(44, 22)];
    }
    return _send;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
