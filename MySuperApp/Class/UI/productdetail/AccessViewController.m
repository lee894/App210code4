//
//  AccessViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-22.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "AccessViewController.h"
#import "StarLevelView.h"

@interface AccessViewController ()

@end

@implementation AccessViewController

@synthesize goodId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我要评价";
    [self createBackBtnWithType:0];
    
    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"提交评价" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"提交评价" forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
    
    if (isIOS7up) {
        CGRect oldframe = scrollContent.frame;
        oldframe.origin.y = 60;
        scrollContent.frame = oldframe;
    }
    
    for (int i = 0; i<3; i++) {
        
        StarLevelView *starView = [[StarLevelView alloc] initWithFrame:CGRectMake(83, 47+i*30, 150, 30)];
        [starView chooseStarLevelAction:5];
        starView.tag = 130+i;
        [viewBackground addSubview:starView];
    }
    
    [self size:(UIButton *)[self.view viewWithTag:72]];
    [self braSize:(UIButton *)[self.view viewWithTag:82]];
    [self degress:(UIButton *)[self.view viewWithTag:93]];
    
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    [mainSev getCheckComment:self.goodId andCo_id:self.co_ID];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
    scrollContent.contentSize = CGSizeMake(320, 700);
}

#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    [self performSelector:@selector(popBackAnimate:) withObject:nil afterDelay:0.6];
    
    //    [self.navigationController popViewControllerAnimated:YES];
    return;
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_CheckCommet_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                for (int i = 91; i < 94; i++) {
                    [(UIButton *)[self.view viewWithTag:i] setHidden:NO];
                }
                for (int i = 81; i < 84; i++) {
                    [(UIButton *)[self.view viewWithTag:i] setHidden:NO];
                }
                for (int i = 71; i < 74; i++) {
                    [(UIButton *)[self.view viewWithTag:i] setHidden:NO];
                }
                
                labelOne.hidden = NO;
                labelOrder_three.hidden = NO;
                labelOrder_tow.hidden = NO;
                imageOrder_three.hidden = NO;
                imageOrder_tow.hidden = NO;
                
                AssessAssessModel *assessModel = (AssessAssessModel *)model;
                for (AssessDetail *assessdetail in assessModel.detail) {
                    
                    
                    
                    if ([assessdetail.goodsid isEqualToString:self.goodId]) {
                        if ([assessdetail.nametype rangeOfString:@"文胸"].location != NSNotFound) {
                            
                        }else if ([assessdetail.nametype rangeOfString:@"保暖"].location != NSNotFound||[assessdetail.nametype rangeOfString:@"睡衣"].location != NSNotFound) {
                            
                            labelOrder_tow.text = @"面料薄厚";
                            [(UIButton *)[self.view viewWithTag:81] setTitle:@"薄款" forState:UIControlStateNormal];
                            [(UIButton *)[self.view viewWithTag:83] setTitle:@"厚款" forState:UIControlStateNormal];
                            
                            for (int i = 91; i < 94; i++) {
                                [(UIButton *)[self.view viewWithTag:i] setHidden:YES];
                            }
                            imageOrder_three.hidden = YES;
                            labelOrder_three.hidden = YES;
                            
                        }else if ([assessdetail.nametype rangeOfString:@"家居"].location != NSNotFound) {
                            labelOrder_tow.text = @"面料薄厚";
                            [(UIButton *)[self.view viewWithTag:81] setTitle:@"薄款" forState:UIControlStateNormal];
                            [(UIButton *)[self.view viewWithTag:83] setTitle:@"厚款" forState:UIControlStateNormal];
                            
                            for (int i = 91; i < 94; i++) {
                                [(UIButton *)[self.view viewWithTag:i] setHidden:YES];
                            }
                            imageOrder_three.hidden = YES;
                            
                            labelOrder_three.hidden = YES;
                        }else {
                            
                            for (int i = 81; i < 84; i++) {
                                [(UIButton *)[self.view viewWithTag:i] setHidden:YES];
                            }
                            
                            for (int i = 91; i < 94; i++) {
                                [(UIButton *)[self.view viewWithTag:i] setHidden:YES];
                            }
                            imageOrder_three.hidden = YES;
                            imageOrder_tow.hidden = YES;
                            
                            labelOrder_tow.hidden = YES;
                            labelOrder_three.hidden = YES;
                        }
                        
                    }
                }
                
            }else {
                
                
                [MYCommentAlertView showMessage:@"即将推出，敬请期待" target:nil];
                //                if ([[self getLastViewController] isEqualToString:@"ShowcomMentViewController"]) {
                //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:model.errorMessage delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                //                    [alert show];
                //
                //                }else {
                //                    [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
                //                }
            }
        }
            
            break;
            
        case Http_addcomment_Tag:
        {
            if (!model.errorMessage) {
                
                if ([(CodeBindBindCodeModel *)model content]) {
                    [SBPublicAlert showMBProgressHUD:[(CodeBindBindCodeModel *)model content] andWhereView:self.view hiddenTime:0.6];
                }else {
                    [SBPublicAlert showMBProgressHUD:@"评论成功" andWhereView:self.view hiddenTime:0.6];
                }
                //                [self performSelector:@selector(popBackAnimate:) withObject:nil afterDelay:0.6];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
        case 10086:
        {
            [MYCommentAlertView showMessage:@"即将推出，敬请期待" target:nil];
            
            //            if ([[self getLastViewController] isEqualToString:@"ShowcomMentViewController"]) {
            //                [SBPublicAlert hideMBprogressHUD:self.view];
            //
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:model.errorMessage delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            //                [alert show];
            //
            //            }else {
            //                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
            //                [self performSelector:@selector(popBackAnimate:) withObject:nil afterDelay:0.6];
            //
            //            }
        }
            break;
        default:
        {
            [SBPublicAlert hideMBprogressHUD:self.view];
        }
            break;
    }
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.navigationController popViewControllerAnimated:YES];
    //    [self performSelector:@selector(popBackAnimate:) withObject:nil afterDelay:0];
    
}

