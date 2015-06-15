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

@interface CheckOutViewController () {
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
    //end
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    //创建返回按钮
    [self createBackBtnWithType:0];
    
    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"提交订单" forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
	
    suitlistcell= [[NSMutableArray alloc] init];
	tableCells = [[NSMutableArray alloc] init];
	otherCells = [[NSMutableArray alloc] init];
	_dicTD = [[NSMutableDictionary alloc] init];
	[self createHeaderAndFooter];
	[self createCells];
	[self createOtherCells];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(poptdo) name:@"ISLOGIN" object:nil];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    height_s = 0;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"enable_button" object:nil userInfo:nil];
    
    [self ShowFooterwithAnimated:NO];
    
    //请求网络数据
    if (!self.vouId) {
        self.vouId = @"";
    }
    if (![self.v6useCardId isEqualToString:@""] && self.v6useCardId) {
        self.vouId = self.v6useCardId;
        
        //lee999recode
        [mainSev getCheckout:self.straddressID andV6usercard_id:self.vouId andCouponcard:@"" payway:self.m_strPayMethod];
    } else {
        
        [mainSev getCheckout:self.straddressID andV6usercard_id:@"" andCouponcard:self.vouId payway:self.m_strPayMethod];
    }
    
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
    self.vouId = @"";
    self.v6useCardId = @"";
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
                
                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

            } else {
                
                NSDate *time = [NSDate date];
                NSMutableDictionary *dic1  = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.errorMessage, @"Reason",self.m_strPayMethod, @"Payment",self.province, @"Province", @"Ordergoodsnum",time, @"OrdernoTime",nil];
                [dic1 addEntriesFromDictionary:self.dicTD];
                [TalkingData trackEvent:@"1009" label:@"提交订单成功" parameters:dic1];
                
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
                
                [self createSuitlistcells];
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

- (void) loadData {
    NSString *str1 = [mycheckOutModel.itemPrice stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    NSString *card_id = [[mycheckOutModel.checkout_usev6cards lastObject] objectForKey:@"card_id"];
    
    if (card_id) {
        self.vouId = @"";
    }
    if ([self.postText isEqualToString:@"订单附言"]) {
        self.postText = @"";
    }
    
    [mainSev getSubmitorder:self.straddressID andCouponcard:self.vouId andPayway:self.m_strPayMethod andPayprice:str1 andRemarkmsg:self.postText andCard_id:card_id];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

- (void)createHeaderAndFooter{
    //ADD FootView:
	UIView* footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 210)];
	footView.backgroundColor = [UIColor clearColor];
	UIButton* tijiButton = [UIButton buttonWithType:UIButtonTypeCustom];
	tijiButton.frame = CGRectMake(50, 160, 220, 35);
	tijiButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
	[tijiButton setTitle:@"提交订单" forState:UIControlStateNormal];
	[tijiButton addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
	[tijiButton setBackgroundImage:[UIImage imageNamed:@"button_red.png"] forState:UIControlStateNormal];
	[tijiButton setBackgroundImage:[UIImage imageNamed:@"button_red_press.png"] forState:UIControlStateHighlighted];
	[footView addSubview:tijiButton];
    
	//ADD HeadView:
	UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, lee1fitAllScreen(140))];
	headerView.backgroundColor = [UIColor clearColor];
    
