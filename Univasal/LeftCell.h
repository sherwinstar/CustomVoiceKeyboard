//
//  LeftCell.h
//  Univasal
//
//  Created by txy on 2022/3/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftCell : UITableViewCell
@property(nonatomic,copy)GlobalBlock block;
- (void)dic:(NSDictionary *)dic select:(BOOL)select;
@end

NS_ASSUME_NONNULL_END
