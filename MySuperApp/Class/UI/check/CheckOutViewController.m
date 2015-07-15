//
//  CheckOutViewController.m
//  MySuperApp
//
//  Created by bonan on 14-4-6.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "CheckOutViewController.h"
#import "UrlImageView.h"
#import "UIImage+ImageSize.h"
#import "YKPayMethod.h"
#import "YKOrderPostscriptView.h"
#import "AddressViewController.h"
#import "YKReferOrderViewController.h"
#import "HasUsedViewController.h"
#import "YKCanReuse_webViewController.h"
#import "ProductDetailViewController.h"

#import "ImproveInformationViewController.h"
#import "SelectCouponTableViewController.h"
#import "CouponcardListCouponcardListModel.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "NSString+WPAttributedMarkup.h"


@interface CheckOutViewController ()<SelectCouponDelegate>
{
}

@property (nonatomic, retain) NSString *str_pay_Way;

@end


@implementation CheckOutViewController
@synthesize postText;
@synthesize addressItem_ben;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"结算中心";
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    //lee999recode
    self.straddressID = @"";
    self.usefreepostcardId = @"";
    self.useCouponcardId = @"";
    self.usev6useCardId = @"";
    //end
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    //创建返回按钮
    [self createBackBtnWithType:0];
    
    [chectOutTable setHidden:YES];
    
    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"提交订单" forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
	
    suitCount = 0;
    packageCount = 0;
    
    suitlistcell= [[NSMutableArray alloc] init];
    packagelistcell = [[NSMutableArray alloc] init];
	tableCells = [[NSMutableArray alloc] init];
	otherCells = [[NSMutableArray alloc] init];
	_dicTD = [[NSMutableDictionary alloc] init];
	[self createHeaderAndFooter];
	[self createCells];
	[self createOtherCells];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(poptdo) name:@"ISLOGIN" object:nil];
    
    
    
    // 防止最后一行地址不好操作
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
//    [footerView setBackgroundColor:[UIColor blueColor]];
//    chectOutTable.tableFooterView = footerView;
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    height_s = 0;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"enable_button" object:nil userInfo:nil];
    
    [self ShowFooterwithAnimated:NO];
    
    //请求网络数据
    if (!self.useCouponcardId) {
        self.useCouponcardId = @"";
    }
    
        [mainSev getCheckout:self.straddressID
            andV6usercard_id:self.usev6useCardId
               andCouponcard:self.useCouponcardId
                      payway:self.m_strPayMethod
             andfreepostcard:self.usefreepostcardId];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    //重新加载界面
	[self createOtherCells];
	[chectOutTable reloadData];
}


#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    //lee999 修改一个比较复杂的bug
    self.useCouponcardId = @"";
    self.usev6useCardId = @"";
    self.usefreepostcardId = @"";

    //end
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_Submitorder_Tag:
        {
            
            if (!model.errorMessage) {
                
                SubmitOrderSubmitOrderModel *submitOrderModel = (SubmitOrderSubmitOrderModel *)model;
                
                SubmitOrderSubmitorder *subOrder = submitOrderModel.submitorder;
                SubmitOrderPrice *priceModel = subOrder.price;
                YKReferOrderViewController * refer = [[YKReferOrderViewController alloc] init];
                refer.dicID = self.dicTD;
                refer.price     =  [priceModel value];
                refer.orderid   = submitOrderModel.orderid;
                refer.payway    = submitOrderModel.payway;
                refer.m_bShowPay = submitOrderModel.ispay;
                refer.tf_tradeNo = submitOrderModel.tf_tradeNo;
                //lee999
                refer.isZhunxiangkaHUIyuanAlert = submitOrderModel.zunxiang;
                refer.sendStrng = submitOrderModel.key;
                //end
                [self.navigationController pushViewController:refer animated:YES];
                
//                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                
//                [mainSev getSubmitorder:self.straddressID andCouponcard:self.useCouponcardId andPayway:self.m_strPayMethod andPayprice:str1 andRemarkmsg:self.postText andCard_id:card_id andfreepostcard:self.usefreepostcardId];

                [DplusMobClick track:@"提交订单成功" property:@{@"地址编号":self.straddressID,
                                                          @"使用优惠券":self.useCouponcardId,
                                                          @"使用电子券":self.usev6useCardId,
                                                          @"使用包邮卡":self.usefreepostcardId,
                                                          @"订单留言":self.postText,
                                                          @"支付方式":self.m_strPayMethod,
                                                          @"订单金额":[priceModel value],
                                                          @"订单编号":submitOrderModel.orderid
                                                          }];
                

            } else {
                
                NSDate *time = [NSDate date];
                NSMutableDictionary *dic1  = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.errorMessage, @"Reason",self.m_strPayMethod, @"Payment",self.province, @"Province", @"Ordergoodsnum",time, @"OrdernoTime",nil];
                [dic1 addEntriesFromDictionary:self.dicTD];
                [TalkingData trackEvent:@"1009" label:@"提交订单失败" parameters:dic1];
                
                
                [DplusMobClick track:@"提交订单成功" property:@{@"地址编号":self.straddressID,
                                                          @"使用优惠券":self.useCouponcardId,
                                                          @"使用电子券":self.usev6useCardId,
                                                          @"使用包邮卡":self.usefreepostcardId,
                                                          @"订单留言":self.postText,
                                                          @"支付方式":self.m_strPayMethod,
                                                          @"失败原因":model.errorMessage
                                                          }];
                
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:model.errorMessage delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert show];
            }
            
            [SBPublicAlert hideMBprogressHUD:self.view];
            
        }
            break;
        case Http_Checkout_Tag:
        {
            if (!model.errorMessage) {
                [self.view addSubview:chectOutTable];
                mycheckOutModel = (COCheckOutModel *)model;
                
                NSMutableString *str = nil;
                for (int i = 0; i < mycheckOutModel.checkoutProductlist.count; i++) {
                    YKItem *tempItem = [mycheckOutModel.checkoutProductlist objectAtIndex:i];
                    
                    [str appendFormat:@"%@|",tempItem.bn];
                    
                    if (i%3==0&&i!=0) {
                        NSString *keyStr = [NSString stringWithFormat:@"goods%d",i];
                        [self.dicTD setValue:str forKey:keyStr];
                        str = nil;   
                    }
                }
                
                [chectOutTable setHidden:NO];
                
                [self createSuitlistcells];
                [self createPackagelistcells];
                [self createCells];
                [self createOtherCells];
                [self createHeaderAndFooter];
                [chectOutTable reloadData];
            }else {
                
                
                //lee999埋点
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"", @"Sign",
                                     model.errorMessage, @"Reason",
                                     self.m_strPayMethod, @"Payment",
                                     self.straddressID, @"Province",
                                     self.straddressID, @"City",
                                     self.straddressID, @"Region",
                                     self.straddressID, @"Address",
                                     self.straddressID, @"Goods",
                                     nil];
                
                [TalkingData trackEvent:@"1011" label:@"提交订单失败" parameters:dic];
                
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            
            [SBPublicAlert hideMBprogressHUD:self.view];
        }
            break;
        case 10086:
        {
            //lee999埋点
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"", @"Sign",
                                 model.errorMessage, @"Reason",
                                 self.m_strPayMethod, @"Payment",
                                 self.addressItem_ben.province, @"Province",
                                 self.addressItem_ben.city, @"City",
                                 self.addressItem_ben.county, @"Region",
                                 self.addressItem_ben.address, @"Address",
                                 self.straddressID, @"Goods",
                                 nil];
            
            [TalkingData trackEvent:@"1011" label:@"提交订单失败" parameters:dic];
            
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
        }
            
        default:
            break;
    }
}