//	UIImageView* bgview = [[UIImageView alloc] init];
//	bgview.frame = CGRectMake(5, 5, 310, 147);
//    //lee给view设置为圆角，不再使用图片了。 -140512
//    [SingletonState setViewRadioSider:bgview];
//	[headerView addSubview:bgview];

	
	NSArray* nameArray = [[NSArray alloc] initWithObjects:@"商品金额：",@"运费：",@"优惠券抵扣：",@"活动优惠金额：",@"尊享卡电子劵抵扣：",@"订单总金额：",@"可获积分：",nil];
	for (int i = 0; i < [nameArray count]; i ++) {
		UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+20*i, 120, 20)];
		colorName.backgroundColor = [UIColor clearColor];
		colorName.text = [nameArray objectAtIndex:i];
		colorName.font = [UIFont systemFontOfSize:12];
		colorName.textAlignment = UITextAlignmentLeft;
		[headerView addSubview:colorName];

	}
	
	for (int i = 0; i < [nameArray count]; i ++) {
		UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(200, 10+20*i, 110, 20)];
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
        
		UIImageView* bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cart_pic_bg"]];
		bgview.frame = CGRectMake(10, 10, 92, 113);
		[Cell.contentView addSubview:bgview];
    
        YKItem* item = (YKItem *)[mycheckOutModel.checkoutProductlist objectAtIndex:i];

        //积分
        UILabel *jifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 128, 88, 15)];
        jifenLabel.backgroundColor = [UIColor clearColor];
        jifenLabel.textAlignment = UITextAlignmentCenter;
        jifenLabel.font = [UIFont systemFontOfSize:13.];
        jifenLabel.text = [NSString stringWithFormat:@"积分： %ld",item.score];
        
        [Cell.contentView addSubview:jifenLabel];
        
		UrlImageView* shoppingImg = [[UrlImageView alloc] init];
		[shoppingImg setImageFromUrl:YES withUrl:item.imgurl];
		shoppingImg.frame = CGRectMake(14, 15, 84, 103);
		shoppingImg.backgroundColor = [UIColor clearColor];
		[Cell.contentView addSubview:shoppingImg];
        
		//lee999recode
        if ([item.type isEqualToString:@"gift"]) {
            UILabel* shoppingName = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, 190, 45)];
            shoppingName.backgroundColor = [UIColor clearColor];
            shoppingName.numberOfLines = 0;
            shoppingName.lineBreakMode = UILineBreakModeWordWrap;
            shoppingName.text = [NSString stringWithFormat:@"             %@",item.name];
            shoppingName.font = [UIFont systemFontOfSize:13];
            shoppingName.textColor = [UIColor blackColor];//UIColorFromRGB(0x666666)
            
            UILabel* biaozhi = [[UILabel alloc] init];
            biaozhi.frame=CGRectMake(0, 6, 60, 18);
			biaozhi.backgroundColor = [UIColor clearColor];
			biaozhi.text = @"【赠品】";
			biaozhi.font = [UIFont systemFontOfSize:13];
			biaozhi.textColor = [UIColor redColor];
			[shoppingName addSubview:biaozhi];
            
            [Cell.contentView addSubview:shoppingName];

        }else{
		UILabel* shoppingName = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, 190, 45)];
		shoppingName.backgroundColor = [UIColor clearColor];
		shoppingName.numberOfLines = 0;
		shoppingName.lineBreakMode = UILineBreakModeWordWrap;
		shoppingName.text = item.name;
		shoppingName.font = [UIFont systemFontOfSize:13];
		shoppingName.textColor = [UIColor blackColor];//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:shoppingName];
		}
        //end
            
		UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, 50, 20)];
		colorName.backgroundColor = [UIColor clearColor];
		colorName.text = @"颜色：";
		colorName.font = [UIFont systemFontOfSize:12];
		colorName.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:colorName];
		
		UILabel* sizeName = [[UILabel alloc] initWithFrame:CGRectMake(110, 80, 50, 20)];
		sizeName.backgroundColor = [UIColor clearColor];
		sizeName.text = @"尺码：";
		sizeName.font = [UIFont systemFontOfSize:12];
		sizeName.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:sizeName];
		
		UILabel* priceName = [[UILabel alloc] initWithFrame:CGRectMake(224, 80, 50, 20)];
		priceName.backgroundColor = [UIColor clearColor];
		priceName.text = @"单价：";
		priceName.font = [UIFont systemFontOfSize:12];
		priceName.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:priceName];
		
		UILabel* numberName = [[UILabel alloc] initWithFrame:CGRectMake(224, 60, 50, 20)];
		numberName.backgroundColor = [UIColor clearColor];
		numberName.text = @"数量：";
		numberName.font = [UIFont systemFontOfSize:12];
		numberName.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:numberName];
		
		UILabel* colorValue = [[UILabel alloc] initWithFrame:CGRectMake(150, 60, 74, 20)];
		colorValue.backgroundColor = [UIColor clearColor];
        colorName.textAlignment = UITextAlignmentLeft;
		colorValue.text = item.color;
		colorValue.font = [UIFont systemFontOfSize:12];
		colorValue.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:colorValue];
		
		UILabel* sizeValue = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 50, 20)];
		sizeValue.backgroundColor = [UIColor clearColor];
        sizeValue.textAlignment = UITextAlignmentLeft;

		sizeValue.text = item.size;
		sizeValue.font = [UIFont systemFontOfSize:12];
		sizeValue.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:sizeValue];
		
		UILabel* priceValue = [[UILabel alloc] initWithFrame:CGRectMake(254, 80, 100, 20)];
		priceValue.backgroundColor = [UIColor clearColor];
		priceValue.text = [NSString stringWithFormat:@" ￥%@",item.price];;
		priceValue.font = [UIFont systemFontOfSize:12];
		priceValue.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:priceValue];
		
		UILabel* numberValue = [[UILabel alloc] initWithFrame:CGRectMake(254, 59, 50, 20)];
		numberValue.backgroundColor = [UIColor clearColor];
		numberValue.text = [NSString stringWithFormat:@"  %@",item.number];
		numberValue.font = [UIFont systemFontOfSize:12];
		numberValue.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:numberValue];
        
        UIFont *font = [UIFont systemFontOfSize:12];

        NSString *strTotal = @"总价： ";
		UILabel* caseName = [[UILabel alloc] initWithFrame:CGRectMake(224, 128, 40, 25)];
		caseName.backgroundColor = [UIColor clearColor];
		caseName.text = strTotal;
		caseName.font = font;
		caseName.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666)
		[Cell.contentView addSubview:caseName];
		
       NSString *str = [NSString stringWithFormat:@"  ¥%.2f",[item.subtotal floatValue]];
		UILabel* caseValue = [[UILabel alloc] initWithFrame:CGRectMake(254, 128, 100, 25)];
		caseValue.backgroundColor = [UIColor clearColor];
		caseValue.text = str;
		caseValue.font = font;
		caseValue.textColor = [UIColor colorWithHexString:@"0xB90023"] ;
		[Cell.contentView addSubview:caseValue];
		
		[tableCells addObject:Cell];
	}
}


