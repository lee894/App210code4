//
//  LCommentAlertView.m
//  paipaiiphone
//
//  Created by lee on 14-8-1.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImage+ImageEffects.h"
#import "LCommentAlertView.h"
#import "MYMacro.h"
#import "LoadingHUD.h"


@interface LCommentAlertView ()<UITextFieldDelegate>

@property (nonatomic,retain) NSMutableDictionary *aDict;
@property (nonatomic,retain) UIButton *getValidCodeButton;

@property (nonatomic,assign) int countdown;
@property (nonatomic,retain) NSTimer *countdownTimer;
@property (nonatomic,assign) BOOL isTimerValid;
@property (nonatomic,retain) UIButton* btnRight;
@property (nonatomic,retain) UITextField *codeTextFieldView;

@end

@implementation LCommentAlertView

- (void)urlWasClicked:(DSURLView *)urlView urlString:(NSString *)urlString
{
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: urlString];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    //添加抄送
//    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
//    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
    //添加密送
//    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
//    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    //添加主题
//    [mailUrl appendString:@"&subject=my email"];
    //添加邮件内容
//    [mailUrl appendString:@"&body=<b>email</b> body!"];
    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
     [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

+ (void)showMessage:(NSString *)msg target:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示"
                                                    message:msg
                                                   delegate:sender
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil];
    [alert show];
}

+ (void)showTitle:(NSString *)title message:(NSString *)msg taget:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:sender
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil];
    [alert show];
}


+ (void)showNetMessage:(NSString *)msg target:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示"
                                                    message:msg
                                                   delegate:sender
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil];
    alert.tag = 11118;
    [alert show];
}

+ (void)showMessage:(NSString *)msg target:(id)sender Tag:(NSInteger)tag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示"
                                                    message:msg
                                                   delegate:sender
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil];
    alert.tag = tag;
    [alert show];
}

- (id)initWithTitle:(NSString*)title Message:(NSString *)msg tag:(NSInteger)tag btns:(NSString*)string, ...NS_REQUIRES_NIL_TERMINATION
{
    if (self = [super init]) {
        
    }
    va_list values;
    va_start(values, string);
    NSString* strBtnName = nil;
    NSMutableArray* btnList = [[NSMutableArray alloc] initWithCapacity:1];
    if (string) {
        [btnList addObject:string];
    }
    while ((strBtnName = va_arg(values, NSString*))) {
        [btnList addObject:strBtnName];
    }
    va_end(values);
    
    //     CGSize imageSize = CGSizeZero;
    //        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    //        if (UIInterfaceOrientationIsPortrait(orientation))
    //            imageSize = [UIScreen mainScreen].bounds.size;
    //        else
    //            imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    //
    //        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    //        CGContextRef context = UIGraphicsGetCurrentContext();
    //        for (UIWindow *window in [[UIApplication sharedApplication] windows])
    //        {
    //            CGContextSaveGState(context);
    //            CGContextTranslateCTM(context, window.center.x, window.center.y);
    //            CGContextConcatCTM(context, window.transform);
    //            CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
    //            if (orientation == UIInterfaceOrientationLandscapeLeft)
    //            {
    //                CGContextRotateCTM(context, M_PI_2);
    //                CGContextTranslateCTM(context, 0, -imageSize.width);
    //            }
    //            else if (orientation == UIInterfaceOrientationLandscapeRight)
    //            {
    //                CGContextRotateCTM(context, -M_PI_2);
    //                CGContextTranslateCTM(context, -imageSize.height, 0);
    //            } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
    //                CGContextRotateCTM(context, M_PI);
    //                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
    //            }
    //            if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    //            {
    //                [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
    //            }
    //            else
    //            {
    //                [window.layer renderInContext:context];
    //            }
    //            CGContextRestoreGState(context);
    //        }
    //
    //
    //    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    _blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [_blurView setUserInteractionEnabled:YES];
    [_blurView setTag:198874];
    [_blurView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    //    if(isIOS7up)
    //    {
    //        UIImage* _blurredBackgroundImage = [viewImage applyBlurWithRadius:1 tintColor:[UIColor colorWithWhite:0 alpha:.2] saturationDeltaFactor:1.4 maskImage:nil];
    //        [_blurView setImage:_blurredBackgroundImage];
    //    }
    self.frame = _blurView.frame;
    [self addSubview:_blurView];
    
    UIView* vAlert = [[UIView alloc] init];//WithFrame:CGRectMake(30, ([UIScreen mainScreen].bounds.size.height - 261.5 ) / 2, 250, 261.5)];
    [vAlert.layer setCornerRadius:5];
    [vAlert setBackgroundColor:[UIColor whiteColor]];
    [_blurView addSubview:vAlert];
    
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 17)];
    [lblTitle setText:title];
    [lblTitle setFont:[UIFont systemFontOfSize:17]];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"#e11f26"]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [vAlert addSubview:lblTitle];
    
    UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 57, 250, 0.5)];
    [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#E7E4DD"]];
    [vAlert addSubview:lblSep];
    
    CGSize szItemPrice;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
    mps.lineBreakMode = NSLineBreakByCharWrapping;
    szItemPrice = [msg boundingRectWithSize:CGSizeMake(210, MAXFLOAT)
                                                options:  NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : mps}
                                                context:nil].size;