- (void)tijiao{
	if ([self.straddressID isEqualToString:@""] || self.straddressID == nil) {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"请添加地址" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
		[alert show];

        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        [chectOutTable scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
	} else if ((self.m_strPayMethod == nil) || ([self.m_strPayMethod isEqualToString:@""])) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"请选择支付方式" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
		[alert show];

        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        [chectOutTable scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        //提交订单
        [self loadData];
	}
}

#pragma mark--- 提交订单
- (void) loadData {
    NSString *str1 = [mycheckOutModel.itemPrice stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    NSString *card_id = [[mycheckOutModel.checkout_usev6cards lastObject] objectForKey:@"card_id"];
    
    if (card_id) {
        self.useCouponcardId = @"";
    }
    if ([self.postText isEqualToString:@"订单附言"]) {
        self.postText = @"";
    }
    
    [mainSev getSubmitorder:self.straddressID andCouponcard:self.useCouponcardId andPayway:self.m_strPayMethod andPayprice:str1 andRemarkmsg:self.postText andCard_id:card_id andfreepostcard:self.usefreepostcardId];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

- (void)createHeaderAndFooter{
    //ADD FootView:
	UIView* footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 260)];
	footView.backgroundColor = [UIColor clearColor];
    
    
    UIView* sepfootView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, ScreenWidth, 10)];
    sepfootView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    [footView addSubview:sepfootView];
    
    
    UILabel* totallab = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 120, 30)];
    totallab.backgroundColor = [UIColor clearColor];
    [totallab setTextColor:[UIColor blackColor]];
    totallab.text = @"合计：";//[nameArray objectAtIndex:i];
    totallab.font = [UIFont systemFontOfSize:LabBigSize];
    totallab.textAlignment = UITextAlignmentLeft;
    [footView addSubview:totallab];
    
    
    UILabel* pricelab = [[UILabel alloc] initWithFrame:CGRectMake(70, 190, 120, 30)];
    pricelab.backgroundColor = [UIColor clearColor];
    pricelab.text = [NSString stringWithFormat:@"%@",mycheckOutModel.orderPrice];
    [pricelab setTextColor:[UIColor colorWithHexString:@"#c8002c"]];
    pricelab.font = [UIFont systemFontOfSize:LabBigSize];
    pricelab.textAlignment = UITextAlignmentLeft;
    [footView addSubview:pricelab];
    
    
	UIButton* tijiButton = [UIButton buttonWithType:UIButtonTypeCustom];
	tijiButton.frame = CGRectMake(lee1fitAllScreen(210), 180, 110, 50);
	tijiButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
	[tijiButton setTitle:@"提交订单" forState:UIControlStateNormal];
	[tijiButton addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
	[tijiButton setBackgroundImage:[UIImage imageNamed:@"sryc_keyb_enter_normal.png"] forState:UIControlStateNormal];
	[tijiButton setBackgroundImage:[UIImage imageNamed:@"sryc_keyb_enter_hover.png"] forState:UIControlStateHighlighted];
	[footView addSubview:tijiButton];
    
    
	//ADD HeadView:
	UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, lee1fitAllScreen(140))];
	headerView.backgroundColor = [UIColor clearColor];
	
	NSArray* nameArray = [[NSArray alloc] initWithObjects:@"商品金额：",@"运费：",@"优惠券抵扣：",@"活动优惠金额：",@"会员卡电子劵抵扣：",@"订单总金额：",@"可获积分：",nil];
	for (int i = 0; i < [nameArray count]; i ++) {
		UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+20*i, 120, 20)];
		colorName.backgroundColor = [UIColor clearColor];
		colorName.text = [nameArray objectAtIndex:i];
		colorName.font = [UIFont systemFontOfSize:13];
		colorName.textAlignment = UITextAlignmentLeft;
		[headerView addSubview:colorName];

	}
	
	for (int i = 0; i < [nameArray count]; i ++) {
		UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(lee1fitAllScreen(200), 10+20*i, 110, 20)];
		colorName.backgroundColor = [UIColor clearColor];
		switch (i) {
			case 0:
                colorName.text = mycheckOutModel.itemPrice;
				break;
			case 1:
                colorName.text = mycheckOutModel.carriagePrice;
				break;
			case 2:
                colorName.text = mycheckOutModel.voucherPrice;
				break;
			case 3:
                colorName.text = mycheckOutModel.preferentialPrice;
				break;
            case 4:
                colorName.text = mycheckOutModel.zuxiangPrice;
				break;
			case 5:
                colorName.text = mycheckOutModel.orderPrice;
				break;
            case 6:
                colorName.text = [NSString stringWithFormat:@"%d",mycheckOutModel.checkout_score];
				break;
			default:
				break;
		}
        
		colorName.font = [UIFont systemFontOfSize:14];
		colorName.textAlignment = UITextAlignmentRight;
		if (i == 5||i==6) {
			colorName.font = [UIFont systemFontOfSize:15];
			colorName.textColor = [UIColor colorWithHexString:@"0xB90023"];//UIColorFromRGB(0xB90023);
		}
		[headerView addSubview:colorName];
	}
    [footView addSubview:headerView];
    chectOutTable.tableFooterView = footView;
}