-(void)createSuitlistcells
{
    [suitlistcell removeAllObjects];
    suitCount = [mycheckOutModel.suitlist count];
    
    for (int j=0; j<[mycheckOutModel.suitlist count]; j++) {
        YKSuitListItem *item = [mycheckOutModel.suitlist objectAtIndex:j];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1];
        
        for (int k = 0; k<[item.suits count]; k++) {
            static NSString	*CellIdentifier2 = @"Cell2";
            UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier2];
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *icon = nil;
            if (k==0) {
                
                UIImageView *topImageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 140)];
                [topImageV setImage:[[UIImage imageNamed:@"list_bg_01.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 14, 250, 100)]];//[ resizableImageWithCap:UIEdgeInsetsMake(14, 14, 0, 0)]
                [Cell.contentView addSubview:topImageV];
                
                icon  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 21, 38)];
                [icon setImage:[UIImage imageNamed:@"icon_suit.png"]];
                [Cell.contentView addSubview:icon];

            }else {
                
                UIImageView *modile = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 140)];
                [modile setImage:[UIImage imageNamed:@"list_bg_02.png"]];//[ resizableImageWithCap:UIEdgeInsetsMake(5, 5, 0, 0)]
                [Cell.contentView addSubview:modile];
            }
            
            YKProductsItem *pItem = [item.suits objectAtIndex:k];
            
            
            UIImageView* bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cart_pic_bg.png"]];
            bgview.frame = CGRectMake(10, 10, 93, 113);
            [Cell.contentView addSubview:bgview];

            UrlImageView* shoppingImg = [[UrlImageView alloc] init];
            [shoppingImg setImageFromUrl:YES withUrl:pItem.pic];
            shoppingImg.frame = CGRectMake(14, 15, 84, 103);
            shoppingImg.backgroundColor = [UIColor clearColor];
            [Cell.contentView addSubview:shoppingImg];
            
            UILabel* shoppingName = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, 190, 45)];
            shoppingName.backgroundColor = [UIColor clearColor];
            shoppingName.numberOfLines = 0;
            shoppingName.lineBreakMode = UILineBreakModeWordWrap;
            shoppingName.text = [NSString stringWithFormat:@"%@【套装】", pItem.name];
            shoppingName.font = [UIFont systemFontOfSize:13];
            shoppingName.textColor = [UIColor blackColor];
            [Cell.contentView addSubview:shoppingName];
            
            UILabel* colorName = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, 175, 30)];
            colorName.backgroundColor = [UIColor clearColor];
            colorName.lineBreakMode = UILineBreakModeMiddleTruncation;
            colorName.text = [NSString stringWithFormat:@"颜色: %@    尺码: %@", pItem.color, pItem.size];
            colorName.font = [UIFont systemFontOfSize:13];
            colorName.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
            [Cell.contentView addSubview:colorName];
            
            UILabel* priceName = [[UILabel alloc] initWithFrame:CGRectMake(110, 90, 50, 30)];
            priceName.backgroundColor = [UIColor clearColor];
            priceName.text = @"单价: ";
            priceName.font = [UIFont systemFontOfSize:13];
            priceName.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
            [Cell.contentView addSubview:priceName];
            
            UILabel* priceValue = [[UILabel alloc] initWithFrame:CGRectMake(150, 89, 100, 30)];
            priceValue.backgroundColor = [UIColor clearColor];
            priceValue.text = [NSString stringWithFormat:@"￥%.2f", pItem.price];
            priceValue.font = [UIFont systemFontOfSize:14];
            priceValue.textColor = [UIColor colorWithHexString:@"0xB90023"];//UIColorFromRGB(0xB90023);
            [Cell.contentView addSubview:priceValue];

            [Cell.contentView bringSubviewToFront:icon];
            
            [array addObject:Cell];
        }
        
        
        static NSString	*CellSuitlist = @"Cell";
        UITableViewCell *viewSuitlistCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellSuitlist];
        viewSuitlistCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *buttom = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 60)];
        [buttom setImage:[UIImage imageNamed:@"list_bg_03.png"]];//[ resizableImageWithCap:UIEdgeInsetsMake(5, 5, 0, 0)]
        [viewSuitlistCell.contentView addSubview:buttom];
        
        UIFont *font = [UIFont systemFontOfSize:13];
        int xOffset = 12;
        int yOffset = 10;
        int height = 20;
        UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, 200, height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.lineBreakMode = UILineBreakModeMiddleTruncation;
        desc.text = [NSString stringWithFormat:@"数量: %d", item.number];
        desc.font = [UIFont systemFontOfSize:13];
        desc.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
        [viewSuitlistCell.contentView addSubview:desc];
        
        //lee999 新增套装积分
