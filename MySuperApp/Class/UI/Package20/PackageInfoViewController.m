//
//  PackageInfoViewController.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15-6-10.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "PackageInfoParser.h"
#import "ProductDetailViewController.h"
#import "PackageInfoViewController.h"

#define PickShowHigh 265.+50.

@interface PackageInfoViewController ()
{
    MainpageServ* mainSev;
    UIView* vGoods;
    
    UIPickerView *pickerForSelectColor;//颜色下拉列表
    UIToolbar *toolBarForPicker;//picker上的toolbar
    
    UIPickerView *pickerForSelectSize;//尺寸下来列表
    UIToolbar *toolBarForSizePicker;//尺寸picker的toolbar
    
    //数据源
    NSMutableArray *marrColor;//颜色数据源
    NSMutableArray *marrSize;//尺码数据源
    
//    NSInteger currentProduct;//因为不同颜色对应不同的商品 换颜色也换currentproduct id
    NSInteger currentColor;//滚动picker时给这b赋值
    NSInteger currentSize;
//    ProductProductDetailModel *productModel;
    UIButton* btnColor;
    UIButton* btnSize;
    PackageGoodsInfo* goodsInfo;
}
@property (nonatomic, retain) PackageInfo* pInfo;
@property (nonatomic, retain) UITableView* tbPackage;
@property (nonatomic, retain) NSMutableArray *marrGoods;
@property (nonatomic, retain) UIView* vToolbar;
@property (nonatomic, retain) UIScrollView* svPackage;
//@property(nonatomic, copy)	NSString *selectedSize;//记录选择的尺码
//@property (nonatomic, retain) NSArray *arrTemSize;
//@property(nonatomic,retain) NSMutableString *str_append;
@end

@implementation PackageInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [self.view addSubview:self.tbPackage];
//    UIView* vFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, lee1fitAllScreen(59))];
//    [self.tbPackage setTableFooterView:vFooter];
    [self.view addSubview:self.vToolbar];
    [self.view addConstraints:[self viewConstraints]];
    [mainSev getPackageInfoWithPid:self.pid];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

    
    currentColor = 0;
    currentSize = 0;
    self.marrGoods = [[NSMutableArray alloc] initWithCapacity:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (_svPackage) {
        [_svPackage removeFromSuperview];
        _svPackage = nil;
    }
    if (vGoods) {
        [vGoods removeFromSuperview];
        vGoods = nil;
    }
    
}

-(void)serviceStarted:(ServiceType)aHandle
{
    
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    [SBPublicAlert hideMBprogressHUD:self.view];

    switch ((NSUInteger)aHandle) {
        case Http_AddPackageToCart20_Tag:
        {
            if ([[amodel objectForKey:@"response"] isEqualToString:@"addpackagetoshopcart"]) {
                
                [SBPublicAlert showMBProgressHUDTextOnly:@"成功加入购物车" andWhereView:self.view hiddenTime:3.0];
                
            }else{
                [SBPublicAlert showMBProgressHUD:@"加入购物车失败" andWhereView:self.view hiddenTime:1.];
            }

        }
            break;
        case Http_PackageInfo20_Tag:
        {
            self.pInfo = [[[PackageInfoParser alloc] init] parsePackageInfo:amodel];
            for (NSInteger i = 0; i < _pInfo.packageinfo.groups.count; ++i) {
                PackageGroupInfo* pgi = [_pInfo.packageinfo.groups objectAtIndex:i isArray:nil];
                for (NSInteger j = 0; j < pgi.goods.count; ++j) {
                    PackageGoodsInfo* pgInfo = [pgi.goods objectAtIndex:j isArray:nil];
                    for (NSInteger k = 0; k < pgInfo.products.count; ++k) {
                        PackageProductInfo* ppi = [pgInfo.products objectAtIndex:k isArray:nil];
                        if (ppi.count == 0) {
                            [pgInfo.products removeObject:ppi];
                        }
                    }
                }
            }
            
            self.title = _pInfo.packageinfo.name;
            [_tbPackage setDelegate:self];
            [_tbPackage setDataSource:self];
            [_tbPackage reloadData];
            
            UIButton* btnAddtoCart = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnAddtoCart setFrame:CGRectMake(_vToolbar.frame.size.width - 13 - lee1fitAllScreen(49), 8, lee1fitAllScreen(49), lee1fitAllScreen(44))];
            [btnAddtoCart setImage:[UIImage imageNamed:@"lp_btn_shop_normal"] forState:UIControlStateNormal];
            [btnAddtoCart setImage:[UIImage imageNamed:@"lp_btn_shop_hover"] forState:UIControlStateHighlighted];
            [btnAddtoCart addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
            [_vToolbar addSubview:btnAddtoCart];
            
            UIButton* btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnReset setFrame:CGRectMake(btnAddtoCart.frame.origin.x - 10 - lee1fitAllScreen(70), 8, lee1fitAllScreen(70), lee1fitAllScreen(44))];
            [btnReset setBackgroundImage:[UIImage imageNamed:@"lp_btn_reset_normal"] forState:UIControlStateNormal];
            [btnReset setBackgroundImage:[UIImage imageNamed:@"lp_btn_reset_hover"] forState:UIControlStateHighlighted];
            [btnReset setTitle:@"重置" forState:UIControlStateNormal];
            [btnReset.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btnReset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnReset addTarget:self action:@selector(resetPackage:) forControlEvents:UIControlEventTouchUpInside];
            [_vToolbar addSubview:btnReset];
            
            UILabel* lblSpec = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, _vToolbar.frame.size.width - btnReset.frame.origin.x - 30, 12)];
            [lblSpec setText:[NSString stringWithFormat:@"%@元/%@件", _pInfo.packageinfo.price, _pInfo.packageinfo.need_select_count]];
            [lblSpec setTextColor:[UIColor colorWithHexString:@"#181818"]];
            [lblSpec setFont:[UIFont systemFontOfSize:12]];
            [_vToolbar addSubview:lblSpec];
            
            UILabel* lblPrice = [[UILabel alloc] init];
            [lblPrice setText:[NSString stringWithFormat:@"金额:%@元", _pInfo.packageinfo.price]];
            [lblPrice setFont:[UIFont systemFontOfSize:12]];
            CGRect rcPrice = [lblPrice.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblPrice.font} context:nil];
            [lblPrice setFrame:CGRectMake(15, lblSpec.frame.size.height + lblSpec.frame.origin.y + 8, rcPrice.size.width, rcPrice.size.height)];
            [lblPrice setTextColor:[UIColor colorWithHexString:@"#181818"]];
            [_vToolbar addSubview:lblPrice];
            
            UILabel* lblCount = [[UILabel alloc] init];
            [lblCount setFont:[UIFont systemFontOfSize:12]];
            [lblCount setText:[NSString stringWithFormat:@"数量:%@", _pInfo.packageinfo.need_select_count]];
            CGRect rcCount = [lblCount.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblCount.font} context:nil];
            [lblCount setFrame:CGRectMake(lblPrice.frame.size.width + lblPrice.frame.origin.x + 14, lblPrice.frame.origin.y, rcCount.size.width, rcCount.size.height)];
            [lblCount setTextColor:[UIColor colorWithHexString:@"#181818"]];
            [_vToolbar addSubview:lblCount];
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPackage:)];
            [_vToolbar addGestureRecognizer:tap];
            
