//
//  AddAddressViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-2.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "AddAddressViewController.h"
#import "UIView+ChangeFrame.h"
#import "SBPublicFormatValidation.h"

@interface AddAddressViewController ()
{
//    UIButton *doneButton;
}
@end

@implementation AddAddressViewController

@synthesize addOrEdit;
@synthesize addressList;
@synthesize isFromcheck;

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
    
     // 新增进入or编辑进入 YES新增 NO编辑
    if (addOrEdit) {
        self.title = @"新增地址";
    }else{
        self.title = @"编辑地址";
    }
    
    
    myallscrollView.delegate = self;
    [myallscrollView setContentSize:CGSizeMake(0, 700)];
    [myallView setBackgroundColor:[UIColor whiteColor]];
    [myallscrollView setBackgroundColor:[UIColor whiteColor]];
    
    [self createBackBtnWithType:0];
    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"保存" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"保存" forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
    

    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    if (!addOrEdit) {//编辑进入，页面信息
        textFieldName.text = addressList.userName;
        
        province = addressList.province;
        city = addressList.city;
        area = addressList.county;
        provinceId = addressList.provinceId;
        cityId = addressList.cityId;
        areaId = addressList.countyId;
        labelCity.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        
        textFieldDetail.text = addressList.address;
        textFieldZip.text = addressList.zipCode;
        textFieldZip.tag = 11110;
        textFieldTel.text = addressList.phone;
        textFieldPhone.text = addressList.mobile;
        textFieldPhone.tag = 11111;
        textFieldEmail.text = addressList.email;
    
    }
    textFieldZip = [[UITextField alloc]init];
    textFieldZip.delegate = self;
    textFieldZip.tag = 11110;
    textFieldTel.delegate = self;
    textFieldPhone.delegate = self;
    textFieldPhone.tag = 11111;
    textFieldZip.keyboardType = UIKeyboardTypeNumberPad;
    textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
    textFieldTel.keyboardType = UIKeyboardTypeNumberPad;
    
    
    int frameH2 = self.view.frame.size.height;
    NSLog(@"-----------%d----model---%@",frameH2,[[UIDevice currentDevice] model]);

    
//    if (isFromcheck) {
//        [myallView setFrame:CGRectMake(0, 50, 320, self.view.frame.size.height-50)];
//    }
//    
//    if ([[[UIDevice currentDevice] systemVersion] intValue]<7) {
//        if (isFromcheck) {
//            [myallView setFrame:CGRectMake(0, 180, 320, self.view.frame.size.height-180)];
//        }else{
//            [myallView setFrame:CGRectMake(0, 130, 320, self.view.frame.size.height-130)];
//        }
//    }else{
//        //lee999recode适配ipad 7.1.2
//        if ([[[UIDevice currentDevice] model] hasPrefix:@"iPad"]) {
//            if (isFromcheck) {
//                [myallView setFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-120)];
//            }else{
//                [myallView setFrame:CGRectMake(0, 80, 320, self.view.frame.size.height-80)];
//            }
//        }else{
//            if (isFromcheck) {
//                [myallView setFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-120)];
//            }else{
//                [myallView setFrame:CGRectMake(0, 80, 320, self.view.frame.size.height-80)];
//            }
//        }
//    }
    
//    //如果是iphone5
//    if ([[UIScreen mainScreen] bounds].size.height > 480) {
//        if (isFromcheck) {
//            [myallView setFrame:CGRectMake(0, 50, 320, self.view.frame.size.height-50)];
//        }
//    }else{
//    //如果是iphone4
//        if (isFromcheck) {
//            [myallView setFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-120)];
//        }else{
//            [myallView setFrame:CGRectMake(0, 80, 320, self.view.frame.size.height-80)];
//        }
//        
//        if ([[[UIDevice currentDevice] systemVersion] intValue]<7) {
//            if (isFromcheck) {
//                [myallView setFrame:CGRectMake(0, 180, 320, self.view.frame.size.height-180)];
//            }else{
//                [myallView setFrame:CGRectMake(0, 130, 320, self.view.frame.size.height-130)];
//            }
//        }
//    }
//    
    
    NSLog(@"system:-------%d",[[[UIDevice currentDevice] systemVersion] intValue]);
    
//    doneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 163, 106, 53)];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(keyboardWillShowOnDelay22:)
//                                                name:UIKeyboardWillShowNotification
//                                              object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    doneButton.hidden = YES;
//    [[NSNotificationCenter defaultCenter]removeObserver:self
//                                                   name:UIKeyboardWillShowNotification
//                                                 object:nil];
}


#pragma mark 增加键盘上的完成按钮
//- (void)keyboardWillShowOnDelay22:(NSNotification *)notification
//{
//    [self performSelector:@selector(keyboardWillShow22:) withObject:nil afterDelay:0];
//}
//
//- (void)keyboardWillShow22:(NSNotification *)notification
//{
//    [doneButton setTitle:@"完成" forState:(UIControlStateNormal)];
//    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
//    UIWindow * tempWindow = [[[UIApplication sharedApplication]windows]objectAtIndex:1];
//    UIView * keyBoard = nil;
//    NSLog(@"%@",tempWindow);
//    for (int i = 0; i < tempWindow.subviews.count; i ++) {
//        keyBoard = [tempWindow.subviews objectAtIndex:i];
//        
//        [keyBoard addSubview:doneButton];
//    }
//    
//}
//
//- (void)doneButton:(UIButton *)btn{
//
//    [textFieldZip resignFirstResponder];
//    [textFieldTel resignFirstResponder];
//    [textFieldPhone resignFirstResponder];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [myallscrollView endEditing:YES];
}

