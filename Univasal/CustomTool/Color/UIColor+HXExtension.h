//
//  UIColor+HXExtension.h
//  照片选择器
//
//  Created by 洪欣 on 2019/12/3.
//  Copyright © 2019 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 渐变方式

 - IHGradientChangeDirectionLevel:              水平渐变
 - IHGradientChangeDirectionVertical:           竖直渐变
 - IHGradientChangeDirectionUpwardDiagonalLine: 向下对角线渐变
 - IHGradientChangeDirectionDownDiagonalLine:   向上对角线渐变
 */
typedef NS_ENUM(NSInteger, IHGradientChangeDirection) {
    IHGradientChangeDirectionLevel,
    IHGradientChangeDirectionVertical,
    IHGradientChangeDirectionUpwardDiagonalLine,
    IHGradientChangeDirectionDownDiagonalLine,
};

@interface UIColor (HXExtension)
@property (nonatomic, copy, readonly, nonnull) NSString *sd_hexString;
+ (UIColor *)hx_colorWithHexStr:(NSString *)string;
+ (UIColor *)hx_colorWithHexStr:(NSString *)string alpha:(CGFloat)alpha;
+ (UIColor *)hx_colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha;
+ (NSString *)hx_hexStringWithColor:(UIColor *)color;

/**
 传入两个颜色和系数获取新的颜色
 
 @param beginColor 开始颜色
 @param coe 系数（0->1）
 @param endColor 终止颜色
 @return 过度颜色
 */
+ (UIColor *)getColorWithColor:(UIColor *)beginColor andCoe:(double)coe  andEndColor:(UIColor *)endColor;

/**
 创建渐变颜色

 @param size       渐变的size
 @param direction  渐变方式
 @param startcolor 开始颜色
 @param endColor   结束颜色

 @return 创建的渐变颜色
 */
+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                                     direction:(IHGradientChangeDirection)direction
                                    startColor:(UIColor *)startcolor
                                      endColor:(UIColor *)endColor;

@end

NS_ASSUME_NONNULL_END