#else
    szItemPrice = [msg sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
#endif
    NSRange range = [[msg description] rangeOfString:@"jubao@paipai.com"];
    if(range.length>0)
    {
        if(urlView==nil)
            urlView = [[DSURLView alloc] init];
        urlView.sourceText = msg;
        urlView.delegate = self;
        urlView.backgroundColor = [UIColor clearColor];
        urlView.frameWidth = 210;
        urlView.frameOriginX = 20;
        urlView.frameOriginY = 57.5 + 50;
        [urlView layoutURLViewWithElements:[urlView splitStringByUrl:msg]];
        [vAlert addSubview:urlView];
    }
    else
    {
        UILabel* lblContent = [[UILabel alloc] init];
        [lblContent setText:msg];
        [lblContent setNumberOfLines:0];
        [lblContent setFont:[UIFont systemFontOfSize:14]];
        [lblContent setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lblContent setTextAlignment:NSTextAlignmentCenter];
        [lblContent setLineBreakMode:NSLineBreakByCharWrapping];
        [vAlert addSubview:lblContent];
        [lblContent setFrame:CGRectMake(20, 57.5 + 50, 210, szItemPrice.height)];
    }
    
    
    UILabel* lblSep1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 57.5 + 50 + szItemPrice.height + 50, 250, 0.5)];
    [lblSep1 setBackgroundColor:[UIColor colorWithHexString:@"#E7E4DD"]];
    [vAlert addSubview:lblSep1];
    
    if ([btnList count] == 1) {
        
        UIButton* singleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [singleBtn setFrame:CGRectMake(20,lblSep1.frame.origin.y + 0.5 + 20, 210, 30)];
        [singleBtn setTitle:[btnList lastObject] forState:UIControlStateNormal];
        [singleBtn setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [singleBtn setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [singleBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [singleBtn setTag:1];
        [vAlert addSubview:singleBtn];
        
        
    }
    else if ([btnList count] == 2) {
        //购物车按钮 第一分割线向下20 左距20 135 35
        UIButton* btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnLeft setTitle:[btnList firstObject] forState:UIControlStateNormal];
        [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateNormal];
        [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateHighlighted];
        [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateSelected];
        [btnLeft setFrame:CGRectMake(20, lblSep1.frame.origin.y + 0.5 + 20, 105, 30)];
        [btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
        [btnLeft setTag:0];
        [btnLeft addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [vAlert addSubview:btnLeft];
        //立即购买按钮 购物车按钮 向后10 其他与购物车按钮相同
        UIButton* btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnRight setFrame:CGRectMake(btnLeft.frame.origin.x + btnLeft.frame.size.width + 10, lblSep1.frame.origin.y + 0.5 + 20, 105, 30)];
        [btnRight setTitle:[btnList lastObject] forState:UIControlStateNormal];
        [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [btnRight addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnRight setTag:1];
        [vAlert addSubview:btnRight];
    }
    self.tag = tag;
    
    [vAlert setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 250) / 2, ([UIScreen mainScreen].bounds.size.height - (lblSep1.frame.origin.y + 0.5 + 20 + 30 + 20)) / 2, 250, lblSep1.frame.origin.y + 0.5 + 20 + 30 + 20)];
    return self;
}

- (id)initWithMessage:(NSString *)msg tag:(NSInteger)tag btns:(NSString*)string, ...NS_REQUIRES_NIL_TERMINATION
{
    if (self = [super init]) {
        
    }
    va_list values;
    va_start(values, string);
    NSString* title = nil;
    NSMutableArray* btnList = [[NSMutableArray alloc] initWithCapacity:1];
    if (string) {
        [btnList addObject:string];
    }
    while ((title = va_arg(values, NSString*))) {
        [btnList addObject:title];
    }
    va_end(values);
    
    //     CGSize imageSize = CGSizeZero;
    //        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    //        if (UIInterfaceOrientationIsPortrait(orientation))
    //            imageSize = [UIScreen mainScreen].bounds.size;
    //        else
    //            imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    //
    //        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    //        CGContextRef context = UIGraphicsGetCurrentContext();
    //        for (UIWindow *window in [[UIApplication sharedApplication] windows])
    //        {
    //            CGContextSaveGState(context);
    //            CGContextTranslateCTM(context, window.center.x, window.center.y);
    //            CGContextConcatCTM(context, window.transform);
    //            CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
    //            if (orientation == UIInterfaceOrientationLandscapeLeft)
    //            {
    //                CGContextRotateCTM(context, M_PI_2);
    //                CGContextTranslateCTM(context, 0, -imageSize.width);
    //            }
    //            else if (orientation == UIInterfaceOrientationLandscapeRight)
    //            {
    //                CGContextRotateCTM(context, -M_PI_2);
    //                CGContextTranslateCTM(context, -imageSize.height, 0);
    //            } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
    //                CGContextRotateCTM(context, M_PI);
    //                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
    //            }
    //            if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    //            {
    //                [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
    //            }
    //            else
    //            {
    //                [window.layer renderInContext:context];
    //            }
    //            CGContextRestoreGState(context);
    //        }
    //
    //
    //    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    _blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.frame = _blurView.frame;
    [_blurView setUserInteractionEnabled:YES];
    [_blurView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    //    if(isIOS7up)
    //    {
    //        UIImage* _blurredBackgroundImage = [viewImage applyBlurWithRadius:1 tintColor:[UIColor colorWithWhite:0 alpha:.2] saturationDeltaFactor:1.4 maskImage:nil];
    //        [_blurView setImage:_blurredBackgroundImage];
    //    }
    [_blurView setTag:198874];
    [self addSubview:_blurView];
    
    UIView* vAlert = [[UIView alloc] initWithFrame:CGRectMake(30, ([UIScreen mainScreen].bounds.size.height - 180 ) / 2, 250, 180)];
    [vAlert.layer setCornerRadius:5];
    [vAlert setBackgroundColor:[UIColor whiteColor]];
    [_blurView addSubview:vAlert];
    
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 47, 250, 18)];
    [lblTitle setText:msg];
    [lblTitle setFont:[UIFont systemFontOfSize:18]];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"#e11f26"]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [vAlert addSubview:lblTitle];
    
    UILabel* lblSep1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 219 / 2, 250, 0.5)];
    [lblSep1 setBackgroundColor:[UIColor colorWithHexString:@"#E7E4DD"]];
    [vAlert addSubview:lblSep1];
    
    if ([btnList count] == 1) {
        UIButton* btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnRight setFrame:CGRectMake(20, lblSep1.frame.origin.y + 0.5 + 20, 220, 30)];
        [btnRight setTitle:@"知道了" forState:UIControlStateNormal];
        [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [btnRight addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnRight setTag:0];
        [vAlert addSubview:btnRight];
    }
    else if ([btnList count] == 2) {
        //购物车按钮 第一分割线向下20 左距20 135 35
        UIButton* btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnLeft setTitle:[btnList firstObject] forState:UIControlStateNormal];
        [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateNormal];
        [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateHighlighted];
        [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateSelected];
        [btnLeft setFrame:CGRectMake(20, lblSep1.frame.origin.y + 0.5 + 20, 105, 30)];
        [btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
        [btnLeft setTag:0];
        [btnLeft addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [vAlert addSubview:btnLeft];
        //立即购买按钮 购物车按钮 向后10 其他与购物车按钮相同
        UIButton* btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnRight setFrame:CGRectMake(btnLeft.frame.origin.x + btnLeft.frame.size.width + 10, lblSep1.frame.origin.y + 0.5 + 20, 105, 30)];
        [btnRight setTitle:[btnList lastObject] forState:UIControlStateNormal];
        [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [btnRight addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnRight setTag:1];
        [vAlert addSubview:btnRight];
    }
    self.tag = tag;
    return self;
}


