//
//  PrefixHeader.pch
//  OurFourMaster_
//
//  Created by txy on 2016/12/5.
//
//
#define APP_WINDOW (UIWindow *)[[UIApplication sharedApplication].windows firstObject]
#define MY_WINDOW  [UIApplication sharedApplication].keyWindow

//适配刘海屏底部
#define kIsBangsScreen ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})




#pragma mark - 《常用间距》

#define LEFT_RIGHT_PING 16 //视图左右间隔
#define LEFT_RIGHT_PING2 12 //视图左右间隔
#define LINE_HEIGHT 0.5 //分割线宽度
#define mainSizeW [UIScreen mainScreen].bounds.size.width
#define mainSizeH [UIScreen mainScreen].bounds.size.height

//通知中心
#define TNotificationCenter [NSNotificationCenter defaultCenter]
#pragma mark - 《字体》

#define FONT_Medium(s)      [UIFont fontWithName:@"PingFangSC-Medium" size:s ]//中黑体
#define FONT_Semibold(s)    [UIFont fontWithName:@"PingFangSC-Semibold" size:s]//中粗体
#define FONT_Regular(s)     [UIFont fontWithName:@"PingFangSC-Regular" size:s ]//常规体
#define FONT_Light(s)       [UIFont fontWithName:@"PingFangSC-Light" size:s ]//细体
#define FONT_Ultralight(s)  [UIFont fontWithName:@"PingFangSC-Ultralight" size:s * [LocalDataTool shareLocalDataTool].changeFont]//极细体
#define FONT_Thin(s)        [UIFont fontWithName:@"PingFangSC-Thin" size:s * [LocalDataTool shareLocalDataTool].changeFont]//纤细体
#define FONT_NAME_SIZE(n,s) [UIFont fontWithName:n size:s * [LocalDataTool shareLocalDataTool].changeFont]


#import <UIKit/UIKit.h>

typedef void(^GlobalBlock)(id param);

#import "XYColor.h"
#import "UIView+YX.h"
#import "UIView+YXHelp.h"
#define ccp(x,y) CGPointMake(x, y)
#define ccsize(x,y) CGSizeMake(x, y)
// 弱引用
#define MJWeakSelf __weak typeof(self) weakSelf = self;