//            UIButton* btnShowPackage = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btnShowPackage setFrame:CGRectMake(0, 0, 0, 0)];
//            [btnShowPackage addTarget:self action:@selector(showPackage:) forControlEvents:UIControlEventTouchUpInside];
//            [_vToolbar addSubview:btnShowPackage];
        }
            break;
        default:
            break;
    }
    
    [self showPackage:nil];
}

-(void)serviceFailed:(ServiceType)aHandle
{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)delSelectedGoods:(UIButton*)sender
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定删除该商品？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [av setTag:sender.tag + 20000];
    [av show];
}

-(void)showPackage:(UITapGestureRecognizer*)gesture
{
    if (_svPackage) {
        [_svPackage removeFromSuperview];
        _svPackage = nil;
    }else
    {
        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        _svPackage = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - lee1fitAllScreen(120) - lee1fitAllScreen(59), SCREEN_WIDTH, lee1fitAllScreen(120))];
        [_svPackage setBackgroundColor:[UIColor colorWithHexString:@"f8f8f8"]];
        [_svPackage setAlpha:0.8];
        [_svPackage.layer setMasksToBounds:YES];
        CGFloat originY = 26.f;
        CGFloat spacing = 15.f;
        [_svPackage setContentSize:CGSizeMake(([_pInfo.packageinfo.need_select_count integerValue] * (60 + spacing) + spacing), _svPackage.frame.size.height)];
        for (NSInteger i = 0; i < [_pInfo.packageinfo.need_select_count integerValue]; ++i) {
            UrlImageView* uiv = [[UrlImageView alloc] initWithFrame:CGRectMake(spacing + i * (60 + spacing), originY, 60, 77)];
            [_svPackage addSubview:uiv];
            if (_marrGoods.count > i) {
                NSDictionary* dic = [_marrGoods objectAtIndex:i isArray:nil];
                PackageGoodsInfo* pgi = [dic objectForKey:[[dic allKeys] firstObject] isDictionary:nil];
                [uiv setImageWithURL:[NSURL URLWithString:pgi.image_url] placeholderImage:nil];
                
                UIButton* btnDel = [UIButton buttonWithType:UIButtonTypeCustom];
                [btnDel setFrame:CGRectMake(uiv.frame.origin.x + uiv.frame.size.width - 15, uiv.frame.origin.y - 9, 25, 25)];
                [btnDel setTag:i];
                [btnDel setImage:[UIImage imageNamed:@"lp_shut_h"] forState:UIControlStateNormal];
                [btnDel addTarget:self action:@selector(delSelectedGoods:) forControlEvents:UIControlEventTouchUpInside];
                [_svPackage addSubview:btnDel];
                
            }else
            {
                [uiv setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
            }
        }
        [app.window addSubview:_svPackage];
        if (_vToolbar) {
            [app.window bringSubviewToFront:_svPackage];
        }
    }
}

-(void)closeGoodsView:(UIButton*)sender
{
    [vGoods removeFromSuperview];
    vGoods = nil;
}

