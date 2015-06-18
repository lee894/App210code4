//
//  CouponDetail20ViewController.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15/6/18.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "CouponListInfoParser.h"
#import "CouponDetail20ViewController.h"

@interface CouponDetail20ViewController ()

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
            textColor = [UIColor colorWithHexString:@"ffdc00"];
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
        [lblPrice setText:ci.price];
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
        lblTitle.text = ci.title;
        lblTime.text = [NSString stringWithFormat:@"有效期至%@", ci.failtime];
    }
    else if (fpci)
    {
        lblTitle.text = [NSString stringWithFormat:@"%@共计%@次", fpci.name, fpci.total_times];
        lblTime.text = [NSString stringWithFormat:@"有效期至%@", [[fpci.end_time componentsSeparatedByString:@" "] firstObject]];
    }
    
    UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(12, 85 + vWhite.frame.size.height, SCREEN_WIDTH - 24, 0.5)];
    [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d0d0d0"]];
    [self.view addSubview:lblSep];
    
    CGFloat totalHeight = lblSep.frame.size.height + lblSep.frame.origin.y;
    if (_dType == kO2O) {
        //o2o券 多一段
    }
    
//    UILabel* lblContent = [[UILabel alloc] init];
//    [lblContent setNumberOfLines:0];
//    if (ci) {
//        [lblContent setText:ci.desc];
//    }else if(fpci)
//    {
//        [lblContent setText:lblTitle.text];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
