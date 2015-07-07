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
#import "CouponDetail20ViewController.h"
#import "CouponDetailViewController.h"
#import "CFunction.h"
#import "CouponListInfoParser.h"

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
//    if (isIOS7up) {
//        frame= CGRectMake(0, 0, 320, ScreenHeight-foottableHeight);
//    }else{
//        frame= CGRectMake(0, 0, 320, ScreenHeight-foottableHeight*2 -10);
//    }
    
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
    }
}

-(void)rightButAction {

    if ([SingletonState sharedStateInstance].userHasLogin) {
        
        BonusTableViewController *ctrl = [[BonusTableViewController alloc] init];
        ctrl.isAimer = YES;
        [self.navigationController pushViewController:ctrl animated:YES];

    }else {

        [self changeToMyaimer];
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
//-------V2
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    
    UIImageView* ivBg = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - (lee1fitAllScreen(295))) / 2, 0, lee1fitAllScreen(295), lee1fitAllScreen(76))];
    [cell.contentView addSubview:ivBg];
    
    UILabel* lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, (lee1fitAllScreen(76) - 18) / 2, lee1fitAllScreen(72), 18)];
    [lblPrice setTextAlignment:NSTextAlignmentCenter];
    [lblPrice setFont:[UIFont boldSystemFontOfSize:15]];
    [lblPrice setTextColor:[UIColor whiteColor]];
    [ivBg addSubview:lblPrice];
    
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(lee1fitAllScreen(72) + 10, 22, lee1fitAllScreen(160), 12)];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:12]];
    [lblTitle setLineBreakMode:NSLineBreakByTruncatingTail];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [ivBg addSubview:lblTitle];
    
    UILabel* lblTime = [[UILabel alloc] initWithFrame:CGRectMake(lee1fitAllScreen(72) + 10, lblTitle.frame.size.height + lblTitle.frame.origin.y + 6, lee1fitAllScreen(160), 12)];
    [lblTime setFont:[UIFont systemFontOfSize:12]];
    [lblTime setLineBreakMode:NSLineBreakByTruncatingTail];
    [lblTime setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [ivBg addSubview:lblTime];
    
    UIImageView* ivState = [[UIImageView alloc] initWithFrame:CGRectMake(ivBg.frame.size.width - (lee1fitAllScreen(63)), 5, 0.5, ivBg.frame.size.height - 10)];
    [ivBg addSubview:ivState];
    
    // NSString* strStatus = @"";
    NSString* type = @"";
    NSString* strPrice = @"";
    NSString* strTitle = @"";
    NSString* strTime = @"";
    UIImage* iBg = nil;
    //优惠券
        NSDictionary *dic = [couponModel.coupon objectAtIndex:indexPath.row];
    NSString *failtime = LegalObject([dic objectForKey:@"end_time"],[NSString class]);
    if ([failtime isEqualToString:@""]) {
        failtime =@"";
    }


        type = LegalObject([dic objectForKey:@"type"],[NSString class]);
        strTitle =  LegalObject([dic objectForKey:@"name"],[NSString class]);
        strPrice = [NSString stringWithFormat:@"￥%@", LegalObject([dic objectForKey:@"amount"],[NSString class])];
        strTime = [NSString stringWithFormat:@"有效期至%@", [failtime substringToIndex:10]];
    
    {
        
        [ivState setBackgroundColor:[UIColor colorWithHexString:@"c6c6c6"]];
        
        UIButton* btnAction = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([type isEqualToString:@"o2o"])
        {
            iBg = [UIImage imageNamed:@"laber_o2o"];
            [btnAction setTitleColor:[UIColor colorWithHexString:@"#fd890a"] forState:UIControlStateNormal];
        }
        else if([type isEqualToString:@"coupon"])
        {
            iBg = [UIImage imageNamed:@"laber_yh"];
            [btnAction setTitleColor:[UIColor colorWithHexString:@"#c8002c"] forState:UIControlStateNormal];
        }
        else if([type isEqualToString:@"gift"])
        {
            iBg = [UIImage imageNamed:@"laber_lpk"];
            [btnAction setTitleColor:[UIColor colorWithHexString:@"#ff6767"] forState:UIControlStateNormal];
        }
        
        [btnAction setTitle:@"领取" forState:UIControlStateNormal];
        [btnAction.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btnAction setFrame:CGRectMake(ivState.frame.origin.x, 0, lee1fitAllScreen(63), ivBg.frame.size.height)];
        [btnAction setTag:indexPath.row];
        [btnAction addTarget:self action:@selector(getCardaction:) forControlEvents:UIControlEventTouchUpInside];
        [ivBg addSubview:btnAction];
    }
    [ivBg setImage:iBg];
    [ivBg setUserInteractionEnabled:YES];
    [lblPrice setText:strPrice];
    [lblTitle setText:strTitle];
    [lblTime setText:strTime];
    CGRect rcTitle = [lblTitle.text boundingRectWithSize:CGSizeMake(lblTitle.frame.size.width, lee1fitAllScreen(62)) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblTitle.font} context:nil];
    NSLog(@"%@", NSStringFromCGRect(rcTitle));
    if (rcTitle.size.height > 15) {
        float originY = (ivBg.frame.size.height - rcTitle.size.height - 6 - 12) / 2;
        [lblTitle setFrame:CGRectMake(lblTitle.frame.origin.x, originY, rcTitle.size.width, rcTitle.size.height)];
        [lblTitle setNumberOfLines:2];
        [lblTime setFrame:CGRectMake(lee1fitAllScreen(72) + 10, lblTitle.frame.size.height + lblTitle.frame.origin.y + 6, lee1fitAllScreen(160), 12)];
    }

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#warning ----- 还没写完  你alloc一个couponinfo传过去也行
    