-(void)selectGoods:(UIButton*)sender
{
    NSInteger index = sender.tag % 10000;
    NSInteger groupIndex = (sender.tag - index) / 10000;
    goodsInfo = [((PackageGroupInfo*)[_pInfo.packageinfo.groups objectAtIndex:groupIndex isArray:nil]).goods objectAtIndex:index];
    
    PackageSpecInfo* firstSepc = (PackageSpecInfo*)[goodsInfo.specs firstObject];
    PackageSpecInfo* lastSepc = (PackageSpecInfo*)[goodsInfo.specs lastObject];
    
    marrColor = [NSMutableArray arrayWithCapacity:1];
    for (PackageProductInfo* ppi in goodsInfo.products) {
        NSString* strSpecValue = [ppi._spec_value_ids attributeForKey:firstSepc.sId];
        PackageSpecValueInfo* sepcValueInfo = [[PackageSpecValueInfo alloc] init];
        [sepcValueInfo setAttributeDic:((YKBaseEntity*)[goodsInfo.spec_values attributeForKey:strSpecValue]).attributeDic];
        
        if (marrColor.count > 0) {
            BOOL has = NO;
            for (int i = 0; i < marrColor.count; ++i) {
                PackageSpecValueInfo* recordColor = [marrColor objectAtIndex:i isArray:nil];
                if ([recordColor.spec_alias isEqualToString:sepcValueInfo.spec_alias]) {
                    has = YES;
                }
            }
            if (!has) {
                [marrColor addObject:sepcValueInfo];
            }
        }else{
            [marrColor addObject:sepcValueInfo];
        }
    }
    
    marrSize = [NSMutableArray arrayWithCapacity:1];
    PackageProductInfo* firstProcuct = [goodsInfo.products firstObject];
    NSString* strSpecValue = [firstProcuct._spec_value_ids attributeForKey:firstSepc.sId];
    for (PackageProductInfo* ppi in goodsInfo.products) {
        if ([[ppi._spec_value_ids attributeForKey:firstSepc.sId] isEqualToString:strSpecValue]) {
            NSString* tempSpecValue = [ppi._spec_value_ids attributeForKey:lastSepc.sId];
            PackageSpecValueInfo* sepcValueInfo = [[PackageSpecValueInfo alloc] init];
            [sepcValueInfo setAttributeDic:((YKBaseEntity*)[goodsInfo.spec_values attributeForKey:tempSpecValue]).attributeDic];
            if (marrSize.count > 0) {
                BOOL has = NO;
                for (int i = 0; i < marrColor.count; ++i) {
                    PackageSpecValueInfo* recordColor = [marrColor objectAtIndex:i isArray:nil];
                    if ([recordColor.spec_alias isEqualToString:sepcValueInfo.spec_alias]) {
                        has = YES;
                    }
                }
                if (!has) {
                    [marrSize addObject:sepcValueInfo];
                }
            }else{
                [marrSize addObject:sepcValueInfo];
            }
        }
    }
    
    
    vGoods = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - lee1fitAllScreen(59))];
    [vGoods setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    UIView* vBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lee1fitAllScreen(270), lee1fitAllScreen(212))];
    [vBG setBackgroundColor:[UIColor colorWithHexString:@"#eaeaea"]];
    [vBG setAlpha:0.8];
    [vBG.layer setCornerRadius:5];
    [vBG setCenter:vGoods.center];
    [vGoods addSubview:vBG];
    
    UrlImageView* uiv = [[UrlImageView alloc] initWithFrame:CGRectMake(15, 15, lee1fitAllScreen(97), lee1fitAllScreen(125))];
    [uiv setImageWithURL:[NSURL URLWithString:goodsInfo.image_url] placeholderImage:nil];
    [vBG addSubview:uiv];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(closeGoodsView:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"lp_shut_b"] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(vBG.frame.origin.x + vBG.frame.size.width - (lee1fitAllScreen(25) / 2), vBG.frame.origin.y - (lee1fitAllScreen(25) / 2), lee1fitAllScreen(25), lee1fitAllScreen(25))];
    [vGoods addSubview:btn];
    
    UILabel* lblName = [[UILabel alloc] init];
    [lblName setFont:[UIFont systemFontOfSize:12]];
    [lblName setNumberOfLines:2];
    [lblName setText:goodsInfo.name];
    [lblName setTextColor:[UIColor colorWithHexString:@"#333333"]];
    [lblName setLineBreakMode:NSLineBreakByTruncatingTail];
    NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
    [mps setLineBreakMode:NSLineBreakByCharWrapping];
    CGRect rcName = [lblName.text boundingRectWithSize:CGSizeMake(vBG.frame.size.width - 40 - uiv.frame.size.width - uiv.frame.origin.x, 36) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSParagraphStyleAttributeName : mps, NSFontAttributeName : lblName.font} context:nil];
    [lblName setFrame:CGRectMake(uiv.frame.size.width + uiv.frame.origin.x + 20, uiv.frame.origin.y, rcName.size.width, rcName.size.height)];
    [vBG addSubview:lblName];
    
    UILabel* lblColor = [[UILabel alloc] init];
    [lblColor setFont:[UIFont systemFontOfSize:12]];
    [lblColor setText:[NSString stringWithFormat:@"%@：", firstSepc.view_name]];
    [lblColor setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [lblColor setFrame:CGRectMake(lblName.frame.origin.x, 76, 100, 12)];
    [vBG addSubview:lblColor];
    
    PackageSpecValueInfo* firstSepcValueInfo = [[PackageSpecValueInfo alloc] init];
    [firstSepcValueInfo setAttributeDic:((YKBaseEntity*)[goodsInfo.spec_values attributeForKey:strSpecValue]).attributeDic];
    
    strSpecValue = [firstProcuct._spec_value_ids attributeForKey:lastSepc.sId];
    PackageSpecValueInfo* lastSepcValueInfo = [[PackageSpecValueInfo alloc] init];
    [lastSepcValueInfo setAttributeDic:((YKBaseEntity*)[goodsInfo.spec_values attributeForKey:strSpecValue]).attributeDic];
    
    btnColor = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnColor setFrame:CGRectMake(uiv.frame.origin.x + uiv.frame.size.width + 62.5, 68, lee1fitAllScreen(80), lee1fitAllScreen(30))];
    [btnColor addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
    [btnColor setTitleColor:[UIColor colorWithHexString:@"181818"] forState:UIControlStateNormal];
    [btnColor.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnColor setTitle:firstSepcValueInfo.spec_alias forState:UIControlStateNormal];
    [btnColor setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [btnColor setBackgroundImage:[UIImage imageNamed:@"lp_option"] forState:UIControlStateNormal];
    [vBG addSubview:btnColor];
    
    UILabel* lblSize = [[UILabel alloc] init];
    [lblSize setFont:[UIFont systemFontOfSize:12]];
    [lblSize setText:[NSString stringWithFormat:@"%@：", lastSepc.view_name]];
    [lblSize setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [lblSize setFrame:CGRectMake(lblName.frame.origin.x, 122, 100, 12)];
    [vBG addSubview:lblSize];
    
    btnSize = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSize setFrame:CGRectMake(uiv.frame.origin.x + uiv.frame.size.width + 62.5, btnColor.frame.size.height + btnColor.frame.origin.y + 14, lee1fitAllScreen(80), lee1fitAllScreen(30))];
    [btnSize addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
    [btnSize setTitleColor:[UIColor colorWithHexString:@"181818"] forState:UIControlStateNormal];
    [btnSize.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnSize setTitle:lastSepcValueInfo.spec_alias forState:UIControlStateNormal];
    [btnSize setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [btnSize setBackgroundImage:[UIImage imageNamed:@"lp_option"] forState:UIControlStateNormal];
    [vBG addSubview:btnSize];
    
    UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, uiv.frame.origin.y + uiv.frame.size.height + 11, vBG.frame.size.width, 0.5)];
    [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d1d1d1"]];
    [vBG addSubview:lblSep];
    
    UIButton* btnToDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnToDetail setBackgroundImage:[UIImage imageNamed:@"lp_btn_normal"] forState:UIControlStateNormal];
    [btnToDetail setBackgroundImage:[UIImage imageNamed:@"lp_btn_hover"] forState:UIControlStateSelected];
    [btnToDetail setTitle:@"单独购买" forState:UIControlStateNormal];
    [btnToDetail setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btnToDetail.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btnToDetail addTarget:self action:@selector(toDetail:) forControlEvents:UIControlEventTouchUpInside];
    [btnToDetail setTag:index];
    [btnToDetail setFrame:CGRectMake(20, 7.5 + lblSep.frame.origin.y + lblSep.frame.size.height, lee1fitAllScreen(105), lee1fitAllScreen(44))];
    [vBG addSubview:btnToDetail];
    
    UIButton* btnAddToPackage = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddToPackage setBackgroundImage:[UIImage imageNamed:@"lp_btn_normal"] forState:UIControlStateNormal];
    [btnAddToPackage setBackgroundImage:[UIImage imageNamed:@"lp_btn_hover"] forState:UIControlStateSelected];
    [btnAddToPackage setTitle:@"加入礼包" forState:UIControlStateNormal];
    [btnAddToPackage setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btnAddToPackage.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btnAddToPackage addTarget:self action:@selector(addToPackage:) forControlEvents:UIControlEventTouchUpInside];
    [btnAddToPackage setTag:index];
    [btnAddToPackage setFrame:CGRectMake(btnToDetail.frame.size.width + btnToDetail.frame.origin.x   + 20, 7.5 + lblSep.frame.origin.y + lblSep.frame.size.height, lee1fitAllScreen(105), lee1fitAllScreen(44))];
    [vBG addSubview:btnAddToPackage];
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window addSubview:vGoods];
    if (_svPackage) {
        [((AppDelegate*)[UIApplication sharedApplication].delegate).window bringSubviewToFront:_svPackage];
    }
}

