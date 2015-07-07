//
//  CouponDetail20ViewController.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15/6/18.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "QRCodeGenerator.h"
#import "CouponListInfoParser.h"
#import "ManageGiftViewController.h"
#import "CouponDetail20ViewController.h"

@interface CouponDetail20ViewController ()
{
    UIButton* btnSave;
    UIButton* btnUse;
    UIView *mgvB;  //背景图
}
@property (nonatomic, retain) QrcodeView *qrcodeV;
@end

@implementation CouponDetail20ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBackBtnWithType:0];
    //配置颜色和data套壳
    UIColor* textColor = nil;
    CouponInfo* ci = nil;
    FreePostCardInfo* fpci = nil;
    switch (_dType) {
        case kCoupon:
        {
            self.title = @"优惠券详情";
            textColor = [UIColor colorWithHexString:@"#c8002c"];
            ci = _data;
        }
            break;
        case kFreePost:
        {
            self.title = @"包邮卡详情";
            textColor = [UIColor colorWithHexString:@"#ff4081"];
            fpci = _data;
        }
            break;
        case kGift:
        {
            self.title = @"礼品卡详情";
            textColor = [UIColor colorWithHexString:@"#ff6767"];
            ci = _data;
        }
            break;
        case kO2O:
        {
            self.title = @"优惠券详情";
            textColor = [UIColor colorWithHexString:@"fd890a"];
            ci = _data;
        }
            break;
        default:
            break;
    }
    UIView* vWhite = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, lee1fitAllScreen(104))];
    [vWhite setBackgroundColor:[UIColor colorWithHexString:@"#f9f9f9"]];
    [self.view addSubview:vWhite];
    
    UILabel* lblDollar = [[UILabel alloc] init];
    [lblDollar setTextColor:textColor];
    if (ci) {
        [lblDollar setText:@"￥"];
    }else if (fpci)
    {
        [lblDollar setText:@"次"];
    }
    [lblDollar setFont:[UIFont systemFontOfSize:30]];
    CGRect rcDollar = [lblDollar.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblDollar.font} context:nil];
    [vWhite addSubview:lblDollar];
    
    UILabel* lblPrice = [[UILabel alloc] init];
    [lblPrice setTextColor:textColor];
    if (ci) {
        [lblPrice setText:[NSString stringWithFormat:@"%.0f", [ci.price floatValue]]];
    }else if (fpci)
    {
        [lblPrice setText:[[NSNumber numberWithInteger:[fpci.total_times integerValue] - [fpci.used_times integerValue]] description]];
    }
    [lblPrice setFont:[UIFont boldSystemFontOfSize:50]];
    CGRect rcPrice = [lblPrice.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblPrice.font} context:nil];
    [vWhite addSubview:lblPrice];
    
    CGFloat originX = (SCREEN_WIDTH - (rcPrice.size.width + rcDollar.size.width)) / 2;
    if(ci)
    {
        [lblDollar setFrame:CGRectMake(originX, 46, rcDollar.size.width, rcDollar.size.height)];
        [lblPrice setFrame:CGRectMake(lblDollar.frame.origin.x + lblDollar.frame.size.width, 30, rcPrice.size.width, rcPrice.size.height)];
    }else if (fpci)
    {
        [lblPrice setFrame:CGRectMake(originX, 30, rcPrice.size.width, rcPrice.size.height)];
        [lblDollar setFrame:CGRectMake(lblPrice.frame.origin.x + lblPrice.frame.size.width, 46, rcDollar.size.width, rcDollar.size.height)];
    }
    
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 18 + vWhite.frame.size.height, SCREEN_WIDTH, 18)];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:14]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"#181818"]];
    [self.view addSubview:lblTitle];
    
    UILabel* lblTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 20 + 14 + 18 + vWhite.frame.size.height, SCREEN_WIDTH, 14)];
    [lblTime setFont:[UIFont systemFontOfSize:14]];
    [lblTime setTextAlignment:NSTextAlignmentCenter];
    [lblTime setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [self.view addSubview:lblTime];
    
    if (ci) {
        lblTitle.text = ci.desc;
        lblTime.text = [NSString stringWithFormat:@"有效期至%@", ci.failtime];
    }
    else if (fpci)
    {
        lblTitle.text = fpci.desc;
//        lblTitle.text = [NSString stringWithFormat:@"%@共计%@次", fpci.name, fpci.total_times];
//        lblTime.text = [NSString stringWithFormat:@"有效期至%@", [[fpci.end_time componentsSeparatedByString:@" "] firstObject]];
        
        
        //lee999 150706 显示到时分秒
        lblTime.text = [NSString stringWithFormat:@"有效期至%@", fpci.end_time];
    }
    
    UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(12, 85 + vWhite.frame.size.height, SCREEN_WIDTH - 24, 0.5)];
    [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d0d0d0"]];
    [self.view addSubview:lblSep];
    
    CGFloat totalHeight = lblSep.frame.size.height + lblSep.frame.origin.y;
    if (_dType == kO2O) {
        //o2o券 多一段
        
        UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 18 + lblSep.frame.origin.y + 0.5, SCREEN_WIDTH, 18)];
        [lblTitle setFont:[UIFont boldSystemFontOfSize:14]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setTextColor:[UIColor colorWithHexString:@"#181818"]];
        lblTitle.text = [NSString stringWithFormat:@"优惠券号：%@", ci.code];
        [self.view addSubview:lblTitle];
        
        UILabel* lblTime = [[UILabel alloc] init];
        [lblTime setFont:[UIFont systemFontOfSize:14]];
        [lblTime setTextAlignment:NSTextAlignmentCenter];
        [lblTime setTextColor:[UIColor colorWithHexString:@"#666666"]];
        lblTime.text = @"点击查看二维码";
        CGRect rcTime = [lblTime.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblTime.font} context:nil];
        [lblTime setFrame:CGRectMake((SCREEN_WIDTH - rcTime.size.width - 20 - 20) / 2, 20 + 14 + 16 + lblSep.frame.origin.y + 0.5, rcTime.size.width, 14)];
        [self.view addSubview:lblTime];
        
        UIImageView* ivQR = [[UIImageView alloc] initWithFrame:CGRectMake(lblTime.frame.size.width + 20 + lblTime.frame.origin.x, 46 + lblSep.frame.origin.y + 0.5, 20, 20)];
        [ivQR setImage:[UIImage imageNamed:@"yhq_ewm"]];
        [self.view addSubview:ivQR];
        
        UIButton* btnQR = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnQR setFrame:CGRectMake(0, lblSep.frame.origin.y + 0.5 + 32, vWhite.frame.size.width, 18 + 14 + 18)];
        [btnQR addTarget:self action:@selector(showQR:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnQR];
        
        UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(12, totalHeight + 85, SCREEN_WIDTH - 24, 0.5)];
        [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d0d0d0"]];
        [self.view addSubview:lblSep];
        
        totalHeight += 85;
    }
    
