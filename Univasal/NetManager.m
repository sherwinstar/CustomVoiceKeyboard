//
//  NetManager.m
//  Univasal
//
//  Created by txy on 2022/3/31.
//

#import "NetManager.h"
#import "Database.h"
#define http @"http://"
#define host @"voiceapp.xiaopuhaohuo.com:8888"
#define requesttoken [Database token]
@implementation NetManager
//单独收藏的文件
+(void)getListcompletionHandler:(void (^ __nullable)(BOOL success,id data))completion{
    NSString*str=[NSString stringWithFormat:@"%@%@%@",http,host,@"/v1/app/voice_file/fav/page?page=1&page_size=10"];
    //1. 创建一个网络请求
    
    NSURL *url = [NSURL URLWithString:str];
    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0];
    
    [request setAllHTTPHeaderFields:@{@"token":requesttoken}];
    NSLog(@"开始请求%@",str);
    //3.获得会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求出错了%@",error);
        }
        else{
            NSLog(@"请求成功,返回%@",response);
            NSError * err;
            id js=[NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            completion(YES,js);
            // NSLog(@"尼玛1%@,response=%@,data=%@",url,response,data);
        }
    }];
    
    //5.执行任务
    [dataTask resume];
}
+(void)getList2completionHandler:(void (^ __nullable)(BOOL success,id data))completion{
    NSString*str=[NSString stringWithFormat:@"%@%@%@",http,host,@"/v1/app/voice_folder/fav/page?page=1&page_size=10"];
    //1. 创建一个网络请求
    NSURL *url = [NSURL URLWithString:str];
    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0];
    
    [request setAllHTTPHeaderFields:@{@"token":requesttoken}];
    NSLog(@"开始请求%@",str);
    //3.获得会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求出错了%@",error);
        }
        else{
            NSLog(@"请求成功,返回%@",response);
            NSError * err;
            id js=[NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            completion(YES,js);
            // NSLog(@"尼玛1%@,response=%@,data=%@",url,response,data);
        }
    }];
    
    //5.执行任务
    [dataTask resume];
}
//右边的语音文件列表
+(void)getList3folder_id:(NSString*)folder_id completionHandler:(void (^ __nullable)(BOOL success,id data))completion{
    NSString*str=[NSString stringWithFormat:@"%@%@%@%@",http,host,@"/v1/app/voice_file/page?page=1&page_size=10&folder_id=",folder_id];
    //1. 创建一个网络请求
    NSURL *url = [NSURL URLWithString:str];
    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0];
    
    [request setAllHTTPHeaderFields:@{@"token":requesttoken}];
    NSLog(@"开始请求%@",str);
    //3.获得会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求出错了%@",error);
        }
        else{
            NSLog(@"请求成功,返回%@",response);
            NSError * err;
            id js=[NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            completion(YES,js);
            // NSLog(@"尼玛1%@,response=%@,data=%@",url,response,data);
        }
    }];
    
    //5.执行任务
    [dataTask resume];
}
+(void)getRequest:(NSString*)str completionHandler:(void (^ __nullable)(BOOL success,id data))completion{
    //1. 创建一个网络请求
    NSURL *url = [NSURL URLWithString:str];
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"开始请求%@",str);
    //3.获得会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求出错了%@",error);
        }
        else{
            NSLog(@"请求成功,返回%@",response);
            NSError * err;
            id js=[NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            completion(YES,js);
            // NSLog(@"尼玛1%@,response=%@,data=%@",url,response,data);
        }
    }];
    
    //5.执行任务
    [dataTask resume];
}
@end
