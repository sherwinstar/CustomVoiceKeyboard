//
//  LeftCell.m
//  Univasal
//
//  Created by txy on 2022/3/28.
//

#import "LeftCell.h"
#import "UIView+AutoLayout.h"
@interface LeftCell()
@property(nonatomic,strong)UIButton*playbn;
@property(nonatomic,strong)UILabel*name;
@property(nonatomic,strong)UIButton*send;
@end
@implementation LeftCell
{
    bool _isplay;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)play{
    //点击播放   unplay playing
    //文字颜色
    if (_isplay) {
        [_name setTextColor:HEXCOLORString(@"#FF6D6D")];
    }else{
        [_name setTextColor:HEXCOLORString(@"#FFFFFF")];
    }
}
- (void)dic:(NSDictionary *)dic select:(BOOL)select{
    _isplay=select;
    //数据副职
    if (_isplay) {
        [_name setTextColor:HEXCOLORString(@"#FF6D6D")];
    }else{
        [_name setTextColor:HEXCOLORString(@"#FFFFFF")];
    }
    _name.text=dic[@"name"];
}
-(void)select{
    if (_isplay) {
        return;
    }
    _isplay=YES;
    if (_isplay) {
        [_name setTextColor:HEXCOLORString(@"#FF6D6D")];
    }else{
        [_name setTextColor:HEXCOLORString(@"#FFFFFF")];
    }
    if (self.block) {
        self.block([NSNumber numberWithBool:_isplay]);
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.name];
        [self.name autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.name autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.name.frame.origin.x];
        [self.name autoSetDimension:ALDimensionHeight toSize:self.name.frame.size.height];
        [self.name autoSetDimension:ALDimensionWidth toSize:self.name.frame.size.width];
       // _name.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor clearColor];
        MJWeakSelf
        [self addControl:^(UIView * _Nullable view) {
            [weakSelf select];
        }];
      //  self.contentView.backgroundColor=[UIColor clearColor];
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
        lb.backgroundColor=[UIColor clearColor];
        lb.textColor=HEXCOLORString(@"#FFFFFF");
        lb.font=FONT_Regular(14);
        _name=lb;
        [_name setFrameWithPositionNormal:ccp(12, 0) anchorPoint:ccp(0, 0) size:ccsize(115-20, 20)];
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
        [_send setTitleColor:HEXCOLORString(@"#FFFFFF") forState:0];
        [_send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        [_send setFrameWithPositionNormal:ccp(mainSizeW-116-16, 17+11) anchorPoint:ccp(1, 0.5) size:ccsize(44, 22)];
    }
    return _send;
}


@end