-(void)createCells{
    
	[tableCells removeAllObjects];
    
	static NSString	*CellIdentifier = @"Cell1";
	UITableViewCell *shoppingCarCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                              reuseIdentifier:CellIdentifier];
	shoppingCarCell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	for (int i=0; i<[mycheckOutModel.checkoutProductlist count]; i++) {
		static NSString	*CellIdentifier2 = @"Cell2";
		UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:CellIdentifier2];
		Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        YKItem* item = (YKItem *)[mycheckOutModel.checkoutProductlist objectAtIndex:i];
        
		UrlImageView* shoppingImg = [[UrlImageView alloc] init];
		[shoppingImg setImageFromUrl:YES withUrl:item.imgurl];
		shoppingImg.frame = CGRectMake(14, 15, 84, 103);
		//shoppingImg.backgroundColor = [UIColor clearColor];
		[Cell.contentView addSubview:shoppingImg];
        
		//lee999recode
        if ([item.type isEqualToString:@"gift"]) {
            
            
            NSDictionary* style123 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14],
                                     @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:14],
                                     @"red": [UIColor redColor]};
            
            UILabel* shoppingName = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, ScreenWidth-120, 45)];
            shoppingName.backgroundColor = [UIColor clearColor];
            shoppingName.numberOfLines = 0;
            shoppingName.lineBreakMode = UILineBreakModeWordWrap;
            shoppingName.attributedText = [[NSString stringWithFormat:@"<red>【赠品】</red>%@",item.name] attributedStringWithStyleBook:style123];
            shoppingName.font = [UIFont systemFontOfSize:13];
            
            [Cell.contentView addSubview:shoppingName];

        }else{
        UILabel* shoppingName = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, ScreenWidth-120, 45)];
		shoppingName.backgroundColor = [UIColor clearColor];
		shoppingName.numberOfLines = 0;
		shoppingName.lineBreakMode = UILineBreakModeWordWrap;
		shoppingName.text = item.name;
		shoppingName.font = [UIFont systemFontOfSize:13];
		shoppingName.textColor = [UIColor blackColor];
		[Cell.contentView addSubview:shoppingName];
		}
        //end
            
		UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, 50, 20)];
		colorName.backgroundColor = [UIColor clearColor];
		colorName.text = @"颜色：";
		colorName.font = [UIFont systemFontOfSize:12];
		colorName.textColor = [UIColor colorWithHexString:@"0x666666"];
		[Cell.contentView addSubview:colorName];
		
		UILabel* sizeName = [[UILabel alloc] initWithFrame:CGRectMake(110, 80, 50, 20)];
		sizeName.backgroundColor = [UIColor clearColor];
		sizeName.text = @"尺码：";
		sizeName.font = [UIFont systemFontOfSize:12];
		sizeName.textColor = [UIColor colorWithHexString:@"0x666666"];
		[Cell.contentView addSubview:sizeName];
		
		UILabel* priceName = [[UILabel alloc] initWithFrame:CGRectMake(224, 80, 50, 20)];
		priceName.backgroundColor = [UIColor clearColor];
		priceName.text = @"单价：";
		priceName.font = [UIFont systemFontOfSize:12];
		priceName.textColor = [UIColor colorWithHexString:@"0x666666"];
		[Cell.contentView addSubview:priceName];
		
		UILabel* numberName = [[UILabel alloc] initWithFrame:CGRectMake(224, 60, 50, 20)];
		numberName.backgroundColor = [UIColor clearColor];
		numberName.text = @"数量：";
		numberName.font = [UIFont systemFontOfSize:12];
		numberName.textColor = [UIColor colorWithHexString:@"0x666666"];
		[Cell.contentView addSubview:numberName];
		
		UILabel* colorValue = [[UILabel alloc] initWithFrame:CGRectMake(150, 60, 74, 20)];
		colorValue.backgroundColor = [UIColor clearColor];
        colorName.textAlignment = UITextAlignmentLeft;
		colorValue.text = item.color;
		colorValue.font = [UIFont systemFontOfSize:12];
		colorValue.textColor = [UIColor colorWithHexString:@"0x666666"];
		[Cell.contentView addSubview:colorValue];
		
		UILabel* sizeValue = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 50, 20)];
		sizeValue.backgroundColor = [UIColor clearColor];
        sizeValue.textAlignment = UITextAlignmentLeft;

		sizeValue.text = item.size;
		sizeValue.font = [UIFont systemFontOfSize:12];
		sizeValue.textColor = [UIColor colorWithHexString:@"0x666666"];
		[Cell.contentView addSubview:sizeValue];
		
		UILabel* priceValue = [[UILabel alloc] initWithFrame:CGRectMake(254, 80, 100, 20)];
		priceValue.backgroundColor = [UIColor clearColor];
		priceValue.text = [NSString stringWithFormat:@" ￥%@",item.price];;
		priceValue.font = [UIFont systemFontOfSize:12];
		priceValue.textColor = [UIColor colorWithHexString:@"0x666666"];
		[Cell.contentView addSubview:priceValue];
		
		UILabel* numberValue = [[UILabel alloc] initWithFrame:CGRectMake(254, 59, 50, 20)];
		numberValue.backgroundColor = [UIColor clearColor];
		numberValue.text = [NSString stringWithFormat:@"  %@",item.number];
		numberValue.font = [UIFont systemFontOfSize:12];
		numberValue.textColor = [UIColor colorWithHexString:@"0x666666"];
		[Cell.contentView addSubview:numberValue];
        
        UIFont *font = [UIFont systemFontOfSize:LabMidSize];
        
        //分割线
        UIView *seplineView = [[UIView alloc] init];
        [seplineView setFrame:CGRectMake(0, 130, ScreenWidth, 0.5)];
        [seplineView setBackgroundColor:[UIColor colorWithHexString:@"E6E6E6"]];
        [Cell addSubview:seplineView];
        
        //积分
        UILabel *jifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 137, 88, 25)];
        jifenLabel.backgroundColor = [UIColor clearColor];
        jifenLabel.textAlignment = UITextAlignmentCenter;
        jifenLabel.font = font;//[UIFont systemFontOfSize:font];
        jifenLabel.text = [NSString stringWithFormat:@"积分： %ld",(long)item.score];
        [Cell.contentView addSubview:jifenLabel];
        
        NSString *strTotal = @"总价： ";
		UILabel* caseName = [[UILabel alloc] initWithFrame:CGRectMake(lee1fitAllScreen(204), 137, 50, 25)];
		caseName.backgroundColor = [UIColor clearColor];
		caseName.text = strTotal;
		caseName.font = font;
		caseName.textColor = [UIColor colorWithHexString:@"0x666666"];
		[Cell.contentView addSubview:caseName];
        
        NSString *str = [NSString stringWithFormat:@"  ¥%.2f",[item.subtotal floatValue]];
		UILabel* caseValue = [[UILabel alloc] initWithFrame:CGRectMake(lee1fitAllScreen(234), 137, 100, 25)];
		caseValue.backgroundColor = [UIColor clearColor];
		caseValue.text = str;
		caseValue.font = font;
		caseValue.textColor = [UIColor colorWithHexString:@"0xB90023"] ;
		[Cell.contentView addSubview:caseValue];
        
        if (i != [mycheckOutModel.checkoutProductlist count]-1) {
            
            UIView *seplineView2 = [[UIView alloc] init];
            //        [seplineView2 setFrame:CGRectMake(0, 169.5, ScreenWidth, 8)];
            [seplineView2 setFrame:CGRectMake(0, caseValue.frame.origin.y+caseValue.frame.size.height+8, ScreenWidth, 8)];
            
            [seplineView2 setBackgroundColor:[UIColor colorWithHexString:@"E6E6E6"]];
            [Cell addSubview:seplineView2];
        }
		
		[tableCells addObject:Cell];
	}
}