-(void)toDetail:(UIButton*)sender
{
    NSInteger index = sender.tag;
    [vGoods removeFromSuperview];
    vGoods = nil;
    PackageGoodsInfo* pgi = [((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods objectAtIndex:index];
    ProductDetailViewController* detail = [[ProductDetailViewController alloc] init];
    detail.thisProductId = pgi.gid;
    detail.ThisPorductName = pgi.name;
    detail.isPush = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)addToPackage:(UIButton*)sender
{
    PackageProductInfo* ppInfo = nil;
    PackageSpecValueInfo* colorSpecValueInfo = [marrColor objectAtIndex:currentColor isArray:nil];
    PackageSpecValueInfo* sizeSpecValueInfo = [marrSize objectAtIndex:currentSize isArray:nil];
    PackageSpecInfo* firstSpec = (PackageSpecInfo*)[goodsInfo.specs firstObject];
    PackageSpecInfo* lastSpec = (PackageSpecInfo*)[goodsInfo.specs lastObject];
    for (PackageProductInfo* ppi in goodsInfo.products) {
        if ([[ppi._spec_value_ids attributeForKey:firstSpec.sId] isEqualToString:colorSpecValueInfo.sid] && [[ppi._spec_value_ids attributeForKey:lastSpec.sId] isEqualToString:sizeSpecValueInfo.sid]) {
            ppInfo = ppi;
            break;
        }
    }
    if (ppInfo) {
//        NSLog(@"%@, %@", ppInfo.product_id, ppInfo._spec_value_ids);
        PackageGroupInfo* pGroupInfo = nil;
        NSInteger groupIndex = -1;
        for (NSInteger i = 0; i < _pInfo.packageinfo.groups.count; ++i) {
            PackageGroupInfo* pgi = [_pInfo.packageinfo.groups objectAtIndex:i isArray:nil];
            for (PackageGoodsInfo* pginfo in pgi.goods) {
                if (pginfo == goodsInfo) {
                    pGroupInfo = pgi;
                    groupIndex = i;
                    break;
                }
            }
        }
        if (pGroupInfo && (groupIndex > -1)) {
            NSInteger i = 0;
            for (NSDictionary* dic in _marrGoods) {
                PackageGoodsInfo* pGoodsInfo = [dic objectForKey:[[dic allKeys] firstObject] isDictionary:nil];
//                NSInteger index = [[[((NSString*)[[dic allKeys] firstObject]) componentsSeparatedByString:@"_"] firstObject] integerValue];
                for (PackageGroupInfo* pgi in _pInfo.packageinfo.groups) {
                    for (PackageGoodsInfo* pginfo in pgi.goods) {
                        if (pginfo == pGoodsInfo) {
                            ++i;
                            break;
                        }
                    }
                }
            }
            if (i < [pGroupInfo.need_select_count integerValue]) {
                [_marrGoods addObject:@{[NSString stringWithFormat:@"%@_%@",pGroupInfo.gid, ppInfo.product_id] : goodsInfo}];
                if (_svPackage) {
                    CGFloat spacing = 15;
                    for (NSInteger i = 0; i < _svPackage.subviews.count; ++i) {
                        UIView* v = [_svPackage.subviews objectAtIndex:i isArray:nil];
                        if (v.frame.origin.x == (spacing + (_marrGoods.count - 1) * (spacing + 60))) {
                            UrlImageView* uiv = (UrlImageView*)v;
                            [uiv setImageWithURL:[NSURL URLWithString:goodsInfo.image_url] placeholderImage:nil];
                            UIButton* btnDel = [UIButton buttonWithType:UIButtonTypeCustom];
                            [btnDel setFrame:CGRectMake(uiv.frame.origin.x + uiv.frame.size.width - 15, uiv.frame.origin.y - 9, 25, 25)];
                            [btnDel setTag:_marrGoods.count - 1];
                            [btnDel setImage:[UIImage imageNamed:@"lp_shut_h"] forState:UIControlStateNormal];
                            [btnDel addTarget:self action:@selector(delSelectedGoods:) forControlEvents:UIControlEventTouchUpInside];
                            [_svPackage addSubview:btnDel];
                            break;
                        }
                    }

                }
            }else
            {
                UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@最多只能购买%@件", pGroupInfo.name, pGroupInfo.need_select_count] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [av show];
            }
        }
    }
    [self closeGoodsView:nil];
}

-(void)addToCart:(UIButton*)sender
{
    BOOL pickGoodsDone = YES;
    for (NSInteger i = 0; i < _pInfo.packageinfo.groups.count; ++i) {
        NSInteger count = 0;
        PackageGroupInfo* pgi = (PackageGroupInfo*)[_pInfo.packageinfo.groups objectAtIndex:i isArray:nil];
        for (NSDictionary* dic in _marrGoods) {
            PackageGoodsInfo* pGoodsInfo = [dic objectForKey:[[dic allKeys] firstObject] isDictionary:nil];
            for (PackageGoodsInfo* pginfo in pgi.goods) {
                if (pginfo == pGoodsInfo) {
                    ++count;
                    break;
                }
            }
        }
        if (count != [pgi.need_select_count integerValue]) {
            pickGoodsDone = NO;
            UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@还未满足条件,无法购买礼包", pgi.name] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [av show];
            return;
        }
    }
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [mainSev addPackageToCartWithData:_marrGoods andPid:self.pid];
}

-(void)resetPackage:(UIButton*)sender
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定重置？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    av.tag = 10213219;
    [av show];
}

-(NSArray*)viewConstraints
{
    NSDictionary *views = @{@"tbPackage" : self.tbPackage, @"vToolbar" : self.vToolbar};
    NSDictionary *metrics = @{@"barHeight" : [NSNumber numberWithFloat:lee1fitAllScreen(59)]};
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tbPackage]|" options:0 metrics:metrics views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0@999)-[vToolbar(barHeight)]|" options:0 metrics:metrics views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tbPackage]|" options:0 metrics:metrics views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[vToolbar]|" options:0 metrics:metrics views:views]];
    return constraints;
}

