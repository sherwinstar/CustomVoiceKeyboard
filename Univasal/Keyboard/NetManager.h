//
//  NetManager.h
//  Univasal
//
//  Created by txy on 2022/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetManager : NSObject
////单独收藏的文件
+(void)getListcompletionHandler:(void (^ __nullable)(BOOL success,id data))completion;
//收藏的专辑列表
+(void)getList2completionHandler:(void (^ __nullable)(BOOL success,id data))completion;
//右边的语音文件列表
+(void)getList3folder_id:(NSString*)folder_id completionHandler:(void (^ __nullable)(BOOL success,id data))completion;
@end

NS_ASSUME_NONNULL_END
