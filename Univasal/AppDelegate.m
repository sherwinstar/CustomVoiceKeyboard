//
//  AppDelegate.m
//  Univasal
//
//  Created by txy on 2021/12/15.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   NSString* st= [[NSBundle mainBundle]pathForResource:@"cert1" ofType:@"archiver"];
//  id   data = [NSData dataWithContentsOfFile:st];
//    id json = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    id js=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dict = @{@"a": @1};

      NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict ];

      NSDictionary *result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    id re = [NSKeyedUnarchiver unarchiveObjectWithFile:st];
    

  //  2、将对象归档到指定的路径中

 //  bool tr= [NSKeyedArchiver archiveRootObject:dict toFile:st];

  //  3、将归档后的数据提取出来

  id ff=  [NSKeyedUnarchiver unarchiveObjectWithFile:st];

    return YES;
}


#pragma mark - UISceneSession lifecycle

//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