//    UILabel* lblContent = [[UILabel alloc] init];
//    [lblContent setNumberOfLines:0];
//    [lblContent setFont:[UIFont systemFontOfSize:14]];
//    [lblContent setTextColor:[UIColor colorWithHexString:@"#666666"]];
    NSString* webtext = @"";
    if (ci) {
        webtext = ci.info;
    }else if(fpci)
    {
        webtext = fpci.info;
    }
//    CGRect rcContent = [lblContent.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 48, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblContent.font} context:nil];
//    [lblContent setFrame:CGRectMake(24, totalHeight + 16, SCREEN_WIDTH - 48, rcContent.size.height)];
//    [self.view addSubview:lblContent];
    
    UIWebView* wbInfo = [[UIWebView alloc] initWithFrame:CGRectMake(24, totalHeight + 16, SCREEN_WIDTH - 48, 1)];
    [wbInfo setDelegate:self];
    wbInfo.scrollView.bounces = NO;
    [wbInfo setBackgroundColor:[UIColor clearColor]];
    [wbInfo setOpaque:NO];
    [wbInfo.scrollView setShowsVerticalScrollIndicator:NO];
    [wbInfo loadHTMLString:[NSString stringWithFormat:@"%@14px;}</style>%@", [NSString stringWithFormat:@"<style type=\"text/css\">img{width:%.0fpx;}.newtext{text-indent:2em;font-size:", wbInfo.frame.size.width], webtext] baseURL:nil];
    [self.view addSubview:wbInfo];
    
    btnUse = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_dType == kO2O) {
        //o2o券 frame不一样
        [btnUse setFrame:CGRectMake(35, wbInfo.frame.size.height + wbInfo.frame.origin.y + 30, lee1fitAllScreen(115), lee1fitAllScreen(36))];
    }else
    {
        [btnUse setFrame:CGRectMake(40, wbInfo.frame.size.height + wbInfo.frame.origin.y + 30, SCREEN_WIDTH - 80, lee1fitAllScreen(36))];
    }
