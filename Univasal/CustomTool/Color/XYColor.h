//
//  XYColor.h
//  UniversalApp
//
//  Created by txy on 2021/12/14.
//

#ifndef XYColor_h
#define XYColor_h
/*
 项目主色
 */
#define MAIN_COLOR [UIColor hx_colorWithHexStr:@"#00ae66"]//主色调(绿色)

#define NAV_COLOR [UIColor hx_colorWithHexStr:@"#f9f9f9"]//导航条色调


#define TEXT_BLACK_COLOR1 [UIColor hx_colorWithHexStr:@"#222222"]//黑色字体(深)

#define TEXT_BLACK_COLOR2 [UIColor hx_colorWithHexStr:@"#666a6c"]//黑色字体(浅)

#define TEXT_BLACK_COLOR3 [UIColor hx_colorWithHexStr:@"#3A4043"]//黑色字体(中)

#define TEXT_GRAY_COLOR1 [UIColor hx_colorWithHexStr:@"#9d9fa1"]//灰色字体

#define TEXT_GRAY_COLOR2 [UIColor hx_colorWithHexStr:@"#9c9fa1"]//灰色字体（浅）

#define TEXT_GRAY_COLOR3 [UIColor hx_colorWithHexStr:@"#DBDBDB"]//灰色字体（极浅）

#define TEXT_WHITE_COLOR1 [UIColor hx_colorWithHexStr:@"#fefefe"]//白色字体 (1号)

#define TEXT_RED_COLOR1 [UIColor hx_colorWithHexStr:@"#fa5741"]//红色字体（浅）

#define TEXT_ORANGE_COLOR1 [UIColor hx_colorWithHexStr:@"#ff8f20"]//橙色字体

#define FILL_GAY [UIColor hx_colorWithHexStr:@"#f6f5f3"]//填充灰色

#define FILL_WHITE [UIColor hx_colorWithHexStr:@"#ffffff"]//填充白色

#define Line_GRAY_COLOR [UIColor hx_colorWithHexStr:@"#e7e7e7"]//灰色分割线


/**
 *颜色
 */
#define COLOR_VALUE(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 随机色
#define COLOR_RANDOM  COLOR_VALUE(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1)

#define COLOR_HexString(s) [UIColor hx_colorWithHexStr:s]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define UIColorFromRGB(rgbValue)  UIColorFromRGBA(rgbValue,1.0f)

#define HEXCOLORString(string) [UIColor hx_colorWithHexStr:string]
#define HEXCOLORStringB(string,coe) [UIColor hx_colorWithHexStr:string alpha:coe]

//获取两种颜色中间的颜色
#define NewCOLOR(color1,coe,color2) [UIColor getColorWithColor:color1 andCoe:coe andEndColor:color2]

//渐变色
#define GradientCOLOR(cgsize,int,uicolor1,uicolor2) [UIColor bm_colorGradientChangeWithSize:cgsize direction:int startColor:uicolor1 endColor:uicolor2]
#endif /* XYColor_h */
#import "UIColor+HXExtension.h"