#pragma mark -- UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [myallscrollView endEditing:YES];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
    
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    [newtxt replaceCharactersInRange:range withString:string];
    
    
  //  NSLog(@"tag-----%ld----newtxt-%@----text-%@",(long)textField.tag,newtxt,textField.text);

    
    if (textField.tag == 11110) {
        if (newtxt.length > 6)
        {
            return NO;
        }
    }
    
//    if (textField.tag == 11111) {
//        if (newtxt.length > 11)
//        {
//            return NO;
//        }
//    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [addressPicker removeFromSuperview];
    
//    if (textField == textFieldZip || textField == textFieldTel || textField == textFieldPhone) {
//        doneButton.hidden = NO;
//    }else{
//        doneButton.hidden = YES;
//    }
    
    
//    if (textField == textFieldZip) {
//        [UIView animateWithDuration:0.2 animations:^{
//            [self.view setFrame:CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height)];
//        }];
//    }else if (textField == textFieldPhone || textField == textFieldTel || textField == textFieldEmail){
//        
//        [self.view setFrame:CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height)];
//    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        //lee999 设置 位置
//        [myallscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        //[self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        }];
//    if (textField == textFieldPhone) {
//        if (![NSString isValidTelephoneNum2:textFieldPhone.text]) {
//            [SBPublicAlert showAlertTitle:@"" Message:@"请输入正确的手机号码"];
//        }
//    }
}

#pragma mark -- 按钮事件

-(void)rightButAction//保存
{
    
    NSLog(@"---textFieldName:%@----labelCity:%@----textFieldDetail:%@-----textFieldPhone:%@-",textFieldName.text,labelCity.text,textFieldDetail.text,textFieldPhone.text);
    
    
    
//    if (![textFieldName.text isEqualToString:@""] && ![labelCity.text isEqualToString:@""] && ![textFieldDetail.text isEqualToString:@""] && ![textFieldPhone.text isEqualToString:@""]) {
    
    
        if (textFieldName.text.length<1) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请您输入收货人姓名"];
            return;
        }
        
        if (labelCity.text.length<5) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请您选择省市区"];
            return;
        }
        
        if (textFieldDetail.text.length<1) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请您输入详细地址"];
            return;
        }
        
        if (![NSString isValidTelephoneNum2:textFieldPhone.text]) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请输入正确的手机号码"];
            return;
        }
                
        if (!addOrEdit) {//编辑进入
            [mainSer getAddressEdit:self.addressList.addresslistIdentifier andName:textFieldName.text andArea:areaId andMobilephone:textFieldPhone.text andCity:cityId  andDetail:textFieldDetail.text andProvince:provinceId andTelephone:textFieldTel.text andZipcode:textFieldZip.text andEmail:textFieldEmail.text];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

            
        }else{//新增进入
        
            [mainSer getAddressAdd:textFieldName.text andArea:areaId andMobilephone:textFieldPhone.text andCity:cityId andDetail:textFieldDetail.text andProvince:provinceId andTelephone:textFieldTel.text andZipcode:textFieldZip.text andEmail:textFieldEmail.text];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];


        }
//    }else{
//        [SBPublicAlert showAlertTitle:@"请将信息填写完整" Message:nil];
//    }
}

- (IBAction)chooseCity:(id)sender//选择城市
{
    [self.view endEditing:YES];
    if (addressPicker == nil) {
        addressPicker = [[[NSBundle mainBundle] loadNibNamed:@"AddressPickerView" owner:self options:nil] lastObject];
    }
   
    addressPicker.delegate =self;
    [addressPicker setOrigin:CGPointMake(0, self.view.frame.size.height)];
    [UIView animateWithDuration:0.3 animations:^{
        [addressPicker setOrigin:CGPointMake(0, self.view.frame.size.height - 222)];
        
        [self.view addSubview:addressPicker];
    }];
}

#pragma mark -- 省市区传值代理方法
- (void)pickCountty:(AddressPickerView *)addressdPicker
{
    province = addressdPicker.areaProvince;
    city = addressdPicker.areacity;
    area = addressdPicker.areaArea;
    
    provinceId = addressdPicker.areaProvinceId;
    cityId = addressdPicker.areacityId;
    areaId = addressdPicker.areaAreaId;
    
    labelCity.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
}

#pragma mark -- netrequest delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    switch (model.requestTag) {
        case Http_Addressadd_Tag:
            [SBPublicAlert hideMBprogressHUD:self.view];

            [self.navigationController popViewControllerAnimated:YES];
            break;
        case Http_AddressEdit_Tag:
            [SBPublicAlert hideMBprogressHUD:self.view];

            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];

            break;
    }
}

//#pragma mark -- 屏幕旋转
////iOS 5
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//}
////iOS 6
//- (BOOL)shouldAutorotate
//{
//	return NO;
//}
//- (NSUInteger)supportedInterfaceOrientations
//{
//	return UIInterfaceOrientationMaskPortrait;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//	return UIInterfaceOrientationPortrait;
//}

@end