//        if (item.suit_score > 0) {
            UILabel* scoredesc = [[UILabel alloc] initWithFrame:CGRectMake(165, yOffset, 200, height)];
            scoredesc.backgroundColor = [UIColor clearColor];
            scoredesc.lineBreakMode = UILineBreakModeMiddleTruncation;
            scoredesc.text = [NSString stringWithFormat:@"积分: %d", item.suit_score];
            scoredesc.font = [UIFont systemFontOfSize:13];
            scoredesc.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
            [viewSuitlistCell.contentView addSubview:scoredesc];
//        }
    
        //套装价
        NSString *str = @"套装价: ";
        int strWidth = [str sizeWithFont:font].width;
        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset+height, strWidth, height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.text = str;
        desc.font = [UIFont systemFontOfSize:13];
        desc.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
        [viewSuitlistCell.contentView addSubview:desc];
        xOffset += strWidth;
        
        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset+height, 90, height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.text = [NSString stringWithFormat:@"￥%.2f", item.disountprice];
        desc.font = [UIFont systemFontOfSize:16];
        desc.textColor = [UIColor colorWithHexString:@"0xB90023"];//UIColorFromRGB(0xB90023);
        [viewSuitlistCell.contentView addSubview:desc];
        xOffset = 165;
        
        //优惠
        desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset+height, 110, height)];
        desc.backgroundColor = [UIColor clearColor];
        desc.lineBreakMode = UILineBreakModeMiddleTruncation;
        desc.text = [NSString stringWithFormat:@"优惠: ￥%.2f", item.save];
        desc.font = [UIFont systemFontOfSize:13];
        desc.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
        [viewSuitlistCell.contentView addSubview:desc];
        
        [array addObject:viewSuitlistCell];
        
        [suitlistcell addObject:array];
    }
}