-(UITableView *)tbPackage
{
    if (_tbPackage) {
        return _tbPackage;
    }
    _tbPackage = [[UITableView alloc] init];
    [_tbPackage setShowsVerticalScrollIndicator:NO];
    [_tbPackage setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tbPackage setTranslatesAutoresizingMaskIntoConstraints:NO];
    return _tbPackage;
}

-(UIView *)vToolbar
{
    if (_vToolbar) {
        return _vToolbar;
    }
    _vToolbar = [[UIView alloc] init];
    [_vToolbar setBackgroundColor:[UIColor whiteColor]];
    [_vToolbar setAlpha:0.8];
    [_vToolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    return _vToolbar;
}

-(void)changeCellDisplay:(UIButton*)sender
{
    
}

-(void)createtoolbarandpicker{
    //toolbar上地按钮
    UIBarButtonItem *buttonForCancel_Number=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel_Number.tintColor = [UIColor whiteColor];
    }
    buttonForCancel_Number.tag=101;
    UIBarButtonItem *buttonForFix_Number=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix_Number.width=225;
    UIBarButtonItem *buttonForDone_Number=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForDone_Number.tintColor = [UIColor whiteColor];
    }
    buttonForDone_Number.tag=102+10;
    
    //创建picker
    //    颜色的pickeView
    pickerForSelectColor=[[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, 320, 216)];
    [pickerForSelectColor setDelegate:self];
    [pickerForSelectColor setDataSource:self];
    pickerForSelectColor.showsSelectionIndicator=YES;
    //    [self.view addSubview:pickerForSelectColor];
    [[MyAppDelegate window] addSubview:pickerForSelectColor];
    //    尺寸的Pickview
    pickerForSelectSize=[[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, 320, 216)];
    [pickerForSelectSize setDelegate:self];
    [pickerForSelectSize setDataSource:self];
    pickerForSelectSize.showsSelectionIndicator=YES;
    //    [self.view addSubview:pickerForSelectSize];
    [[MyAppDelegate window] addSubview:pickerForSelectSize];
    
    //创建toolbar
    toolBarForPicker=[[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight+20, 320, 44)];
    toolBarForPicker.hidden = YES;
    toolBarForPicker.barStyle=UIBarStyleBlackTranslucent;
    //    [self.view addSubview:toolBarForPicker];
    [[MyAppDelegate window] addSubview:toolBarForPicker];
    toolBarForSizePicker=[[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight+20, 320, 44)];
    toolBarForSizePicker.barStyle=UIBarStyleBlackTranslucent;
    //    [self.view addSubview:toolBarForSizePicker];
    [[MyAppDelegate window] addSubview:toolBarForSizePicker];
    
    //toolbar上地按钮
    UIBarButtonItem *buttonForCancel=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel.tintColor = [UIColor whiteColor];
    }
    buttonForCancel.tag=101;
    UIBarButtonItem *buttonForFix=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix.width=225;
    UIBarButtonItem *buttonForDone=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForDone.tintColor = [UIColor whiteColor];
    }
    buttonForDone.tag=102;
    [toolBarForPicker setItems:[NSArray arrayWithObjects:buttonForCancel,buttonForFix,buttonForDone,nil]];
    
    
    UIBarButtonItem *buttonForCancel_size=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel_size.tintColor = [UIColor whiteColor];
    }
    buttonForCancel_size.tag=101+100;
    UIBarButtonItem *buttonForFix_size=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix_size.width=220;
    UIBarButtonItem *buttonForDone_size=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForDone_size.tintColor = [UIColor whiteColor];
    }
    buttonForDone_size.tag=102+100;
    [toolBarForSizePicker setItems:[NSArray arrayWithObjects:buttonForCancel_size,buttonForFix_size,buttonForDone_size,nil]];
    
    pickerForSelectColor.backgroundColor = [UIColor whiteColor];
    pickerForSelectSize.backgroundColor = [UIColor whiteColor];
    
}

