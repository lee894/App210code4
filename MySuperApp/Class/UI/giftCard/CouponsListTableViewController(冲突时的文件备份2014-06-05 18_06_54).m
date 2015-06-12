//
//  CouponsListTableViewController.m
//  爱慕商场呵


//  Created by zhangfeng on 13-9-25.
//  Copyright (c) 2013年 zan. All rights re360云盘served.
//

#import "CouponsListTableViewController.h"
#import "BonusCardCell.h"
#import "CFunction.h"
#import "MYMacro.h"
#import "BindViewController.h"
#import "BonusCell.h"
#import "ExchangeRecordViewController.h"
#import "CodeBindBindCodeModel.h"
#import "YKCanReuse_webViewController.h"

#import "CouponDetailViewController.h"


@interface CouponsListTableViewController (){
    UITextField *nametextfield;
}

@end

@implementation CouponsListTableViewController
@synthesize isAimer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arrCard = [[NSMutableArray alloc] init];
    _contentArr = [[NSMutableArray alloc] init];
    
    self.title = @"使用优惠券";
    
    [self createBackBtnWithType:0];
    mainSer  = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"绑定" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"绑定" forState:UIControlStateHighlighted];
    
    _tableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-60)];
    //lee999 注释  防止位置偏移
//    if (isIOS7up) {
//        _tableView.frame = CGRectMake(0, 60, 320, self.view.frame.size.height-60);
//    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    nametextfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 12, 210, 25)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initRequest];
}

- (void)initRequest
{
    [self getData];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}




- (void)popBackAnimate:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButAction{
    BindViewController *ctrl = [[BindViewController alloc] initWithNibName:@"BindViewController" bundle:nil];
    [self.navigationController pushViewController:ctrl animated:YES];
}


- (void)Sendcodes
{
    NSRange numRange = NSMakeRange(self.phoneNum.length-12, 11);;
    //发送验证码
    [mainSer getProveMobile:[self.phoneNum substringWithRange:numRange] andType:@"v6card"];
}

