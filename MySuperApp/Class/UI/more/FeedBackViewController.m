//
//  FeedBackViewController.m
//  MySuperApp
//
//  Created by lee on 14-3-27.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIView+ChangeFrame.h"
#import "SBPublicFormatValidation.h"
#import "GiftCheckOutFinishViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    [self createBackBtnWithType:0];
    
    arrayPicker = [NSArray arrayWithObjects:@"关于商品", @"物流结算",@"软件问题",@"其他建议",nil];
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    if (isIOS7up) {
        [myallscrollView setFrame:CGRectMake(0, new20ViewY, ScreenWidth, self.view.frame.size.height-new20ViewY)];
    }
    
    [myallscrollView setContentSize:CGSizeMake(0, 680)];
}



- (IBAction)submit:(id)sender//提交
{
//#warning ---  测试
//    
//    GiftCheckOutFinishViewController* gcovc = [[GiftCheckOutFinishViewController alloc] init];
//    gcovc.orderId = @"asdasdasd";
//    [self.navigationController pushViewController:gcovc animated:YES];
//    
//    return;
    
    
    if ([labelChoose.text isEqualToString:@"必选"])
    {
        [SBPublicAlert showMBProgressHUD:@"请选择反馈类型" andWhereView:self.view hiddenTime:AlertShowTime];
    }
    else if ([textFieldPhone.text isEqualToString:@""])
    {
        [SBPublicAlert showMBProgressHUD:@"请输入联系方式" andWhereView:self.view hiddenTime:AlertShowTime];
    }
    else  if ([textViewContent.text isEqualToString:@""]) {
        [SBPublicAlert showMBProgressHUD:@"请输入内容" andWhereView:self.view hiddenTime:AlertShowTime];
    }
    else
    {
        
        if (![NSString isValidTelephoneNum2:textFieldPhone.text]) {
            [SBPublicAlert showMBProgressHUD:@"请输入正确的手机号码" andWhereView:self.view hiddenTime:AlertShowTime];
        }else {
            
            [mainSer getFeedback:textViewContent.text andContact:textFieldPhone.text andType:labelChoose.text];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        }        
    }
}

#pragma mark -- netrequest delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_FeedBack_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示"
                                                                message:@"恭喜您，反馈提交成功"
                                                               delegate:self
                                                      cancelButtonTitle:@"知道了"
                                                      otherButtonTitles:nil];
                [alert show];
                alert.tag = 100999;
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 100999) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (IBAction)choosePicker:(id)sender//PickerView弹出
{
    [self.view endEditing:YES];
    
    if (!viewPicker) {
        viewPicker = [[[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil] lastObject];
    }

        [viewPicker setOrigin:CGPointMake(0, self.view.frame.size.height)];
        [UIView animateWithDuration:0.3 animations:^{
            [viewPicker setOrigin:CGPointMake(0, self.view.frame.size.height - 262)];
            [self.view addSubview:viewPicker];
        }];
}

- (IBAction)confirmOrCancel:(UIButton *)sender//pickerView 确认取消
{
    if (sender.tag == 202) {
        
        labelChoose.text = [arrayPicker objectAtIndex:[pickerChoose selectedRowInComponent:0]];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [viewPicker setOrigin:CGPointMake(0, self.view.frame.size.height)];
    } completion:^(BOOL finish){
        [viewPicker removeFromSuperview];
    }];
}

#pragma mark -- 键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [myallscrollView setContentOffset:CGPointMake(0, 130) animated:YES];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        
        [myallscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    
    if (![NSString isValidTelephoneNum2:textFieldPhone.text]) {
        [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请输入正确的手机号码"];
    }
}

#pragma mark -- UITextView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [viewPicker removeFromSuperview];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [myallscrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }];
    labelContent.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textViewContent.text isEqualToString:@""]) {
        labelContent.hidden = NO;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [myallscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
}

#pragma mark -- UIPickerView datesource and delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrayPicker.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arrayPicker objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