//    CouponDetailViewController *userCtrl = [[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil];
//    //是不是我自己的优惠券，（自己的能显示二维码，不是自己的没有二维码）
//    userCtrl.isMycard = NO;
//    userCtrl.couponDic = [couponModel.coupon objectAtIndex:[indexPath row]];
//[self.navigationController pushViewController:userCtrl animated:YES];
    

    CouponDetail20ViewController* cdvc = [[CouponDetail20ViewController alloc] init];
    
    id data = [couponModel.coupon objectAtIndex:indexPath.row];
    NSString* type = (LegalObject([data objectForKey:@"type"],[NSString class]));
    
    if ([type isEqualToString:@"o2o"])
    {
        cdvc.dType = kO2O;
    }
    else if([type isEqualToString:@"coupon"])
    {
        cdvc.dType = kCoupon;
        
    }
    else if([type isEqualToString:@"gift"])
    {
        cdvc.dType = kGift;
    }
    
    CouponInfo *info  = [[CouponInfo alloc] init];
    [info setAttribute:(LegalObject([data objectForKey:@"id"],[NSString class])) forKey:@"code"];
    [info setAttribute:(LegalObject([data objectForKey:@"type"],[NSString class])) forKey:@"type"];
    [info setAttribute:(LegalObject([data objectForKey:@"stuatus"],[NSString class])) forKey:@"stuatus"];
    [info setAttribute:(LegalObject([data objectForKey:@"end_time"],[NSString class])) forKey:@"failtime"];
    [info setAttribute:(LegalObject([data objectForKey:@"start_time"],[NSString class])) forKey:@"start_time"];
    [info setAttribute:(LegalObject([data objectForKey:@"name"],[NSString class])) forKey:@"title"];
    [info setAttribute:(LegalObject([data objectForKey:@"amount"],[NSString class])) forKey:@"price"];
    [info setAttribute:(LegalObject([data objectForKey:@"memo"],[NSString class])) forKey:@"desc"];
    [info setAttribute:(LegalObject([data objectForKey:@"couponinfo"],[NSString class])) forKey:@"info"];
    [info setAttribute:(LegalObject([data objectForKey:@"rule"],[NSString class])) forKey:@"url"];

    cdvc.data = info;
    cdvc.isMycard = 1; // 1不是我的优惠券
    [self.navigationController pushViewController:cdvc animated:YES];
}



