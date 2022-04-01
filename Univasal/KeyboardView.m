//
//  KeyboardView.m
//  Univasal
//
//  Created by txy on 2022/3/28.
//

#import "KeyboardView.h"
#import "KeyboardCell.h"
#import "LeftCell.h"
#import "Player.h"
#import "NetManager.h"
#import "Database.h"
@interface KeyboardView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView* topview;
@property(nonatomic,strong)UITableView*lefttab;
@property(nonatomic,strong)UITableView*righttab;
@property(nonatomic,strong)UIView*line;
@property(nonatomic,assign) NSInteger selectinx;//左边选择的项目;
@property(nonatomic,assign) NSInteger selectsub;//右边选择的
@property(nonatomic,strong)NSArray*history;
@property(nonatomic,strong)NSArray* packageList;
@property(nonatomic,strong)NSArray*zhuanji;
@property(nonatomic,strong)NSArray* rightData;//右边文件列表
@property(nonatomic,strong) NSString* delayurl;//存储延时播放的url;
@end
@implementation KeyboardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
{
    NSArray*favorite;
    NSTimer* timer;
    NSInteger leavetime;//剩余时间
   
}
static KeyboardView *_instance;
+ (KeyboardView *)shared{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[KeyboardView alloc] init];
        [_instance initUI];
        [_instance database];
    });
    return _instance;
}
- (void)show{
    [self requestapi];
}
-(void)database{
    [Database token];
    [Database voicelist];
}
-(void)delayPlay{
    //延时播放
    leavetime=4;
    [self stopplay];
    [timer setFireDate:[NSDate distantPast]];
}
-(void)changeSelectFav{
    if (_selectinx==0) {
        //请求数据库
        self.rightData=[Database voicelist];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.righttab reloadData];
        });
    }else if (_selectinx==1) {
        [NetManager getListcompletionHandler:^(BOOL success, id  _Nonnull data) {
            if (success) {
                NSDictionary* datadic=data[@"data"];
                self.rightData=datadic[@"items"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.righttab reloadData];
                });
                
            }
        }];
    }else{
        NSDictionary* dic=self.zhuanji[_selectinx-2];
        //专辑下面的文件列表
        [NetManager getList3folder_id:dic[@"folder_id"] completionHandler:^(BOOL success, id  _Nonnull data) {
            if (success) {
                NSDictionary* datadic=data[@"data"];
                self.rightData=datadic[@"items"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.righttab reloadData];
                });
            }
        }];
    }
}

-(void)requestsqlite{
    self.rightData=[Database voicelist];
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.lefttab reloadData];
        [self.righttab reloadData];
    });
}
-(void)requesshoucang{
    [NetManager getListcompletionHandler:^(BOOL success, id  _Nonnull data) {
        if (success) {
            NSDictionary* datadic=data[@"data"];
            self.rightData=datadic[@"items"];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.lefttab reloadData];
                [self.righttab reloadData];
            });
        }
    }];
}
-(void)requestapi{
    [NetManager getList2completionHandler:^(BOOL success, id  _Nonnull data) {
        if (success) {
            NSDictionary* datadic=data[@"data"];
            self.zhuanji=datadic[@"items"];
            NSMutableArray* muarr=[[NSMutableArray alloc]init];
            [muarr addObject:@{@"name":@"历史变声"}];
            [muarr addObject:@{@"name":@"收藏语音包"}];
//            for (int i=0; i<self.zhuanji.count; i++) {
//                NSDictionary* fil=self.zhuanji[i];
//                [muarr addObject:fil[@"name"]];
//            }
            [muarr addObjectsFromArray:self.zhuanji];
            self.packageList=[muarr copy];
            [self requestsqlite];
        }
    }];
   
}
- (void)timergoon{
    leavetime--;
    [self.righttab reloadData];
    if (leavetime==-1) {
        [self playWithurl:_delayurl];
        leavetime=-1;
        [timer setFireDate:[NSDate distantFuture]];
    }
}
- (void)dealloc{
    [timer invalidate];
    timer=nil;
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [self deleteSandBoxWithDomain:docDirPath];
}

