//
//  UIView+YX.h
//  OurYX
//
//  Created by txy on 2016/12/6.
//
//

#import <UIKit/UIKit.h>
typedef void (^ViewTapBlock)(UIView * _Nullable view);

@interface UIView (YX)
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat radius;   //设置圆角

//找到自己的vc
- (UIViewController *_Nullable)viewController;
//设置frame 
- (void)setFrameWithPositionNormal:(CGPoint)position anchorPoint:(CGPoint)anchorPoint size:(CGSize)newSize;
- (void)setFrameWithPositionNormal:(CGPoint)position anchorPoint:(CGPoint)anchorPoint size:(CGSize)newSize zoom:(BOOL)zoom;
- (void)setFrameWithPositionScale:(CGPoint)position anchorPoint:(CGPoint)anchorPoint size:(CGSize)newSize andSuperViewSize:(CGSize)superSize zoom:(BOOL)zoom;
- (void)setFrameWithPositionScale:(CGPoint)position anchorPoint:(CGPoint)anchorPoint size:(CGSize)newSize andSuperViewSize:(CGSize)superSize;
+ (void)setAbscissaWithPositionX:(CGFloat)positionX anchorPointX:(CGFloat)anchorPointX space:(CGFloat)space views:(nullable UIView *)view, ... NS_REQUIRES_NIL_TERMINATION;
- (void)addControl:(ViewTapBlock _Nullable )block;
+ (void)heartAnimationWithButton:(UIButton *_Nullable)btn;
+ (void)textGradientview:(UIView *_Nullable)view bgVIew:(UIView *_Nullable)bgVIew gradientColors:(NSArray *_Nullable)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