- (id)initWithTitle:(NSString*)title tag:(NSInteger)tag view:(UIView*)view
{
    if (self = [super init]) {
        //         CGSize imageSize = CGSizeZero;
        //        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        //        if (UIInterfaceOrientationIsPortrait(orientation))
        //            imageSize = [UIScreen mainScreen].bounds.size;
        //        else
        //            imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        //
        //        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        //        CGContextRef context = UIGraphicsGetCurrentContext();
        //        for (UIWindow *window in [[UIApplication sharedApplication] windows])
        //        {
        //            CGContextSaveGState(context);
        //            CGContextTranslateCTM(context, window.center.x, window.center.y);
        //            CGContextConcatCTM(context, window.transform);
        //            CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        //            if (orientation == UIInterfaceOrientationLandscapeLeft)
        //            {
        //                CGContextRotateCTM(context, M_PI_2);
        //                CGContextTranslateCTM(context, 0, -imageSize.width);
        //            }
        //            else if (orientation == UIInterfaceOrientationLandscapeRight)
        //            {
        //                CGContextRotateCTM(context, -M_PI_2);
        //                CGContextTranslateCTM(context, -imageSize.height, 0);
        //            } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        //                CGContextRotateCTM(context, M_PI);
        //                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        //            }
        //            if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        //            {
        //                [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        //            }
        //            else
        //            {
        //                [window.layer renderInContext:context];
        //            }
        //            CGContextRestoreGState(context);
        //        }
        //
        //
        //        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        _blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [_blurView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
        //        if(isIOS7up)
        //        {
        //            UIImage* _blurredBackgroundImage = [viewImage applyBlurWithRadius:1 tintColor:[UIColor colorWithWhite:0 alpha:.2] saturationDeltaFactor:1.4 maskImage:nil];
        //            [_blurView setImage:_blurredBackgroundImage];
        //        }
        [_blurView setUserInteractionEnabled:YES];
        self.frame = _blurView.frame;
        [self addSubview:_blurView];
        
        UIView* vAlert = [[UIView alloc] init];
        [vAlert.layer setCornerRadius:5];
        [vAlert setBackgroundColor:[UIColor whiteColor]];
        [_blurView addSubview:vAlert];
        
        UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 17)];
        [lblTitle setText:title];
        [lblTitle setFont:[UIFont systemFontOfSize:17]];
        [lblTitle setTextColor:[UIColor colorWithHexString:@"#e11f26"]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [vAlert addSubview:lblTitle];
        
        UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 57, 250, 0.5)];
        [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#E7E4DD"]];
        [vAlert addSubview:lblSep];
        
        [view setFrame:CGRectMake(0, lblSep.frame.size.height + lblSep.frame.origin.y, 250, view.frame.size.height)];
        [vAlert addSubview:view];
        
        UILabel* lblSep1 = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.origin.y + view.frame.size.height, 250, 0.5)];
        [lblSep1 setBackgroundColor:[UIColor colorWithHexString:@"#E7E4DD"]];
        [vAlert addSubview:lblSep1];
        
        UIButton* btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnRight setFrame:CGRectMake(20, lblSep1.frame.origin.y + 0.5 + 20, 220, 30)];
        [btnRight setTitle:@"知道了" forState:UIControlStateNormal];
        [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [btnRight addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnRight setTag:1];
        [vAlert addSubview:btnRight];
        self.tag = tag;
        
        [vAlert setFrame:CGRectMake(30, ([UIScreen mainScreen].bounds.size.height - (btnRight.frame.origin.y + btnRight.frame.size.height + 20)) / 2, 260, btnRight.frame.origin.y + btnRight.frame.size.height + 20)];
    }
    return self;
}

