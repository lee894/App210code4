//
//  GetCouponTableViewController.m
//  爱慕商场
//
//  Created by malan on 14-9-27.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "GetCouponTableViewController.h"
#import "BonusCell.h"
#import "Coupon.h"
#import "BonusTableViewController.h"
#import "MyAimerViewController.h"
#import "CouponDetailViewController.h"

#import "CFunction.h"

@interface GetCouponTableViewController ()
{
    NSString *nowDate;//当前时间

}
@end

@implementation GetCouponTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"领取优惠券";

    UITextView* labelUserDec = [[UITextView alloc] init];
    labelUserDec.backgroundColor = [UIColor clearColor];
    [labelUserDec setFrame:CGRectMake(0, 0, 320, 30)];
    [labelUserDec setTextColor:[UIColor blackColor]];
    labelUserDec.font = [UIFont systemFontOfSize:16.];
    labelUserDec.editable = NO;
    [labelUserDec setText:@"优惠券（点击优惠券可查看使用规则）"];
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    //创建返回按钮
    [self createBackBtnWithType:0];
    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"查优惠券" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"查优惠券" forState:UIControlStateHighlighted];
    
    
    CGRect frame;
    frame= CGRectMake(0, 0, 320, ScreenHeight-foottableHeight);
    if (isIOS7up) {
        frame= CGRectMake(0, 0, 320, ScreenHeight-foottableHeight);
    }else{
        frame= CGRectMake(0, 0, 320, ScreenHeight-foottableHeight*2 -10);
    }
    
    mytableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    mytableView.backgroundView = nil;
    mytableView.backgroundColor = [UIColor clearColor];
    mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mytableView];
    [mytableView setTableHeaderView:labelUserDec];
    
    

    [self NewHiddenTableBarwithAnimated:YES];
    
    
    //lee新增获取当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    nowDate = [formatter stringFromDate:[NSDate date]];
    


    
    [self getList];
    
}


- (void)getList{
    [mainSer getGetscoupon:self.couponed];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        
        [self changeToMyaimer];
        
//        MyAimerViewController* checkOrder = [[MyAimerViewController alloc] initWithNibName:@"MyAimerViewController" bundle:nil];
//        checkOrder.isPushBack = YES;
//        [self.navigationController pushViewController:checkOrder animated:YES];
    }
}

