////
////  ProductShareViewController.m
////  MySuperApp
////
////  Created by LEE on 14-4-29.
////  Copyright (c) 2014年 zan. All rights reserved.
////
//
//#import "ProductShareViewController.h"
//
//@interface ProductShareViewController ()
//
//@end
//
//@implementation ProductShareViewController
//
//@synthesize isSina;
//@synthesize strTitle;
//@synthesize productDetailModel;
//
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    self.title = strTitle;
//    
//    [self createBackBtnWithType:0];
//    
//    //创建右边按钮
//    [self createRightBtn];
//    [self.navbtnRight setTitle:@"完成" forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"完成" forState:UIControlStateHighlighted];
//    
//    //    https://itunes.apple.com/cn/app/aimer-ai-mu-guan-fang-shang/id515651364?mt=8
//    
//    textContent.text = [NSString stringWithFormat:@"我在@爱慕官方商城 客户端发现了一款不错的产品:\n%@下载客户端:\nhttp://m.aimer.com.cn/method/xiazai",self.productDetailModel.product_share_url== nil?@"":self.productDetailModel.product_share_url];
//    
//    
//    if (textContent.text.length >140) {
//        textContent.text = [textContent.text substringToIndex:140];
//    }
//    
//    labelText.text = [NSString stringWithFormat:@"剩余%d个字",140-textContent.text.length];
//    
//    body = self.productDetailModel.prodcutName;
//    [imageProduct setImageFromUrl:YES withUrl:[[self.productDetailModel.bannerlist objectAtIndex:0] BannerPic]];
//    labelTitle.text = self.strTitle;
//    
//    if (isIOS7up) {
//        [myallView setFrame:CGRectMake(0, 60, 320, self.view.frame.size.height-60)];
//    }
//}
//
//#pragma mark -- 按钮事件
//#pragma mark -- 分享到微信朋友圈
//- (void)setWeiXin{
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popBackAnimate:) name:@"shareSuccess" object:nil];
//    
//    weixin= [[WeixinManager alloc] init];
//    
//    UIImage *ThumbImage =  [UIImage scaleToSize:imageProduct.image size:CGSizeMake(30, 30)];
//    [weixin sendImg:imageProduct.image andThumbImage:ThumbImage orImgUrl:self.productDetailModel.product_share_url andTitle:body andDescription:textContent.text withScene:1];
//}
//
//
//- (void)rightButAction {
//    
//    
//    NSDictionary *dic1 = nil;
//    if (isSina) {
//        dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Sina", @"ShareType",self.productID, @"GoodsID",self.productDetailModel.prodcutName, @"GoodsName",nil];
//        
//        [SinaClass sendShare:textContent.text andImage:imageProduct.image];
//        [SBPublicAlert showMBProgressHUD:@"正在分享···" andWhereView:self.view states:NO];
//        
//        [SinaClass shareWBInfo].loginDelegate = self;
//    }else{
//        [self setWeiXin];
//        dic1  = [NSDictionary dictionaryWithObjectsAndKeys:@"WeiXin", @"ShareType",self.productID, @"GoodsID",self.productDetailModel.prodcutName, @"GoodsName",nil];
//    }
//    
//    [TalkingData trackEvent:@"1004" label:@"商品分享" parameters:dic1];
//}
//
//- (void)shareSuccess {
//    
//    [SBPublicAlert showMBProgressHUD:@"分享成功" andWhereView:self.view hiddenTime:0.6];
//    [self performSelector:@selector(popBackAnimate:) withObject:nil afterDelay:0.6];
//}
//
//- (void)failed {
//    [SBPublicAlert showMBProgressHUD:@"分享失败" andWhereView:self.view hiddenTime:1.];
//    
//}
//
//-(void)popBackAnimate:(id)sender{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)cancelShare {
//    [SBPublicAlert hideMBprogressHUD:self.view];
//}
//
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    
//    if (textView.text.length >140) {
//        return NO;
//    }
//    return YES;
//}
//
//- (void)textViewDidChange:(UITextView *)textView {
////    NSInteger number = [textView.text length];
//    
//    if (textView.text.length >140) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"字符个数不能大于140" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        textView.text = [textView.text substringToIndex:140];
////        number = 140;
//    }
//}
//
//
//- (void)delTextView:(UITextView *)textView {
//    labelText.text = [NSString stringWithFormat:@"剩余%d个字",140-textView.text.length];
//}
//
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    [self performSelector:@selector(delTextView:) withObject:textView afterDelay:0.1];
//    
//    return YES;
//}
//
//
//#pragma mark -- UITextView键盘小时
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}
//
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
//
//- (void)didReceiveMemoryWarning{
//    [super didReceiveMemoryWarning];
//}
//
//
//@end