-(void)createSuitlistcells
//-----V2
{
    [suitlistcell removeAllObjects];
    suitCount = [mycheckOutModel.suitlist count];
    
    for (int j=0; j<[mycheckOutModel.suitlist count]; j++) {
        YKSuitListItem* item = [mycheckOutModel.suitlist objectAtIndex:j];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1];
        
        static NSString	*CellSuitlist3 = @"Cell3";
        UITableViewCell *viewSuitlistCell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellSuitlist3];
        viewSuitlistCell3.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UIFont *font = [UIFont systemFontOfSize:13];
        CGFloat xOffset = 20;
        CGFloat yOffset = 16;
        CGFloat height = 14;
        
        UILabel* pName = [[UILabel alloc] init];
        pName.backgroundColor = [UIColor clearColor];
        pName.lineBreakMode = UILineBreakModeTailTruncation;
        pName.text = [NSString stringWithFormat:@"套装：%@",item.name];
        pName.font = [UIFont systemFontOfSize:14];
        pName.textColor = [UIColor blackColor];//UIColorFromRGB(0xc8002c);//;//UIColorFromRGB(0x666666);
        NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
        [mps setLineBreakMode:pName.lineBreakMode];
        CGRect rcName = [pName.text boundingRectWithSize:CGSizeMake((lee1fitAllScreen(204) - xOffset), MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : pName.font, NSParagraphStyleAttributeName : mps} context:nil];
        [pName setFrame:CGRectMake(xOffset, yOffset - (rcName.size.height > pName.font.pointSize ? rcName.size.height - pName.font.pointSize : 0), (lee1fitAllScreen(204) - xOffset), rcName.size.height)];
        [viewSuitlistCell3 addSubview:pName];
        
        NSString *str = @"套装价: ";
        int strWidth = [str sizeWithFont:font].width;
        UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset + 20, strWidth, height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.text = str;
        desc.font = [UIFont systemFontOfSize:14];
        desc.textColor = UIColorFromRGB(0x181818);/*UIColorFromRGB(0x666666)*/
        [viewSuitlistCell3 addSubview:desc];
        xOffset += strWidth;
        
        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, desc.frame.origin.y, 90, height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.text = [NSString stringWithFormat:@"￥%.2f", item.disountprice];
        desc.font = [UIFont systemFontOfSize:14];
        desc.textColor = UIColorFromRGB(0xc8002c);
        [viewSuitlistCell3 addSubview:desc];
        xOffset = lee1fitAllScreen(204);
        
        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, desc.frame.origin.y, 110, height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.lineBreakMode = UILineBreakModeMiddleTruncation;
        desc.text = [NSString stringWithFormat:@"积分: %d", item.suit_score];
        desc.font = [UIFont systemFontOfSize:14];
        desc.textColor = UIColorFromRGB(0x666666);
        [viewSuitlistCell3 addSubview:desc];
        
        
        NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14],
                                 @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:14],
                                 @"red": [UIColor colorWithHexString:@"666666"]};
        
        
        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, pName.frame.origin.y, ScreenWidth - xOffset - 12, rcName.size.height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.lineBreakMode = UILineBreakModeMiddleTruncation;
        desc.attributedText = [[NSString stringWithFormat:@"<red>数量：</red>%d",item.number] attributedStringWithStyleBook:style1];
        //        desc.text = [NSString stringWithFormat:@"数量: %d", item.number];
        desc.font = [UIFont systemFontOfSize:14];
        [viewSuitlistCell3 addSubview:desc];
        
        [array addObject:viewSuitlistCell3];
        
        
        xOffset = 20;
        
        for (int k = 0; k<[item.suits count]; k++) {
            static NSString	*CellIdentifier2 = @"Cell2";
            UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier2];
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, 0, ScreenWidth - 12, 1)];
            [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d0d0d0"]];
            [Cell addSubview:lblSep];
            
            YKProductsItem *pItem = [item.suits objectAtIndex:k];
            BOOL showStock = NO;
            if (pItem.stock && ![pItem.stock isKindOfClass:[NSNull class]] && ![pItem.stock isEqualToString:@""]) {
                showStock = YES;
            }
            
            UrlImageView* shoppingImg = [[UrlImageView alloc] init];
            [shoppingImg setImageFromUrl:YES withUrl:pItem.pic];
            shoppingImg.frame = CGRectMake(xOffset, 12, lee1fitAllScreen(70), lee1fitAllScreen(90));
            //shoppingImg.backgroundColor = [UIColor clearColor];
            [Cell addSubview:shoppingImg];
            
            CGFloat fTextWidth = ScreenWidth - shoppingImg.frame.size.width - xOffset - 12;
            
            int yOffset = 6;
            if (!showStock) {
                yOffset += 8;
            }
            
            CGFloat nameHeight = showStock ? 40 : 45;
            UILabel* shoppingName = [[UILabel alloc] initWithFrame:CGRectMake(shoppingImg.frame.origin.x + shoppingImg.frame.size.width + 16, yOffset, fTextWidth/*shoppingCarTab.editing ? 160 : 190*/, nameHeight)];
            shoppingName.backgroundColor = [UIColor clearColor];
            shoppingName.numberOfLines = 0;
            shoppingName.lineBreakMode = UILineBreakModeWordWrap;
            shoppingName.text = pItem.name;
            shoppingName.font = [UIFont systemFontOfSize:13];
            shoppingName.textColor = [UIColor colorWithHexString:@"#181818"];
            [Cell addSubview:shoppingName];
            
            yOffset += nameHeight;
            
            if (showStock) {
                UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(shoppingImg.frame.origin.x + shoppingImg.frame.size.width + 16, yOffset, fTextWidth, 12)];
                desc.backgroundColor = [UIColor clearColor];
                desc.text = pItem.stock;
                desc.font = [UIFont systemFontOfSize:12];
                desc.textColor = [UIColor colorWithHexString:@"#c8002c"];
                [Cell addSubview:desc];
                
                yOffset += 12;
            }
            yOffset = 64;
            UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(shoppingImg.frame.origin.x + shoppingImg.frame.size.width + 16, 64, fTextWidth/*shoppingCarTab.editing?160:170*/, 13)];
            colorName.backgroundColor = [UIColor clearColor];
            colorName.lineBreakMode = UILineBreakModeMiddleTruncation;
            colorName.text = [NSString stringWithFormat:@"颜色: %@    尺码: %@", pItem.color, pItem.size];
            colorName.font = [UIFont systemFontOfSize:13];
            colorName.textColor = UIColorFromRGB(0x666666);
            [Cell addSubview:colorName];
            
            yOffset += 13;
            
            UILabel* priceName = [[UILabel alloc] initWithFrame:CGRectMake(shoppingImg.frame.origin.x + shoppingImg.frame.size.width + 16, 89, fTextWidth, 13)];
            priceName.backgroundColor = [UIColor clearColor];
            priceName.text = [NSString stringWithFormat:@"单价: ￥%.2f", pItem.price];
            priceName.font = [UIFont systemFontOfSize:13];
            priceName.textColor = UIColorFromRGB(0x666666);
            [Cell addSubview:priceName];
            [array addObject:Cell];
        }
        
        [suitlistcell addObject:array];
    }
}


