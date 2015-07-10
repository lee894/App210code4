    //
//  YKOrderPostscriptView.m
//  YKProduct
//
//  Created by caiting on 11-12-26.
//  Copyright 2011 yek. All rights reserved.
//

#import "YKOrderPostscriptView.h"
#import "UIImage+ImageSize.h"

@implementation YKOrderPostscriptView
@synthesize checkOut;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单留言";
    [self createBackBtnWithType:0];
    
    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"保存" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"保存" forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];

    
	UIImageView* bgtextview = [[UIImageView alloc] init];//WithImage:[[UIImage imageNamed:@"list_one.png"]
    bgtextview.frame = CGRectMake(0, 20, ScreenWidth, 130);
    [bgtextview setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:bgtextview];

    if ([self.postStr isEqualToString:@""]) {
        self.postStr = @"请输入留言";
    }
    
    postText = [[UITextView alloc] initWithFrame:CGRectMake(10, 25,  ScreenWidth-20, 120)];
	postText.font = [UIFont systemFontOfSize:14];
	postText.delegate = self;
	postText.backgroundColor = [UIColor clearColor];
    [postText setTextColor:[UIColor colorWithHexString:@"777777"]];
    postText.text=self.postStr;
	[self.view addSubview:postText];
    
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, ScreenWidth-20, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"50字以内";
    [label setTextColor:[UIColor colorWithHexString:@"777777"]];
    [label setTextAlignment:NSTextAlignmentRight];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
}

- (void)rightButAction {
    
    [postText resignFirstResponder];
    
    if ([self.postStr isEqualToString:@"请输入留言"]) {
    
        [SBPublicAlert showMBProgressHUD:@"请您输入留言内容" andWhereView:self.view hiddenTime:AlertShowTime];
        return;
    }
    
    checkOut.postText = postText.text;
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if ([postText.text isEqualToString:@"请输入留言"]) {
        postText.text = @"";
        self.postStr = @"";
    }
    
    return YES;
}

//判断联想输入字符长度
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 51)
    {
        textView.text = [textView.text substringToIndex:51];
    }
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        return YES;
    }
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
	if (aString.length >=50) {
        [ESToast showDelayToastWithText:@"您最多可以输入50个字哦"];
//        [SBPublicAlert showMBProgressHUD:@"您最多可以输入50个字" andWhereView:self.view hiddenTime:AlertShowTime];
		return NO;
    }
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