- (void)deleteSandBoxWithDomain:(NSString*)homepath{//正向用
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *homecontent = [fileManager contentsOfDirectoryAtPath:homepath error:NULL];
    for (int i=0; i<homecontent.count; i++) {
        NSString *documentsDirectory = [NSString stringWithFormat:@"%@/%@",homepath,homecontent[i]];
        NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
        NSEnumerator *e = [contents objectEnumerator];
        NSString *filename;
        while ((filename = [e nextObject])) {
                BOOL isdelete=   [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
                if(isdelete){
                    NSLog(@"删除日志成功%@",[documentsDirectory stringByAppendingPathComponent:filename]);
                }
                else{
                    NSLog(@"删除日志失败%@",[documentsDirectory stringByAppendingPathComponent:filename]);
                }
        }
    }
}
-(void)playWithurl:(NSString*)url{
    [[Player shared]playWithurl:url];
    leavetime=-1;
    
}
- (void)receivestopplay{
    self.selectsub=-1;
    [self stopplay];
     [self.righttab reloadData];
}
-(void)stopplay{
    [[Player shared]stop];
}
-(void)initUI{
    leavetime=-1;
    MJWeakSelf
    if (@available(iOS 10.0, *)) {
        timer=[NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf timergoon];
        }];
    } else {
        // Fallback on earlier versions
    }
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    [_instance setFrameWithPositionNormal:ccp(0, mainSizeH) anchorPoint:ccp(0, 1) size:ccsize(mainSizeW, 54+263+78+3)];
    _instance.backgroundColor =HEXCOLORString(@"#313233");
    [_instance addSubview:self.topview];
    [_instance addSubview:self.lefttab];
    [_instance addSubview:self.righttab];
    [_instance addSubview:self.line];
   
    _selectinx=0;
    _selectsub=-1;
}

-(void)close{
    //关闭
    [self removeFromSuperview];
    self.zhuanji=@[];
    self.packageList=@[];
    self.selectsub=-1;
    self.selectinx=0;
    self.rightData=@[];
    leavetime=-1;
    [self stopplay];
    [timer setFireDate:[NSDate distantFuture]];
   
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager* file=[NSFileManager defaultManager];
    [file removeItemAtPath:[NSString stringWithFormat:@"%@/voice", docDirPath] error:nil];
}
- (UIView *)topview{
    if (!_topview) {
        _topview=[UIView new];
        [_topview setFrameWithPositionNormal:ccp(0, 0) anchorPoint:ccp(0, 0) size:ccsize(mainSizeW, 54)];
        UILabel*lb=[UILabel new];
        lb.text=@"语音包";
        lb.font=FONT_Semibold(16);
        lb.textColor=[UIColor whiteColor];
        [lb setFrameWithPositionNormal:ccp(12, 27) anchorPoint:ccp(0, 0.5) size:ccsize(200, 25)];
        [_topview addSubview:lb];
        lb.backgroundColor=[UIColor clearColor];
        UIButton* bn =[UIButton buttonWithType:UIButtonTypeCustom];
        [bn setImage:[UIImage imageNamed:@"closebtn"] forState:0];
        [bn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_topview addSubview:bn];
        [bn setFrameWithPositionNormal:ccp(mainSizeW-18, 27) anchorPoint:ccp(1, 0.5) size:ccsize(14, 14)];
    }
    return _topview;
}
- (UITableView *)lefttab {
    if (!_lefttab) {
        _lefttab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_lefttab registerClass:[LeftCell class] forCellReuseIdentifier:@"lefttab"];
        _lefttab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _lefttab.delegate = self;
        _lefttab.dataSource = self;
        _lefttab.showsVerticalScrollIndicator=NO;
        _lefttab.showsHorizontalScrollIndicator=NO;
        [_lefttab setFrameWithPositionNormal:ccp(0, 54) anchorPoint:ccp(0, 0) size:ccsize(115, 263)];
        [_lefttab setBackgroundColor:HEXCOLORString(@"#202020")];
        UIView*head=[UIView new];
        head.backgroundColor=HEXCOLORString(@"#202020");
        [head setFrameWithPositionNormal:ccp(0, 0) anchorPoint:ccp(0, 0) size:ccsize(115, 24)];
        _lefttab.tableHeaderView=head;
//        [_lefttab addControl:^(UIView * _Nullable view) {
//            NSLog(@"");
//        }];
    }
    return _lefttab;
}
- (UITableView *)righttab {
    if (!_righttab) {
        _righttab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_righttab registerClass:[KeyboardCell class] forCellReuseIdentifier:@"righttab"];
        _righttab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _righttab.delegate = self;
        _righttab.dataSource = self;
        _righttab.showsVerticalScrollIndicator=NO;
        _righttab.showsHorizontalScrollIndicator=NO;
        [_righttab setFrameWithPositionNormal:ccp(116, 54) anchorPoint:ccp(0, 0) size:ccsize(mainSizeW-115-1, 263)];
        [_righttab setBackgroundColor:HEXCOLORString(@"#202020")];
    }
    return _righttab;
}
- (UIView *)line{
    if (!_line) {
        _line=[UIView new];
        _line.backgroundColor= HEXCOLORStringB(@"#D8D8D8", 0.1); 
        [_line setFrameWithPositionNormal:ccp(115, 54) anchorPoint:ccp(0, 0) size:ccsize(1, 263)];
    }
    return _line;
}