#pragma mark 创建礼包列表
-(void)createPackagelistcells
{
    [packagelistcell removeAllObjects];
    packageCount = [mycheckOutModel.packagelist count];
    
    for (int j=0; j<[mycheckOutModel.packagelist count]; j++) {
        YKSuitListItem* item = [mycheckOutModel.packagelist objectAtIndex:j];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1];
        
        static NSString	*CellSuitlist3 = @"Cell4";
        UITableViewCell *viewSuitlistCell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellSuitlist3];
        viewSuitlistCell3.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UIFont *font = [UIFont systemFontOfSize:13];
        CGFloat xOffset = 20;//28 + lee1fitAllScreen(28);
        CGFloat yOffset = 16;
        
        
        UILabel* pName = [[UILabel alloc] init];
        pName.backgroundColor = [UIColor clearColor];
        pName.lineBreakMode = UILineBreakModeTailTruncation;
        pName.text = [NSString stringWithFormat:@"礼包：%@",item.name];
        pName.font = [UIFont systemFontOfSize:14];
        pName.textColor = [UIColor blackColor];//[UIColor colorWithHexString:@"0xc8002c"];//UIColorFromRGB(0x666666);
        NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
        [mps setLineBreakMode:pName.lineBreakMode];
        CGRect rcName = [pName.text boundingRectWithSize:CGSizeMake((lee1fitAllScreen(204) - xOffset), MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : pName.font, NSParagraphStyleAttributeName : mps} context:nil];
        [pName setFrame:CGRectMake(xOffset, yOffset - (rcName.size.height > pName.font.pointSize ? rcName.size.height - pName.font.pointSize : 0), (lee1fitAllScreen(204) - xOffset), rcName.size.height)];
        [viewSuitlistCell3 addSubview:pName];
        
        NSString *str = @"礼包价: ";
        CGFloat strWidth = [str sizeWithFont:font].width;
        UILabel* price = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset + 20, strWidth, rcName.size.height)];
        price.backgroundColor = [UIColor clearColor];
        price.text = str;
        price.font = [UIFont systemFontOfSize:14];
        price.textColor = UIColorFromRGB(0x181818);/*UIColorFromRGB(0x666666)*/
        [viewSuitlistCell3 addSubview:price];
        xOffset += strWidth;
        
        UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, price.frame.origin.y, 90, rcName.size.height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.text = [NSString stringWithFormat:@"￥%.2f", item.disountprice];
        desc.font = [UIFont systemFontOfSize:14];
        desc.textColor = UIColorFromRGB(0xc8002c);
        [viewSuitlistCell3 addSubview:desc];
        xOffset = lee1fitAllScreen(204);
        
        UILabel* save = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, price.frame.origin.y, 110, rcName.size.height)];
        save.backgroundColor = [UIColor clearColor];
        save.lineBreakMode = UILineBreakModeMiddleTruncation;
        save.text = [NSString stringWithFormat:@"积分: %d", item.suit_score];
        save.font = [UIFont systemFontOfSize:14];
        save.textColor = UIColorFromRGB(0x666666);//UIColorFromRGB(0x666666);
        [viewSuitlistCell3 addSubview:save];
        
        NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14],
                                 @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:14],
                                 @"red": [UIColor colorWithHexString:@"666666"]};
        
        UILabel* number = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, pName.frame.origin.y, ScreenWidth - xOffset - 12, rcName.size.height)];
        number.backgroundColor = [UIColor clearColor];
        number.lineBreakMode = UILineBreakModeMiddleTruncation;
        number.attributedText = [[NSString stringWithFormat:@"<red>数量：</red>%d",1] attributedStringWithStyleBook:style1];
        number.font = [UIFont systemFontOfSize:14];
        [viewSuitlistCell3 addSubview:number];
        
        [array addObject:viewSuitlistCell3];
        
        
        xOffset = 20;
        
        for (int k = 0; k<[item.suits count]; k++) {
            static NSString	*CellIdentifier2 = @"Cell5";
            UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier2];
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, 0, ScreenWidth - 12, 1)];
            [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d0d0d0"]];
            [Cell addSubview:lblSep];
            
            YKProductsItem *pItem = [item.suits objectAtIndex:k];
            BOOL showStock = NO;
            if (pItem.stock && ![pItem.stock isKindOfClass:[NSNull class]] && ![pItem.stock isEqualToString:@""]) {
                showStock = YES;
            }
            
            UrlImageView* shoppingImg = [[UrlImageView alloc] init];
            [shoppingImg setImageFromUrl:YES withUrl:pItem.pic];
            shoppingImg.frame = CGRectMake(xOffset, 12, lee1fitAllScreen(70), lee1fitAllScreen(90));
            //shoppingImg.backgroundColor = [UIColor clearColor];
            [Cell addSubview:shoppingImg];
            
            CGFloat fTextWidth = ScreenWidth - shoppingImg.frame.size.width - xOffset - 12 - 16;
            
            int yOffset = 6;
            if (!showStock) {
                yOffset += 8;
            }
            
            CGFloat nameHeight = showStock ? 40 : 45;
            UILabel* shoppingName = [[UILabel alloc] initWithFrame:CGRectMake(shoppingImg.frame.origin.x + shoppingImg.frame.size.width + 16, yOffset, fTextWidth/*shoppingCarTab.editing ? 160 : 190*/, nameHeight)];
            shoppingName.backgroundColor = [UIColor clearColor];
            shoppingName.numberOfLines = 0;
            shoppingName.lineBreakMode = UILineBreakModeWordWrap;
            shoppingName.text = pItem.name;
            shoppingName.font = [UIFont systemFontOfSize:13];
            shoppingName.textColor = [UIColor colorWithHexString:@"#181818"];
            [Cell addSubview:shoppingName];
            
            yOffset += nameHeight;
            
            if (showStock) {
                UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(shoppingImg.frame.origin.x + shoppingImg.frame.size.width + 16, yOffset, fTextWidth, 12)];
                desc.backgroundColor = [UIColor clearColor];
                desc.text = pItem.stock;
                desc.font = [UIFont systemFontOfSize:12];
                desc.textColor = [UIColor colorWithHexString:@"#c8002c"];
                [Cell addSubview:desc];
                
                yOffset += 12;
            }
            yOffset = 64;
            UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(shoppingImg.frame.origin.x + shoppingImg.frame.size.width + 16, 64, fTextWidth/*shoppingCarTab.editing?160:170*/, 13)];
            colorName.backgroundColor = [UIColor clearColor];
            colorName.lineBreakMode = UILineBreakModeMiddleTruncation;
            colorName.text = [NSString stringWithFormat:@"颜色: %@    尺码: %@", pItem.color, pItem.size];
            colorName.font = [UIFont systemFontOfSize:13];
            colorName.textColor = UIColorFromRGB(0x666666);
            [Cell addSubview:colorName];
            
            yOffset += 13;
            
            UILabel* priceName = [[UILabel alloc] initWithFrame:CGRectMake(shoppingImg.frame.origin.x + shoppingImg.frame.size.width + 16, 89, fTextWidth, 13)];
            priceName.backgroundColor = [UIColor clearColor];
            priceName.text = [NSString stringWithFormat:@"单价: ￥%.2f", pItem.price];
            priceName.font = [UIFont systemFontOfSize:13];
            priceName.textColor = UIColorFromRGB(0x666666);
            [Cell addSubview:priceName];
            [array addObject:Cell];
        }
        
        [packagelistcell addObject:array];
    }
}

