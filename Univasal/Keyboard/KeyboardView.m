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
#import "UIView+AutoLayout.h"

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
@property(nonatomic,assign) BOOL isPortrait;
@property(nonatomic,assign) BOOL isKeyboard;
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
    });
    return _instance;
}

- (void)initialize:(BOOL)isKeyboard {
    self.isKeyboard = isKeyboard;
    [self initUI];
    [self database];
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
    leavetime = -1;
    self.isPortrait = YES;
    MJWeakSelf
    if (@available(iOS 10.0, *)) {
        timer=[NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf timergoon];
        }];
    } else {
        // Fallback on earlier versions
    }
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    [self setFrameWithPositionNormal:ccp(0, mainSizeH) anchorPoint:ccp(0, 1) size:ccsize(mainSizeW, 398 - (self.isPortrait ? 0 : 100))];//54+263+78+3
    self.backgroundColor = HEXCOLORString(@"#313233");
    [self addSubview:self.topview];
    [self addSubview:self.lefttab];
    [self addSubview:self.righttab];
    [self addSubview:self.line];
    
    if (self.isKeyboard) {
        [self.topview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [self.topview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [self.topview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.topview autoSetDimension:ALDimensionHeight toSize:54];
        
        [self.lefttab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [self.lefttab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topview];
        [self.lefttab autoSetDimension:ALDimensionHeight toSize:[self contentHeight]];
        [self.lefttab autoSetDimension:ALDimensionWidth toSize:115];
       
        [self.line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topview];
        [self.line autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.lefttab];
        [self.line autoSetDimension:ALDimensionWidth toSize:1];
        [self.line autoSetDimension:ALDimensionHeight toSize:115];
        
        [self.righttab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topview];
        [self.righttab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.line];
        [self.righttab autoSetDimension:ALDimensionHeight toSize:[self contentHeight]];
        [self.righttab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    }
   
    _selectinx=0;
    _selectsub=-1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeOrientation:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)didChangeOrientation:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        self.isPortrait = YES;
    } else {
        self.isPortrait = NO;
    }
    
    CGFloat height = [self viewHeight] - (self.isPortrait ? 0 : 100);
    self.frame = CGRectMake(self.frame.origin.x, [UIScreen mainScreen].bounds.size.height - height, [UIScreen mainScreen].bounds.size.width, height);
    self.topview.frame = CGRectMake(self.topview.frame.origin.x, self.topview.frame.origin.y, [UIScreen mainScreen].bounds.size.width, self.topview.frame.size.height);
    self.lefttab.frame = CGRectMake(self.lefttab.frame.origin.x, self.lefttab.frame.origin.y, self.lefttab.frame.size.width, [self contentHeight]);
    self.righttab.frame = CGRectMake(self.righttab.frame.origin.x, self.righttab.frame.origin.y, [UIScreen mainScreen].bounds.size.width - self.righttab.frame.origin.x, [self contentHeight]);
    self.line.frame = CGRectMake(self.line.frame.origin.x, self.line.frame.origin.y, self.line.frame.size.width, [self contentHeight]);
}

- (CGFloat)viewHeight {
    return 398;
}

- (CGFloat)contentHeight {
    return 263 - (self.isPortrait ? 0 : 100);
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
//        bn.tag = 10;
        [bn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        if (!self.isKeyboard) {
            [_topview addSubview:bn];
            [bn setFrameWithPositionNormal:ccp(mainSizeW-18, 27) anchorPoint:ccp(1, 0.5) size:ccsize(14, 14)];
            CGFloat right = mainSizeW - 14 - bn.frame.origin.x;
            [bn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [bn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:right];
            [bn autoSetDimension:ALDimensionHeight toSize:14];
            [bn autoSetDimension:ALDimensionWidth toSize:14];
        }
        
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
        [_lefttab setFrameWithPositionNormal:ccp(0, 54) anchorPoint:ccp(0, 0) size:ccsize(115, [self contentHeight])];
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
        _righttab.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        [_righttab registerClass:[KeyboardCell class] forCellReuseIdentifier:@"righttab"];
        _righttab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _righttab.delegate = self;
        _righttab.dataSource = self;
        _righttab.showsVerticalScrollIndicator=NO;
        _righttab.showsHorizontalScrollIndicator=NO;
        [_righttab setFrameWithPositionNormal:ccp(116, 54) anchorPoint:ccp(0, 0) size:ccsize(mainSizeW-115-1, [self contentHeight])];
        [_righttab setBackgroundColor:HEXCOLORString(@"#202020")];
    }
    return _righttab;
}
- (UIView *)line{
    if (!_line) {
        _line=[UIView new];
        _line.backgroundColor= HEXCOLORStringB(@"#D8D8D8", 0.1); 
        [_line setFrameWithPositionNormal:ccp(115, 54) anchorPoint:ccp(0, 0) size:ccsize(1, [self contentHeight])];
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
          }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
          }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
