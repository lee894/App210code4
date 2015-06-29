//
//  CouponsListTableViewController.m
//  爱慕商场呵
//  Created by malan on 14-9-25.
//  Copyright (c) 2014年 zan. All rights re360云盘served.
//

#import "SelectCouponTableViewController.h"
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


@interface SelectCouponTableViewController (){
    UIButton* selectedBtn;
    UIView* vCouponMenu;
    NSInteger nSelectedIndexInMenu;
}
@property (nonatomic, retain) UIView* vToolbar;
@property (nonatomic, retain) NSString* strType;
@property (nonatomic, retain) CouponListInfo* cli;
@end

@implementation SelectCouponTableViewController
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的优惠券";
    
    [self NewHiddenTableBarwithAnimated:YES];
    [self createBackBtnWithType:0];
    
    
    [self.view addSubview:self.vToolbar];
    [self.view addSubview:self.mytableView];
    [self.view addConstraints:[self viewConstraints]];
    
//    [self.contentArr removeAllObjects];
//    
//    if (self.couponcardListModel.checkoutCouponcard && [self.couponcardListModel.checkoutCouponcard count]) {
//        [self.contentArr addObjectsFromArray:(NSMutableArray *)self.couponcardListModel.checkoutCouponcard];
//    }
    
    
//    UIImageView* ivBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yhq_laber_bg"]];
//    [ivBG setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, lee1fitAllScreen(35))];
//    [_vToolbar addSubview:ivBG];
//    
//    UIButton* btnShowCouponMenu = [UIButton buttonWithType:UIButtonTypeCustom];
//    CGFloat btnWidth = ([UIScreen mainScreen].bounds.size.width - 4) / 3;
//    [btnShowCouponMenu setFrame:CGRectMake(0, 0, btnWidth, lee1fitAllScreen(35))];
//    [btnShowCouponMenu addTarget:self action:@selector(showCouponMenu:) forControlEvents:UIControlEventTouchUpInside];
//    [btnShowCouponMenu setTitle:@"优惠券" forState:UIControlStateNormal];
//    [btnShowCouponMenu setTitle:@"优惠券" forState:UIControlStateSelected];
//    [btnShowCouponMenu setTitleColor:[UIColor colorWithHexString:@"#6c6c6c"] forState:UIControlStateNormal];
//    [btnShowCouponMenu setTitleColor:[UIColor colorWithHexString:@"#181818"] forState:UIControlStateSelected];
//    [btnShowCouponMenu setSelected:YES];
//    [btnShowCouponMenu setExclusiveTouch:NO];
//    [_vToolbar addSubview:btnShowCouponMenu];
//    selectedBtn = btnShowCouponMenu;
//    nSelectedIndexInMenu = 10001;
//    
//    UIButton* btnToFreeShippingCard = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnToFreeShippingCard setFrame:CGRectMake(btnShowCouponMenu.frame.size.width + btnShowCouponMenu.frame.origin.x + 2, 0, btnWidth, lee1fitAllScreen(35))];
//    [btnToFreeShippingCard addTarget:self action:@selector(toFreeShippingCard:) forControlEvents:UIControlEventTouchUpInside];
//    [btnToFreeShippingCard setTitle:@"包邮卡" forState:UIControlStateNormal];
//    [btnToFreeShippingCard setTitle:@"包邮卡" forState:UIControlStateSelected];
//    [btnToFreeShippingCard setTitleColor:[UIColor colorWithHexString:@"#6c6c6c"] forState:UIControlStateNormal];
//    [btnToFreeShippingCard setTitleColor:[UIColor colorWithHexString:@"#181818"] forState:UIControlStateSelected];
//    [btnToFreeShippingCard setExclusiveTouch:NO];
//    [_vToolbar addSubview:btnToFreeShippingCard];
//    
//    UIButton* btnToGiftCard = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnToGiftCard setFrame:CGRectMake(btnToFreeShippingCard.frame.size.width + btnToFreeShippingCard.frame.origin.x + 2, 0, btnWidth, lee1fitAllScreen(35))];
//    [btnToGiftCard addTarget:self action:@selector(toGiftCard:) forControlEvents:UIControlEventTouchUpInside];
//    [btnToGiftCard setTitle:@"礼包卡" forState:UIControlStateNormal];
//    [btnToGiftCard setTitle:@"礼包卡" forState:UIControlStateSelected];
//    [btnToGiftCard setTitleColor:[UIColor colorWithHexString:@"#6c6c6c"] forState:UIControlStateNormal];
//    [btnToGiftCard setTitleColor:[UIColor colorWithHexString:@"#181818"] forState:UIControlStateSelected];
//    [btnToGiftCard setExclusiveTouch:NO];
//    [_vToolbar addSubview:btnToGiftCard];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
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
    NSInteger index = [[_mytableView indexPathForCell:cell] row];
    switch (btn.tag) {
        case 1:
        {
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://m.aimer.com.cn/method/v6codeinfo";
            webView.strTitle = @"使用规则";
            //            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
            
        }
            break;
        case 2:
        {
            //POBJECT(@"使用");
            if([self.title isEqualToString:@"积分优惠"])
            {
                //lee999切换到我的爱慕，直接显示到首页
                [self changetableBarto:0];
                
                //积分优惠界面，使用按钮不可用
                //POBJECT(@"直接回首页");
            } else {
                
                if (!self.phoneNum) {
                    [SBPublicAlert showMBProgressHUD:@"暂无法使用尊享卡" andWhereView:self.view hiddenTime:0.6];
                    return;
                }
                
                UITextField *textFieldalert;
                BlockTextPromptAlertView *alert = [BlockTextPromptAlertView promptWithTitle:@"爱慕提示" message:[NSString stringWithFormat:@"%@\n\n",self.phoneNum] textField:&textFieldalert block:^(BlockTextPromptAlertView *alert){
                    
                    return YES;
                }];
                
                alert.delegate = self;
                [alert setDestructiveButtonWithTitle:@"确定" block:^{
                    if (!textFieldalert.text || [textFieldalert.text isEqualToString:@""]) {
                        [SBPublicAlert showMBProgressHUD:@"请输入验证码" andWhereView:self.view hiddenTime:1.5];
                        return;
                    }
                    //[mainSer usev6card:[[self.arrCard objectAtIndex:0 isArray:nil] objectForKey:@"card_id"] mobile:[self.phoneNum substringWithRange:NSMakeRange(self.phoneNum.length-12, 11)] checkcode:textFieldalert.text];
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
            //            webView.webViewFrame = self.view.frame;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        case 5:
        {
            //POBJECT(@"自助兑换记录");
            ExchangeRecordViewController *ctrl = [[ExchangeRecordViewController alloc] init];
            //ctrl.cardId = [[self.arrCard objectAtIndex:0 isArray:nil] objectForKey:@"card_id"];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 6:
        {
            //POBJECT(@"优惠券详情");
            NSLog(@"----%@",[self.contentArr objectAtIndex:index isArray:nil]);
            
//            if (isAimer) {
//                CouponDetailViewController *userCtrl = [[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil];
//                //是不是我自己的优惠券，（自己的能显示二维码，不是自己的没有二维码）
//                userCtrl.isMycard = YES;
//                userCtrl.couponDic =[self.contentArr objectAtIndex:index isArray:nil];
//                [self.navigationController pushViewController:userCtrl animated:YES];
//            }
        }
            break;
        case 7:
        {
            //POBJECT(@"使用优惠券");   cell上的点击使用---------
            if([self.title isEqualToString:@"积分优惠"])
            {//积分优惠界面，使用按钮不可用
                
                //lee987 增加兑换礼品卡
                NSDictionary *dic = [self.contentArr objectAtIndex:index isArray:nil];
                NSString* cardType = [[dic objectForKey:@"type" isDictionary:nil] description];
                if ([cardType isEqualToString:@"gift"]) {
                    YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
                    webView.strURL  = [[dic objectForKey:@"url" isDictionary:nil] description];
                    webView.strTitle = [[dic objectForKey:@"title" isDictionary:nil] description];
                    [self.navigationController pushViewController:webView animated:YES];
                    
                }else{
                    //                    lee999切换到我的爱慕，直接显示到首页
                    [self changeToShop];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                }
            } else {
                NSDictionary *dic = [self.contentArr objectAtIndex:index isArray:nil];
//                self.checkOutViewCtrl.vouId = LegalObject([dic objectForKey:@"code"],[NSString class]);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return [self.arrCard count];
//    }else if (section == 1) {
//        if (self.isAimer) {
//        }
//        return 1;
//    }else {
        return [self.contentArr count];
//    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"----title:%@------",self.title);
    
    //尊享卡
//    if (indexPath.section==0) {
//        static NSString *CellIdentifier = @"BonusCardCellIdentifier";
//        BonusCardCell *cell = (BonusCardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"BonusCardCell" owner:self options:nil] lastObject];
//            cell.parent = self;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        NSDictionary *dic = [self.arrCard objectAtIndex:indexPath.row isArray:nil];
//        cell.labelTitle.text = [NSString stringWithFormat:@"%@",LegalObject([dic objectForKey:@"name"],[NSString class])];
//        cell.labelId.text = [NSString stringWithFormat:@"NO. %@",[dic objectForKey:@"card_id"]];
//        cell.labelBalance.text = [dic objectForKey:@"balance"];
//        cell.labelFrozenBalance.text = [NSString stringWithFormat:@"%@",LegalObject([dic objectForKey:@"frozenBalance"],[NSNumber class])];
//        cell.labelIntegral.text = [NSString stringWithFormat:@"冻结%@   可用%@",
//                                   LegalObject([dic objectForKey:@"frozenScore"],[NSNumber class]),LegalObject([dic objectForKey:@"canUseScore"],[NSNumber class])];;
//        
//        
//        if ([[dic objectForKey:@"canUseScore"] integerValue] < 2000) {
//            [cell.btnExchange setEnabled:NO];
//        }
//        
//        return cell;
//    } else if(indexPath.section==1) {
//    
//        UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                                       reuseIdentifier:nil];
//        //        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
//        //        [SingletonState setViewRadioSider:view];
//        //        [Cell.contentView addSubview:view];
//        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [Cell setBackgroundColor:[UIColor clearColor]];
//        //        UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 25)];
//        //        name.backgroundColor = [UIColor clearColor];
//        //        name.font = [UIFont systemFontOfSize:14];
//        //        name.text = @"优惠券号码：";
//        //        [Cell.contentView addSubview:name];
//        
//        nametextfield = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, lee1fitAllScreen(215), lee1fitAllScreen(44))];
//        nametextfield.delegate = self;
//        nametextfield.backgroundColor = [UIColor whiteColor];
//        nametextfield.placeholder = @"请输入您的优惠券号";
//        nametextfield.font = [UIFont systemFontOfSize:17];
//        nametextfield.keyboardType = UIKeyboardTypeNumberPad;
//        [Cell.contentView addSubview:nametextfield];
//        [nametextfield.layer setBorderColor:[UIColor colorWithHexString:@"#d0d0d0"].CGColor];
//        [nametextfield.layer setBorderWidth:0.5];
//        [nametextfield.layer setCornerRadius:2];
//        [nametextfield.layer setMasksToBounds:YES];
//        [nametextfield setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, lee1fitAllScreen(17), nametextfield.frame.size.height)]];
//        [nametextfield setLeftViewMode:UITextFieldViewModeAlways];
//        
//        MyButton *but = [MyButton buttonWithType:UIButtonTypeCustom];
//        [but setFrame:CGRectMake(nametextfield.frame.origin.x + nametextfield.frame.size.width + 10, 15, lee1fitAllScreen(65), lee1fitAllScreen(44))];
//        [but setTitle:@"绑定" forState:UIControlStateNormal];
//        [but setTitle:@"绑定" forState:UIControlStateHighlighted];
//        but.titleLabel.font = [UIFont systemFontOfSize:17.0];
//        
//        //lee999recode
//        if ([self.title isEqualToString:@"使用优惠券"]) {
//            [but setTitle:@"使用" forState:UIControlStateNormal];
//            [but setTitle:@"使用" forState:UIControlStateHighlighted];
//            
//            [but addTarget:self action:@selector(UserCouns:) forControlEvents:UIControlEventTouchUpInside];
//            
//        }else{
//            [but addTarget:self action:@selector(btnBindClicked:) forControlEvents:UIControlEventTouchUpInside];
//        }
//        [but setBackgroundImage:[UIImage imageNamed:@"yhq_btn_normal"] forState:UIControlStateNormal];
//        [but setImage:[UIImage imageNamed:@"yhq_btn_hover"] forState:UIControlStateHighlighted];
//        
//        [Cell addSubview:but];
//        
//        UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, but.frame.size.height + but.frame.origin.y + 15, [UIScreen mainScreen].bounds.size.width, 0.5)];
//        [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d0d0d0"]];
//        [Cell addSubview:lblSep];
//        
//        UILabel* lblContent = [[UILabel alloc] initWithFrame:CGRectMake(12.5, lblSep.frame.size.height + lblSep.frame.origin.y + 15, [UIScreen mainScreen].bounds.size.width - 25, 12)];
//        [lblContent setText:@"点击优惠券可查看使用规则"];
//        [lblContent setFont:[UIFont systemFontOfSize:12]];
//        [lblContent setTextColor:[UIColor colorWithHexString:@"#666666"]];
//        [Cell addSubview:lblContent];
//        
//        return Cell;
//    }
    //优惠券
//    else if(indexPath.section==2)
    
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
        
        NSString* strStatus = @"";
        NSString* type = @"";
        NSString* strPrice = @"";
        NSString* strTitle = @"";
        NSString* strTime = @"";
        UIImage* iBg = nil;
        NSDictionary* data = [self.contentArr objectAtIndex:indexPath.row isArray:nil];
        
        if (self.selectType == 1) {
            //优惠券
            
            type = [data objectForKey:@"type" isDictionary:nil];
            strTitle = [data objectForKey:@"title" isDictionary:nil];
            strPrice = [NSString stringWithFormat:@"￥%@", [data objectForKey:@"price" isDictionary:nil]];
            strTime = [NSString stringWithFormat:@"有效期至%@", [data objectForKey:@"time" isDictionary:nil]];
            
        }else if (self.selectType == 2){
        //电子券
        
        }
        
        else if (self.selectType == 3)
        {
        //包邮卡
            
           // strStatus = ((FreePostCardInfo*)data).status;
            strTitle = [NSString stringWithFormat:@"%@  共计%@次", [data objectForKey:@"name" isDictionary:nil],[data objectForKey:@"total_times" isDictionary:nil]];
            strPrice = [[NSNumber numberWithInteger:[[data objectForKey:@"total_times" isDictionary:nil] integerValue] - [[data objectForKey:@"used_times" isDictionary:nil] integerValue]] description];
            iBg = [UIImage imageNamed:@"laber_byk"];
            strTime = [NSString stringWithFormat:@"有效期至%@", [data objectForKey:@"end_time" isDictionary:nil]];
        }
        
        {
            
            [ivState setBackgroundColor:[UIColor colorWithHexString:@"c6c6c6"]];
            UIButton* btnAction = [UIButton buttonWithType:UIButtonTypeCustom];
            if ([type isEqualToString:@"o2o"])
            {
                iBg = [UIImage imageNamed:@"laber_o2o"];
            }
            else if([type isEqualToString:@"coupon"])
            {
                iBg = [UIImage imageNamed:@"laber_yh"];
            }
            else if([type isEqualToString:@"gift"])
            {
                iBg = [UIImage imageNamed:@"laber_lpk"];
            }
            [btnAction addTarget:self action:@selector(toHome:) forControlEvents:UIControlEventTouchUpInside];
            [btnAction setTitle:@"使用" forState:UIControlStateNormal];
            [btnAction setTitleColor:[UIColor colorWithHexString:@"#c8002c"] forState:UIControlStateNormal];
            [btnAction.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btnAction setFrame:CGRectMake(ivState.frame.origin.x, 0, lee1fitAllScreen(63), ivBg.frame.size.height)];
            [ivBg addSubview:btnAction];
        }

        
        [ivBg setImage:iBg];
        [lblPrice setText:strPrice];
        [lblTitle setText:strTitle];
        [lblTime setText:strTime];
        CGRect rcTitle = [lblTitle.text boundingRectWithSize:CGSizeMake(lblTitle.frame.size.width, lee1fitAllScreen(62)) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblTitle.font} context:nil];
        if (rcTitle.size.height > 15) {
            float originY = (ivBg.frame.size.height - rcTitle.size.height - 6 - 12) / 2;
            [lblTitle setFrame:CGRectMake(lblTitle.frame.origin.x, originY, rcTitle.size.width, rcTitle.size.height)];
            [lblTitle setNumberOfLines:2];
            [lblTime setFrame:CGRectMake(lee1fitAllScreen(72) + 10, lblTitle.frame.size.height + lblTitle.frame.origin.y + 6, lee1fitAllScreen(160), 12)];
        }
        return cell;
    }
    return nil;
}

-(void)toHome:(UIButton*)sender
{
    
}

//lee999 修改绑定
- (void)btnBindClicked:(UIButton *)sender {
    
    [nametextfield resignFirstResponder];
//    self.checkOutViewCtrl.vouId = nametextfield.text;
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    [mainSer addCouponcard:nametextfield.text];
}


- (void)UserCouns:(UIButton *)sender {
    
//    self.checkOutViewCtrl.vouId = nametextfield.text;
    [self popBackAnimate:nil];
}


//lee999 新增礼品卡的使用界面
-(void)showGiftUrlAction:(MyButton*)sender{
    
    YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
    webView.strURL  = sender.addstring;
    webView.strTitle = @"礼品卡使用";
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //点击选中礼品卡
    if (self.delegate && [self.delegate respondsToSelector:@selector(SelectCouponIndex:withslelectTag:withCodeValue:)]) {
        
        NSDictionary* data = [self.contentArr objectAtIndex:indexPath.row isArray:nil];

        NSString *strid = @"";
        if (self.selectType == 1) {
            strid = [data objectForKey:@"code" isDictionary:nil];
        }else if(self.selectType == 2){
            strid = [data objectForKey:@"card_id" isDictionary:nil];
        }else if (self.selectType == 3){
            strid = [data objectForKey:@"id" isDictionary:nil];
        }
        
        [self.delegate SelectCouponIndex:[indexPath row] withslelectTag:self.selectType withCodeValue:strid];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
//    id data = [self.contentArr objectAtIndex:indexPath.row isArray:nil];
//    CouponDetail20ViewController* cdvc = [[CouponDetail20ViewController alloc] init];
//    if ([data class] == [CouponInfo class]) {
//        NSString* type = ((CouponInfo*)data).type;
//        if ([type isEqualToString:@"o2o"])
//        {
//            cdvc.dType = kO2O;
//        }
//        else if([type isEqualToString:@"coupon"])
//        {
//            cdvc.dType = kCoupon;
//        }
//        else if([type isEqualToString:@"gift"])
//        {
//            cdvc.dType = kGift;
//        }
//    }
//    else if ([data class] == [FreePostCardInfo class])
//    {
//        cdvc.dType = kFreePost;
//    }
//    cdvc.data = data;
//    [self.navigationController pushViewController:cdvc animated:YES];
}

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



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 137) {
        if (buttonIndex==1) {
            [SBPublicAlert showMBProgressHUD:@"正在兑换···" andWhereView:self.view states:NO];
            //[mainSer exchangecoupon:[[self.arrCard objectAtIndex:0 isArray:nil] objectForKey:@"card_id"]];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)showCouponMenu:(UIButton*)sender
{
    if (vCouponMenu) {
        [vCouponMenu removeFromSuperview];
        vCouponMenu = nil;
        return;
    }
    [selectedBtn setSelected:NO];
    selectedBtn = sender;
    [sender setSelected:YES];
    
    vCouponMenu = [[UIView alloc] initWithFrame:CGRectMake(0, sender.frame.size.height, sender.frame.size.width, sender.frame.size.height * 2)];
    [self.view addSubview:vCouponMenu];
    [self.view bringSubviewToFront:vCouponMenu];
    
    UIButton* btnShowAllCoupon = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnShowAllCoupon setFrame:CGRectMake(0, 0, vCouponMenu.frame.size.width, vCouponMenu.frame.size.height / 2)];
    [btnShowAllCoupon setTag:10001];
    [btnShowAllCoupon addTarget:self action:@selector(showCouponWithType:) forControlEvents:UIControlEventTouchUpInside];
    [btnShowAllCoupon setTitle:@"全部优惠券" forState:UIControlStateNormal];
    [btnShowAllCoupon setTitleColor:[UIColor colorWithHexString:@"#6c6c6c"] forState:UIControlStateNormal];
    [btnShowAllCoupon setExclusiveTouch:NO];
    [btnShowAllCoupon setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
    [vCouponMenu addSubview:btnShowAllCoupon];
    
    UIButton* btnShowUnusedCoupon = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnShowUnusedCoupon setFrame:CGRectMake(0, btnShowAllCoupon.frame.size.height, vCouponMenu.frame.size.width, vCouponMenu.frame.size.height / 2)];
    [btnShowUnusedCoupon setTag:10002];
    [btnShowUnusedCoupon addTarget:self action:@selector(showCouponWithType:) forControlEvents:UIControlEventTouchUpInside];
    [btnShowUnusedCoupon setTitle:@"未使用" forState:UIControlStateNormal];
    [btnShowUnusedCoupon setTitleColor:[UIColor colorWithHexString:@"#6c6c6c"] forState:UIControlStateNormal];
    [btnShowUnusedCoupon setExclusiveTouch:NO];
    [btnShowUnusedCoupon setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
    [vCouponMenu addSubview:btnShowUnusedCoupon];
    
    switch (nSelectedIndexInMenu) {
        case 10001:
        {
            [btnShowAllCoupon setBackgroundColor:[UIColor colorWithHexString:@"#f6f6f6"]];
        }
            break;
        case 10002:
        {
            [btnShowUnusedCoupon setBackgroundColor:[UIColor colorWithHexString:@"#f6f6f6"]];
        }
            break;
        default:
            break;
    }
}


-(void)toFreeShippingCard:(UIButton*)sender
{
    [selectedBtn setSelected:NO];
    selectedBtn = sender;
    [sender setSelected:YES];
    if (vCouponMenu) {
        [vCouponMenu removeFromSuperview];
        vCouponMenu = nil;
    }
    _strType = @"f";
}

-(void)toGiftCard:(UIButton*)sender
{
    [selectedBtn setSelected:NO];
    selectedBtn = sender;
    [sender setSelected:YES];
    if (vCouponMenu) {
        [vCouponMenu removeFromSuperview];
        vCouponMenu = nil;
    }
    _strType = @"g";
}

-(NSArray*)viewConstraints
{
    NSDictionary *views = @{@"mytableView" : self.mytableView, @"vToolbar" : self.vToolbar};
    NSDictionary *metrics = @{@"barHeight" : [NSNumber numberWithFloat:lee1fitAllScreen(35)]};
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    if (self.clType == EAll) {
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[vToolbar(barHeight)][mytableView]|" options:0 metrics:metrics views:views]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[vToolbar]|" options:0 metrics:metrics views:views]];
    }else
    {
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mytableView]|" options:0 metrics:metrics views:views]];
    }
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mytableView]|" options:0 metrics:metrics views:views]];
    return constraints;
}

-(UIView *)vToolbar
{
    if (_vToolbar) {
        return _vToolbar;
    }
    _vToolbar = [[UIView alloc] init];
    [_vToolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    return _vToolbar;
}

-(UITableView *)mytableView
{
    if (_mytableView) {
        return _mytableView;
    }
    _mytableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.backgroundView = nil;
    _mytableView.backgroundColor = [UIColor clearColor];
    _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mytableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    return _mytableView;
}
@end