#pragma mark-- 其他cell
-(void)createOtherCells{
    NSLog(@"createOtherCells  come in");
	[otherCells removeAllObjects];
	
	NSArray* titleArray = [[NSArray alloc] initWithObjects:
                           @"收货人信息（必填）",
                           @"订单附言",
                           @"支付方式",
                           @"使用优惠券",
                           @"使用电子券",
                           @"使用包邮卡",
                           nil];
    static NSString	* CellIdentifier = @"Cell";
	for (int i = 0; i < 6; i ++) {
		UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:CellIdentifier];
		Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
		if (i == 0) {//地址
            
            height_d = 70; //如果地址有内容 cell section 的高度
            
            UILabel* name2 = nil;
            
			if (self.addressItem_ben != nil)
            {
				self.straddressID = self.addressItem_ben.addresslistIdentifier;
				UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5,ScreenWidth-46, 30)];
				name.backgroundColor = [UIColor clearColor];
				name.font = [UIFont systemFontOfSize:LabMidSize];
				name.text = self.addressItem_ben.userName;
				[Cell addSubview:name];

				UILabel* address2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, ScreenWidth-46, 35)];
				address2.backgroundColor = [UIColor clearColor];
				address2.font = [UIFont systemFontOfSize:14];
				NSString* addresss1 = [NSString stringWithFormat:@"地址：%@%@%@%@",self.addressItem_ben.province,self.addressItem_ben.city,self.addressItem_ben.county,self.addressItem_ben.address];
                
                self.province = self.addressItem_ben.province;
				address2.text = addresss1;
				address2.numberOfLines = 0;
				address2.lineBreakMode = UILineBreakModeWordWrap;
				address2.textColor = [UIColor colorWithHexString:@"0x666666"];;
				[Cell addSubview:address2];

				UILabel* phone = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, lee1fitAllScreen(280), 25)];
				phone.backgroundColor = [UIColor clearColor];
				phone.font = [UIFont systemFontOfSize:14];
				phone.textColor = [UIColor colorWithHexString:@"0x666666"];;
				phone.text = [NSString stringWithFormat:@"电话：%@",self.addressItem_ben.mobile];
				[Cell addSubview:phone];
			}
            else if ([mycheckOutModel.checkoutConsigneeinfo count] >0)
            {
                YKAdressItem* addressItem = nil;
                
                for (YKAdressItem *temp in mycheckOutModel.checkoutConsigneeinfo) {
                    if ([temp.default_flag isEqualToString:@"yes"]) {
                        if ([temp.default_flag isEqualToString:@"yes"]) {
                            addressItem = temp;
                        }
                        else {
                            addressItem = (YKAdressItem*)[mycheckOutModel.checkoutConsigneeinfo objectAtIndex:[mycheckOutModel.checkoutConsigneeinfo count]-1];
                        }
                    }
                }
                
				self.straddressID = addressItem.addressId;
                self.province = addressItem.province;
                
				UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-46, 30)];
				name.backgroundColor = [UIColor clearColor];
				name.font = [UIFont systemFontOfSize:LabMidSize];
				name.text = addressItem.user_name;
				[Cell addSubview:name];

				
				UILabel* address2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, ScreenWidth-46, 35)];
				address2.backgroundColor = [UIColor clearColor];
				address2.font = [UIFont systemFontOfSize:14];
				NSString* addresss1 = [NSString stringWithFormat:@"地址：%@%@%@%@",addressItem.province,addressItem.city,addressItem.county,addressItem.address];
				address2.text = addresss1;
				address2.numberOfLines = 0;
				address2.lineBreakMode = UILineBreakModeWordWrap;
				address2.textColor = [UIColor colorWithHexString:@"0x666666"];;
				[Cell addSubview:address2];

				
				UILabel* phone = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, 280, 25)];
				phone.backgroundColor = [UIColor clearColor];
				phone.font = [UIFont systemFontOfSize:14];
				phone.textColor = [UIColor colorWithHexString:@"0x666666"];;
				phone.text = [NSString stringWithFormat:@"电话：%@",addressItem.mobile];
				[Cell addSubview:phone];

			}else {
				
                height_d = 0;// 地址没有信息
             
                name2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, ScreenWidth-20, 30)];
				name2.text = [titleArray objectAtIndex:i];
				name2.backgroundColor = [UIColor clearColor];
				name2.font = [UIFont systemFontOfSize:LabMidSize];
				name2.textColor = [UIColor colorWithHexString:@"0x666666"];;
				[Cell.contentView addSubview:name2];
			}
            
            [Cell.contentView bringSubviewToFront:name2];

			Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
		}
        else if (i == 1) {//附言
            
			if ([self.postText isEqualToString:@""] || self.postText == nil) {
				UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, ScreenWidth-46, 30)];
				name.text = [titleArray objectAtIndex:i];
				name.backgroundColor = [UIColor clearColor];
				name.font = [UIFont systemFontOfSize:LabMidSize];
				name.textColor = [UIColor colorWithHexString:@"0x666666"];;
                name.tag=1154;
				[Cell.contentView addSubview:name];
			} else {
				UIFont *font = [UIFont systemFontOfSize:14];
                CGSize size = [self.postText sizeWithFont:font constrainedToSize:CGSizeMake(ScreenWidth-40, 10000) lineBreakMode:NSLineBreakByWordWrapping];
                
                CGFloat heigth;
                heigth = size.height;
                
                if (heigth > 18) {
                    
                } else {
                    heigth+=10;
                }
                
                UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, ScreenWidth-46, heigth)];
				name.text = self.postText;
				name.numberOfLines = 0;
				name.lineBreakMode = UILineBreakModeWordWrap;
				name.backgroundColor = [UIColor clearColor];
				name.font = [UIFont systemFontOfSize:14];
				name.textColor = [UIColor colorWithHexString:@"0x666666"];;
				[Cell.contentView addSubview:name];
                
                if ([self.postText isEqualToString:[titleArray objectAtIndex:i]]) {
                    name.font = [UIFont systemFontOfSize:LabMidSize];
                }
			}
			Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
        else if (i == 2) { //新增付款方式选择
            
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            OHAttributedLabel *name = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(10, 5+5+2, 300, 30)];
            name.userInteractionEnabled = NO;
            
            
            if ((self.m_strPayMethod == nil) || ([self.m_strPayMethod isEqualToString:@""])) {
                NSMutableAttributedString *attributeStr = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:i]]];
                [attributeStr setTextColor:[UIColor colorWithHexString:@"0x666666"]];
                [attributeStr setFont:[UIFont systemFontOfSize:LabMidSize]];
                
                name.attributedText = attributeStr;
                
                } else {
                //选择的支付方式
                if (self.selectIndex < [[mycheckOutModel checkoutPaywayNew] count]) {
                    [[mycheckOutModel checkoutPaywayNew] objectAtIndex:self.selectIndex];
                    NSInteger index = 0;
                    for (NSDictionary * a in [mycheckOutModel checkoutPaywayNew]) {
                        if (index == self.selectIndex) {
                            NSString * str = [[NSString alloc] initWithFormat:@"支付方式：%@", [a objectForKey:@"desc"]];
                            self.str_pay_Way = [NSString stringWithFormat:@"%@",[a objectForKey:@"id"]];
                            
                            NSMutableAttributedString *attributeStr = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@",str]];
                            [attributeStr setTextColor:[UIColor redColor]];
                            NSRange textRange = [str rangeOfString:@"支付方式："];
                            [attributeStr setTextColor:[UIColor colorWithHexString:@"0x666666"] range:textRange];
                            [attributeStr setFont:[UIFont systemFontOfSize:LabMidSize]];
                            
                            name.attributedText = attributeStr;
                        }
                        index++;
                    }
                } else {
                    
                    NSMutableAttributedString *attributeStr = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:i]]];
                    [attributeStr setTextColor:[UIColor colorWithHexString:@"0x666666"]];
                    [attributeStr setFont:[UIFont systemFontOfSize:LabMidSize]];
                    name.attributedText = attributeStr;
                }
			}
            name.backgroundColor = [UIColor clearColor];
            [Cell.contentView addSubview:name];
            Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else if (i == 3) {//优惠券
            
            UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 150, 30)];
            name.text = [titleArray objectAtIndex:i];
            name.backgroundColor = [UIColor clearColor];
            name.font = [UIFont systemFontOfSize:LabMidSize];
            name.textColor = [UIColor colorWithHexString:@"0x666666"];;
            [Cell.contentView addSubview:name];
            
            
            if (!mycheckOutModel.checkout_usecouponcard) {
                
                UILabel* name2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, ScreenWidth-60, 30)];
                [name2 setTextAlignment:NSTextAlignmentRight];
                name2.text = [NSString stringWithFormat:@"您有%lu张优惠券可用",(unsigned long)[mycheckOutModel.arrCheckout_couponcard count]];
                name2.backgroundColor = [UIColor clearColor];
                name2.font = [UIFont systemFontOfSize:LabSmallSize];
                name2.textColor = [UIColor colorWithHexString:@"0x666666"];;
                [Cell.contentView addSubview:name2];
                
                Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            } else {
                
                UILabel* name2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 8, ScreenWidth-120, 30)];
                name2.text = @"已使用";
                name2.backgroundColor = [UIColor clearColor];
                name2.font = [UIFont systemFontOfSize:LabSmallSize];
                name2.textColor = [UIColor redColor];
                [Cell.contentView addSubview:name2];
                
                UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
                [cancle setTitle:@"取消" forState:UIControlStateNormal];
                [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                cancle.titleLabel.font = [UIFont systemFontOfSize:13];
                [cancle setFrame:CGRectMake(ScreenWidth-80, 5, 50, 31)];
                [cancle setBackgroundImage:[UIImage imageNamed:@"signup_btn.png"] forState:UIControlStateNormal];
                [cancle addTarget:self action:@selector(cancleCouponcard) forControlEvents:UIControlEventTouchUpInside];
                [Cell.contentView addSubview:cancle];
                
                
                Cell.accessoryType = UITableViewCellAccessoryNone;

            }
        }
        else if (i == 4){
            //会员卡
            
            
            UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 150, 30)];
            name.text = [titleArray objectAtIndex:i];
            name.backgroundColor = [UIColor clearColor];
            name.font = [UIFont systemFontOfSize:LabMidSize];
            name.textColor = [UIColor colorWithHexString:@"0x666666"];;
            [Cell.contentView addSubview:name];
            
            
            if (!mycheckOutModel.checkout_usev6cards || [self.usev6useCardId isEqualToString:@""]) {
                
                UILabel* name2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, ScreenWidth-60, 30)];
                [name2 setTextAlignment:NSTextAlignmentRight];
                
                if (mycheckOutModel.checkoutCountv6 >0) {
                    NSArray *arr = mycheckOutModel.checkoutV6cards;
                    
                    name2.text = [NSString stringWithFormat:@"您有%@元电子券可用",[[arr objectAtIndex:0]objectForKey:@"balance" isDictionary:nil]];
                }else{
                    name2.text = [NSString stringWithFormat:@"您没有可用的电子券"];
                }
                name2.backgroundColor = [UIColor clearColor];
                name2.font = [UIFont systemFontOfSize:LabSmallSize];
                name2.textColor = [UIColor colorWithHexString:@"0x666666"];;
                [Cell.contentView addSubview:name2];
                
                Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else {
                
                UILabel* name2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 8, ScreenWidth-120, 30)];
                name2.text = @"已使用";
                name2.backgroundColor = [UIColor clearColor];
                name2.font = [UIFont systemFontOfSize:LabSmallSize];
                name2.textColor = [UIColor redColor];
                [Cell.contentView addSubview:name2];
                
                UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
                [cancle setTitle:@"取消" forState:UIControlStateNormal];
                [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                cancle.titleLabel.font = [UIFont systemFontOfSize:13];
                [cancle setFrame:CGRectMake(ScreenWidth-80, 5, 50, 31)];
                [cancle setBackgroundImage:[UIImage imageNamed:@"signup_btn.png"] forState:UIControlStateNormal];
                [cancle addTarget:self action:@selector(canclev6useCard) forControlEvents:UIControlEventTouchUpInside];
                [Cell.contentView addSubview:cancle];
                
                Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }

		}
        else if (i == 5){
            //包邮卡
            
            UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 150, 30)];
            name.text = [titleArray objectAtIndex:i];
            name.backgroundColor = [UIColor clearColor];
            name.font = [UIFont systemFontOfSize:LabMidSize];
            name.textColor = [UIColor colorWithHexString:@"0x666666"];;
            [Cell.contentView addSubview:name];
            
            if (!mycheckOutModel.checkout_freepostcard || [self.usefreepostcardId isEqualToString:@""]) {
                
                UILabel* name2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, ScreenWidth-60, 30)];
                [name2 setTextAlignment:NSTextAlignmentRight];
                name2.text = [NSString stringWithFormat:@"您有%lu张包邮卡可用",(unsigned long)[mycheckOutModel.checkout_freepostcard count]];
                name2.backgroundColor = [UIColor clearColor];
                name2.font = [UIFont systemFontOfSize:LabSmallSize];
                name2.textColor = [UIColor colorWithHexString:@"0x666666"];;
                [Cell.contentView addSubview:name2];
                
                Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else {
                
                UILabel* name2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 8, ScreenWidth-120, 30)];
                name2.text = @"已使用";
                name2.backgroundColor = [UIColor clearColor];
                name2.font = [UIFont systemFontOfSize:LabSmallSize];
                name2.textColor = [UIColor redColor];
                [Cell.contentView addSubview:name2];
                
                UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
                [cancle setTitle:@"取消" forState:UIControlStateNormal];
                [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                cancle.titleLabel.font = [UIFont systemFontOfSize:13];
                [cancle setFrame:CGRectMake(ScreenWidth-80, 5, 50, 31)];
                [cancle setBackgroundImage:[UIImage imageNamed:@"signup_btn.png"] forState:UIControlStateNormal];
                [cancle addTarget:self action:@selector(canclefreepostcard) forControlEvents:UIControlEventTouchUpInside];
                [Cell.contentView addSubview:cancle];
                
                Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
        }
        
        [otherCells addObject:Cell];
	}