- (id)initWithTitle:(NSString*)title tag:(NSInteger)tag view:(UIView*)view btns:(NSString*)string, ... NS_REQUIRES_NIL_TERMINATION
{
    if (self = [super init]) {
        
        va_list values;
        va_start(values, string);
        NSString* strBtnName = nil;
        NSMutableArray* btnList = [[NSMutableArray alloc] initWithCapacity:1];
        if (string) {
            [btnList addObject:string];
        }
        while ((strBtnName = va_arg(values, NSString*))) {
            [btnList addObject:strBtnName];
        }
        va_end(values);
        
        //         CGSize imageSize = CGSizeZero;
        //        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        //        if (UIInterfaceOrientationIsPortrait(orientation))
        //            imageSize = [UIScreen mainScreen].bounds.size;
        //        else
        //            imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        //
        //        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        //        CGContextRef context = UIGraphicsGetCurrentContext();
        //        for (UIWindow *window in [[UIApplication sharedApplication] windows])
        //        {
        //            CGContextSaveGState(context);
        //            CGContextTranslateCTM(context, window.center.x, window.center.y);
        //            CGContextConcatCTM(context, window.transform);
        //            CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        //            if (orientation == UIInterfaceOrientationLandscapeLeft)
        //            {
        //                CGContextRotateCTM(context, M_PI_2);
        //                CGContextTranslateCTM(context, 0, -imageSize.width);
        //            }
        //            else if (orientation == UIInterfaceOrientationLandscapeRight)
        //            {
        //                CGContextRotateCTM(context, -M_PI_2);
        //                CGContextTranslateCTM(context, -imageSize.height, 0);
        //            } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        //                CGContextRotateCTM(context, M_PI);
        //                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        //            }
        //            if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        //            {
        //                [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        //            }
        //            else
        //            {
        //                [window.layer renderInContext:context];
        //            }
        //            CGContextRestoreGState(context);
        //        }
        //
        //
        //        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        _blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [_blurView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
        //        if(isIOS7up)
        //        {
        //            UIImage* _blurredBackgroundImage = [viewImage applyBlurWithRadius:1 tintColor:[UIColor colorWithWhite:0 alpha:.2] saturationDeltaFactor:1.4 maskImage:nil];
        //            [_blurView setImage:_blurredBackgroundImage];
        //        }
        [_blurView setUserInteractionEnabled:YES];
        self.frame = _blurView.frame;
        [self addSubview:_blurView];
        
        UIView* vAlert = [[UIView alloc] init];
        [vAlert.layer setCornerRadius:5];
        [vAlert setBackgroundColor:[UIColor whiteColor]];
        [_blurView addSubview:vAlert];
        
        UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 17)];
        [lblTitle setText:title];
        [lblTitle setFont:[UIFont systemFontOfSize:17]];
        [lblTitle setTextColor:[UIColor colorWithHexString:@"#e11f26"]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [vAlert addSubview:lblTitle];
        
        UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 57, 250, 0.5)];
        [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#E7E4DD"]];
        [vAlert addSubview:lblSep];
        
        [view setFrame:CGRectMake(0, lblSep.frame.size.height + lblSep.frame.origin.y, 250, view.frame.size.height)];
        [vAlert addSubview:view];
        
        UILabel* lblSep1 = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.origin.y + view.frame.size.height, 250, 0.5)];
        [lblSep1 setBackgroundColor:[UIColor colorWithHexString:@"#E7E4DD"]];
        [vAlert addSubview:lblSep1];
        
        if ([btnList count] == 1) {
            
            UIButton* singleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [singleBtn setFrame:CGRectMake(20,lblSep1.frame.origin.y + 0.5 + 20, 210, 30)];
            [singleBtn setTitle:[btnList lastObject] forState:UIControlStateNormal];
            [singleBtn setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
            [singleBtn setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
            [singleBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [singleBtn setTag:1];
            [vAlert addSubview:singleBtn];
            
        }
        else if ([btnList count] == 2) {
            //购物车按钮 第一分割线向下20 左距20 135 35
            UIButton* btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnLeft setTitle:[btnList firstObject] forState:UIControlStateNormal];
            [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateNormal];
            [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateHighlighted];
            [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateSelected];
            [btnLeft setFrame:CGRectMake(20, lblSep1.frame.origin.y + 0.5 + 20, 105, 30)];
            [btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
            [btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
            [btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
            [btnLeft setTag:0];
            [btnLeft addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [vAlert addSubview:btnLeft];
            //立即购买按钮 购物车按钮 向后10 其他与购物车按钮相同
            UIButton* btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnRight setFrame:CGRectMake(btnLeft.frame.origin.x + btnLeft.frame.size.width + 10, lblSep1.frame.origin.y + 0.5 + 20, 105, 30)];
            [btnRight setTitle:[btnList lastObject] forState:UIControlStateNormal];
            [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
            [btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
            [btnRight addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [btnRight setTag:1];
            [vAlert addSubview:btnRight];
        }
        self.tag = tag;
        
        [vAlert setFrame:CGRectMake(30, ([UIScreen mainScreen].bounds.size.height - (lblSep1.frame.origin.y + 0.5 + 20 + 30 + 20)) / 2, 260, lblSep1.frame.origin.y + 0.5 + 20 + 30 + 20)];
    }
    return self;
}

-(void)onClick:(UIButton*)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [_delegate alertView:(UIAlertView*)self clickedButtonAtIndex:sender.tag];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *sub in urlView.subviews)
            [sub removeFromSuperview];
        [urlView removeFromSuperview];
        [self removeFromSuperview];
    });
}

-(void)show
{
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self];
}


-(void)showActivityWithView:(UIView *)view
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if(isIOS7up)
    {
        UIImage* _blurredBackgroundImage = [viewImage applyBlurWithRadius:1 tintColor:[UIColor colorWithWhite:0 alpha:.2] saturationDeltaFactor:1.4 maskImage:nil];
        [_blurView setImage:_blurredBackgroundImage];
    }
    [_blurView setUserInteractionEnabled:YES];
    self.frame = _blurView.frame;
    [self addSubview:_blurView];
    
}