-(void)createOtherCells{
    NSLog(@"createOtherCells  come in");
	[otherCells removeAllObjects];
	
	NSArray* titleArray = [[NSArray alloc] initWithObjects:
                           @"收货人信息（必填）",
                           @"订单附言",
                           @"使用优惠券",
                           @"支付方式",
                           @"商品数量",nil];
    static NSString	* CellIdentifier = @"Cell";
	for (int i = 0; i < 5; i ++) {
		UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:CellIdentifier];
		Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
		if (i == 0) {//地址
            
            height_d = 70; //如果地址有内容 cell section 的高度
            
            UILabel* name2 = nil;
            
			if (self.addressItem_ben != nil)
            {
				self.straddressID = self.addressItem_ben.addresslistIdentifier;
				UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(20, 5,ScreenWidth-40, 30)];
				name.backgroundColor = [UIColor clearColor];
				name.font = [UIFont systemFontOfSize:LabMidSize];
				name.text = self.addressItem_ben.userName;
				[Cell addSubview:name];

				UILabel* address2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, ScreenWidth-60, 35)];
				address2.backgroundColor = [UIColor clearColor];
				address2.font = [UIFont systemFontOfSize:14];
				NSString* addresss1 = [NSString stringWithFormat:@"地址：%@%@%@%@",self.addressItem_ben.province,self.addressItem_ben.city,self.addressItem_ben.county,self.addressItem_ben.address];
                
                self.province = self.addressItem_ben.province;
				address2.text = addresss1;
				address2.numberOfLines = 0;
				address2.lineBreakMode = UILineBreakModeWordWrap;
				address2.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
				[Cell addSubview:address2];

				UILabel* phone = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, lee1fitAllScreen(280), 25)];
				phone.backgroundColor = [UIColor clearColor];
				phone.font = [UIFont systemFontOfSize:14];
				phone.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
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
                
				UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, ScreenWidth-40, 30)];
				name.backgroundColor = [UIColor clearColor];
				name.font = [UIFont systemFontOfSize:LabMidSize];
				name.text = addressItem.user_name;
				[Cell addSubview:name];

				
				UILabel* address2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, ScreenWidth-40, 35)];
				address2.backgroundColor = [UIColor clearColor];
				address2.font = [UIFont systemFontOfSize:14];
				NSString* addresss1 = [NSString stringWithFormat:@"地址：%@%@%@%@",addressItem.province,addressItem.city,addressItem.county,addressItem.address];
				address2.text = addresss1;
				address2.numberOfLines = 0;
				address2.lineBreakMode = UILineBreakModeWordWrap;
				address2.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
				[Cell addSubview:address2];

				
				UILabel* phone = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 280, 25)];
				phone.backgroundColor = [UIColor clearColor];
				phone.font = [UIFont systemFontOfSize:14];
				phone.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
				phone.text = [NSString stringWithFormat:@"电话：%@",addressItem.mobile];
				[Cell addSubview:phone];

			}else {
				
                height_d = 0;// 地址没有信息
             
                name2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-20, 30)];
				name2.text = [titleArray objectAtIndex:i];
				name2.backgroundColor = [UIColor clearColor];
				name2.font = [UIFont systemFontOfSize:LabMidSize];
				name2.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
				[Cell.contentView addSubview:name2];
			}
            
            [Cell.contentView bringSubviewToFront:name2];

			Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
		}
        else if (i == 1) {//附言
            
			if ([self.postText isEqualToString:@""] || self.postText == nil) {
				UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-20, 30)];
				name.text = [titleArray objectAtIndex:i];
				name.backgroundColor = [UIColor clearColor];
				name.font = [UIFont systemFontOfSize:LabMidSize];
				name.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
                name.tag=1154;
				[Cell.contentView addSubview:name];
			} else {
				UIFont *font = [UIFont systemFontOfSize:14];
                CGSize size = [self.postText sizeWithFont:font constrainedToSize:CGSizeMake(ScreenWidth-60, 10000) lineBreakMode:NSLineBreakByWordWrapping];
                
                CGFloat heigth;
                heigth = size.height;
                
                if (heigth > 18) {
                    
                } else {
                    heigth+=10;
                }
                
                UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, ScreenWidth-60, heigth)];
				name.text = self.postText;
				name.numberOfLines = 0;
				name.lineBreakMode = UILineBreakModeWordWrap;
				name.backgroundColor = [UIColor clearColor];
				name.font = [UIFont systemFontOfSize:14];
				name.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
				[Cell.contentView addSubview:name];
                
                if ([self.postText isEqualToString:[titleArray objectAtIndex:i]]) {
                    name.font = [UIFont systemFontOfSize:LabMidSize];
                }
			}
        
			Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
		} else if (i == 2) {//优惠券
            
			if (!mycheckOutModel.checkout_usecouponcard&& !mycheckOutModel.checkout_usev6cards) {
				UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
				name.text = [titleArray objectAtIndex:i];
				name.backgroundColor = [UIColor clearColor];
				name.font = [UIFont systemFontOfSize:LabMidSize];
				name.textColor = [UIColor colorWithHexString:@"0x666666"];//UIColorFromRGB(0x666666);
				[Cell.contentView addSubview:name];
				Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			} else {
				UILabel* name1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 200, 30)];
				name1.text = @"使用优惠券";
				name1.backgroundColor = [UIColor clearColor];
				name1.font = [UIFont systemFontOfSize:14];
				name1.textColor = [UIColor grayColor];
				[Cell.contentView addSubview:name1];
                
                UILabel* name2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 3, 200, 30)];
				name2.text = @"已使用";
				name2.backgroundColor = [UIColor clearColor];
				name2.font = [UIFont systemFontOfSize:14];
				name2.textColor = [UIColor redColor];
				[Cell.contentView addSubview:name2];
				
				UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
				[cancle setTitle:@"取消" forState:UIControlStateNormal];
                [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				cancle.titleLabel.font = [UIFont systemFontOfSize:13];
				[cancle setFrame:CGRectMake(240, 5, 50, 31)];
				[cancle setBackgroundImage:[UIImage imageNamed:@"signup_btn.png"] forState:UIControlStateNormal];
				[cancle addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
				[Cell.contentView addSubview:cancle];
			}
			
		} else if (i == 3) { //新增付款方式选择
            
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
                            [attributeStr setFont:[UIFont systemFontOfSize:14]];
                            
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
            
        } else if (i == 4){
            
			Cell.selectionStyle = UITableViewCellSelectionStyleNone;
			UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
			name.text = [titleArray objectAtIndex:i];
			name.backgroundColor = [UIColor clearColor];
			name.font = [UIFont systemFontOfSize:LabMidSize];
			name.textColor = [UIColor colorWithHexString:@"0x666666"];
			[Cell.contentView addSubview:name];
            
            UILabel *numerTotle = [[UILabel alloc] initWithFrame:CGRectMake(300, 5, 50, 30)];
            numerTotle.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"];
            numerTotle.backgroundColor = [UIColor clearColor];
            name.font = [UIFont systemFontOfSize:14.];
            [Cell.contentView addSubview:numerTotle];

		}
        [otherCells addObject:Cell];
	}
