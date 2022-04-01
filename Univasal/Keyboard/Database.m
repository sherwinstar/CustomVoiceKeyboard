//
//  Database.m
//  Univasal
//
//  Created by txy on 2022/3/31.
//

#import "Database.h"
#import "FMDB.h"
#import <sqlite3.h>
@implementation Database
+ (NSString *)token{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"voice_app" ofType:@"db"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
    [dataBase open];
    //select distinct DVN_SERIES,DVN_BRAND from DICT_VEHICLE_NEW where DVN_BRAND='%@' order by DVN_SERIES asc
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM \"main\".\"user_token\""];
    FMResultSet *result = [dataBase executeQuery:queryString];
    NSMutableArray* mu=[[NSMutableArray alloc]init];
    while ([result next]) {
        NSString*token = [result objectForColumn:@"token"];
        NSLog(@"%@",token);
        [mu addObject:token];
//        VehicledModel *model = [[VehicledModel alloc] init];
//        model.DVN_SERIES = [result objectForColumnName:@"DVN_SERIES"];
//        model.DVN_BRAND = [result objectForKeyedSubscript:@"DVN_BRAND"];
//        [self.dataSource addObject:model];
    }
    if (mu.count>0) {
        return mu[0];
    }
    return @"";
}
+ (NSArray *)voicelist{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"voice_app" ofType:@"db"];
   // NSString* source=[[NSBundle mainBundle]resourcePath];///Users/a0496/Library/Developer/CoreSimulator/Devices/0D43C3A3-487C-4429-91D3-56FB53130E06/data/Containers/Bundle/Application/1233E485-6D16-4438-B3ED-530970FA7BD2/Univasal.app
  //  NSString* expath=[[NSBundle mainBundle]executablePath];///Users/a0496/Library/Developer/CoreSimulator/Devices/0D43C3A3-487C-4429-91D3-56FB53130E06/data/Containers/Bundle/Application/1233E485-6D16-4438-B3ED-530970FA7BD2/Univasal.app/Univasal
    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
    [dataBase open];
    //select distinct DVN_SERIES,DVN_BRAND from DICT_VEHICLE_NEW where DVN_BRAND='%@' order by DVN_SERIES asc
    NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM \"main\".\"voice_list\""];
    FMResultSet *result = [dataBase executeQuery:queryString];
    NSMutableArray* mu=[[NSMutableArray alloc]init];
    while ([result next]) {
        NSString* file_name=[result objectForColumn:@"file_name"];
        NSString* voice_name=[result objectForColumn:@"voice_name"];
        [mu addObject:@{@"name":voice_name,@"file_url":file_name}];
       
//        VehicledModel *model = [[VehicledModel alloc] init];
//        model.DVN_SERIES = [result objectForColumnName:@"DVN_SERIES"];
//        model.DVN_BRAND = [result objectForKeyedSubscript:@"DVN_BRAND"];
//        [self.dataSource addObject:model];
    }
    
    return mu;
}
@end
