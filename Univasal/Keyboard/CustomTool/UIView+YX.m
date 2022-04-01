//
//  UIView+YX.m
//  OurYX
//
//  Created by txy on 2016/12/6.
//
//

#import "UIView+YX.h"
#import <objc/runtime.h>
@implementation UIView (YX)
- (CGFloat)left {
    return self.frame.origin.x;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}

- (CGFloat)radius
{
    return self.layer.cornerRadius;
}



- (UIViewController *)viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (void)setFrameWithPositionScale:(CGPoint)position anchorPoint:(CGPoint)anchorPoint size:(CGSize)newSize andSuperViewSize:(CGSize)superSize
{
    [self setFrameWithPositionScale:position anchorPoint:anchorPoint size:newSize andSuperViewSize:superSize zoom:NO];
}
- (void)setFrameWithPositionScale:(CGPoint)position anchorPoint:(CGPoint)anchorPoint size:(CGSize)newSize andSuperViewSize:(CGSize)superSize zoom:(BOOL)zoom
{
    CGRect rect;
    CGSize size = [UIScreen mainScreen].bounds.size;
    if(zoom)
    {
        newSize.width = newSize.width*size.width/375;
        newSize.height = newSize.height*size.width/375;
    }
    rect.origin.x = -anchorPoint.x*newSize.width+position.x*superSize.width;
    rect.origin.y = -anchorPoint.y*newSize.height+position.y*superSize.height;
    rect.size = newSize;
    self.frame = rect;
}
- (void)setFrameWithPositionNormal:(CGPoint)position anchorPoint:(CGPoint)anchorPoint size:(CGSize)newSize
{
    [self setFrameWithPositionNormal:position anchorPoint:anchorPoint size:newSize zoom:NO];
}
- (void)setFrameWithPositionNormal:(CGPoint)position anchorPoint:(CGPoint)anchorPoint size:(CGSize)newSize zoom:(BOOL)zoom
{
    CGRect rect;
    CGSize size = [UIScreen mainScreen].bounds.size;
    if(zoom)
    {
        newSize.width =newSize.width*size.width/375;
        newSize.height =newSize.height*size.width/375;
    }
    rect.origin.x = -anchorPoint.x*newSize.width+position.x;
    rect.origin.y = -anchorPoint.y*newSize.height+position.y;
    rect.size = newSize;
    self.frame = rect;
}
/**
 *    @brief     n个view 整体设置横坐标
 *    @param     positionX     整体view横坐标
 *    @param     anchorPointX     整体view锚点
 *    @param     space      view间隔
**/
+ (void)setAbscissaWithPositionX:(CGFloat)positionX anchorPointX:(CGFloat)anchorPointX space:(CGFloat)space views:(nullable UIView *)view, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list arg_ptr;
    UIView *itemView = view;
    CGFloat width = -space;
    va_start(arg_ptr, itemView); //以固定参数的地址为起点sure变参的内存起始地址。
    do
    {
        if (itemView != nil)
        {
            width += space+itemView.width;
        }
        itemView = va_arg(arg_ptr, UIView *); //得到下一个可变参数的值
    } while(itemView != nil);
    
    CGFloat x = -anchorPointX*width+positionX;
    
    va_end(arg_ptr);
    UIView *view2 = view;
    va_start(arg_ptr, view2); //以固定参数的地址为起点sure变参的内存起始地址。
    do
    {
        if (view2 != nil)
        {
            CGRect viewRect = view2.frame;
            viewRect.origin.x = x;
            view2.frame = viewRect;
            x+=view2.width+space;
        }
        view2 = va_arg(arg_ptr, UIView *); //得到下一个可变参数的值
    } while(view2 != nil);
    va_end(arg_ptr);

}

+ (void)heartAnimationWithButton:(UIButton *)btn {
    
    btn.selected = YES;
    
    float bigSize = 1.5;
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = 0.075;
    pulseAnimation.toValue = [NSNumber numberWithFloat:bigSize];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 倒转动画
    pulseAnimation.autoreverses = YES;
    // 设置重复次数为无限大
    pulseAnimation.repeatCount = 2;
    // 添加动画到layer
    [btn.layer addAnimation:pulseAnimation forKey:@"transform.scale"];
    
    
}

+ (void)textGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer* gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = view.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint =startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = view.layer;
    view.frame = gradientLayer1.bounds;
}


static char ViewTapBlockAddress;

- (void)addControl:(ViewTapBlock)block
{
    objc_setAssociatedObject(self, &ViewTapBlockAddress, block, OBJC_ASSOCIATION_COPY);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
    [self addGestureRecognizer:tap];
}
- (void)viewClick
{
    ViewTapBlock block = objc_getAssociatedObject(self, &ViewTapBlockAddress);
    block(self);
}

@end