- (void)createBlurView{
    if ([((AppDelegate*)[UIApplication sharedApplication].delegate).window viewWithTag:982839478]) {
        [LoadingHUD stopLoading];
    }
    
    //    CGSize imageSize = CGSizeZero;
    //    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    //    if (UIInterfaceOrientationIsPortrait(orientation))
    //        imageSize = [UIScreen mainScreen].bounds.size;
    //    else
    //        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    //
    //    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    //    {
    //        CGContextSaveGState(context);
    //        CGContextTranslateCTM(context, window.center.x, window.center.y);
    //        CGContextConcatCTM(context, window.transform);
    //        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
    //        if (orientation == UIInterfaceOrientationLandscapeLeft)
    //        {
    //            CGContextRotateCTM(context, M_PI_2);
    //            CGContextTranslateCTM(context, 0, -imageSize.width);
    //        }
    //        else if (orientation == UIInterfaceOrientationLandscapeRight)
    //        {
    //            CGContextRotateCTM(context, -M_PI_2);
    //            CGContextTranslateCTM(context, -imageSize.height, 0);
    //        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
    //            CGContextRotateCTM(context, M_PI);
    //            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
    //        }
    //        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    //        {
    //            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
    //        }
    //        else
    //        {
    //            [window.layer renderInContext:context];
    //        }
    //        CGContextRestoreGState(context);
    //    }
    //
    //    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    _blurView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ((AppDelegate*)[UIApplication sharedApplication].delegate).window.bounds.size.width, ((AppDelegate*)[UIApplication sharedApplication].delegate).window.bounds.size.height)];
    [_blurView setUserInteractionEnabled:YES];
    [_blurView setTag:982839478];
    [_blurView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    //    if(isIOS7up)
    //    {
    //        UIImage* _blurredBackgroundImage = [viewImage applyBlurWithRadius:1 tintColor:[UIColor colorWithWhite:0 alpha:.2] saturationDeltaFactor:1.4 maskImage:nil];
    //        [_blurView setImage:_blurredBackgroundImage];
    //    }
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window addSubview:_blurView];
    
    [self addSubview:_blurView];
}

