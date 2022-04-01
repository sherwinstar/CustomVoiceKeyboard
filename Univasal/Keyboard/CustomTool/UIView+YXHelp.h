//
//  UIView+YXHelp.h
//  ClouderWork
//
//  Created by txy on 2019/9/25.
//  Copyright © 2019 https://www.clouderwork.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YXHelp)
-(void)curePush;
-(void)curePop;
-(void)oglFlipWithDirection:(NSInteger)di;
- (void)rotateView:(CGFloat)dushu;
@end

NS_ASSUME_NONNULL_END
