//
//  KeyboardViewController.m
//  VoiceKeyboard
//
//  Created by Shaolin Zhou on 2022/4/1.
//

#import "KeyboardViewController.h"
#import "KeyboardView.h"
#import "UIView+AutoLayout.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    KeyboardView* keyview = [KeyboardView shared];
    [keyview show];
    [self.view addSubview:keyview];
    [keyview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [keyview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [keyview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [keyview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [keyview autoSetDimension:ALDimensionHeight toSize:54 + 263 + 3];
}

- (void)viewWillLayoutSubviews
{
    self.nextKeyboardButton.hidden = !self.needsInputModeSwitchKey;
    [super viewWillLayoutSubviews];
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