NSLog(@"createOtherCells  come out");
}

#pragma mark ---优惠券 包邮卡等

-(void)SelectCouponIndex:(NSInteger)index withslelectTag:(NSInteger)tag withCodeValue:(NSString *)value{
    
    if (tag == 1)
    {
        //礼品卡
        self.useCouponcardId = value;
    }else if (tag == 2)
    {
    //会员卡
        self.usev6useCardId = value;
        
    }else if(tag == 3){
    //包邮卡
        self.usefreepostcardId = value;
    }
}

#pragma mark --- 取消使用
- (void) cancleCouponcard {
    
    self.useCouponcardId = @"";
    
    if (!self.useCouponcardId) {
        self.useCouponcardId = @"";
    }
    
    [self cancleUsedcard];
}

- (void) canclev6useCard {
    
    self.usev6useCardId = @"";
    [self cancleUsedcard];
}

- (void) canclefreepostcard {
 self.usefreepostcardId = @"";
    [self cancleUsedcard];
}

-(void)cancleUsedcard{
    [mainSev getCheckout:self.straddressID andV6usercard_id:self.usev6useCardId andCouponcard:self.useCouponcardId payway:self.m_strPayMethod andfreepostcard:self.usefreepostcardId];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}



- (void)rightButAction {
    
    [self tijiao];
    
}

