//
//  ViewController.m
//  UniversalApp
//
//  Created by txy on 2021/12/14.
//

#import "ViewController.h"

#import "KeyboardView.h"
@interface ViewController ()
@property(nonatomic,strong)UIView *vi;
@property(nonatomic,strong)UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //HEXCOLORString(@"#0x000000");
    
    self.vi.backgroundColor =GradientCOLOR(CGSizeMake(200, 200), 1, HEXCOLORStringB(@"BC8F8F", 1.0), [UIColor blueColor]);//NewCOLOR([UIColor blueColor], 1, [UIColor greenColor]);
    [self.vi addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(run)]];
    [self.view addSubview:self.vi];
    [self.view addSubview:self.textField];
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
    KeyboardView* keyview=[KeyboardView shared];
    [keyview show];
    [self.view addSubview:keyview];
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
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(150, 350, 100, 44)];
    }
    return _textField;
}

@end