#pragma mark -- 按钮事件
- (void)popBackAnimate:(UIButton *)sender//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}

//提交评价
-(void)rightButAction {
    
    NSString *scre0 = [(StarLevelView *)[viewBackground viewWithTag:130] starLevel];
    NSString *scre1 = [(StarLevelView *)[viewBackground viewWithTag:131] starLevel];
    NSString *scre2 = [(StarLevelView *)[viewBackground viewWithTag:132] starLevel];
    
    NSString *scre3 = [NSString stringWithFormat:@"%d",buttonLast.tag-70];
    NSString *scre4 = [NSString stringWithFormat:@"%d",buttonBra.tag-80];
    NSString *scre5 = [NSString stringWithFormat:@"%d",buttonLast.tag-90];
    
    
    [mainSev getAddcommentGoods_Id:self.goodId andProduct_Id:self.productID andCo_Id:self.co_ID andScore0:scre0 andScore1:scre1 andScore2:scre2 andScore3:scre3 andScore4:scre4 andScore5:scre5 andContent:textAccess.text];
    [SBPublicAlert showMBProgressHUD:@"正在提交···" andWhereView:self.view states:NO];
    
}

- (IBAction)size:(UIButton *)sender//尺码
{
    if (buttonLast!=nil) {
        buttonLast.selected = NO;
    }
    buttonLast = sender;
    sender.selected = YES;
}

- (IBAction)braSize:(UIButton *)sender//罩杯薄厚
{
    if (buttonBra!=nil) {
        buttonBra.selected = NO;
    }
    buttonBra = sender;
    sender.selected = YES;
}

- (IBAction)degress:(UIButton *)sender//聚拢度
{
    if (buttonDegree!=nil) {
        buttonDegree.selected = NO;
    }
    buttonDegree = sender;
    sender.selected = YES;
}

- (void)disAppear//UITextView 键盘消失
{
    [textAccess resignFirstResponder];
}

#pragma mark -- UITextView delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonText = tempButton;
    buttonText.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [buttonText addTarget:self action:@selector(disAppear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonText];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, -180, self.view.frame.size.width, self.view.frame.size.height)];
    }];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    labelAccess.hidden = YES;
    
    if (text.length == 0) {
        labelAccess.hidden = NO;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
    [buttonText removeFromSuperview];
}

#pragma mark -- 屏幕旋转
//iOS 5
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
//iOS 6
- (BOOL)shouldAutorotate
{
	return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