- (void)hiddle {
    toolBarForSizePicker.hidden = YES;
    toolBarForPicker.hidden = YES;
}

-(void)hiddenBar{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    pickerForSelectColor.frame=CGRectMake(0, ScreenHeight, 320, 216);
    toolBarForPicker.frame=CGRectMake(0, ScreenHeight+20, 320, 44)
    ;
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    pickerForSelectSize.frame=CGRectMake(0, ScreenHeight, 320, 216);
    toolBarForSizePicker.frame=CGRectMake(0, ScreenHeight+20, 320, 44)
    ;
    [UIView setAnimationDidStopSelector:@selector(hiddle)];
    [UIView commitAnimations];
}

-(void)BarButtonClick:(UIBarButtonItem *)barButton{
    
    
    [self hiddenBar];
    
    
    if(barButton.tag==102)
    {
        //颜色
        PackageSpecValueInfo* sepcValueInfo = [marrColor objectAtIndex:currentColor isArray:nil];
        [btnColor setTitle:sepcValueInfo.spec_alias forState:UIControlStateNormal];
        
        PackageSpecInfo* firstSepc = (PackageSpecInfo*)[goodsInfo.specs firstObject];
        PackageSpecInfo* lastSepc = (PackageSpecInfo*)[goodsInfo.specs lastObject];
        
        [marrSize removeAllObjects];
        for (PackageProductInfo* ppi in goodsInfo.products) {
            if ([[ppi._spec_value_ids attributeForKey:firstSepc.sId] isEqualToString:sepcValueInfo.sid]) {
                NSString* tempSpecValue = [ppi._spec_value_ids attributeForKey:lastSepc.sId];
                PackageSpecValueInfo* sepcValueInfo = [[PackageSpecValueInfo alloc] init];
                [sepcValueInfo setAttributeDic:((YKBaseEntity*)[goodsInfo.spec_values attributeForKey:tempSpecValue]).attributeDic];
                if (marrSize.count > 0) {
                    BOOL has = NO;
                    for (int i = 0; i < marrColor.count; ++i) {
                        PackageSpecValueInfo* recordColor = [marrColor objectAtIndex:i isArray:nil];
                        if ([recordColor.spec_alias isEqualToString:sepcValueInfo.spec_alias]) {
                            has = YES;
                        }
                    }
                    if (!has) {
                        [marrSize addObject:sepcValueInfo];
                    }
                }else{
                    [marrSize addObject:sepcValueInfo];
                }
            }
        }
        currentSize = 0;
        sepcValueInfo = [marrSize objectAtIndex:currentSize isArray:nil];
        [btnSize setTitle:sepcValueInfo.spec_alias forState:UIControlStateNormal];
    }
    else if(barButton.tag==102+100)
    {
        PackageSpecValueInfo* sepcValueInfo = [marrSize objectAtIndex:currentSize isArray:nil];
        [btnSize setTitle:sepcValueInfo.spec_alias forState:UIControlStateNormal];
    }
}

