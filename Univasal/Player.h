//
//  Player.h
//  Univasal
//
//  Created by txy on 2022/3/30.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject<AVAudioPlayerDelegate>
+(Player*)shared;
- (void)playWithurl:(NSString*)url;
-(void)stop;
@end

NS_ASSUME_NONNULL_END