//单元格上按钮的点击事件
- (void)btnClicked:(UIButton *) btn onCell:(UITableViewCell *)cell
{
    int index = [[_tableView indexPathForCell:cell] row];
    switch (btn.tag) {
        case 1:
        {
//            [MYCommentAlertView showMessage:@"静态界面，即将推出，敬请期待" target:nil];
//            POBJECT(@"使用规则");
            
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/v6codeinfo";
            webView.strTitle = @"使用规则";
            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
            
        }
            break;
        case 2:
        {
            //POBJECT(@"使用");
            if([self.title isEqualToString:@"积分优惠"])
            {
                //lee999切换到我的爱慕，直接显示到首页
                [self changeToShop];
                
                //积分优惠界面，使用按钮不可用
                //POBJECT(@"直接回首页");
                
//                MillViewController *MillCtrl = [[MillViewController alloc] init];
//                [self.navigationController pushViewController:MillCtrl animated:YES];
//                [MillCtrl viewDidAppear:YES];
            } else {
                
                if (!self.phoneNum) {
                    [SBPublicAlert showMBProgressHUD:@"暂无法使用尊享卡" andWhereView:self.view hiddenTime:0.6];
                    return;
                }
                
                UITextField *textField;
                BlockTextPromptAlertView *alert = [BlockTextPromptAlertView promptWithTitle:@"爱慕提示" message:[NSString stringWithFormat:@"%@\n\n",self.phoneNum] textField:&textField block:^(BlockTextPromptAlertView *alert){
                    
                    return YES;
                }];
                
                alert.delegate = self;
                [alert setDestructiveButtonWithTitle:@"确定" block:^{
                    if (!textField.text || [textField.text isEqualToString:@""]) {
                        [SBPublicAlert showMBProgressHUD:@"请输入验证码" andWhereView:self.view hiddenTime:1.5];
                        return;
                    }
                    [mainSer usev6card:[[self.arrCard objectAtIndex:0] objectForKey:@"card_id"] mobile:[self.phoneNum substringWithRange:NSMakeRange(self.phoneNum.length-12, 11)] checkcode:textField.text];
                }];
                
                [alert setCancelButtonWithTitle:@"取消" block:nil];
                [alert show];
                
                
                NSRange numRange = NSMakeRange(self.phoneNum.length-12, 11);
                
                NSLog(@"[self.phoneNum substringWithRange:numRange]----------%@",[self.phoneNum substringWithRange:numRange]);
            }
        }
            break;
        case 3:
        {
            //POBJECT(@"兑换")
            UIAlertView *arert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"是否确认兑换？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            arert.tag = 137;
            [arert show];
        }
            break;
        case 4:
        {
            //POBJECT(@"积分说明");
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/v6codedescribe";
            webView.strTitle = @"积分说明";
            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        case 5:
        {
            //POBJECT(@"自助兑换记录");
            ExchangeRecordViewController *ctrl = [[ExchangeRecordViewController alloc] init];
            ctrl.cardId = [[self.arrCard objectAtIndex:0] objectForKey:@"card_id"];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 6:
        {
            //POBJECT(@"优惠券详情");
            NSLog(@"----%@",[self.contentArr objectAtIndex:index]);
            
            if (isAimer) {
                CouponDetailViewController *userCtrl = [[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil];
                //是不是我自己的优惠券，（自己的能显示二维码，不是自己的没有二维码）
                userCtrl.isMycard = YES;
                userCtrl.couponDic =[self.contentArr objectAtIndex:index];
                [self.navigationController pushViewController:userCtrl animated:YES];
            }
        }
            break;
        case 7:
        {
            //POBJECT(@"使用优惠券");
            if([self.title isEqualToString:@"积分优惠"])
            {//积分优惠界面，使用按钮不可用
                //POBJECT(@"直接回首页");
                
                //lee999切换到我的爱慕，直接显示到首页
                [self changeToShop];
                
//                MillViewController *MillCtrl = [[MillViewController alloc] init];
//                [self.navigationController pushViewController:MillCtrl animated:YES];
//                [MillCtrl footBarSelectedType:HomeView];

            } else {
                NSDictionary *dic = [self.contentArr objectAtIndex:index];
                self.checkOutViewCtrl.vouId = LegalObject([dic objectForKey:@"code"],[NSString class]);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.arrCard count];
    }else if (section == 1) {
        if (self.isAimer) {
//            return 0;
        }
        return 1;
    }else {
        return [self.contentArr count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //尊享卡
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"BonusCardCellIdentifier";
        BonusCardCell *cell = (BonusCardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BonusCardCell" owner:self options:nil] lastObject];
            cell.parent = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *dic = [self.arrCard objectAtIndex:indexPath.row];
        cell.labelTitle.text = [NSString stringWithFormat:@"%@",LegalObject([dic objectForKey:@"name"],[NSString class])];
        cell.labelId.text = [NSString stringWithFormat:@"NO. %@",[dic objectForKey:@"card_id"]];
        cell.labelBalance.text = [dic objectForKey:@"balance"];
        cell.labelFrozenBalance.text = [NSString stringWithFormat:@"%@",LegalObject([dic objectForKey:@"frozenBalance"],[NSNumber class])];
        cell.labelIntegral.text = [NSString stringWithFormat:@"冻结%@   可用%@",
                                   LegalObject([dic objectForKey:@"frozenScore"],[NSNumber class]),LegalObject([dic objectForKey:@"canUseScore"],[NSNumber class])];;
        
        
        if ([[dic objectForKey:@"canUseScore"] integerValue] < 2000) {
            [cell.btnExchange setEnabled:NO];
        }
        
        return cell;
    } else if(indexPath.section==1) {
        
        UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:nil];
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
//        view.image = [UIImage imageNamed:@"list_one.png"];
        //lee给view设置为圆角，不再使用图片了。 -140512
        [SingletonState setViewRadioSider:view];
        [Cell.contentView addSubview:view];
        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 100, 25)];
        name.backgroundColor = [UIColor clearColor];
        name.font = [UIFont systemFontOfSize:14];
        name.text = @"优惠券号码：";
        [Cell.contentView addSubview:name];

        nametextfield.backgroundColor = [UIColor clearColor];
        nametextfield.delegate = self;
        nametextfield.placeholder = @"请输入您的优惠券号";
        nametextfield.font = [UIFont systemFontOfSize:14];
        nametextfield.keyboardType = UIKeyboardTypeNumberPad;
        [Cell.contentView addSubview:nametextfield];
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(240, 8, 60, 30)];
        [but setTitle:@"绑定" forState:UIControlStateNormal];
        [but setTitle:@"绑定" forState:UIControlStateHighlighted];
        but.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        [but setBackgroundImage:[UIImage imageNamed:@"nav_btn.png"] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:@"nav_btn.png"] forState:UIControlStateHighlighted];
        
        [but addTarget:self action:@selector(btnBindClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [Cell addSubview:but];
        
        return Cell;
    }
    //优惠券
    else if(indexPath.section==2) {
        static NSString *CellIdentifier = @"BonusCellIdentifier";
        BonusCell *cell = (BonusCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        // Configure the cell...
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BonusCell" owner:self options:nil] lastObject];
            cell.parent = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *dic = [self.contentArr objectAtIndex:indexPath.row];
        //    cell.imageCard.image = [UIImage imageNamed:@"card_aimer01"];
        cell.labelTitle.text = LegalObject([dic objectForKey:@"title"],[NSString class]);//@"线上全场通用券";
        cell.labelDesc.text = LegalObject([dic objectForKey:@"desc"],[NSString class]);
        NSString *startTime = LegalObject([dic objectForKey:@"start_time"],[NSString class]);
        if ([startTime isEqualToString:@""] || !startTime) {
            startTime = @"0000-00-00 00:00:00";
        }
        
        NSString *failtime = LegalObject([dic objectForKey:@"failtime"],[NSString class]);
        if ([failtime isEqualToString:@""] || !failtime) {
            failtime = @"0000-00-00 00:00:00";
        }
        cell.labelTime.text = [NSString stringWithFormat:@"%@ 至\n%@",[startTime substringToIndex:10],[failtime substringToIndex:10]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];

        NSComparisonResult compareResult = [dateStr compare:failtime];
        NSString *status = LegalObject([dic objectForKey:@"stuatus"],[NSString class]);
        
        
        if ([status isEqualToString:@"已过期优惠劵"]||[status isEqualToString:@"已过期优惠劵状态"]) {
            
            BtnSetImg(cell.btnBonus, @"card_ticket02.png", @"", @"")
            cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_out.png"];
            cell.buttonUsed.hidden = YES;
        } else if ([status isEqualToString:@"未使用"])
        {
            if(compareResult == NSOrderedAscending || compareResult == NSOrderedSame) {//没有过期
                [cell.btnBonus setImage:[UIImage imageNamed:@"card_aimer01.png"] forState:UIControlStateNormal];
                cell.imageViewIsUsed.image = [UIImage imageNamed:@""];
                cell.buttonUsed.hidden = NO;
            } else if (compareResult == NSOrderedDescending){//已过期
                BtnSetImg(cell.btnBonus, @"card_ticket02.png", @"", @"")
                cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_out.png"];
                cell.buttonUsed.hidden = YES;
            }
        }
        else if ([status isEqualToString:@"已使用"]){//已使用
            BtnSetImg(cell.btnBonus,@"card_aimer01.png",@"",@"");
            cell.buttonUsed.hidden = YES;
            cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_used.png"];
        }
        cell.labelPrice.text = LegalObject([dic objectForKey:@"price"],[NSString class]);
        
        
        //lee增加o2o优惠券的显示
        NSString *cardtype = @"";
        cardtype = LegalObject([dic objectForKey:@"type"],[NSString class]);
        NSLog(@"cardtype---:%@",cardtype);
        if ([cardtype isEqualToString:@"o2o"]) {
            [cell.btnBonus setImage:[UIImage imageNamed:@"card_lb03.png"] forState:UIControlStateNormal];
//            cell.labelTitle.text = @"线上线下通用O2O券";
        }
        
        return cell;
    }
    return nil;
}

//lee999 修改绑定
- (void)btnBindClicked:(UIButton *)sender {
    
    [nametextfield resignFirstResponder];
    if (nametextfield.text.length == 14) {
        self.checkOutViewCtrl.vouId = nametextfield.text;
        
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        [mainSer addCouponcard:nametextfield.text];
        
//        [self popBackAnimate:nil];
    }else {
        [SBPublicAlert showMBProgressHUD:@"请输入正确的优惠劵号码" andWhereView:self.view hiddenTime:1.];
    }
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 270.f;
    }else if(indexPath.section == 1) {
        if (self.isAimer) {
            return 44;    //     return 0;
        }else {
            return 44;
        }
    }else {
        return 144.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if ([self.contentArr count]) {
            return 30.0f;
        }
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (![self.contentArr count]) {
            return nil;
        }
        
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 21)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15.0f];
    label.text = @"优惠券（点击优惠券可查看使用规则）";
    [view addSubview:label];
    
    return view;
}



#pragma mark 刷新的代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [nametextfield resignFirstResponder];
    
    NSInteger returnKey = [_tableView tableViewDidEndDragging];
    if (returnKey != k_RETURN_DO_NOTHING) {
        NSString * key = [NSString stringWithFormat:@"%d", returnKey];
        [self updateThread:key];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [nametextfield resignFirstResponder];

    NSInteger returnKey = [_tableView tableViewDidDragging];
    if (returnKey == k_RETURN_LOADMORE) {
        NSString * key = [NSString stringWithFormat:@"%d", returnKey];
        [self updateThread:key];
    }
}

#pragma mark 刷新
-(void)getData
{
        current = 1;
        NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
        [mainSer getCouponcardListWithPage:PageCurr andPer_page:Per_Page];
}

#pragma mark 加载
- (void)nextPage
{
    current ++;
    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
    
        [mainSer getCouponcardListWithPage:PageCurr andPer_page:Per_Page];
}

- (void)updateTableView
{
    BOOL status = NO;
    if (self.couponcardListModel.currentPage < self.couponcardListModel.pageCount) {//小于
        status = YES;
    }
    _tableView.isCloseFooter = !status;
    
    if (status) {//还有数据
        // 一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [_tableView reloadData:NO];
    } else {//没有数据
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [_tableView reloadData:YES];
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSLog(@"-----%@",textField.text);
    return YES;
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
    BaseModel *model = (BaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_CoupncardList_Tag:
        {
            if (!model.errorMessage) {
                
                self.couponcardListModel = (CouponcardListCouponcardListModel *)model;
                _labelInfo.text = [NSString stringWithFormat:@"%@%d张会员卡  %d张优惠券",([self.title  isEqualToString:@"使用优惠券"] ?  @"本单可用" : @"我有"),self.couponcardListModel.cards_count,self.couponcardListModel.couponcard_count];
                
                if (self.couponcardListModel.recordCount == 0) {
                    [SBPublicAlert showMBProgressHUD:@"您还没有尊享卡或优惠券可用" andWhereView:self.view hiddenTime:1.];
                    return;
                }
                if (current == 1) {
                    [self.arrCard removeAllObjects];
                    [self.arrCard addObjectsFromArray:(NSMutableArray *)self.couponcardListModel.checkoutCards];
                    [self.contentArr removeAllObjects];
                    [self.contentArr addObjectsFromArray:(NSMutableArray *)self.couponcardListModel.checkoutCouponcard];
                    
                }else {
                    
                    [self.contentArr addObjectsFromArray:(NSMutableArray *)self.couponcardListModel.checkoutCouponcard];
                }
                
                [self updateTableView];
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
                [self updateTableView];
            }
        }
            break;
        case Http_Sendcodes_Tag:
        {
            if (!model.errorMessage) {
                
                [SBPublicAlert showMBProgressHUDTextOnly:((CodeBindBindCodeModel *)model).content andWhereView:self.view hiddenTime:3.0];
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
            }
        }
            break;
        case Http_usev6card_Tag:
        {
            if (!model.errorMessage) {
                //使用成功
                self.checkOutViewCtrl.v6useCardId = [((Usev6cardusev6cardModel *)model) usev6cardID];
                [self popBackAnimate:nil];//回到结算中心
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
            }
        }
            break;
        case Http_exchangecoupon_Tag:
        {
            if (!model.errorMessage) {
                //兑换成功
                [SBPublicAlert showMBProgressHUD:@"兑换成功" andWhereView:self.view hiddenTime:1.];
                [self performSelector:@selector(getData) withObject:nil afterDelay:1.2];
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
            }
        }
            break;
            //lee999 新增判断
        case Http_addCouponcard_Tag:
        {
            if (!model.errorMessage) {
                nametextfield.text = @"";
                ChengeMyInfo *bangModel = (ChengeMyInfo *)model;
                [self getData];
                [MYCommentAlertView showMessage:bangModel.res target:nil];
            } else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }//end
            
        case 10086:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.];
            break;
        }
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 137) {
        if (buttonIndex==1) {
            [SBPublicAlert showMBProgressHUD:@"正在兑换···" andWhereView:self.view states:NO];
            [mainSer exchangecoupon:[[self.arrCard objectAtIndex:0] objectForKey:@"card_id"]];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
