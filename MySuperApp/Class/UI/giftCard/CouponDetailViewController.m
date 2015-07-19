////
////  CouponDetailViewController.m
////  MySuperApp
////
////  Created by lee on 14-5-8.
////  Copyright (c) 2014年 aimer. All rights reserved.
//
////        [btnBg setBackgroundImage:[[UIImage imageNamed:@"qrcodeBg.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateHighlighted];
//
//
//#import "CouponDetailViewController.h"
//#import "QrcodeView.h"
//#import "CFunction.h"
//#import "QRCodeGenerator.h"
//#import "AppDelegate.h"
//#import "YKCanReuse_webViewController.h"
//
//@interface CouponDetailViewController ()
//{
//    UIButton *dackBtn;
//    QrcodeView *qrcodeV;
//    UIImageView *qrcodebg;
//}
//@end
//
//@implementation CouponDetailViewController
//@synthesize couponDic;
//@synthesize isMycard;//是不是我自己的优惠券，（自己的能显示二维码，不是自己的没有二维码）
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.title = @"优惠券详情";
//    [self createBackBtnWithType:0];
//    
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//
//    dackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [dackBtn setFrame:self.view.frame];
//    [dackBtn addTarget:self action:@selector(hiddenMyself) forControlEvents:UIControlEventTouchUpInside];
//    [dackBtn setBackgroundImage:[UIImage imageNamed:@"qrcodeabout.png"] forState:UIControlStateNormal];
//    [dackBtn setBackgroundImage:[UIImage imageNamed:@"qrcodeabout.png"] forState:UIControlStateHighlighted];
//
//    [app.window addSubview:dackBtn];
//    dackBtn.alpha = 0.0;
//    
//    //添加优惠券号的显示
//    couponnumber.text = @"";
//    
//    [textWebView setBackgroundColor:[UIColor clearColor]];
//    [couponTextview setBackgroundColor:[UIColor clearColor]];
//    
//    [myallView setContentSize:CGSizeMake(320, 600)];
//    
//    //lee增加o2o优惠券的显示
//    NSString *cardtype = @"";
//    cardtype = LegalObject([couponDic objectForKey:@"type"],[NSString class]);
//    NSLog(@"cardtype---:%@",cardtype);
//    if ([cardtype isEqualToString:@"o2o"]) {
//        [cuoponsBg setImage:[UIImage imageNamed:@"card_lb03.png"]];
//    }else{
//        
//        //不是020的卡 隐藏二维码和使用按钮   文字区域上移！！
//        qrcodeview.hidden = YES;
//        btno2ouseCardnow.hidden = YES; //隐藏o2o的立即使用按钮
//        btnsavecode.hidden = YES;
//        btnabout.hidden = YES;
//        CGRect oldrect = couponTextview.frame;
//        oldrect.origin.y = couponTextview.frame.origin.y - 40;
//        [couponTextview setFrame:oldrect];
//        
//        [cuoponsBg setImage:[UIImage imageNamed:@"card_aimer01.png"]];
//    }
//    
//
//    if (!isMycard) {
//        
//        cuoponprice.text = LegalObject([couponDic objectForKey:@"amount"],[NSString class]);
////        coupontitle.text = LegalObject([couponDic objectForKey:@"memo"],[NSString class]);
//        coupontitle.text = LegalObject([couponDic objectForKey:@"name"],[NSString class]);
//
//        //lee999 袁小英非得让改精确到秒
//        NSString* timestr = LegalObject([couponDic objectForKey:@"end_time"],[NSString class]);
//
//        enditime.text = [NSString stringWithFormat:@"有效期至%@",timestr];
//        
//        //文字描述
//        NSString *webtext = LegalObject([couponDic objectForKey:@"couponinfo"],[NSString class]);
//        [textWebView loadHTMLString:[NSString stringWithFormat:@"%@16%@%@", @"<style type=\"text/css\">img{width:300px;}.newtext{text-indent:2em;font-size:", @"px;}</style>", webtext] baseURL:nil];
//        
//        //lee999 如果不是我的优惠券，就不显示优惠券的使用按钮
//        btno2ouseCardnow.hidden = YES; //立即使用 o2o
//        btnuseCardnow.hidden = YES; //立即使用 普通
//        btnsavecode.hidden = YES;;   //保存优惠券
//        btnabout.hidden = YES;;     //关于
//        
//        qrcodeview.hidden = YES;
//        CGRect oldrect = couponTextview.frame;
//        oldrect.origin.y = couponTextview.frame.origin.y - 20;
//        [couponTextview setFrame:oldrect];
//        
//        if ([cardtype isEqualToString:@"o2o"]) {
//            [cuoponsBg setImage:[UIImage imageNamed:@"card_lb03.png"]];
//        }else{
//            [cuoponsBg setImage:[UIImage imageNamed:@"card_aimer01.png"]];
//        }
//        
//        //end
//        
//    }else{
//    //是我的优惠卡
//        cuoponprice.text = LegalObject([couponDic objectForKey:@"price"],[NSString class]);
//        coupontitle.text = LegalObject([couponDic objectForKey:@"title"],[NSString class]);
//        NSString* timestr = LegalObject([couponDic objectForKey:@"failtime"],[NSString class]);
//        enditime.text = [NSString stringWithFormat:@"有效期至%@",timestr];
//
//        //文字描述
//        NSString *webtext = LegalObject([couponDic objectForKey:@"info"],[NSString class]);
//        [textWebView loadHTMLString:[NSString stringWithFormat:@"%@16%@%@", @"<style type=\"text/css\">img{width:300px;}.newtext{text-indent:2em;font-size:", @"px;}</style>", webtext] baseURL:nil];
//    
//        if ([cardtype isEqualToString:@"o2o"]) {
//            //是o2o的券，能显示二维码
//            //我的爱慕——积分优惠——优惠券——点击优惠券——O2O券面信息加一项：【优惠券号】在点击查看二维码上方
//            couponnumber.text = [NSString stringWithFormat:@"优惠券号：%@",LegalObject([couponDic objectForKey:@"code"],[NSString class])];
//            
//            //lee999
//            btnabout.hidden = NO;
//            btnuseCardnow.hidden = YES;
//            
//            qrcodebg = [[UIImageView alloc] initWithFrame:self.view.frame];
//            [qrcodebg setImage:[[UIImage imageNamed:@"qrcodeBg.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
//            [self.view addSubview:qrcodebg];
//            qrcodebg.hidden = YES;
//            
//            //创建二维码界面~~
//            qrcodeV = [[[NSBundle mainBundle] loadNibNamed:@"QrcodeView" owner:self options:nil] lastObject];
//            qrcodeV.delegate = self;
//            //将视图移除屏幕外
//            CGRect oldViewR = qrcodeV.frame;
//            oldViewR.origin.y = self.view.frame.size.height;
//            [qrcodeV setFrame:oldViewR];
//            
//            qrcodeV.qrcodeNum.text = [NSString stringWithFormat:@"优惠券号：%@",LegalObject([couponDic objectForKey:@"code"],[NSString class])];
//            qrcodeV.qrcodeimg.image = [QRCodeGenerator qrImageForString:LegalObject([couponDic objectForKey:@"code"],[NSString class]) imageSize:220];
//            qrcodeV.qrcodetime.text = [NSString stringWithFormat:@"有效期:%@至%@",LegalObject([couponDic objectForKey:@"start_time"],[NSString class]),LegalObject([couponDic objectForKey:@"failtime"],[NSString class])];
//            qrcodeV.qrcodetitle.text = LegalObject([couponDic objectForKey:@"title"],[NSString class]);
//            qrcodeV.qrcodedesc.text = LegalObject([couponDic objectForKey:@"desc"],[NSString class]);
//            qrcodeV.userInteractionEnabled = YES;
//            [app.window addSubview:qrcodeV];
//        }
//    }
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
//    int height = [height_str intValue];
//    
//    NSLog(@"高度是-------:%d",height);
//    
//    CGRect oldFrame = textWebView.frame;
//    oldFrame.size.height = height+20;
//    webView.frame = oldFrame;
//    webView.scrollView.scrollEnabled = NO;
//    CGSize oldsize = myallView.contentSize;
//    
//    if (btno2ouseCardnow.hidden && btnuseCardnow.hidden &&btnsavecode.hidden ) {
//        oldsize.height = 220+20+height;
//    }else{
//        oldsize.height = 220+20+height + 60;
//
//        CGRect oldF1 = btno2ouseCardnow.frame;
//        oldF1.origin.y = height+250;
//        btno2ouseCardnow.frame = oldF1;
//        
//        CGRect oldF2 = btnuseCardnow.frame;
//        oldF2.origin.y = height+250;
//        btnuseCardnow.frame = oldF2;
//        
//        CGRect oldF3 = btnsavecode.frame;
//        oldF3.origin.y = height+250;
//        btnsavecode.frame = oldF3;
//        
//        CGRect oldF4 = btnabout.frame;
//        oldF4.origin.y = height+250;
//        btnabout.frame = oldF4;
//        
//    }
//    
//    [myallView setContentSize:oldsize];
//    
//    NSLog(@"height: %@", [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]);
//}
//
////界面消失
//-(void)viewWillDisappear:(BOOL)animated{
//    [qrcodeV removeFromSuperview];
//    [dackBtn removeFromSuperview];
//}
//
//#pragma mark-- 查看二维码
//- (IBAction)popoverBtnClicked:(id)sender forEvent:(UIEvent *)event {
//    
//    qrcodebg.hidden = NO;
//    
//    qrcodeV.userInteractionEnabled = YES;
//    
//    NSLog(@"---%@----%@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(qrcodeV.frame));
//
//    CGRect oldViewR = qrcodeV.frame;
//    
//    if (isIOS7up) {
//        oldViewR.origin.y = self.view.frame.size.height - qrcodeV.frame.size.height;
//    }else{
//    oldViewR.origin.y = self.view.frame.size.height - qrcodeV.frame.size.height+60;
//    }
//
//    [UIView animateWithDuration:0.5 animations:^{
//        [qrcodeV setFrame:oldViewR];
//    }];
//}
//
////立即使用 跳转到首页
//- (IBAction)usecardnowAction:(id)sender {
//    //lee999recode
////    [self myAimerBack];
//    
//    //lee987 增加兑换礼品卡
//    NSString* cardType = [[couponDic objectForKey:@"type" isDictionary:nil] description];
//    if ([cardType isEqualToString:@"gift"]) {
//        YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
//        webView.strURL  = [[couponDic objectForKey:@"url" isDictionary:nil] description];
//        webView.strTitle = [[couponDic objectForKey:@"title" isDictionary:nil] description];
//        [self.navigationController pushViewController:webView animated:YES];
//        
//    }else{
//        
//        //lee999 修改bug  从领券页，登陆，领券，点击右上角的查看优惠券按钮进优惠券页，点击优惠券进详情页，点击使用按钮没跳转   应该去首页界面
//        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        
//        if (app.mytabBarController.selectedIndex ==0) {
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }else{
//            [self changeToShop];
//        }
//    }
//}
////关于二维码的说明
//- (IBAction)aboutqrcodeAction:(id)sender {
//
//    [UIView animateWithDuration:0.5 animations:^{
//        dackBtn.alpha = 1.0;
//    }];
//}
//
////保存二维码
//- (IBAction)saveqrAction:(id)sender {
//    
//    [MYCommentAlertView showMessage:@"二维码已经保存到相册" target:nil];
//    
//    UIGraphicsBeginImageContext(qrcodeV.bounds.size);     //currentView 当前的view
//    [qrcodeV.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
//}
//
//-(void)hiddenMyself{
//
//    [UIView animateWithDuration:0.5 animations:^{
//        dackBtn.alpha = 0.0;
//    }];
//}
//
//-(void)hiddenView{
//
//    qrcodebg.hidden = YES;
//}
//
//-(void)viewDidUnload{
//    [super viewDidUnload];
//    
//    [qrcodeV removeFromSuperview];
//    [dackBtn removeFromSuperview];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