-(void)showCouponViewWithSum:(int)sum
{
    
    [self createBlurView];
    
    UIImageView *bgImageview = [[UIImageView alloc] initWithFrame:CGRectMake(70, 160, (180.0*ScreenWidth/320.0), 515.0/2.0)];
    bgImageview.image = [UIImage imageNamed:@"getCoupon.png"];
    bgImageview.userInteractionEnabled = YES;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 140, 15)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"恭喜您!";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 97, 140, 15)];
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.text = @"获得代金券:";
    subtitleLabel.textColor = [UIColor blackColor];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    UILabel *danweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 127, 20, 20)];
    danweiLabel.backgroundColor = [UIColor clearColor];
    danweiLabel.text = [NSString stringWithFormat:@"￥"];
    danweiLabel.textColor = [UIColor whiteColor];
    danweiLabel.textAlignment = NSTextAlignmentRight;
    danweiLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    
    UILabel *sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 125, 140, 23)];
    sumLabel.backgroundColor = [UIColor clearColor];
    sumLabel.text = [NSString stringWithFormat:@"%d元",sum];
    sumLabel.textColor = [UIColor whiteColor];
    sumLabel.textAlignment = NSTextAlignmentLeft;
    sumLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 325.0/2.0, 160, 13)];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.text = @"10分钟内系统自动发放";
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:12.0f];
    
    
    UIButton *knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [knowBtn setFrame:CGRectMake(20, 214, 140, 50)];
    knowBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [knowBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [knowBtn addTarget:self action:@selector(IKnowAction:) forControlEvents:UIControlEventTouchUpInside];
    [knowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [bgImageview addSubview:titleLabel];
    [bgImageview addSubview:subtitleLabel];
    [bgImageview addSubview:danweiLabel];
    [bgImageview addSubview:sumLabel];
    [bgImageview addSubview:tipLabel];
    [bgImageview addSubview:knowBtn];
    
    [self addSubview:bgImageview];
    [self show];
    
}


- (void)getVerfyCode:(id)sender{
    
    if (_countdown == 60) {
        // 启动倒计时60s，60s内发送验证码按钮不可点
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                           target:self
                                                         selector:@selector(refreshCountdown)
                                                         userInfo:nil repeats:YES];
        [_countdownTimer fire];
        _isTimerValid = YES;
        
        [_getValidCodeButton setBackgroundImage:[[UIImage imageNamed:@"unsendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [_getValidCodeButton setBackgroundImage:[[UIImage imageNamed:@"unsendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [_getValidCodeButton setBackgroundImage:[[UIImage imageNamed:@"unsendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
        
        [self.getValidCodeButton setTitleColor:[UIColor colorWithHexString:@"#d2c9b6"] forState:UIControlStateNormal];
        [self.getValidCodeButton setTitleColor:[UIColor colorWithHexString:@"#d2c9b6"] forState:UIControlStateSelected];
        [self.getValidCodeButton setTitleColor:[UIColor colorWithHexString:@"#d2c9b6"] forState:UIControlStateHighlighted];
        
        if (_mDelegate && [_mDelegate respondsToSelector:@selector(sendVerifyCode:)]) {
            [_mDelegate sendVerifyCode:nil];
        }
        
    }
}

#pragma mark 刷新倒计时
- (void)refreshCountdown {
    if (_countdown < 0) {
        [self.getValidCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        
        [_getValidCodeButton setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateNormal];
        [_getValidCodeButton setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateHighlighted];
        [_getValidCodeButton setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateSelected];
        [_getValidCodeButton setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [_getValidCodeButton setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [_getValidCodeButton setBackgroundImage:[[UIImage imageNamed:@"btnCancel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
        
        _countdown = 60;
        [_countdownTimer invalidate]; // 停止倒计时定时器
        _isTimerValid = NO;
        return;
    }
    [self.getValidCodeButton setTitle:[NSString stringWithFormat:@"重发(%d秒)", _countdown--] forState:UIControlStateNormal];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    
    if (self.btnRight) {
        
        NSMutableString *newValue = [textField.text mutableCopy];
        [newValue replaceCharactersInRange:range withString:string];
        
        if ([newValue length]== 0) {
            self.btnRight.enabled = NO;
            [_btnRight setBackgroundColor:[UIColor clearColor]];
            [_btnRight setBackgroundImage:[[UIImage imageNamed:@"unsendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
            [_btnRight setBackgroundImage:[[UIImage imageNamed:@"unsendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
            [_btnRight setBackgroundImage:[[UIImage imageNamed:@"unsendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
            [_btnRight setTitleColor:[UIColor colorWithHexString:@"#d2c9b6"] forState:UIControlStateNormal];
        }else{
            self.btnRight.enabled = YES;
            [_btnRight setBackgroundColor:[UIColor clearColor]];
            [_btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
            [_btnRight setBackgroundImage:[[UIImage imageNamed:@"picSearchBarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
            [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
    }
    
    //    if (textField.text.length > 7) {
    //        // 提示  请输入正确的验证码
    //        return NO;
    //    }
    return YES;
}

- (void)showAddVerifyCodeView:(NSDictionary *)dict{
    
    [self createBlurView];
    
    self.aDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    _isTimerValid = NO;
    _countdown = 60;
    
    NSString *title = @"确认收货";
    NSString *numberStr = [dict objectForKey:@"buyerMobile"];
    
    
    UIView* vAlert = [[UIView alloc] init];
    [vAlert.layer setCornerRadius:5];
    [vAlert setBackgroundColor:[UIColor whiteColor]];
    [_blurView addSubview:vAlert];
    
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 17)];
    [lblTitle setText:title];
    [lblTitle setFont:[UIFont systemFontOfSize:17]];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"#e11f26"]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [vAlert addSubview:lblTitle];
    
    //上分割线
    UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 57, 250, 0.5)];
    [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#E7E4DD"]];
    [vAlert addSubview:lblSep];
    
    UILabel *alertLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 70, 250 - 30*2, 25)];
    alertLable.text = @"请不要在没有收到商品的情况下";
    alertLable.font = [UIFont systemFontOfSize:13];
    alertLable.textColor = [UIColor colorWithHexString:@"D2CABB"];
    alertLable.textAlignment = NSTextAlignmentCenter;
    [vAlert addSubview:alertLable];
    
    UILabel *alertLable2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 90, 250 - 30*2, 25)];
    alertLable2.text = @"确认收货，以免被骗";
    alertLable2.font = [UIFont systemFontOfSize:13];
    alertLable2.textColor = [UIColor colorWithHexString:@"D2CABB"];
    alertLable2.textAlignment = NSTextAlignmentCenter;
    [vAlert addSubview:alertLable2];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 120, 250 - 25*2, 30)];
    phoneLabel.text = [NSString stringWithFormat:@"您的手机号 %@",numberStr];
    phoneLabel.font = [UIFont systemFontOfSize:17];
    phoneLabel.textColor = [UIColor colorWithHexString:@"412509"];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    [vAlert addSubview:phoneLabel];
    
    self.codeTextFieldView = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, 110, 30)];
    //    codeTextFieldView.keyboardType = UIKeyboardTypeNumberPad;
    _codeTextFieldView.returnKeyType = UIReturnKeyDone;
    _codeTextFieldView.textColor = [UIColor colorWithHexString:@"412509"];
    _codeTextFieldView.tag = 10002;
    [_codeTextFieldView setBackgroundColor:[UIColor colorWithHexString:@"#F9F8F4"]];
    _codeTextFieldView.layer.borderWidth = .8;
    _codeTextFieldView.layer.cornerRadius = 5.0;
    _codeTextFieldView.layer.borderColor = [UIColor colorWithHexString:@"#E7E4DE"].CGColor;
    _codeTextFieldView.delegate = self;
    [vAlert addSubview:_codeTextFieldView];
    
    self.getValidCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getValidCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    _getValidCodeButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_getValidCodeButton setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateNormal];
    [_getValidCodeButton setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateHighlighted];
    [_getValidCodeButton setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateSelected];
    [_getValidCodeButton setBackgroundImage:[[UIImage imageNamed:@"sendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
    [_getValidCodeButton setBackgroundImage:[[UIImage imageNamed:@"sendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
    [_getValidCodeButton setBackgroundImage:[[UIImage imageNamed:@"sendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
    _getValidCodeButton.frame = CGRectMake(140, 160, 100, 30);
    
    [_getValidCodeButton addTarget:self action:@selector(getVerfyCode:) forControlEvents:UIControlEventTouchUpInside];
    [vAlert addSubview:_getValidCodeButton];
    
    
    
    UILabel* lblSep1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 220, 250, 0.5)];
    [lblSep1 setBackgroundColor:[UIColor colorWithHexString:@"#E7E4DD"]];
    [vAlert addSubview:lblSep1];
    
    {
        UIButton* btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnLeft setTitle:@"取消" forState:UIControlStateNormal];
        [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateNormal];
        [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateHighlighted];
        [btnLeft setTitleColor:[UIColor colorWithHexString:@"#e11f26"] forState:UIControlStateSelected];
        [btnLeft setFrame:CGRectMake(20, lblSep1.frame.origin.y + 0.5 + 20, 105, 30)];
        [btnLeft setBackgroundImage:[[UIImage imageNamed:@"sendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [btnLeft setBackgroundImage:[[UIImage imageNamed:@"sendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [btnLeft setBackgroundImage:[[UIImage imageNamed:@"sendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
        [btnLeft setTag:0];
        [btnLeft addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [vAlert addSubview:btnLeft];
        
        self.btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRight setFrame:CGRectMake(btnLeft.frame.origin.x + btnLeft.frame.size.width + 10, lblSep1.frame.origin.y + 0.5 + 20, 105, 30)];
        [_btnRight setTitle:@"确定" forState:UIControlStateNormal];
        [_btnRight setBackgroundColor:[UIColor clearColor]];
        [_btnRight setTitleColor:[UIColor colorWithHexString:@"#d2c9b6"] forState:UIControlStateNormal];
        
        _btnRight.enabled = NO;
        [_btnRight setBackgroundImage:[[UIImage imageNamed:@"unsendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateSelected];
        [_btnRight setBackgroundImage:[[UIImage imageNamed:@"unsendCode.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17.5, 0, 17.5) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(goDoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btnRight setTag:1];
        [vAlert addSubview:_btnRight];
    }
    
    
    [vAlert setFrame:CGRectMake(30, ([UIScreen mainScreen].bounds.size.height - (lblSep1.frame.origin.y + 0.5 + 20 + 30 + 20)) / 2 - 30, 260, lblSep1.frame.origin.y + 0.5 + 20 + 30 + 20)];
    
    
    [self show];
}

- (void)cancelAction:(id)sender{
    [self removeself];
}

- (void)goCouponAction:(id)sender{
    
    if (_mDelegate && [_mDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:withParam:)]) {
        [_mDelegate alertView:(UIAlertView *)self clickedButtonAtIndex:1 withParam:self.aDict];
        [self removeself];
    }
}
- (void)goDoneAction:(id)sender{
    
    [self.aDict setObject:self.codeTextFieldView.text forKey:@"phoneCode"];
    
    if (_mDelegate && [_mDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:withParam:)]) {
        [_mDelegate alertView:(UIAlertView *)self clickedButtonAtIndex:1 withParam:self.aDict];
        [self removeself];
    }
}
-(void)IKnowAction:(UIButton *)btn
{
    self.btnBlock(self);
}


-(void)showConfirmReceiveTip
{
    [self createBlurView];
    
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeself)];
    [view addGestureRecognizer:tap];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-140)/2.0, (ScreenHeight-40)/2.0, 140, 40)];
    titleLabel.layer.cornerRadius = 3.0f;
    titleLabel.layer.masksToBounds = YES;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = @"请在PC上确认收货";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [self performSelector:@selector(removeself) withObject:nil afterDelay:3];
    
    [self addSubview:titleLabel];
    
    [self addSubview:view];
    [self show];
    
}

-(void)removeself
{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

@end
