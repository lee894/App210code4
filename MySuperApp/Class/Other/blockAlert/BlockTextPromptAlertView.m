//
//  BlockTextPromptAlertView.m
//  BlockAlertsDemo
//
//  Created by Barrett Jacobsen on 2/13/12.
//  Copyright (c) 2012 Barrett Jacobsen. All rights reserved.
//

#import "BlockTextPromptAlertView.h"
#import "AppDelegate.h"

#define kTextBoxHeight      31
#define kTextBoxSpacing     5
#define kTextBoxHorizontalMargin (12+10)

#define kKeyboardResizeBounce         20


#define BtnAddClickEvent(btn,sel)\
{\
[btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];\
}

@interface BlockTextPromptAlertView()
@property(nonatomic, copy) TextFieldReturnCallBack callBack;
@end

@implementation BlockTextPromptAlertView
@synthesize textField, callBack;



+ (BlockTextPromptAlertView *)promptWithTitle:(NSString *)title message:(NSString *)message defaultText:(NSString*)defaultText {
    return [self promptWithTitle:title message:message defaultText:defaultText block:nil];
}

+ (BlockTextPromptAlertView *)promptWithTitle:(NSString *)title message:(NSString *)message defaultText:(NSString*)defaultText block:(TextFieldReturnCallBack)block {
    return [[BlockTextPromptAlertView alloc] initWithTitle:title message:message defaultText:defaultText block:block];
}

+ (BlockTextPromptAlertView *)promptWithTitle:(NSString *)title message:(NSString *)message textField:(out UITextField**)textField {
    return [self promptWithTitle:title message:message textField:textField block:nil];
}


+ (BlockTextPromptAlertView *)promptWithTitle:(NSString *)title message:(NSString *)message textField:(out UITextField**)textField block:(TextFieldReturnCallBack) block{
    BlockTextPromptAlertView *prompt = [[BlockTextPromptAlertView alloc] initWithTitle:title message:message defaultText:nil block:block];
    
    *textField = prompt.textField;
    
    return prompt;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message defaultText:(NSString*)defaultText block: (TextFieldReturnCallBack) block {
    
    self = [super initWithTitle:title message:message];
    
    if (self) {
        UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(kTextBoxHorizontalMargin, _height, _view.bounds.size.width - kTextBoxHorizontalMargin * 2, kTextBoxHeight)]; 
        
        [theTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [theTextField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
        [theTextField setBorderStyle:UITextBorderStyleRoundedRect];
//        [theTextField setTextAlignment:UITextAlignmentCenter];
        [theTextField setClearButtonMode:UITextFieldViewModeAlways];
        
        if (defaultText)
            theTextField.text = defaultText;
        
        if(block){
            theTextField.delegate = self;
        }
        
        [_view addSubview:theTextField];
        
        self.textField = theTextField;
        theTextField.placeholder = @"在此输入6位验证码";
        theTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        BtnSetImg(btn, @"share_btn.png", @"share_btn_press.png", @"share_btn_press.png");
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(50, theTextField.frame.origin.y-theTextField.frame.size.height-10, 200, 74/2);
        BtnAddClickEvent(btn,@selector(btnClicked:));
        [_view addSubview:btn];
        
        _height += kTextBoxHeight + kTextBoxSpacing;
        
        self.callBack = block;
    }
    
    return self;
}

- (void)btnClicked:(UIButton *)btn
{
    //发送验证码
//    if([self.delegate respondsToSelector:@selector(Sendcodes)]) {
    [self.delegate Sendcodesandtf:self.textField];
//    }
}

- (void)show {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [super show];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    __block CGRect frame = _view.frame;
    
    if (frame.origin.y + frame.size.height > ScreenHeight - keyboardSize.height) {
        
        frame.origin.y = ScreenHeight - keyboardSize.height - frame.size.height;
        
        if (frame.origin.y < 0)
            frame.origin.y = 0;
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _view.frame = frame;
                         } 
                         completion:nil];
    }
}


- (void)setAllowableCharacters:(NSString*)accepted {
    unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:accepted] invertedSet];
    self.textField.delegate = self;
}

- (void)setMaxLength:(NSInteger)max {
    maxLength = max;
    self.textField.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)_textField{
    if(callBack){
        return callBack(self);
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger newLength = [self.textField.text length] + [string length] - range.length;
    
    if (maxLength > 0 && newLength > maxLength)
        return NO;
    
    if (!unacceptedInput)
        return YES;
    
    if ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] > 1)
        return NO;
    else 
        return YES;
}

@end
