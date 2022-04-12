//
//  ViewController.m
//  UniversalApp
//
//  Created by txy on 2021/12/14.
//

#import "ViewController.h"

#import "KeyboardView.h"
@interface ViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *vi;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)KeyboardView *keyboardView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //HEXCOLORString(@"#0x000000");
    [self copyDB];
    self.vi.backgroundColor =GradientCOLOR(CGSizeMake(200, 200), 1, HEXCOLORStringB(@"BC8F8F", 1.0), [UIColor blueColor]);//NewCOLOR([UIColor blueColor], 1, [UIColor greenColor]);
    [self.vi addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(run)]];
    [self.view addSubview:self.vi];
    [self.view addSubview:self.textField];
    self.textField.text = @"系统键盘";
    self.textField.backgroundColor = [UIColor redColor];
    
    //  [self networkchangeIp];
    // Do any additional setup after loading the view.
}

- (void)teststr {
    NSString * str =@"1266";
    str = @"1iu2u2";
}

- (void)run {
     //[GenerateIDF generateIDFA];
  //  [self networkchangeIp];
    [_textField resignFirstResponder];
    self.keyboardView = [KeyboardView shared];
    [_keyboardView initialize:NO];
    [_keyboardView show];
    [self.view addSubview:_keyboardView];
}

- (void)copyDB {
    NSFileManager *fileManager =[NSFileManager defaultManager];
    NSURL *groupUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.linhua.Univasal"];
    NSError *error;
    NSString *directory = groupUrl.path;

    NSString *dbPath =[directory stringByAppendingPathComponent:@"voice_app.db"];

    if([fileManager fileExistsAtPath:dbPath]== NO){
        NSString *resourcePath =[[NSBundle mainBundle] pathForResource:@"voice_app" ofType:@"db"];
        [fileManager copyItemAtPath:resourcePath toPath:dbPath error:&error];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.keyboardView removeFromSuperview];
}

- (UIView *)vi {
    if (!_vi) {
        _vi=[UIView new];
        [_vi setFrame:CGRectMake(100, 100, 200, 200)];
        _vi.backgroundColor=[UIColor greenColor];
    }
    return _vi;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 350, 150, 44)];
        _textField.delegate = self;
    }
    return _textField;
}

- (BOOL)shouldAutorotate {
    return YES;
}


@end