#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_lefttab) {
        return self.packageList.count;
    }else{
        return self.rightData.count;
    }
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_lefttab) {
        return 32;
    }
    return 39;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_lefttab) {
        static NSString * cellID = @"lefttab";
          LeftCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
          if (cell == nil) {
              cell = [[LeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //  cell.backgroundColor = [UIColor whiteColor];
          }
        MJWeakSelf
        __weak typeof(tableView)weaktaab=tableView;
        [cell setBlock:^(id param) {
            weakSelf.selectinx=indexPath.row;
            [weaktaab reloadData];
            [weakSelf  stopplay];
            weakSelf.selectsub=-1;
            [weakSelf changeSelectFav];
            //刷新子table数据
           // [weakSelf.righttab reloadData];
        }];
        NSDictionary*dic=self.packageList[indexPath.row];
        [cell dic:dic select:_selectinx==indexPath.row];
        return cell;
    }else{
        static NSString * cellID = @"righttab";
          KeyboardCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
          if (cell == nil) {
              cell = [[KeyboardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //  cell.backgroundColor = [UIColor whiteColor];
          }
        MJWeakSelf
        __weak typeof(tableView)weaktaab=tableView;
        [cell setBlock:^(id param) {
            bool isplay=[param boolValue];
            if (isplay) {
                weakSelf.selectsub=indexPath.row;
                NSDictionary* dic=weakSelf.rightData[indexPath.row];
                [weakSelf playWithurl:dic[@"file_url"]];
            }else{
                weakSelf.selectsub=-1;
                [weakSelf stopplay];
            }
            [weaktaab reloadData];
        }];
        [cell setDelayblock:^(id param) {
            weakSelf.selectsub=indexPath.row;
            NSDictionary* dic=weakSelf.rightData[indexPath.row];
            weakSelf.delayurl=dic[@"file_url"];
            [weakSelf delayPlay];
            [weaktaab reloadData];
        }];
        NSDictionary* filedetail=self.rightData[indexPath.row];
        [cell  dic:filedetail select:_selectsub==indexPath.row];
        if (_selectsub==indexPath.row&&leavetime>-1) {
            [cell delay:leavetime];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (tableView==_lefttab) {
//        //todo
//        self.selectinx=indexPath.row;
//        [tableView reloadData];
//    }else{
//        //todo
//    }
}
@end
