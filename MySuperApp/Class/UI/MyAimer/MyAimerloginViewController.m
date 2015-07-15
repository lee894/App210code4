//
//  MyAimerloginViewController.m
//  MySuperApp
//
//  Created by LEE on 14-3-30.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "MyAimerloginViewController.h"
#import "AimerHeadCell.h"
#import "UniversalCell.h"
#import "AMServerCenterViewController.h"
#import "ChangePwdViewController.h"
#import "BindPhoneViewController.h"
#import "AddressViewController.h"
#import "ModifyInformationViewController.h"
#import "MyFavViewController.h"
#import "YKCanReuse_webViewController.h"
#import "OrderViewController.h"
#import "BonusTableViewController.h"
#import "MyImagePickViewController.h"
#import "MyFavAll20ViewController.h"
#import "NoticeinfoViewController.h"
#import "MyCloset1ViewController.h"
#import "MyClosetListViewController.h"
#import "BrandListViewController.h"
#import "MyAimerParser.h"
#import "NSString+WPAttributedMarkup.h"
#import "HasBindPhoneViewController.h"

#import "ImproveInformationViewController.h"



@interface MyAimerloginViewController ()
{
    UIImageView *bgBut;
    MainpageServ *mainSer;
    MyAimerInfo *myAimerInfo;
}

@property (nonatomic, weak) IBOutlet UITableView *tableList;
@end

@implementation MyAimerloginViewController
@synthesize headimage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self)
        self.title = @"我的爱慕";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的爱慕";

    [_tableList setBackgroundView:nil];
    [_tableList setBackgroundColor:[UIColor clearColor]];
        
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *unSelectedImg = [UIImage imageNamed:@"t_ico_info_normal.png"];
    UIImage *selectedImg = [UIImage imageNamed:@"t_ico_info_hover.png"];
    [photoBtn setBackgroundImage:unSelectedImg forState:UIControlStateNormal];
    [photoBtn setBackgroundImage:selectedImg forState:UIControlStateHighlighted];
    [photoBtn addTarget:self action:@selector(rightButAction) forControlEvents:UIControlEventTouchUpInside];
    photoBtn.frame = CGRectMake(10, 3, 20, 20);
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:photoBtn];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)rightButAction{
    //活动公告
    NoticeinfoViewController *done = [[NoticeinfoViewController alloc] init];
    [self.navigationController pushViewController:done animated:YES];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self NewSHowTableBarwithAnimated:YES];
    
    //判断登录  判断如果没有登录，弹出登录界面
    if (![SingletonState sharedStateInstance].userHasLogin) {
        _tableList.hidden = YES;
        [self changeToMyaimer];
        return;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
        _tableList.hidden  =NO;
    }
    //end
    
    //lee999  重置，默认购车返回首页
    [SingletonState sharedStateInstance].mycarfrom = 1;
    
    [mainSer getUserInfo];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
    [DplusMobClick track:@"我的爱慕"];
}

- (void)successMyziliao {
    
    //    ImproveInformationViewController *iivc = [[ImproveInformationViewController alloc] init];
    ModifyInformationViewController * iivc = [[ModifyInformationViewController alloc] init];
    [self.navigationController pushViewController:iivc animated:YES];
}

- (IBAction)shopOrUnhandelOrUnaccess:(UIButton *)sender//购物车||待处理||待评价
{
    switch (sender.tag) {
        case 11://代付款
        {
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [TalkingData trackEvent:@"5010" label:@"待付款" parameters:dic1];
            
            [DplusMobClick track:@"待付款" property:dic1];

            
            OrderViewController *tempOrder = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
            tempOrder.ishowHeadView = NO;
            tempOrder.howEnter = 4;
            [self.navigationController pushViewController:tempOrder animated:YES];
        }
            break;
        case 12://待处理
        {
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [TalkingData trackEvent:@"5010" label:@"待处理" parameters:dic1];
            
            [DplusMobClick track:@"待处理" property:dic1];

            
            OrderViewController *tempOrder = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
            tempOrder.ishowHeadView = NO;
            tempOrder.howEnter = 2;
            [self.navigationController pushViewController:tempOrder animated:YES];
        }
            break;
        case 13://待评价
        {
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [TalkingData trackEvent:@"5010" label:@"待评价" parameters:dic1];
            
            [DplusMobClick track:@"待评价" property:dic1];

            
            OrderViewController *tempOrder = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
            tempOrder.howEnter = 3;
            tempOrder.ishowHeadView = NO;
            //            tempOrder.userName = _moreModel.userinfo.username;
            [self.navigationController pushViewController:tempOrder animated:YES];
        }
            break;
        default:
            break;
    }
    
}
#pragma mark -- 打电话
- (IBAction)makeCall:(id)sender//拨打电话
{
    
    
    NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
    [DplusMobClick track:@"拨打电话" property:dic1];
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", @"4000602008"]];
    [[UIApplication sharedApplication] openURL:phoneNumberURL];
}