/**
 *	颜色picker的显示
 *	@param  (UIButton *)button 颜色按钮
 *  @return (void)
 */
-(void)showPicker:(UIButton *)button
{
    [pickerForSelectColor removeFromSuperview];
    [toolBarForPicker removeFromSuperview];
    [pickerForSelectSize removeFromSuperview];
    [toolBarForSizePicker removeFromSuperview];
    
    [self createtoolbarandpicker];
    
    if (button == btnColor) {
        //color
        toolBarForSizePicker.hidden = YES;
        toolBarForPicker.hidden = NO;
        [pickerForSelectColor reloadAllComponents];//picker的数据源是会变的 reload后更换一套新的数据源
        [pickerForSelectColor selectRow:currentColor inComponent:0 animated:NO];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        pickerForSelectSize.frame=CGRectMake(0, ScreenHeight, 320, 216);
        toolBarForSizePicker.frame=CGRectMake(0,ScreenHeight+20, 320, 44);
        pickerForSelectColor.frame=CGRectMake(0, ScreenHeight-PickShowHigh, 320, 216);
        toolBarForPicker.frame=CGRectMake(0, ScreenHeight-PickShowHigh-44, 320, 44);
        
        [UIView commitAnimations];
    }else{
        //size
        toolBarForSizePicker.hidden = NO;
        toolBarForPicker.hidden = YES;
        [pickerForSelectSize reloadAllComponents];//picker的数据源是会变的 reload后更换一套新的数据源
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        pickerForSelectSize.frame=CGRectMake(0, ScreenHeight-PickShowHigh, 320, 216);
        toolBarForSizePicker.frame=CGRectMake(0,ScreenHeight-PickShowHigh-44, 320, 44);
        pickerForSelectColor.frame=CGRectMake(0, ScreenHeight, 320, 216);
        toolBarForPicker.frame=CGRectMake(0, ScreenHeight+20, 320, 44);
        [UIView commitAnimations];
    }
}