NSLog(@"createOtherCells  come out");
}

#pragma mark 取消优惠券

- (void) cancle {
    self.vouId = nil;
    self.v6useCardId = nil;
    
    if (!self.vouId) {
        self.vouId = @"";
    }
    [mainSev getCheckout:self.straddressID andV6usercard_id:@"" andCouponcard:self.vouId payway:self.m_strPayMethod];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
    if ((self.m_strPayMethod == nil) || ([self.m_strPayMethod isEqualToString:@""])) {
    } else {
    }
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
    return 6  + suitCount;
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
    }else{
        if (section-suitCount == 5) {
            return [tableCells count];
        }
        else {
            return [(NSMutableArray*)[suitlistcell objectAtIndex:section-5 isArray:nil] count];
        }
    }
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 ||section == 2 ||section == 3 ||section == 4) {
        return 0.5;
    }
    return 10.;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *fv = [[UIView alloc] init];
    [fv setBackgroundColor:[UIColor colorWithHexString:@"E6E6E6"]];
    return fv;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section >= 5) {
        if (section - suitCount == 5) {
            //普通商品
            return [tableCells objectAtIndex:indexPath.row];
        }
        else {
            //套装商品
            return [[suitlistcell objectAtIndex:section-5] objectAtIndex:indexPath.row];
        }
    }
    else {
        //选择结算信息按钮
        return [otherCells objectAtIndex:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    
    switch (section) {
        case 0:
        {
            if (height_d > 0){
                return height_d+45;
            }else {
                return 45;
            }
        }
            break;
        case 1:
        {
            if ([self.postText isEqualToString:@""] || self.postText == nil) {
                self.postText = @"订单附言";
                return 45;
            }else {
            CGSize size = [self.postText sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(230.0f, 10000) lineBreakMode:NSLineBreakByWordWrapping];
            if (size.height > 18) {
                return size.height+10;
            } else {
                return size.height+20;
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
        default:
        {
            if (section-suitCount == 5) {
                return 160;
            }
            else {
                if (indexPath.row == [(NSMutableArray*)[suitlistcell objectAtIndex:0 isArray:nil] count]-1) {
                    return 70;
                }else {
                    return 140;
                }
            }
        }
            break;
    }
    return 160;
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

	} else if (section == 1) {
        //订单附言
        YKOrderPostscriptView* post = [[YKOrderPostscriptView alloc] init];
        post.checkOut = self;
        if ([self.postText isEqualToString:@"订单附言"]) {
            post.postStr = @"";
        } else {
            post.postStr = self.postText;
        }
        [self.navigationController pushViewController:post animated:YES];
        
	} else if (section == 2) {
        //优惠券
        if (mycheckOutModel.checkout_usecouponcard || mycheckOutModel.checkout_usev6cards)
        {//已使用
            //            /*
            //lee999recode
            //进入已使用优惠券列表
//            HasUsedViewController *ctrl = [[HasUsedViewController alloc] init];
//            ctrl.checkout_usecouponcard = mycheckOutModel.checkout_usecouponcard;//优惠券
//            ctrl.checkout_usev6cards = mycheckOutModel.checkout_usev6cards;//尊享卡
//            ctrl.checkOutViewCtrl = self;
//            [self.navigationController pushViewController:ctrl animated:YES];
        } else {

            //进入优惠券列表页
            SelectCouponTableViewController *ctrl = [[SelectCouponTableViewController alloc] init];
            ctrl.isAimer = NO;
            
            ctrl.phoneNum = mycheckOutModel.checkout_usev6cardsres;
            ctrl.checkOutViewCtrl = self;
            CouponcardListCouponcardListModel *couponcardListModel = [[CouponcardListCouponcardListModel alloc] init];
            if (mycheckOutModel.checkoutCountv6 == 0) {
                couponcardListModel.cards_count = 0;
                couponcardListModel.checkoutCards = nil;
            } else {
                couponcardListModel.checkoutCards = mycheckOutModel.checkoutV6cards;
                couponcardListModel.cards_count=1;
            }
            
            couponcardListModel.checkoutCouponcard = mycheckOutModel.arrCheckout_couponcard;
            couponcardListModel.couponcard_count = [couponcardListModel.checkoutCouponcard count];
            if (!couponcardListModel.checkoutCouponcard) {
                couponcardListModel.couponcard_count = 0;
            }
            ctrl.couponcardListModel = couponcardListModel;

            [self.navigationController pushViewController:ctrl animated:YES];
        }
        
    }else if (section == 3) {
        //支付方式
        YKPayMethod * page_paymethod = [[YKPayMethod  alloc] init];
        page_paymethod.m_StrSelectIndex = self.m_strPayMethod;
        page_paymethod.m_sourcePage = self;
        page_paymethod.m_pay_id = self.str_pay_Way;
        [page_paymethod initPayMethod:mycheckOutModel.checkoutPaywayNew];
      
        [self.navigationController pushViewController:page_paymethod animated:YES];
    }
	
    //lee999 新增结算中心能进入商品详情
//    if (section >= 5) {
//        if (section - suitCount == 5) {
//            //普通商品
//            if ([indexPath section] < 0 || [indexPath section] >= [checkOutModel.suitlist count]) {
//                return ;
//            }
//            YKSuitListItem *item = [checkOutModel.suitlist objectAtIndex:[indexPath section]];
//            if (indexPath.row < 0 || indexPath.row >= [item.suits count]) {
//                return ;
//            }
//            YKProductsItem *pItem = [item.suits objectAtIndex:indexPath.row];
//            ProductDetailViewController *controller = [[ProductDetailViewController alloc] init];
//            controller.isPush = YES;
//            controller.isShop = YES;
//            controller.thisProductId = pItem.product_id;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//        else {
//            //套装商品
//            YKItem* item = (YKItem*)[checkOutModel.checkoutProductlist objectAtIndex:indexPath.row];
//            
//            if ([item.type isEqualToString:@"gift"]) {
//                return;
//            }
//            ProductDetailViewController* detail = [[ProductDetailViewController alloc] init];
//            detail.thisProductId = item.goodsid;
//            detail.isShop = YES;
//            
//            detail.isPush = YES;
//            [self.navigationController pushViewController:detail animated:YES];
//        }
//    }
    // end
    
    
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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


@end
