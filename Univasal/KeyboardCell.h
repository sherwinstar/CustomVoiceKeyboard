//
//  KeyboardCell.h
//  Univasal
//
//  Created by txy on 2022/3/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyboardCell : UITableViewCell
@property(nonatomic,copy)GlobalBlock block;
@property(nonatomic,copy)GlobalBlock delayblock;
- (void)delay:(NSInteger)time;
-(void)dic:(NSDictionary*)dic select:(BOOL)select;
@end

NS_ASSUME_NONNULL_END
