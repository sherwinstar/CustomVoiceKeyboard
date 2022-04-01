//
//  Player.m
//  Univasal
//
//  Created by txy on 2022/3/30.
//

#import "Player.h"
#import "KeyboardView.h"
@implementation Player
{
    //播放器
        AVAudioPlayer *player;
}
static Player *_instance;
+ (Player *)shared{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[Player alloc] init];
    });
    return _instance;
}

- (void)playWithurl:(NSString*)urlstring{
    if (urlstring == nil) {
        return;;
    }
    //刷新数据
    //播放的时候声音小
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        NSError *err = nil;
        [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
        
        
      
       
        //http://oss.xiaopuhaohuo.com:8887/apk/3.mp3.mp3
        //将数据保存到本地指定位置
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* sttt=[urlstring stringByReplacingOccurrencesOfString:@"/" withString:@""];
        NSString *filePath = [NSString stringWithFormat:@"%@/voice/%@.mp3", docDirPath , sttt];
    NSFileManager* file=[NSFileManager defaultManager];
    NSURL *url = [[NSURL alloc]initWithString:urlstring];
    if (![file fileExistsAtPath:[NSString stringWithFormat:@"%@/voice", docDirPath]]) {
        [file createDirectoryAtPath:[NSString stringWithFormat:@"%@/voice", docDirPath]
         
                  withIntermediateDirectories:NO
         
                                   attributes:nil
          
                                        error:nil];
    }
    
    if (![file fileExistsAtPath:filePath]) {
        NSData * audioData = [NSData dataWithContentsOfURL:url];
        [audioData writeToFile:filePath atomically:YES];
    }else{
        
    }
        //播放本地音乐
        NSError *playerError;
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
       
    if ([urlstring containsString:@"http://"]||[urlstring containsString:@"https://"]) {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&playerError];
    }else{
        NSString* source=[[NSBundle mainBundle]resourcePath];
        NSString*localfile=[NSString stringWithFormat:@"%@/%@",source,urlstring];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:localfile] error:&playerError];
    }
    player.delegate=self;
        if (player == nil)
        {
            NSLog(@"--play--error---%@", [playerError description]);
        }else{
            [player play];
        }
}
-(void)stop{
    [player stop];
}

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [[KeyboardView shared]receivestopplay];
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    
}
@end