//    [btnUse setBackgroundImage:[[UIImage imageNamed:@"yhq_btn_normal_s"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 57.5, 18, 57.5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
//    [btnUse setBackgroundImage:[[UIImage imageNamed:@"yhq_btn_hover_s"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 57.5, 18, 57.5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
    [btnUse setBackgroundColor:textColor];
    [btnUse.layer setCornerRadius:btnUse.frame.size.height / 2];
    [btnUse.layer setMasksToBounds:YES];
    [btnUse setTitle:@"立即使用" forState:UIControlStateNormal];
    [btnUse.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [btnUse addTarget:self action:@selector(toHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnUse];
    
    if (_dType == kO2O) {
        btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSave setFrame:CGRectMake(btnUse.frame.size.width + btnUse.frame.origin.x + 20, wbInfo.frame.size.height + wbInfo.frame.origin.y + 30, lee1fitAllScreen(115), lee1fitAllScreen(36))];
//        [btnSave setBackgroundImage:[[UIImage imageNamed:@"yhq_btn_normal_s"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 57.5, 18, 57.5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
//        [btnSave setBackgroundImage:[[UIImage imageNamed:@"yhq_btn_hover_s"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 57.5, 18, 57.5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
        [btnSave setBackgroundColor:btnUse.backgroundColor];
        [btnSave.layer setCornerRadius:btnSave.frame.size.height / 2];
        [btnSave.layer setMasksToBounds:YES];
        [btnSave setTitle:@"保存" forState:UIControlStateNormal];
        [btnSave setTitle:@"保存" forState:UIControlStateHighlighted];
        [btnSave.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [btnSave addTarget:self action:@selector(saveCard:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSave];

    }
}

-(void)showQR:(UIButton*)sender
{
    if (!mgvB) {
        mgvB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }else{
        mgvB.hidden = NO;
    }
    
    [mgvB setBackgroundColor:[UIColor blackColor]];
    [mgvB setAlpha:0.7];
    self.view.userInteractionEnabled = NO;
    [self.view addSubview:mgvB];
    
    
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    //创建二维码界面~~
    _qrcodeV = [[[NSBundle mainBundle] loadNibNamed:@"QrcodeView" owner:self options:nil] lastObject];
    _qrcodeV.delegate = self;
    //将视图移除屏幕外
//    CGRect oldViewR = _qrcodeV.frame;
//    oldViewR.origin.y = self.view.frame.size.height;
    [_qrcodeV setCenter:app.window.center];
    
    CouponInfo* ci = _data;
    
    _qrcodeV.qrcodeNum.text = [NSString stringWithFormat:@"优惠券号：%@", ci.code];
    _qrcodeV.qrcodeimg.image = [QRCodeGenerator qrImageForString:ci.code imageSize:220];
    _qrcodeV.qrcodetime.text = [NSString stringWithFormat:@"有效期:%@至%@", ci.start_time, ci.failtime];
    _qrcodeV.qrcodetitle.text = ci.title;
    _qrcodeV.qrcodedesc.text = ci.desc;
    _qrcodeV.userInteractionEnabled = YES;
    [app.window addSubview:_qrcodeV];
}

-(void)saveCard:(UIButton*)sender
{
    [MYCommentAlertView showMessage:@"二维码已经保存到相册" target:nil];
    
//    UIGraphicsBeginImageContext(self.view.bounds.size);     //currentView 当前的view
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    CouponInfo* ci = _data;
    UIImage *viewImage = [QRCodeGenerator qrImageForString:ci.code imageSize:220];
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
}

-(void)toHome:(UIButton*)sender
{
    if (_dType == kGift) {
        ManageGiftViewController* mgvc = [[ManageGiftViewController alloc] init];
        CouponInfo* ci = _data;
        [mgvc setCouponInfo:ci];
        [self.navigationController pushViewController:mgvc animated:YES];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        [self changetableBarto:0];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_qrcodeV removeFromSuperview];
    self.view.userInteractionEnabled = YES;
    if (mgvB) {
        [mgvB removeFromSuperview];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hiddenView
{
    _qrcodeV.hidden = YES;
    
    if (mgvB)
    mgvB.hidden = YES;
    self.view.userInteractionEnabled = YES;

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    CGFloat fWebViewMaxHeight = self.view.bounds.size.height - (lee1fitAllScreen(36) + 30 + 30) - webView.frame.origin.y;
    
//    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    CGFloat height = webView.scrollView.contentSize.height;
    CGRect oldFrame = webView.frame;
    oldFrame.size.height = (height > fWebViewMaxHeight ? fWebViewMaxHeight : height);
    webView.frame = oldFrame;
    
    if (_dType == kO2O) {
        //o2o券 frame不一样
        [btnUse setFrame:CGRectMake(35, webView.frame.size.height + webView.frame.origin.y + 30, lee1fitAllScreen(115), lee1fitAllScreen(36))];
        [btnSave setFrame:CGRectMake(btnUse.frame.size.width + btnUse.frame.origin.x + 20, webView.frame.size.height + webView.frame.origin.y + 30, lee1fitAllScreen(115), lee1fitAllScreen(36))];
    }else
    {
        [btnUse setFrame:CGRectMake(40, webView.frame.size.height + webView.frame.origin.y + 30, SCREEN_WIDTH - 80, lee1fitAllScreen(36))];
    }
}

@end