#pragma mark -- netrequest delegate

-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    //lee999 新增more20解析
    if(![amodel isKindOfClass:[LBaseModel class]])
    {
        switch ((NSUInteger)aHandle) {
            case Http_More20_Tag:
            {
                myAimerInfo = [[MyAimerParser alloc] parsemyAimerInfo:amodel];
                
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[myAimerInfo userinfo] shopcartcount]] forKey:@"totalNUM"];
                //[UIApplication sharedApplication].applicationIconBadgeNumber=[[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]intValue];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TotleNumber" object:nil];
                
                //lee999 设置气泡
                AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]intValue] > 0) {
                    
                    [[[[app.mytabBarController tabBar] items] objectAtIndex:3] setBadgeValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]];
                }else{
                    [[[[app.mytabBarController tabBar] items] objectAtIndex:3] setBadgeValue:@""];
                }
                
                
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
                [TalkingData trackEvent:@"5010" label:@"我的爱慕" parameters:dic1];
                
                [DplusMobClick track:@"我的爱慕" property:dic1];

                
                [_tableList reloadData];
            }
                break;
                
            default:
                break;
        }
        return;
    }
    //end
    
    
    switch (model.requestTag) {
        case Http_Logout_Tag:
        {
            //退出登录
            if (!model.errorMessage) {
                
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"0"] forKey:@"totalNUM"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TotleNumber" object:nil];
                
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usersession"];
                
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"usersessionUserid"];
                
                //退出登录，修改icon上的气泡数字
                //[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                
                
                //lee999 设置气泡  退出登录  清空气泡
                AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
                [[[[app.mytabBarController tabBar] items] objectAtIndex:3] setBadgeValue:@""];
                //end
                
                
                
                [SingletonState sharedStateInstance].userHasLogin = NO;
                
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                //lee999 修改退出登录，返回到登录界面。
                [self changetableBarto:4];
                
                
                //lee999 返回顶部
                [_tableList setContentOffset:CGPointMake(0, 0)];
                
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            }
        }
            break;
        case Http_Uploadface_Tag:
        {
            //上传头像
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                AimerHeadCell *cell = (AimerHeadCell *)[_tableList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                [cell.InfterFaceBut setImage:self.headimage
                                    forState:UIControlStateNormal];
                
                [SBPublicAlert showMBProgressHUD:@"头像上传成功" andWhereView:self.view hiddenTime:2.0];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            }
        }
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
}


