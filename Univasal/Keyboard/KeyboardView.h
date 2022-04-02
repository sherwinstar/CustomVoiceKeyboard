//
//  KeyboardView.h
//  Univasal
//
//  Created by txy on 2022/3/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyboardView : UIView
+(KeyboardView*)shared;
-(void)show;
-(void)receivestopplay;
- (CGFloat)viewHeight;
@end

NS_ASSUME_NONNULL_END