#pragma mark table delegate&dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = _pInfo.packageinfo.groups.count;
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView* v = [[UIView alloc] init];
    for (NSInteger i = 0; i < ((PackageGroupInfo*)[_pInfo.packageinfo.groups objectAtIndex:indexPath.row isArray:nil]).goods.count; ++i) {
        PackageGoodsInfo* pgi = [((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods objectAtIndex:i];
        UIView* vUnit = [[UIView alloc] initWithFrame:CGRectMake(15 + (i % 2) * (lee1fitAllScreen(140) + 10), (i / 2) * (lee1fitAllScreen((180 + 105))), lee1fitAllScreen(140), lee1fitAllScreen((180 + 105)))];
        UrlImageView* uiv = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 15, lee1fitAllScreen(140), lee1fitAllScreen(180))];
        [uiv setImageWithURL:[NSURL URLWithString:pgi.image_url] placeholderImage:nil];
        [vUnit addSubview:uiv];
        
        UILabel* lblName = [[UILabel alloc] init];
        [lblName setFont:[UIFont systemFontOfSize:11]];
        [lblName setNumberOfLines:2];
        [lblName setText:pgi.name];
        [lblName setTextColor:[UIColor colorWithHexString:@"#333333"]];
        [lblName setLineBreakMode:NSLineBreakByTruncatingTail];
        NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
        [mps setLineBreakMode:NSLineBreakByCharWrapping];
        CGRect rcName = [lblName.text boundingRectWithSize:CGSizeMake(vUnit.frame.size.width - 20, 36) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSParagraphStyleAttributeName : mps, NSFontAttributeName : lblName.font} context:nil];
        [lblName setFrame:CGRectMake(10, uiv.frame.size.height + uiv.frame.origin.y + 12, rcName.size.width, rcName.size.height)];
        [vUnit addSubview:lblName];
        
        UILabel* lblPrice = [[UILabel alloc] init];
        [lblPrice setFont:[UIFont systemFontOfSize:11]];
        [lblPrice setText:[NSString stringWithFormat:@"￥%@", pgi.price]];
        [lblPrice setTextColor:[UIColor colorWithHexString:@"#c8002c"]];
        CGRect rcPrice = [lblName.text boundingRectWithSize:CGSizeMake(vUnit.frame.size.width - 20, 36) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblPrice.font} context:nil];
        [lblPrice setFrame:CGRectMake(lblName.frame.origin.x, vUnit.frame.size.height - 15 - rcPrice.size.height, rcPrice.size.width, rcPrice.size.height)];
        [vUnit addSubview:lblPrice];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, vUnit.frame.size.width, vUnit.frame.size.height)];
        [btn addTarget:self action:@selector(selectGoods:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:indexPath.row * 10000 + i];
        [vUnit addSubview:btn];
        
        [v addSubview:vUnit];
        
        if (i % 2 == 1) {
            UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(15, vUnit.frame.origin.y + vUnit.frame.size.height, [UIScreen mainScreen].bounds.size.width - 30, 0.5)];
            [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d1d1d1"]];
            [v addSubview:lblSep];
        }
    }
    
    NSInteger total = ((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods.count;
    CGFloat height = 0;
    UIView* vGroup = nil;
    if ([self tableView:tableView numberOfRowsInSection:0] > 1) {
        vGroup = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        UILabel* lblGroupName = [[UILabel alloc] initWithFrame:CGRectMake(15, (lee1fitAllScreen(44) - 15) / 2, SCREEN_WIDTH - 30, 15)];
        [lblGroupName setFont:[UIFont systemFontOfSize:15]];
        [lblGroupName setText:((PackageGroupInfo*)[_pInfo.packageinfo.groups objectAtIndex:indexPath.row isArray:nil]).name];
        [lblGroupName setTextColor:[UIColor colorWithHexString:@"#181818"]];
        [vGroup addSubview:lblGroupName];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, tableView.frame.size.width, lee1fitAllScreen(44))];
        [btn addTarget:self action:@selector(changeCellDisplay:) forControlEvents:UIControlEventTouchUpInside];
        [vGroup addSubview:btn];
        height = lee1fitAllScreen(44);
    }
    [v setFrame:CGRectMake(0, height, SCREEN_WIDTH, lee1fitAllScreen(285) * (total % 2 > 0 ? (total / 2 + 1) : (total / 2)))];
    UITableViewCell* cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, v.frame.size.width, v.frame.size.height + height)];
    [cell addSubview:v];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = _pInfo.packageinfo.groups.count;
    CGFloat height = 0;
    if (count) {
        height += 44;
    }
    NSInteger total = ((PackageGroupInfo*)[_pInfo.packageinfo.groups objectAtIndex:indexPath.row isArray:nil]).goods.count;
    height += lee1fitAllScreen(285) * (total % 2 > 0 ? (total / 2 + 1) : (total / 2));
    return height;
}
#pragma mark picker delegate&dataSource
//====================================================
// 函数名称: picker delegate&dataSource
// 函数功能: picker的协议方法
//====================================================
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==pickerForSelectColor) {
        return marrColor.count;
    }else if (pickerView == pickerForSelectSize) {
        return [marrSize count];
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 44) ];
    NSString *pickerText=@"";
    UrlImageView *image=[[UrlImageView alloc]init];
    if (pickerView == pickerForSelectColor) {
        PackageSpecValueInfo* sepcValueInfo = [marrColor objectAtIndex:row isArray:nil];
        pickerText= sepcValueInfo.spec_alias;
        [image setImageWithURL:[NSURL URLWithString:sepcValueInfo.spec_alias]];
        titleLabel.textAlignment = UITextAlignmentLeft;
    }
    else if (pickerView==pickerForSelectSize){
        
        titleLabel.textAlignment = UITextAlignmentCenter;
        
        PackageSpecValueInfo* sepcValueInfo = [marrSize objectAtIndex:row isArray:nil];
        pickerText= sepcValueInfo.spec_alias;
        
    }
    titleLabel.text = pickerText;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [ UIFont boldSystemFontOfSize:18];;
    titleLabel.opaque = NO;
    
    image.frame=CGRectMake(180, 4, 50, 36);
    UIView *view_image=[[UIView alloc]init];
    view_image.frame=CGRectMake(0, 0, 320, 44);
    [view_image addSubview:image];
    [view_image addSubview:titleLabel];
    return view_image;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView==pickerForSelectColor) {
        currentColor = row;
    }else if (pickerView == pickerForSelectSize) {
        currentSize = row;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10213219) {
        if (buttonIndex == 1) {
            [_marrGoods removeAllObjects];
            if(_svPackage)
            {
                [_svPackage removeFromSuperview];
                _svPackage = nil;
                [self showPackage:nil];
            }
        }
        return;
    }
    if (alertView.tag >= 20000) {
        if (buttonIndex == 1) {
            [_marrGoods removeObjectAtIndex:alertView.tag - 20000];
            if (_svPackage) {
                [_svPackage removeFromSuperview];
                _svPackage = nil;
                [self showPackage:nil];
//                CGFloat spacing = 15;
//                BOOL finduiv = NO;
//                BOOL finddelbtn = NO;
//                UrlImageView* uiv = nil;
//                for (NSInteger i = 0; i < _vPackage.subviews.count; ++i) {
//                    UIView* v = [_vPackage.subviews objectAtIndex:i isArray:nil];
//                    if (v.frame.origin.x == (spacing + (alertView.tag - 20000) * (spacing + 60))) {
//                        uiv = (UrlImageView*)v;
//                        [uiv setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
//                        finduiv = YES;
//                    }
//                    if (uiv) {
//                        if (uiv.frame.origin.x + uiv.frame.size.width - 15 == v.frame.origin.x) {
//                            [v removeFromSuperview];
//                            finddelbtn = YES;
//                        }
//                    }
//                    if (finddelbtn && finduiv) {
//                        break;
//                    }
//                }
            }
        }
    }
}

@end
