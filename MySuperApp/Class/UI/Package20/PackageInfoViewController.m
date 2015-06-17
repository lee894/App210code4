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
@property (nonatomic, retain) UIScrollView* svPackage;
@property (nonatomic, retain) NSMutableArray *marrGoods;
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
    [self.view addSubview:self.svPackage];
    [self.view addConstraints:[self viewConstraints]];
    [mainSev getPackageInfoWithPid:self.pid];
    currentColor = 0;
    currentSize = 0;
    self.marrGoods = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)serviceStarted:(ServiceType)aHandle
{
    
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    _pInfo = [[[PackageInfoParser alloc] init] parsePackageInfo:amodel];
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
    for (NSInteger i = 0; i < ((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods.count; ++i) {
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
        [btn setTag:i];
        [vUnit addSubview:btn];
        
        [self.svPackage addSubview:vUnit];
        
        if (i % 2 == 1) {
            UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(15, vUnit.frame.origin.y + vUnit.frame.size.height, [UIScreen mainScreen].bounds.size.width - 30, 0.5)];
            [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d1d1d1"]];
            [self.svPackage addSubview:lblSep];
        }
    }
    NSInteger total = ((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods.count;
    [_svPackage setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, lee1fitAllScreen(285) * (total % 2 > 0 ? (total / 2 + 1) : (total / 2)))];
}

-(void)serviceFailed:(ServiceType)aHandle
{
    
}

-(void)closeGoodsView:(UIButton*)sender
{
    [vGoods removeFromSuperview];
}

-(void)selectGoods:(UIButton*)sender
{
    NSInteger index = sender.tag;
    goodsInfo = [((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods objectAtIndex:index];
    
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
}

-(void)toDetail:(UIButton*)sender
{
    NSInteger index = sender.tag;
    [vGoods removeFromSuperview];
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
        [_marrGoods addObject:@{ppInfo.product_id : goodsInfo}];
    }
    [self closeGoodsView:nil];
}

-(NSArray*)viewConstraints
{
    NSDictionary *views = @{@"svPackage" : self.svPackage};
    NSDictionary *metrics = @{@"barHeight" : [NSNumber numberWithFloat:lee1fitAllScreen(59)]};
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[svPackage]-(barHeight)-|" options:0 metrics:metrics views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[svPackage]|" options:0 metrics:metrics views:views]];
    return constraints;
}

-(UIScrollView *)svPackage
{
    if (_svPackage) {
        return _svPackage;
    }
    _svPackage = [[UIScrollView alloc] init];
    [_svPackage setDelegate:self];
    [_svPackage setShowsVerticalScrollIndicator:NO];
    [_svPackage setTranslatesAutoresizingMaskIntoConstraints:NO];
    return _svPackage;
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



@end
