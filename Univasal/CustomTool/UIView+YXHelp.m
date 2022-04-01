//
//  UIView+YXHelp.m
//  ClouderWork
//
//  Created by txy on 2019/9/25.
//  Copyright © 2019 https://www.clouderwork.com. All rights reserved.
//

#import "UIView+YXHelp.h"

@implementation UIView (YXHelp)
-(void)curePush{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
  //  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.type = kCATransitionPush;
    
    animation.subtype = kCATransitionFromRight;
    
    [self.window.layer addAnimation:animation forKey:nil];
}
-(void)curePop{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    //animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;animation.subtype = kCATransitionFromLeft;
    [self.window.layer addAnimation:animation forKey:nil];
}
-(void)oglFlipWithDirection:(NSInteger)di{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.7;
    //animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    if (di==1) {
        animation.subtype = kCATransitionFromRight;
    }
    else{
        animation.subtype = kCATransitionFromLeft;
    }
    [self.layer addAnimation:animation forKey:nil];
}
- (void)rotateView:(CGFloat)dushu
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:dushu];
    rotationAnimation.duration = 1;
    rotationAnimation.repeatCount = 1;
    [self.window.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
@end
