//
//  V6CardVC.m
//  MyAimerApp
//
//  Created by yanglee on 15/7/6.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "V6CardVC.h"
#import "BonusCardCell.h"
#import "CFunction.h"
#import "MYMacro.h"
#import "MyButton.h"
#import "BindViewController.h"
#import "BonusCell.h"
#import "ExchangeRecordViewController.h"
#import "CodeBindBindCodeModel.h"
#import "YKCanReuse_webViewController.h"
#import "CouponListInfoParser.h"
#import "CouponDetailViewController.h"
#import "CouponDetail20ViewController.h"
#import "ManageGiftViewController.h"


@interface V6CardVC ()
{
    NSString *    _strType;
}

@property (nonatomic, retain) CouponListInfo* cli;


@end

@implementation V6CardVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的会员卡";
    [self NewHiddenTableBarwithAnimated:YES];
    [self createBackBtnWithType:0];
    
    _strType = @"v6card";

    
    mainSer  = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    [self getData];
    
    
    [self.view addSubview:self.mytableView];
}


-(PullToRefreshTableView *)mytableView
{
    if (_mytableView) {
        return _mytableView;
    }
    _mytableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.backgroundView = nil;
    _mytableView.backgroundColor = [UIColor clearColor];
    _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mytableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    return _mytableView;
}



-(void)getData
{
    current = 1;
    NSString *PageCurr = [[NSNumber numberWithInteger:current] description];
    [mainSer getCouponcardList20WithPage:PageCurr andPer_page:@"10" andType:@"v6card"];
}


#pragma mark 加载
- (void)nextPage
{
    current ++;
    NSString *PageCurr = [[NSNumber numberWithInteger:current] description];
    //    [mainSer getCouponcardListWithPage:PageCurr andPer_page:Per_Page];
    [mainSer getCouponcardList20WithPage:PageCurr andPer_page:Per_Page andType:_strType];
}

- (void)updateTableView
{
    BOOL status = NO;
    if (_cli.current_page < _cli.page_count) {//小于
        status = YES;
    }
    _mytableView.isCloseFooter = !status;
    
    if (status) {//还有数据
        // 一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [_mytableView reloadData:NO];
    } else {//没有数据
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [_mytableView reloadData:YES];
    }
}
- (void)updateThread:(NSString *)returnKey{
    switch ([returnKey intValue]) {
        case k_RETURN_REFRESH:
            [self getData];
            break;
        case k_RETURN_LOADMORE:
            [self nextPage];
            break;
        default:
            break;
    }
}



#pragma mark -- NETrequest delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    [SBPublicAlert hideMBprogressHUD:self.view];
    if(![amodel isKindOfClass:[LBaseModel class]])
    {
        switch ((NSUInteger)aHandle) {
            case Http_CouponList20_Tag:
            {
                _cli = [[[CouponListInfoParser alloc] init] parseCouponListInfo:amodel];
                
                if (current == 1) {
                    [self.contentArr removeAllObjects];
                    [self.contentArr addObjectsFromArray:_cli.v6cards];
                }else {
                    [self.contentArr addObjectsFromArray:_cli.v6cards];
                }
                
                [self updateTableView];
                
            }
                break;
                
            default:
                break;
        }
        return;
    }
    
//    LBaseModel *model = (LBaseModel *)amodel;
    
//    switch (model.requestTag) {
////        case Http_CoupncardList_Tag:
////        {
////            if (!model.errorMessage) {
////                
////                self.couponcardListModel = (CouponcardListCouponcardListModel *)model;
////                _labelInfo.text = [NSString stringWithFormat:@"%@%d张会员卡  %ld张优惠券",([self.title  isEqualToString:@"使用优惠券"] ?  @"本单可用" : @"我有"),self.couponcardListModel.cards_count,(long)self.couponcardListModel.couponcard_count];
////                
////                if (self.couponcardListModel.recordCount == 0) {
////                    [SBPublicAlert showMBProgressHUD:@"您还没有尊享卡或优惠券可用" andWhereView:self.view hiddenTime:1.];
////                    return;
////                }
////                if (current == 1) {
////                    [self.arrCard removeAllObjects];
////                    [self.arrCard addObjectsFromArray:(NSMutableArray *)self.couponcardListModel.checkoutCards];
////                    [self.contentArr removeAllObjects];
////                    [self.contentArr addObjectsFromArray:(NSMutableArray *)self.couponcardListModel.checkoutCouponcard];
////                    
////                }else {
////                    
////                    [self.contentArr addObjectsFromArray:(NSMutableArray *)self.couponcardListModel.checkoutCouponcard];
////                }
////                
////                [self updateTableView];
////            }else {
////                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
////                [self updateTableView];
////            }
////        }
////            break;
//        case Http_Sendcodes_Tag:
//        {
//            if (!model.errorMessage) {
//                
//                [SBPublicAlert showMBProgressHUDTextOnly:((CodeBindBindCodeModel *)model).content andWhereView:self.view hiddenTime:3.0];
//                
//            }else{
//                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
//            }
//        }
//            break;
//        case Http_usev6card_Tag:
//        {
//            if (!model.errorMessage) {
//                //使用成功
////                self.checkOutViewCtrl.usev6useCardId = [((Usev6cardusev6cardModel *)model) usev6cardID];
////                [self popBackAnimate:nil];//回到结算中心
//            }else{
//                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
//            }
//        }
//            break;
//        case Http_exchangecoupon_Tag:
//        {
//            if (!model.errorMessage) {
//                //兑换成功
//                [SBPublicAlert showMBProgressHUD:@"兑换成功" andWhereView:self.view hiddenTime:1.];
//                [self performSelector:@selector(getData) withObject:nil afterDelay:1.2];
//                
//            }else{
//                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
//            }
//        }
//            break;
//            //lee999 新增判断
//        case Http_addCouponcard_Tag:
//        {
//            if (!model.errorMessage) {
//                nametextfield.text = @"";
//                ChengeMyInfo *bangModel = (ChengeMyInfo *)model;
//                [self getData];
//                [MYCommentAlertView showMessage:bangModel.res target:nil];
//            } else {
//                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
//            }
//        }//end
//            
//        case 10086:
//        {
//            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
//            break;
//        }
//            
//        default:
//            break;
//    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