#pragma mark --
#pragma mark -- UITableView delegate and datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return lee1fitAllScreen(100);
            break;
        case 1:
            return 44;
            break;
        case 2:
            return 44;
            break;
        case 3:
            return lee1fitAllScreen(165);
            break;
        case 4:
            return 44;
            break;
        case 9:
            //底部更多，联系我们
            return lee1fitAllScreen(150);
            break;
        default:
            return 44;
            break;
    }
    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10; //+1 增加联系客服
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifierUniversal = @"cellIdentifierFirst";
    switch (indexPath.row) {
        case 0:
        {
            //lee999 公用的cell
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:identifierUniversal];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            }
            
            UIImageView *headAllV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, lee1fitAllScreen(100))];
            [headAllV setImage:[UIImage imageNamed:@"my_am_user_bg"]];
            [cell addSubview:headAllV];
            
            //头像
            UIImage *imag = [UIImage imageNamed:@"my_am_user_img"];
            UrlImageButton *btn = [UrlImageButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:imag forState:UIControlStateNormal];
            [btn setFrame:CGRectMake((headAllV.width - imag.size.width)/2, 12, imag.size.width, imag.size.height)];
            [headAllV addSubview:btn];
            
            if ([myAimerInfo.userinfo.userface description].length > 0) {
                [btn setImageWithURL:[NSURL URLWithString:myAimerInfo.userinfo.userface] placeholderImage:[UIImage imageNamed:@"defaulthead.jpg"]];
            }
            
            
            //carma
            UIImage *imagca = [UIImage imageNamed:@"my_am_ca"];
            UIImageView *imacaV = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(
                                                            btn.frame.origin.x + btn.frame.size.width - 10,
                                                            btn.frame.origin.y + btn.frame.size.height - 10,
                                                            imagca.size.width,
                                                            imagca.size.height)];
            [imacaV setImage:imagca];
            [cell addSubview:imacaV];
            
            //name
            UILabel * noticeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, btn.frame.size.height + lee1fitAllScreen(12), headAllV.width - 20, 30)];
            noticeTitle.text = myAimerInfo.userinfo.username;
            noticeTitle.textColor = [UIColor colorWithHexString:@"0xe4a1a1"];//UIColorFromRGB(0xB90023);
            noticeTitle.backgroundColor = [UIColor clearColor];
            noticeTitle.font = [UIFont systemFontOfSize:14];
            [noticeTitle setTextAlignment:NSTextAlignmentCenter];
            [headAllV addSubview:noticeTitle];
            
            
            
            //            AimerHeadCell *headcell = [[[NSBundle mainBundle] loadNibNamed:@"AimerHeadCell" owner:self options:nil] lastObject];
            //
            //            if ([_moreModel.userinfo.userface description].length > 0) {
            //                //[headcell.InfterFaceBut setImageWithURL:[NSURL URLWithString:_moreModel.userinfo.userface] placeholderImage:[UIImage imageNamed:@"defaulthead.jpg"]];
            //            }
            //
            //
            //            //   图片圆角化  遮罩层的运用
            //            UIImage *roundCorner = [UIImage imageNamed:@"magazine_pic_bg.png"];
            //            CALayer* roundCornerLayer = [CALayer layer];
            //            roundCornerLayer.frame = headcell.InfterFaceBut.bounds;
            //            roundCornerLayer.contents = (id)[roundCorner CGImage];
            //            //lee999 150503 修改头像不显示的bug
            //            //[[headcell.InfterFaceBut layer] setMask:roundCornerLayer];
            //
            //            [headcell setContent:_moreModel.userinfo];
            //            headcell.selectionStyle = UITableViewCellSelectionStyleNone;
            //
            //            //lee999取消上传头像
            //            //[headcell.InfterFaceBut addTarget:self action:@selector(btnUploadHeardClicked:) forControlEvents:UIControlEventTouchUpInside];
            //            [headcell.changeBut addTarget:self action:@selector(successMyziliao) forControlEvents:UIControlEventTouchUpInside];
            //            [headcell.buttonintegral addTarget:self action:@selector(jifenYouHui) forControlEvents:UIControlEventTouchUpInside];
            
            
            return cell;
        }
            break;
            
        case 2:
        {
            //lee999 公用的cell
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:identifierUniversal];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            }
            
            NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14],
                                     @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:14],
                                     @"red": [UIColor redColor]};
            
            
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn1 setFrame:CGRectMake(0,0,ScreenWidth/3,44)];
            [btn1 setTag:11];
            [btn1 addTarget:self action:@selector(shopOrUnhandelOrUnaccess:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn1];
            
            //代付款lab
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,ScreenWidth/3,44)];
            [lab1 setFont:[UIFont systemFontOfSize:14.]];
            if ([[myAimerInfo.userinfo.nopay description] intValue] > 0) {
                
                NSInteger num = [[myAimerInfo.userinfo.nopay description] intValue];
                NSString *strnum = @"";
                if (num>99) {
                    strnum = @"99+";
                }else{
                    strnum = [NSString stringWithFormat:@"%ld",(long)num];
                }
                lab1.attributedText = [[NSString stringWithFormat:@"待付款（<red>%@</red>）",strnum] attributedStringWithStyleBook:style1];
            }else{
                [lab1 setText:[NSString stringWithFormat:@"待付款"]];
            }
            lab1.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lab1];

            UIView *sepV1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3, 0, 0.5, 44)];
            [sepV1 setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
            [cell addSubview:sepV1];
            
            
            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn2 setFrame:CGRectMake(ScreenWidth/3,0,ScreenWidth/3,44)];
            [btn2 setTag:13];
            [btn2 addTarget:self action:@selector(shopOrUnhandelOrUnaccess:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
            
            
            //待评价lab
            UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/3,0,ScreenWidth/3,44)];
            if ([[myAimerInfo.userinfo.norates description] intValue] > 0) {
                
                NSInteger num = [[myAimerInfo.userinfo.norates description] intValue];
                NSString *strnum = @"";
                if (num>99) {
                    strnum = @"99+";
                }else{
                    strnum = [NSString stringWithFormat:@"%ld",(long)num];
                }
                lab2.attributedText = [[NSString stringWithFormat:@"待评价（<red>%@</red>）",strnum] attributedStringWithStyleBook:style1];
            }else{
                [lab2 setText:[NSString stringWithFormat:@"待评价"]];
            }
            [lab2 setFont:[UIFont systemFontOfSize:14.]];
            lab2.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lab2];
            
            
            
            UIView *sepV2 = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth/3)*2, 0, 0.5, 44)];
            [sepV2 setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
            [cell addSubview:sepV2];
            
            UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn3 setFrame:CGRectMake((ScreenWidth/3)*2,0,ScreenWidth/3,44)];
            [btn3 setTag:12];
            [btn3 addTarget:self action:@selector(shopOrUnhandelOrUnaccess:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn3];
            
            //待处理lab
            UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth/3)*2,0,ScreenWidth/3,44)];
            [lab3 setFont:[UIFont systemFontOfSize:14.]];
            if ([[myAimerInfo.userinfo.nodispose description] intValue] > 0) {
                
                NSInteger num = [[myAimerInfo.userinfo.nodispose description] intValue];
                NSString *strnum = @"";
                if (num>99) {
                    strnum = @"99+";
                }else{
                    strnum = [NSString stringWithFormat:@"%ld",(long)num];
                }
                lab3.attributedText = [[NSString stringWithFormat:@"待处理（<red>%@</red>）",strnum] attributedStringWithStyleBook:style1];
            }else{
                [lab3 setText:[NSString stringWithFormat:@"待处理"]];
            }
            lab3.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lab3];
            
            return cell;
        }
        case 3:
        {
            //lee999 公用的cell
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:identifierUniversal];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                [cell setBackgroundColor:[UIColor colorWithHexString:@"#e6e6e6"]];
                
                NSInteger sp = 10; //间隔10
                NSInteger BW = (ScreenWidth-5*sp)/4;
                
                for (NSInteger i = 0; i < 8; ++i) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setFrame:CGRectMake((i % 4) * (BW + 10) + 10, i / 4 * (BW + 10) + 10, BW, BW)];
                    [btn setTag:i];
                    NSString* strImgName = [NSString stringWithFormat:@"my_am_ico_%ld", (long)(i + 1)];
                    [btn setBackgroundImage:[UIImage imageNamed:strImgName] forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(toNextFromThridCell:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:btn];
                }
            }
            
            return cell;
        }
            
            break;
            
            //尾部
        case 9:
        {
            UITableViewCell *endCell = [[[NSBundle mainBundle] loadNibNamed:@"AimerLastCell" owner:self options:nil] lastObject];
            endCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return endCell;
        }
            break;
        default:
            break;
    }
    
    //中间分区
    if (indexPath.row != 0 && indexPath.row != 9) {
        
        UniversalCell *universalCell = [tableView dequeueReusableCellWithIdentifier:identifierUniversal];
        //if (universalCell == nil) {
        universalCell =  [[[NSBundle mainBundle] loadNibNamed:@"UniversalCell" owner:self options:nil] objectAtIndex:0];
        //}
        [universalCell setBackgroundColor:[UIColor whiteColor]];
        switch (indexPath.row) {
            case 1:
            {
                universalCell.labelTitle.text = @"全部订单";
            }
                break;
            case 4:
            {
                universalCell.labelTitle.text = @"修改密码";
            }
                break;
            case 5:
            {
                universalCell.labelTitle.text = @"绑定手机";
                
                if ([myAimerInfo.userinfo.isbind isEqualToString:@"0"]) {
                    universalCell.labelDetail.text = @"未绑定";
                }else if([myAimerInfo.userinfo.isbind isEqualToString:@"1"]){
                    universalCell.labelDetail.text = @"已绑定";
                    universalCell.imgViewBg.hidden = YES;
                }
            }
                break;
            case 6:
            {
                universalCell.labelTitle.text = @"联系客服";
            }
                break;
                
            case 7:
            {
                universalCell.labelTitle.text = @"退出登录";
            }
                break;
            case 8:
            {
                universalCell.labelTitle.text = @"应用评分";
                universalCell.labelDetail.text= @"如果你喜欢爱慕，请给我个好评";
            }
                break;
            default:
                break;
        }
        universalCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return universalCell;
    }
    return nil;
}


