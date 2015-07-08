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

	
//	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, isIOS7up?44+20:20, 200, 25)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 200, 25)];

	label.backgroundColor = [UIColor clearColor];
    label.text = @"请输入附言（50字以内）"; 
	label.font = [UIFont systemFontOfSize:14];
	[self.view addSubview:label];

	UIImageView* bgtextview = [[UIImageView alloc] init];//WithImage:[[UIImage imageNamed:@"list_one.png"] resizableImageWithCap:UIEdgeInsetsMake(14, 14, 14, 14)]
    //lee给view设置为圆角，不再使用图片了。 -140512
//    [SingletonState setViewRadioSider:bgtextview];
    bgtextview.frame = CGRectMake(10, 50, ScreenWidth-20, 130);
    [bgtextview setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:bgtextview];

	
//	postText = [[UITextView alloc] initWithFrame:CGRectMake(10, isIOS7up?44+ 50:50, 300, 120)];
    postText = [[UITextView alloc] initWithFrame:CGRectMake(10, 50,  ScreenWidth-20, 120)];

	postText.font = [UIFont systemFontOfSize:14];
	postText.delegate = self;
	postText.backgroundColor = [UIColor clearColor];
    postText.text=self.postStr;
	[self.view addSubview:postText];
}

- (void)rightButAction {
    checkOut.postText = postText.text;
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    NSInteger number = [textView.text length];

	if (number >=50) {
        [SBPublicAlert showMBProgressHUD:@"您最多可以输入50个字" andWhereView:self.view hiddenTime:AlertShowTime];
		return NO;
    }
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