//单元格上按钮的点击事件
- (void)btnClicked:(UIButton *) btn onCell:(UITableViewCell *)cell
{
    int index = [[mytableView indexPathForCell:cell] row];
    if (btn.tag == 7) {//领取按钮
    if ([SingletonState sharedStateInstance].userHasLogin) {
           
        [mainSer getGetscouponup:[[couponModel.coupon objectAtIndex:index] objectForKey:@"id"]];
        [SBPublicAlert showMBProgressHUD:@"正在领取···" andWhereView:self.view states:NO];
        
    }else {

        [self changeToMyaimer];

        
//        UIAlertView *arelt = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
//        [arelt show];
    }

    } else if (btn.tag == 6) {
        
        CouponDetailViewController *userCtrl = [[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil];
        //是不是我自己的优惠券，（自己的能显示二维码，不是自己的没有二维码）
        userCtrl.isMycard = NO;
        userCtrl.couponDic = [couponModel.coupon objectAtIndex:index];
        [self.navigationController pushViewController:userCtrl animated:YES];
    }
}

-(void)rightButAction {

    if ([SingletonState sharedStateInstance].userHasLogin) {
        
        BonusTableViewController *ctrl = [[BonusTableViewController alloc] init];
        ctrl.isAimer = YES;
        [self.navigationController pushViewController:ctrl animated:YES];

    }else {

        [self changeToMyaimer];

        
//        UIAlertView *arelt = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
//        [arelt show];
        
//        MyAimerViewController* checkOrder = [[MyAimerViewController alloc] initWithNibName:@"MyAimerViewController" bundle:nil];
//        checkOrder.isPush = YES;
//        [self.navigationController pushViewController:checkOrder animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [couponModel.coupon count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BonusCellIdentifier";
    BonusCell *cell = (BonusCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BonusCell" owner:self options:nil] lastObject];
        cell.parent = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.buttonUsed setTitle:@"领取" forState:UIControlStateNormal];
        [cell.buttonUsed setTitle:@"领取" forState:UIControlStateHighlighted];
    }

    NSDictionary *dic = [couponModel.coupon objectAtIndex:indexPath.row];

    cell.labelTitle.text = LegalObject([dic objectForKey:@"name"],[NSString class]);//@"线上全场通用劵";
    cell.labelDesc.text = LegalObject([dic objectForKey:@"memo"],[NSString class]);
    NSString *startTime = LegalObject([dic objectForKey:@"start_time"],[NSString class]);
    if ([startTime isEqualToString:@""] || !startTime) {
        startTime = /*@"0000-00-00 00:00:00"*/@"";
    }
    NSString *failtime = LegalObject([dic objectForKey:@"end_time"],[NSString class]);
    if ([failtime isEqualToString:@""] || !startTime) {
        failtime = /*@"0000-00-00 00:00:00"*/@"";
    }
    cell.labelTime.text = [NSString stringWithFormat:@"%@ 至\n%@",[startTime substringToIndex:10],[failtime substringToIndex:10]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
 
    NSComparisonResult compareResult = [dateStr compare:failtime];
    NSString *status = LegalObject([dic objectForKey:@"status"],[NSString class]);
    
    if ([status isEqualToString:@"已过期优惠劵"]||[status isEqualToString:@"已过期优惠劵状态"]) {
            BtnSetImg(cell.btnBonus, @"card_ticket02", @"", @"");
            cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_out"];
            cell.buttonUsed.hidden = YES;
        
        //lee999 已经过期的优惠券不可点击
        cell.btnBonus.enabled = NO;
        //end
        
    } else if ([status isEqualToString:@"已使用"]){//已使用
        BtnSetImg(cell.btnBonus,@"card_aimer01",@"",@"");
        cell.buttonUsed.hidden = YES;
        cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_used"];
        
    }else if ([status isEqualToString:@"未使用"]) {
        if(compareResult == NSOrderedAscending || compareResult == NSOrderedSame) {//没有过期
            [cell.btnBonus setImage:[UIImage imageNamed:@"card_aimer01.png"] forState:UIControlStateNormal];
            cell.imageViewIsUsed.image = [UIImage imageNamed:@""];
            cell.buttonUsed.hidden = NO;
        } else if (compareResult == NSOrderedDescending){//已过期
            BtnSetImg(cell.btnBonus, @"card_ticket02", @"", @"")
            cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_out"];
            cell.buttonUsed.hidden = YES;
            
            //lee999 已经过期的优惠券不可点击
            cell.btnBonus.enabled = NO;
            //end
        }
    }
    
    cell.labelPrice.text = LegalObject([dic objectForKey:@"amount"],[NSString class]);
    
    //lee增加o2o优惠券的显示
    NSString *cardtype = @"";
    cardtype = LegalObject([dic objectForKey:@"type"],[NSString class]);
    NSLog(@"cardtype---:%@",cardtype);
    if ([cardtype isEqualToString:@"o2o"]) {
        [cell.btnBonus setImage:[UIImage imageNamed:@"card_lb03.png"] forState:UIControlStateNormal];
        
        //lee987 修改020的优惠券展示
        [cell.buttonUsed setBackgroundImage:[UIImage imageNamed:@"alert-yellow-button.png"] forState:UIControlStateNormal];
        
//        cell.labelTitle.text = @"线上线下通用O2O券";
        
//        啊实打实大师的
        
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 134.0f;
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
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_Getscoupon_Tag:
        {
            
            if (!model.errorMessage) {
                
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                couponModel = (GetscouponModel *)model;
                [mytableView reloadData];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view states:NO];
            }

        }
            break;
        case Http_Getscouponup_Tag:
        {
            if (!model.errorMessage) {
                
                CounponupGetCounponupModel *getCounModel = (CounponupGetCounponupModel *)model;
                
                [SBPublicAlert showMBProgressHUD:getCounModel.getmessage andWhereView:self.view hiddenTime:1.];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view states:NO];
            }
        }
            break;
        default:
            
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
            break;
    }
    
}

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
}


@end