- (void)clearCacheInMemoryCell:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        [sender setFrame:CGRectMake(270, 10, 24, 24)];
        [bgBut setImage:[UIImage imageNamed:@"switch_on_bg.png"]];
        [SBPublicAlert showMBProgressHUD:@"正在清除缓存···" andWhereView:self.view hiddenTime:1.0];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:[self DoumentPath] error:nil];
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        [fileManager removeItemAtPath:path error:nil];
    }else {
        [sender setFrame:CGRectMake(270-24, 10, 24, 24)];
        [bgBut setImage:[UIImage imageNamed:@"switch_off_bg.png"]];
    }
}

- (NSString *)DoumentPath {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return path ;
}

#pragma mark---  8个按钮的点击

-(void)toNextFromThridCell:(UIButton*)sender
{
    switch (sender.tag) {
        case 0:
        {
            //积分优惠
            [self jifenYouHui];
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"我的优惠" property:dic1];
        }
            break;
        case 1:
        {
            //会员卡
                    
            BonusTableViewController *ctrl = [[BonusTableViewController alloc] init];
            ctrl.isAimer = YES;
            ctrl.clType = EV6Card;
            [self.navigationController pushViewController:ctrl animated:YES];
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"会员卡" property:dic1];
            
            return;
            
            /*
            CouponsListTableViewController *vc = [[CouponsListTableViewController alloc] init];
            vc.clType = EV6Card;
            [self.navigationController pushViewController:vc animated:YES];
             */
            
        }
            break;
        case 2:
        {
            MyFavAll20ViewController *favvc = [[MyFavAll20ViewController alloc] init];
            [self.navigationController pushViewController:favvc animated:YES];
         
            //我的收藏
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [TalkingData trackEvent:@"5010" label:@"收藏" parameters:dic1];
            
            [DplusMobClick track:@"我的收藏" property:dic1];
            
        }
            break;
        case 3:
        {
 
            //地址列表
            AddressViewController *tempAddress = [[AddressViewController alloc] initWithNibName:@"AddressViewController" bundle:nil];
            tempAddress.isCar = NO;
            [self.navigationController pushViewController:tempAddress animated:YES];
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"地址列表" property:dic1];
        }
            break;
        case 4:
        {
            //服务中心
            AMServerCenterViewController *tempService = [[AMServerCenterViewController alloc] initWithNibName:@"AMServerCenterViewController" bundle:nil];
            [self.navigationController pushViewController:tempService animated:YES];
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"服务中心" property:dic1];
        }
            break;
        case 5:
        {
            //品牌馆
            BrandListViewController *barnvc = [[BrandListViewController alloc] init];
            [self.navigationController pushViewController:barnvc animated:YES];
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"品牌馆" property:dic1];
            
        }
            break;
        case 6:
        {
            //私人衣橱
            if ([myAimerInfo.userinfo.is_wardrobe isEqualToString:@""]) {
                
                MyCloset1ViewController *vc1 = [[MyCloset1ViewController alloc] initWithNibName:@"MyCloset1ViewController" bundle:nil];
                [self.navigationController pushViewController:vc1 animated:YES];
            }else{
                
                [SingletonState sharedStateInstance].str_wardrobe  = myAimerInfo.userinfo.is_wardrobe ;

                
                MyClosetListViewController *vc1 = [[MyClosetListViewController alloc] initWithNibName:@"MyClosetListViewController" bundle:nil];
                //vc1.strselectStr = myAimerInfo.userinfo.is_wardrobe;
                [self.navigationController pushViewController:vc1 animated:YES];
            }
            
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"私人衣橱" property:dic1];
            
        }
            break;
        case 7:
        {
            //微社区
            
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = @"http://xiaoqu.qq.com/mobile/barindex.html?_bid=128&_wv=1027&bid=51413";
            webView.strTitle = @"微社区";
            [self.navigationController pushViewController:webView animated:YES];
            
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"微社区" property:dic1];
            
        }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    switch (indexPath.row) {
        case 1:
        {
            //@"全部订单";
            OrderViewController *tempOrder = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
            tempOrder.howEnter = 1;
            tempOrder.ishowHeadView = YES;
            //lee999
            UserInfo *info = myAimerInfo.userinfo;
            tempOrder.bandgeNum1 = [info.nodispose isKindOfClass:[NSNull class]] ? @"0" : info.nodispose;
            int noaccess = (int)info.norates;
            tempOrder.bandgeNum2 = [NSString stringWithFormat:@"%d",noaccess];
            //end
            [self.navigationController pushViewController:tempOrder animated:YES];
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"全部订单" property:dic1];

        }
            break;
        case 4:
        {
            //@"修改密码";
            ChangePwdViewController *updatePwdVC = [[ChangePwdViewController alloc] initWithNibName:@"ChangePwdViewController" bundle:nil];
            [self.navigationController pushViewController:updatePwdVC animated:YES];
            
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"修改密码" property:dic1];
        }
            break;
        case 5:
        {
            //@"绑定手机";
            if ([myAimerInfo.userinfo.isbind isEqualToString:@"0"]) {
                
                //未绑定手机
                
                BindPhoneViewController *tempBindPhone = [[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil];
                [self.navigationController  pushViewController:tempBindPhone animated:YES];
                
            }else{
            
                //已绑定手机
                
                HasBindPhoneViewController *tempBindPhone = [[HasBindPhoneViewController alloc] initWithNibName:@"HasBindPhoneViewController" bundle:nil];
                
                NSRange rang = {3,4};//location
                NSMutableString *strphone = [NSMutableString stringWithFormat:@"%@",myAimerInfo.userinfo.bind_number];
                [strphone replaceCharactersInRange:rang  withString:@"****"];

                tempBindPhone.strLab = [NSString stringWithFormat:@"已绑定：  %@",strphone];
                [self.navigationController  pushViewController:tempBindPhone animated:YES];
            }
            
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
            [DplusMobClick track:@"绑定手机" property:dic1];
        }
            break;
        case 6:
        {
            //@"联系客服";
            YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
            webView.strURL = kefuUrl;
            webView.strTitle = @"联系客服";
            [self.navigationController pushViewController:webView animated:YES];
            
        }
            break;
        case 7:
        {
            //@"退出登录";
            [mainSer getuserLogout];
            [SBPublicAlert showMBProgressHUD:@"正在退出···" andWhereView:self.view states:NO];
        }
            break;
        case 8:
        {
//            @"应用评分";
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=515651364"]];

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=515651364&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
            
        }
            break;
        default:
            break;
    }
}




