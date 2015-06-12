//
//  CouponDetailViewController.h
//  MySuperApp
//
//  Created by lee on 14-5-8.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "QrcodeView.h"

@interface CouponDetailViewController : LBaseViewController<UIWebViewDelegate,UIScrollViewDelegate,QrcodeViewDelegate>
{

    __weak IBOutlet UIScrollView *myallView;

    __weak IBOutlet UIImageView *cuoponsBg;
    __weak IBOutlet UILabel *cuoponprice;
    
    __weak IBOutlet UILabel *couponnumber; //优惠券号码
    
    __weak IBOutlet UILabel *coupontitle;
    __weak IBOutlet UILabel *enditime;
    
    //查看二维码的视图
    __weak IBOutlet UIView *qrcodeview;
    __weak IBOutlet UIButton *seeqrcode;
    
    //说明文字的视图
    __weak IBOutlet UIView *couponTextview;
    __weak IBOutlet UIWebView *textWebView;
    __weak IBOutlet UIButton *btno2ouseCardnow; //立即使用 o2o
    __weak IBOutlet UIButton *btnuseCardnow; //立即使用 普通
    __weak IBOutlet UIButton *btnsavecode;   //保存优惠券
    __weak IBOutlet UIButton *btnabout;     //关于
}

@property(nonatomic,strong)NSDictionary *couponDic;
@property(nonatomic,assign)BOOL isMycard; //是不是我自己的优惠券，（自己的能显示二维码，不是自己的没有二维码）

- (IBAction)usecardnowAction:(id)sender;
- (IBAction)aboutqrcodeAction:(id)sender;
- (IBAction)saveqrAction:(id)sender;



@end