- (void)popBackAnimate:(UIButton *)sender {
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) poptdo {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 0) {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark -
#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6+ 1  + suitCount + packageCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 1;
    }
    else if (section == 2) {
        return 1;
    }else if (section == 3) {
        return 1;
    }else if (section == 4) {
        return 1;
    }else if (section == 5) {
        return 1;
    }else{
        
        if (section - 6 < suitCount) {
            //lee999  这个地方是套装的cell
            return [(NSMutableArray*)[suitlistcell objectAtIndex:section-6 isArray:nil] count];
            
        }else if (section -6 -suitCount < packageCount){
            //lee999  这个地方是礼包的cell
            return [(NSMutableArray*)[packagelistcell objectAtIndex:section-6-suitCount isArray:nil] count];
        }else{
            //lee999  这个地方是普通商品的cell
            return [tableCells count];
        }
    }
	return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    
    switch (section) {
        case 0:
        {
            //地址
            if (height_d > 0){
                return height_d+45;
            }else {
                return 45;
            }
        }
            break;
        case 1:
        {
            if ([self.postText isEqualToString:@""] || self.postText == nil || [self.postText hasPrefix:@"订单附言"]) {
                self.postText = @"订单附言";
                return 45;
            }else {
                CGSize size = [self.postText sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(ScreenWidth-60, 10000) lineBreakMode:NSLineBreakByWordWrapping];
                if (size.height > 18) {
                    return size.height+15;
                } else {
                    
                    return 45;
                    // return size.height+20;
                }
            }
        }
            break;
        case 2:
        {
            return 45;
        }
            break;
        case 3:
        {
            return 45;
        }
            break;
        case 4:
        {
            return 45;
        }
            break;
        case 5:
        {
            return 45;
        }
            break;
            
        default:
        {
            
            if (section - 6 < suitCount) {
                //lee999  这个地方是套装的cell
                if (indexPath.row == 0) {
                    return 66;
                }
//                //+1 lee9 为了加上分割线
//                else if (indexPath.row == [(NSMutableArray*)[suitlistcell objectAtIndex:section-6 isArray:nil] count])
//                {
//                    return 8;
//                }
                return lee1fitAllScreen(116);
                
            }else if (section -6 -suitCount < packageCount){
                //lee999  这个地方是礼包的cell
                if (indexPath.row == 0) {
                    return 66;
                }
//                //+1 为了加上分割线
//                else if (indexPath.row == [(NSMutableArray*)[packagelistcell objectAtIndex:section-6-suitCount isArray:nil] count])
//                {
//                    return 8;
//                }
                return lee1fitAllScreen(116);
                
            }else{
                //lee999  这个地方是普通商品的cell
                return 180;//lee1fitAllScreen(150);
            }
        }
            break;
    }
    return 160;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 ||section == 2 ||section == 3 ||section == 4) {
        return 0.5;
    }
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *fv = [[UIView alloc] init];
    [fv setBackgroundColor:[UIColor colorWithHexString:@"E6E6E6"]];
    return fv;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (section< 6) {
        return [otherCells objectAtIndex:section];
    }
    else if (section - 6 < suitCount) {
        //lee999  这个地方是套装的cell
        return [[suitlistcell objectAtIndex:section-6 isArray:nil] objectAtIndex:indexPath.row isArray:nil];
        
    }else if (section -6 -suitCount < packageCount){
        //lee999  这个地方是礼包的cell
        return [[packagelistcell objectAtIndex:section-6 -suitCount isArray:nil] objectAtIndex:indexPath.row isArray:nil];
    }else{
        //lee999  这个地方是普通商品的cell
        return [tableCells objectAtIndex:indexPath.row isArray:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section == 0) {
        //地址选择
        AddressViewController* addressView = [[AddressViewController alloc] initWithNibName:@"AddressViewController" bundle:nil];
        addressView.chectOutViewC = self;
        addressView.PublicStringAddressId=self.straddressID;
        addressView.isCar = YES;
        [self.navigationController pushViewController:addressView animated:YES];

	}
    else if (section == 1) {
        //订单附言
        YKOrderPostscriptView* post = [[YKOrderPostscriptView alloc] init];
        post.checkOut = self;
        if ([self.postText isEqualToString:@"订单附言"]) {
            post.postStr = @"";
        } else {
            post.postStr = self.postText;
        }
        [self.navigationController pushViewController:post animated:YES];
	}
    
    else if (section == 2) {
        //支付方式
        YKPayMethod * page_paymethod = [[YKPayMethod  alloc] init];
        page_paymethod.m_StrSelectIndex = self.m_strPayMethod;
        page_paymethod.m_sourcePage = self;
        page_paymethod.m_pay_id = self.str_pay_Way;
        [page_paymethod initPayMethod:mycheckOutModel.checkoutPaywayNew];
        
        if ([self.usefreepostcardId description].length > 0) {
            page_paymethod.isSelectFreePostCard = YES;
        }
        [self.navigationController pushViewController:page_paymethod animated:YES];
    }
    
    else if (section == 3) {
        //优惠券
        
        
        if ([self.usev6useCardId description].length>0) {
            [ESToast showDelayToastWithText:@"优惠券和电子券不能同时使用"];
            return;
        }
        
        if (mycheckOutModel.checkout_usecouponcard || ![self.useCouponcardId isEqualToString:@""])
        {//已使用
        } else {
            
            
            //if ([mycheckOutModel.arrCheckout_couponcard count] == 0) {
            //return;
            //}

            //进入优惠券列表页
            SelectCouponTableViewController *ctrl = [[SelectCouponTableViewController alloc] init];
            ctrl.delegate = self;
            ctrl.selectType = 1;
            ctrl.contentArr = mycheckOutModel.arrCheckout_couponcard;

            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }else if (section ==4)
    {
    //电子券
        
        if ([mycheckOutModel.checkoutV6cards count] == 0) {
            return;
        }
        
        
        if ([self.useCouponcardId description].length>0) {
            [ESToast showDelayToastWithText:@"优惠券和电子券不能同时使用"];
            return;
        }
        
        if ([mycheckOutModel.checkoutV6cards count] == 0) {
            return;
        }else{
        
            SelectCouponTableViewController *ctrl = [[SelectCouponTableViewController alloc] init];
            ctrl.delegate = self;
            ctrl.selectType = 2;
            ctrl.clType = EV6Card;
            ctrl.phoneNum = mycheckOutModel.checkout_usev6cardsres;
            ctrl.contentArr = mycheckOutModel.checkoutV6cards;
            
            [self.navigationController pushViewController:ctrl animated:YES];
        }
        
        
        
    }else if (section ==5)
    {
    //包邮卡
        
        
        if ([mycheckOutModel.checkout_freepostcard count] == 0) {
            return;
        }
        
        
        //进入优惠券列表页
        if ([self.usefreepostcardId isEqualToString:@""]){
            
            SelectCouponTableViewController *ctrl = [[SelectCouponTableViewController alloc] init];
            ctrl.delegate = self;
            ctrl.selectType = 3;
            
            ctrl.contentArr = mycheckOutModel.checkout_freepostcard;
            
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark--- 处理section的不悬浮

//去掉UItableview headerview黏性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == chectOutTable)
    {
        CGFloat sectionHeaderHeight = 8.;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