#pragma mark-- 积分优惠
- (void)jifenYouHui {
    
    NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:myAimerInfo.userinfo.username, @"UserName",nil];
    [TalkingData trackEvent:@"5010" label:@"积分优惠" parameters:dic1];
    
    
    [DplusMobClick track:@"积分优惠" property:dic1];

    
    BonusTableViewController *ctrl = [[BonusTableViewController alloc] init];
    ctrl.isAimer = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}


#pragma mark 更换头像
- (void)btnUploadHeardClicked:(UIButton *)theBtn
{
    //lee999  IOS8 禁用了  141114
    //    UIActionSheet *tmpActionSheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册获取", nil];
    //    [tmpActionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    MyImagePickViewController *imagePickerController = [[MyImagePickViewController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    if (buttonIndex == 0) {//拍照
        if([MyImagePickViewController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self.navigationController presentModalViewController:imagePickerController animated:YES];
        } else {
            return;
        }
    } else if (buttonIndex == 1) {//从相册中获取
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.navigationController presentModalViewController:imagePickerController animated:YES];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image=[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *newImage = [self imageWithImage:image scaledToSize:CGSizeMake(60, 60)];
    
    self.headimage = newImage;
    [mainSer getUpLoadface:UIImagePNGRepresentation(newImage)];
    
    [SBPublicAlert showMBProgressHUD:@"更新头像中..." andWhereView:self.view states:NO];
    
    [self performSelector:@selector(dismissPicker:) withObject:picker afterDelay:1.];
    
}

