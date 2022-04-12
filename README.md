# 共享数据库说明
#### 在APP和键盘target里添加App Groups, App Groups Id如group.com.linhua.Universal, 其中com.linhua.Universal与主App的bundle id一致
#### 在主App的查询获取app数据库前，如可在appdidfinishlanchoptions里或者在第一个viewcontroller里的viewdidload里执行拷贝数据库到group里（即调用下面方法：[self copyDB]）：
	- (void)copyDB {
	    NSFileManager *fileManager =[NSFileManager defaultManager];
	    NSURL *groupUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.linhua.Universal"];
	    //group.com.linhua.Universal为第一步填的group id
	    NSError *error;
	    NSString *directory = groupUrl.path;
	
	    NSString *dbPath =[directory stringByAppendingPathComponent:@"voice_app.db"];
	
	    if([fileManager fileExistsAtPath:dbPath]== NO){
	        NSString *resourcePath =[[NSBundle mainBundle] pathForResource:@"voice_app" ofType:@"db"];
	        [fileManager copyItemAtPath:resourcePath toPath:dbPath error:&error];
	    }
	}

#### 在Database.m里修改db地址，以后不管在键盘里还是在主app里操作数据库必须用此路径
	+ (NSString *)dbPath {
	    NSURL *groupUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.linhua.Univasal"];
	    NSString *directory = groupUrl.path;
	
	    NSString *dbPath =[directory stringByAppendingPathComponent:@"voice_app.db"];
	    return dbPath;
	}