-(void)getCardaction:(UIButton*)sender
{
    
    if ([SingletonState sharedStateInstance].userHasLogin) {
        
        [mainSer getGetscouponup:[[couponModel.coupon objectAtIndex:sender.tag isArray:nil] objectForKey:@"id"]];
        [SBPublicAlert showMBProgressHUD:@"正在领取···" andWhereView:self.view states:NO];
        
    }else {
        
        [self changeToMyaimer];
    }
    
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return lee1fitAllScreen(76) + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end




//{
//    static NSString *CellIdentifier = @"BonusCellIdentifier";
//    BonusCell *cell = (BonusCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"BonusCell" owner:self options:nil] lastObject];
//        cell.parent = self;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell.buttonUsed setTitle:@"领取" forState:UIControlStateNormal];
//        [cell.buttonUsed setTitle:@"领取" forState:UIControlStateHighlighted];
//    }
//
//    NSDictionary *dic = [couponModel.coupon objectAtIndex:indexPath.row];
//
//    cell.labelTitle.text = LegalObject([dic objectForKey:@"name"],[NSString class]);//@"线上全场通用劵";
//    cell.labelDesc.text = LegalObject([dic objectForKey:@"memo"],[NSString class]);
//    NSString *startTime = LegalObject([dic objectForKey:@"start_time"],[NSString class]);
//    if ([startTime isEqualToString:@""] || !startTime) {
//        startTime = /*@"0000-00-00 00:00:00"*/@"";
//    }
//    NSString *failtime = LegalObject([dic objectForKey:@"end_time"],[NSString class]);
//    if ([failtime isEqualToString:@""] || !startTime) {
//        failtime = /*@"0000-00-00 00:00:00"*/@"";
//    }
//    cell.labelTime.text = [NSString stringWithFormat:@"%@ 至\n%@",[startTime substringToIndex:10],[failtime substringToIndex:10]];
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
//
//    NSComparisonResult compareResult = [dateStr compare:failtime];
//    NSString *status = LegalObject([dic objectForKey:@"status"],[NSString class]);
//
//    if ([status isEqualToString:@"已过期优惠劵"]||[status isEqualToString:@"已过期优惠劵状态"]) {
//            BtnSetImg(cell.btnBonus, @"card_ticket02", @"", @"");
//            cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_out"];
//            cell.buttonUsed.hidden = YES;
//
//        //lee999 已经过期的优惠券不可点击
//        cell.btnBonus.enabled = NO;
//        //end
//
//    } else if ([status isEqualToString:@"已使用"]){//已使用
//        BtnSetImg(cell.btnBonus,@"card_aimer01",@"",@"");
//        cell.buttonUsed.hidden = YES;
//        cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_used"];
//
//    }else if ([status isEqualToString:@"未使用"]) {
//        if(compareResult == NSOrderedAscending || compareResult == NSOrderedSame) {//没有过期
//            [cell.btnBonus setImage:[UIImage imageNamed:@"card_aimer01.png"] forState:UIControlStateNormal];
//            cell.imageViewIsUsed.image = [UIImage imageNamed:@""];
//            cell.buttonUsed.hidden = NO;
//        } else if (compareResult == NSOrderedDescending){//已过期
//            BtnSetImg(cell.btnBonus, @"card_ticket02", @"", @"")
//            cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_out"];
//            cell.buttonUsed.hidden = YES;
//
//            //lee999 已经过期的优惠券不可点击
//            cell.btnBonus.enabled = NO;
//            //end
//        }
//    }
//
//    cell.labelPrice.text = LegalObject([dic objectForKey:@"amount"],[NSString class]);
//
//    //lee增加o2o优惠券的显示
//    NSString *cardtype = @"";
//    cardtype = LegalObject([dic objectForKey:@"type"],[NSString class]);
//    NSLog(@"cardtype---:%@",cardtype);
//    if ([cardtype isEqualToString:@"o2o"]) {
//        [cell.btnBonus setImage:[UIImage imageNamed:@"card_lb03.png"] forState:UIControlStateNormal];
//
//        //lee987 修改020的优惠券展示
//        [cell.buttonUsed setBackgroundImage:[UIImage imageNamed:@"alert-yellow-button.png"] forState:UIControlStateNormal];
//    }
//
//    return cell;
//}



//单元格上按钮的点击事件
//- (void)btnClicked:(UIButton *) btn onCell:(UITableViewCell *)cell
//{
//    NSInteger index = [[mytableView indexPathForCell:cell] row];
//    if (btn.tag == 7) {//领取按钮
//    if ([SingletonState sharedStateInstance].userHasLogin) {
//
//        [mainSer getGetscouponup:[[couponModel.coupon objectAtIndex:index] objectForKey:@"id"]];
//        [SBPublicAlert showMBProgressHUD:@"正在领取···" andWhereView:self.view states:NO];
//
//    }else {
//
//        [self changeToMyaimer];
//
//
////        UIAlertView *arelt = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
////        [arelt show];
//    }
//
//    } else if (btn.tag == 6) {
//
//        CouponDetailViewController *userCtrl = [[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil];
//        //是不是我自己的优惠券，（自己的能显示二维码，不是自己的没有二维码）
//        userCtrl.isMycard = NO;
//        userCtrl.couponDic = [couponModel.coupon objectAtIndex:index];
//        [self.navigationController pushViewController:userCtrl animated:YES];
//    }
//}