- (void)dismissPicker:(id)argc {
    [argc dismissModalViewControllerAnimated:YES];
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end



//            {
//                if (indexPath.row == 0) {
//
//                    universalCell.imgViewBg.image = [UIImage imageNamed:@"list_bg_01.png"];
//
//                }else if (indexPath.row >0 && indexPath.row < 4){
//
//                    universalCell.imgViewBg.image = [UIImage imageNamed:@"list_bg_02.png"];
//
//                }else if(indexPath.row == 4){
//
//                    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//                    [but setFrame:CGRectMake(270, 10, 24, 24)];
//                    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                    [but setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//
//                    [but setTitle:@"关" forState:UIControlStateNormal];
//                    [but setTitle:@"开" forState:UIControlStateSelected];
//                    [but setBackgroundImage:[UIImage imageNamed:@"switch_bar.png"] forState:UIControlStateNormal];
//                    [but setBackgroundImage:[UIImage imageNamed:@"switch_bar.png"] forState:UIControlStateSelected];
//
//                    [but addTarget:self action:@selector(clearCacheInMemoryCell:) forControlEvents:UIControlEventTouchUpInside];
//
//                    bgBut = [[UIImageView alloc] initWithFrame:CGRectMake(270-24, 10, 24*2, 24)];
//                    [bgBut setImage:[UIImage imageNamed:@"switch_on_bg.png"]];
//
//                    [universalCell addSubview:bgBut];
//
//                    [universalCell addSubview:but];
//
//                    universalCell.imgViewBg.image = [UIImage imageNamed:@"list_bg_03.png"];
//                }
//
//                universalCell.labelTitle.text = [arraySectionThird objectAtIndex:indexPath.row];
//                universalCell.labelDetail.text = [arraySectionThird objectAtIndex:indexPath.row + 5];
//                if (indexPath.row == 3) {
//                    if ([_moreModel.userinfo.isbind isEqualToString:@"0"]) {
//                        universalCell.labelDetail.text = @"未绑定";
//                    }else if([_moreModel.userinfo.isbind isEqualToString:@"1"])
//                        universalCell.labelDetail.text = @"已绑定";
//                }
////            }
//                break;
//
//            case 3:
//            {
//                universalCell.imgViewBg.image = [UIImage imageNamed:@"list_one.png"];
//                universalCell.labelTitle.text = @"爱慕简介";
//                universalCell.labelDetail.text = @"爱慕集团简介";
//            }
//                break;
//            case 4:
//            {
//                universalCell.imgViewBg.image = [UIImage imageNamed:@"list_one"];
//                if (indexPath.row == 0) {
//                    universalCell.labelTitle.text = @"退出登录";
//                }else{
//                    universalCell.labelTitle.text = @"应用评分";
//                    universalCell.labelDetail.text = @"如果你喜欢爱慕，请给我个好评!";
//                }
//            }
//                break;





/*
 if (indexPath.section == 1) {
 switch (indexPath.row) {
 case 0:
 {
 //积分优惠
 [self jifenYouHui];
 }
 break;
 case 1:
 {
 //我的收藏
 NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:_moreModel.userinfo.username, @"UserName",nil];
 [TalkingData trackEvent:@"5010" label:@"收藏" parameters:dic1];
 
 MyFavAll20ViewController *favvc = [[MyFavAll20ViewController alloc] init];
 [self.navigationController pushViewController:favvc animated:YES];
 }
 break;
 case 2:
 {
 //订单列表
 OrderViewController *tempOrder = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
 tempOrder.howEnter = 1;
 tempOrder.ishowHeadView = YES;
 //lee999
 MoerUserinfo*info = _moreModel.userinfo;
 tempOrder.bandgeNum1 = [info.nodispose isKindOfClass:[NSNull class]] ? @"0" : info.nodispose;
 int noaccess = (int)info.norates;
 tempOrder.bandgeNum2 = [NSString stringWithFormat:@"%d",noaccess];
 //end
 [self.navigationController pushViewController:tempOrder animated:YES];
 }
 
 break;
 default:
 break;
 }
 }else if (indexPath.section == 2){
 switch (indexPath.row) {
 case 0:
 {
 //地址列表
 AddressViewController *tempAddress = [[AddressViewController alloc] initWithNibName:@"AddressViewController" bundle:nil];
 tempAddress.isCar = NO;
 [self.navigationController pushViewController:tempAddress animated:YES];
 }
 break;
 case 1:
 {
 //服务中心
 AMServerCenterViewController *tempService = [[AMServerCenterViewController alloc] initWithNibName:@"AMServerCenterViewController" bundle:nil];
 [self.navigationController pushViewController:tempService animated:YES];
 }
 break;
 case 2:
 {
 //修改密码
 ChangePwdViewController *updatePwdVC = [[ChangePwdViewController alloc] initWithNibName:@"ChangePwdViewController" bundle:nil];
 [self.navigationController pushViewController:updatePwdVC animated:YES];
 }
 break;
 case 3:
 {
 //绑定手机
 BindPhoneViewController *tempBindPhone = [[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil];
 [self.navigationController  pushViewController:tempBindPhone animated:YES];
 }
 break;
 case 4:
 {
 
 }
 break;
 default:
 break;
 }
 }else if (indexPath.section == 3){
 //爱慕简介
 YKCanReuse_webViewController *webView = [[YKCanReuse_webViewController alloc] init];
 webView.strURL = @"http://m.aimer.com.cn/method/about";
 webView.strTitle = @"爱慕简介";
 [self.navigationController pushViewController:webView animated:YES];
 
 }else if (indexPath.section == 4){
 switch (indexPath.row) {
 case 0:
 //退出登录
 [mainSer getuserLogout];
 [SBPublicAlert showMBProgressHUD:@"正在退出···" andWhereView:self.view states:NO];
 break;
 case 1:
 {
 //应用评分
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=515651364"]];
 }
 
 break;
 default:
 break;
 }
 }
 */




//        case Http_More_Tag:
//            if (!model.errorMessage) {
//                _moreModel = (MoerMoreModel *)model;
//
//
//                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%.f",[[_moreModel userinfo] shopcartcount]] forKey:@"totalNUM"];
//
//
//                [UIApplication sharedApplication].applicationIconBadgeNumber=[[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]intValue];
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"TotleNumber" object:nil];
//
//                //lee999 设置气泡
//                AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]intValue] > 0) {
//
//                    [[[[app.mytabBarController tabBar] items] objectAtIndex:3] setBadgeValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"]];
//                }else{
//                    [[[[app.mytabBarController tabBar] items] objectAtIndex:3] setBadgeValue:@""];
//                }
//
//
//                [SBPublicAlert hideMBprogressHUD:self.view];
//
//                NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:_moreModel.userinfo.username, @"UserName",nil];
//                [TalkingData trackEvent:@"5010" label:@"我的爱慕" parameters:dic1];
//
//                [_tableList reloadData];
//            }else{
//                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
//            }
//            break;
