//
//  ManageGiftViewController.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15/6/29.
//  Copyright (c) 2015年 aimer. All rights reserved.
//
#import "GiftCheckOutFinishViewController.h"
#import "PackageInfoParser.h"
#import "ManageGiftInfoParser.h"
#import "AddressViewController.h"
#import "AddAddressViewController.h"
#import "ManageGiftViewController.h"

#define PickShowHigh 265.+50.

@interface ManageGiftViewController ()
{
    UIPickerView *pickerForSelectColor;//颜色下拉列表
    UIToolbar *toolBarForPicker;//picker上的toolbar
    UIPickerView *pickerForSelectSize;//尺寸下来列表
    UIToolbar *toolBarForSizePicker;//尺寸picker的toolbar
    NSMutableArray *marrColor;//颜色数据源
    NSMutableArray *marrSize;//尺码数据源
    NSInteger currentColor;//滚动picker临时储存选项
    NSInteger currentSize;
    UIButton* btnCurColor;
    UIButton* btnCurSize;
    GiftProductInfo* curGPI;
    CGFloat fAddressCellHeight;
}
@property (nonatomic, strong) MainpageServ* mainSer;
@property (nonatomic, retain) UITableView* mytableView;
@property (nonatomic, retain) NSMutableArray* marrCell;
@property (nonatomic, retain) ManageGiftInfo* mgi;
@property (nonatomic, retain) NSString* straddressID;
@property (nonatomic, retain) AddressAddresslist* addressItem_ben;
@end

@implementation ManageGiftViewController

-(void)viewWillAppear:(BOOL)animated
{
    if (_mgi) {
        if (![_straddressID isEqualToString:_mgi.address.address_id]) {
            NSLog(@"%@",  @"地址变化");
            [_mainSer getGiftWithCode:self.couponInfo.code andAddress:_straddressID];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtnWithType:0];
    [self setTitle:@"选择您的礼品"];
    
    [self.view addSubview:self.mytableView];
    [self.view addConstraints:[self viewConstraints]];
    _marrCell = [[NSMutableArray alloc] initWithCapacity:1];
    _mainSer = [[MainpageServ alloc] init];
    _mainSer.delegate = self;
    [_mainSer getGiftWithCode:self.couponInfo.code andAddress:@""];
}

-(void)serviceStarted:(ServiceType)aHandle
{
    
}

-(void)serviceFailed:(ServiceType)aHandle
{
    
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    switch ((NSUInteger)aHandle) {
        case Http_GetGiftCode20_Tag:
        {
            _mgi = [[[ManageGiftInfoParser alloc] init] ParseManageGiftInfo:amodel];
            [self createProductCell];
            [_mytableView setDelegate:self];
            [_mytableView setDataSource:self];
            [_mytableView reloadData];
            
            UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _mytableView.frame.size.width, lee1fitAllScreen(75))];
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake((v.frame.size.width - lee1fitAllScreen(240)) / 2, 15, lee1fitAllScreen(240), lee1fitAllScreen(36))];
            [btn setBackgroundImage:[[UIImage imageNamed:@"btn_mid_b_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 120, 18, 120) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
            [btn setBackgroundImage:[[UIImage imageNamed:@"btn_mid_b_hover"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 120, 18, 120) resizingMode:UIImageResizingModeTile] forState:UIControlStateHighlighted];
            [btn setTitle:@"提交" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(checkOutGift:) forControlEvents:UIControlEventTouchUpInside];
            [v addSubview:btn];
            [_mytableView setTableFooterView:v];
        }
            break;
        case Http_SubmitGiftOrder20_Tag:
        {
            GiftCheckOutFinishViewController* gcovc = [[GiftCheckOutFinishViewController alloc] init];
            gcovc.orderId = [amodel objectForKey:@"orderid" isDictionary:nil];
            [self.navigationController pushViewController:gcovc animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)createProductCell
{
    if (_mgi) {
        [_marrCell removeAllObjects];
        NSInteger m = 0;
        for (GiftProductInfo* gpi in _mgi.productlist) {
            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            UILabel* lblName = [[UILabel alloc] init];
            [lblName setText:gpi.product_name];
            [lblName setTextColor:[UIColor colorWithHexString:@"#181818"]];
            [lblName setFont:[UIFont systemFontOfSize:13]];
            CGRect rcName = [lblName.text boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblName.font} context:nil];
            [lblName setFrame:CGRectMake(15, 15 - (rcName.size.height - lblName.font.pointSize), rcName.size.width, rcName.size.height)];
            [cell addSubview:lblName];
            
            UrlImageView* uiv = [[UrlImageView alloc] initWithFrame:CGRectMake(15, 43, lee1fitAllScreen(84), lee1fitAllScreen(108))];
            [uiv setImageWithURL:[NSURL URLWithString:((ProductBanner*)[gpi.product_banner firstObject]).pic] placeholderImage:nil];
            [cell addSubview:uiv];
            
            UILabel* lblPrice = [[UILabel alloc] init];
            [lblPrice setText:[NSString stringWithFormat:@"价值：￥%@", gpi.mkt_price]];
            [lblPrice setTextColor:[UIColor colorWithHexString:@"#666666"]];
            [lblPrice setFont:[UIFont systemFontOfSize:13]];
            CGRect rcPrice = [lblPrice.text boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblPrice.font} context:nil];
            [lblPrice setFrame:CGRectMake(uiv.frame.size.width + uiv.frame.origin.x + 28, uiv.frame.origin.y + 6 - (rcPrice.size.height - lblPrice.font.pointSize), rcPrice.size.width, rcPrice.size.height)];
            [cell addSubview:lblPrice];
            
            PackageSpecInfo* firstSepc = (PackageSpecInfo*)[gpi.specs firstObject];
            PackageSpecInfo* lastSepc = (PackageSpecInfo*)[gpi.specs lastObject];
            
//            NSMutableArray* marrSize = [NSMutableArray arrayWithCapacity:1];
            GiftProductItemInfo* firstProcuct = [gpi.products firstObject];
            [gpi setCurrentProduct:firstProcuct];
            NSString* strSpecValue = [firstProcuct._spec_value_ids attributeForKey:firstSepc.sId];
            
            SpecValues* firstSepcValueInfo = nil;
            for (SpecValues* sv in gpi.spec_values) {
                if ([sv.svid isEqualToString:strSpecValue]) {
                    firstSepcValueInfo = sv;
                    break;
                }
            }
            
            strSpecValue = [firstProcuct._spec_value_ids attributeForKey:lastSepc.sId];
            SpecValues* lastSepcValueInfo = nil;
            for (SpecValues* sv in gpi.spec_values) {
                if ([sv.svid isEqualToString:strSpecValue]) {
                    lastSepcValueInfo = sv;
                    break;
                }
            }
            
            UIButton* btnColor = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnColor setFrame:CGRectMake(uiv.frame.origin.x + uiv.frame.size.width + 62.5, 76, lee1fitAllScreen(80), lee1fitAllScreen(30))];
            [btnColor addTarget:self action:@selector(showColorPicker:) forControlEvents:UIControlEventTouchUpInside];
            [btnColor setTag:m];
            [btnColor setTitleColor:[UIColor colorWithHexString:@"181818"] forState:UIControlStateNormal];
            [btnColor.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [btnColor setTitle:firstSepcValueInfo.spec_alias forState:UIControlStateNormal];
            [btnColor setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
            [btnColor setBackgroundImage:[UIImage imageNamed:@"lp_option"] forState:UIControlStateNormal];
            [cell addSubview:btnColor];
            
            UILabel* lblColor = [[UILabel alloc] init];
            [lblColor setFont:[UIFont systemFontOfSize:13]];
            [lblColor setText:[NSString stringWithFormat:@"%@：", [firstSepc.view_name stringByReplacingOccurrencesOfString:@"分类" withString:@""]]];
            [lblColor setTextColor:[UIColor colorWithHexString:@"#666666"]];
            [lblColor setFrame:CGRectMake(lblPrice.frame.origin.x, btnColor.center.y - 6.5, 100, 13)];
            [cell addSubview:lblColor];
            
            UIButton* btnSize = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnSize setFrame:CGRectMake(uiv.frame.origin.x + uiv.frame.size.width + 62.5, btnColor.frame.size.height + btnColor.frame.origin.y + 14, lee1fitAllScreen(80), lee1fitAllScreen(30))];
            [btnSize setTag:m];
            [btnSize addTarget:self action:@selector(showSizePicker:) forControlEvents:UIControlEventTouchUpInside];
            [btnSize setTitleColor:[UIColor colorWithHexString:@"181818"] forState:UIControlStateNormal];
            [btnSize.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [btnSize setTitle:lastSepcValueInfo.spec_alias forState:UIControlStateNormal];
            [btnSize setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
            [btnSize setBackgroundImage:[UIImage imageNamed:@"lp_option"] forState:UIControlStateNormal];
            [cell addSubview:btnSize];
            
            UILabel* lblSize = [[UILabel alloc] init];
            [lblSize setFont:[UIFont systemFontOfSize:13]];
            [lblSize setText:[NSString stringWithFormat:@"%@：", lastSepc.view_name]];
            [lblSize setTextColor:[UIColor colorWithHexString:@"#666666"]];
            [lblSize setFrame:CGRectMake(lblPrice.frame.origin.x, btnSize.center.y - 6.5, 100, 13)];
            [cell addSubview:lblSize];
            
            [_marrCell addObject:cell];
            ++m;
        }
    }
}

-(NSArray*)viewConstraints
{
    NSDictionary *views = @{@"mytableView" : self.mytableView};
    NSDictionary *metrics = @{};
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mytableView]|" options:0 metrics:metrics views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mytableView]|" options:0 metrics:metrics views:views]];
    return constraints;
}

-(UITableView *)mytableView
{
    if (_mytableView) {
        return _mytableView;
    }
    _mytableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mytableView.backgroundColor = [UIColor clearColor];
    _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mytableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    return _mytableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    switch (section) {
        case 0:
        {
            row = [_marrCell count];
        }
            break;
        case 1:
        {
            row = 1;
        }
            break;
        default:
            break;
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            cell = [_marrCell objectAtIndex:indexPath.row isArray:nil];
        }
            break;
        case 1:
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            if (_mgi.address.address_id != nil) {
                //有地址
                UILabel* lblName = [[UILabel alloc] init];
                [lblName setText:_mgi.address.user_name];
                [lblName setFont:[UIFont systemFontOfSize:15]];
                [lblName setTextColor:[UIColor colorWithHexString:@"#333333"]];
                CGRect rcName = [lblName.text boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblName.font} context:nil];
                [lblName setFrame:CGRectMake(15, 11 - (rcName.size.height - lblName.font.pointSize), rcName.size.width, rcName.size.height)];
                [cell addSubview:lblName];
                
                UILabel* lblAddress = [[UILabel alloc] init];
                [lblAddress setText:[NSString stringWithFormat:@"地址：%@%@%@", _mgi.address.province, _mgi.address.city, _mgi.address.address]];
                [lblAddress setFont:[UIFont systemFontOfSize:13]];
                [lblAddress setNumberOfLines:0];
                [lblAddress setLineBreakMode:NSLineBreakByCharWrapping];
                [lblAddress setTextColor:[UIColor colorWithHexString:@"#666666"]];
                NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
                mps.lineBreakMode = lblAddress.lineBreakMode;
                
                CGRect rcAddress = [lblAddress.text boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblAddress.font, NSParagraphStyleAttributeName : mps} context:nil];
                [lblAddress setFrame:CGRectMake(15, 40, rcAddress.size.width, rcAddress.size.height)];
                [cell addSubview:lblAddress];

                
                UILabel* lblPhone = [[UILabel alloc] init];
                [lblPhone setText:[NSString stringWithFormat:@"电话：%@", _mgi.address.mobile]];
                [lblPhone setFont:[UIFont systemFontOfSize:13]];
                [lblPhone setTextColor:[UIColor colorWithHexString:@"#333333"]];
                CGRect rcPhone = [lblPhone.text boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblPhone.font} context:nil];
                [lblPhone setFrame:CGRectMake(15, lblAddress.frame.size.height + lblAddress.frame.origin.y + 12 - (rcPhone.size.height - lblPhone.font.pointSize), rcPhone.size.width, rcPhone.size.height)];
                [cell addSubview:lblPhone];
                
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, lee1fitAllScreen(44))];
    [v setBackgroundColor:[UIColor whiteColor]];
    
    UILabel* lbl = [[UILabel alloc] init];
    switch (section) {
        case 0:
        {
            [lbl setText:@"礼品清单"];
        }
            break;
        case 1:
        {
            [lbl setText:@"收货地址"];
            
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(tableView.frame.size.width - 15 - lee1fitAllScreen(25), (v.frame.size.height - lee1fitAllScreen(25)) / 2, lee1fitAllScreen(25), lee1fitAllScreen(25))];
            if (_mgi.address.address_id == nil) {
                //没地址
                [btn setImage:[UIImage imageNamed:@"lp_add"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(addNewAddress:) forControlEvents:UIControlEventTouchUpInside];
            }else
            {
                [btn setImage:[UIImage imageNamed:@"lp_editor"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(changeAddress:) forControlEvents:UIControlEventTouchUpInside];
            }
            [v addSubview:btn];
        }
            break;
        default:
            break;
    }
    [lbl setFont:[UIFont systemFontOfSize:lee1fitAllScreen(15)]];
    [lbl setTextColor:[UIColor colorWithHexString:@"#181818"]];
    CGRect rc = [lbl.text boundingRectWithSize:CGSizeMake(ScreenWidth - 30, lee1fitAllScreen(44)) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lbl.font} context:nil];
    [lbl setFrame:CGRectMake(15, (v.frame.size.height - rc.size.height) / 2, rc.size.width, rc.size.height)];
    [v addSubview:lbl];
    
    return v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    switch (section) {
        case 0:
        {
            v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 42)];
            [v setBackgroundColor:[UIColor whiteColor]];
            UILabel* lbl = [[UILabel alloc] init];
            [lbl setText:@"温馨提示：赠品不予以退换，请您谅解"];
            [lbl setFont:[UIFont systemFontOfSize:12]];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            [lbl setTextColor:[UIColor colorWithHexString:@"#c8002c"]];
            CGSize sz = [lbl.text sizeWithFont:lbl.font];
            [lbl setFrame:CGRectMake(0, (42 - sz.height) / 2, v.frame.size.width, sz.height)];
            [v addSubview:lbl];
        }
            break;
            
        default:
        {
            
        }
            break;
    }
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat fHeight = 0.1;
    switch (section) {
        case 0:
        {
            fHeight = 42 + 10;
        }
            break;
            
        default:
            break;
    }
    return fHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return lee1fitAllScreen(168);
        }
            break;
        case 1:
        {
            if (_mgi.address.address_id == nil) {
                return 0.1;
            }
            
            UILabel* lblName = [[UILabel alloc] init];
            [lblName setText:_mgi.address.user_name];
            [lblName setFont:[UIFont systemFontOfSize:15]];
            [lblName setTextColor:[UIColor colorWithHexString:@"#333333"]];
            CGRect rcName = [lblName.text boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblName.font} context:nil];
            [lblName setFrame:CGRectMake(15, 11 - (rcName.size.height - lblName.font.pointSize), rcName.size.width, rcName.size.height)];
            
            UILabel* lblAddress = [[UILabel alloc] init];
            [lblAddress setText:[NSString stringWithFormat:@"地址：%@%@%@", _mgi.address.province, _mgi.address.city, _mgi.address.address]];
            [lblAddress setFont:[UIFont systemFontOfSize:13]];
            [lblAddress setNumberOfLines:0];
            [lblAddress setLineBreakMode:NSLineBreakByCharWrapping];
            [lblAddress setTextColor:[UIColor colorWithHexString:@"#666666"]];
            NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
            mps.lineBreakMode = lblAddress.lineBreakMode;
            
            CGRect rcAddress = [lblAddress.text boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblAddress.font, NSParagraphStyleAttributeName : mps} context:nil];
            [lblAddress setFrame:CGRectMake(15, 40, rcAddress.size.width, rcAddress.size.height)];
            
            UILabel* lblPhone = [[UILabel alloc] init];
            [lblPhone setText:[NSString stringWithFormat:@"电话：%@", _mgi.address.mobile]];
            [lblPhone setFont:[UIFont systemFontOfSize:13]];
            [lblPhone setTextColor:[UIColor colorWithHexString:@"#333333"]];
            CGRect rcPhone = [lblPhone.text boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 30, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblPhone.font} context:nil];
            [lblPhone setFrame:CGRectMake(15, lblAddress.frame.size.height + lblAddress.frame.origin.y + 12 - (rcPhone.size.height - lblPhone.font.pointSize), rcPhone.size.width, rcPhone.size.height)];
            
            return lblPhone.frame.size.height + lblPhone.frame.origin.y + 15 - (rcPhone.size.height - lblPhone.font.pointSize);
        }
            break;
        default:
            return 0.1;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return lee1fitAllScreen(44);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [_mytableView removeFromSuperview];
    _mytableView = nil;
}

/**
 *	颜色picker的显示
 *	@param  (UIButton *)button 颜色按钮
 *  @return (void)
 */
-(void)showColorPicker:(UIButton *)button
{
    
    [pickerForSelectColor removeFromSuperview];
    [toolBarForPicker removeFromSuperview];
    [pickerForSelectSize removeFromSuperview];
    [toolBarForSizePicker removeFromSuperview];
    
    //生成颜色列表
    
    marrColor = [NSMutableArray arrayWithCapacity:1];
    currentColor = 0;
    GiftProductInfo* gpi = [_mgi.productlist objectAtIndex:button.tag isArray:nil];
    curGPI = gpi;
    PackageSpecInfo* firstSepc = (PackageSpecInfo*)[gpi.specs firstObject];
    
    for (SpecValues* sv in gpi.spec_values) {
        if (![sv.spec_id isEqualToString:firstSepc.sId]) {
            continue;
        }
        if (marrColor.count > 0) {
            BOOL has = NO;
            for (int i = 0; i < marrColor.count; ++i) {
                SpecValues* recordColor = [marrColor objectAtIndex:i isArray:nil];
                if ([recordColor.spec_alias isEqualToString:sv.spec_alias]) {
                    has = YES;
                }
            }
            if (!has) {
                [marrColor addObject:sv];
            }
        }else{
            [marrColor addObject:sv];
        }
    }

    
    [self createtoolbarandpicker];
    //color
    toolBarForSizePicker.hidden = YES;
    toolBarForPicker.hidden = NO;
    [pickerForSelectColor reloadAllComponents];//picker的数据源是会变的 reload后更换一套新的数据源
//    [pickerForSelectColor selectRow:currentColor inComponent:0 animated:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    pickerForSelectSize.frame=CGRectMake(0, ScreenHeight, 320, 216);
    toolBarForSizePicker.frame=CGRectMake(0,ScreenHeight+20, 320, 44);
    pickerForSelectColor.frame=CGRectMake(0, ScreenHeight-PickShowHigh, 320, 216);
    toolBarForPicker.frame=CGRectMake(0, ScreenHeight-PickShowHigh-44, 320, 44);
    
    [UIView commitAnimations];
    btnCurColor = button;
    for (UIView* v in button.superview.subviews) {
        if (v.tag == button.tag && v != button && [v class] == [UIButton class]) {
            btnCurSize = (UIButton*)v;
            break;
        }
    }
}

-(void)showSizePicker:(UIButton*)button
{
    [pickerForSelectColor removeFromSuperview];
    [toolBarForPicker removeFromSuperview];
    [pickerForSelectSize removeFromSuperview];
    [toolBarForSizePicker removeFromSuperview];
    
    
    marrSize = [NSMutableArray arrayWithCapacity:1];
    currentSize = 0;
    
    GiftProductInfo* gpi = [_mgi.productlist objectAtIndex:button.tag isArray:nil];
    curGPI = gpi;
    PackageSpecInfo* firstSepc = (PackageSpecInfo*)[gpi.specs firstObject];
    PackageSpecInfo* lastSepc = (PackageSpecInfo*)[gpi.specs lastObject];
    
    NSString* strSpecValue = [gpi.currentProduct._spec_value_ids attributeForKey:firstSepc.sId];
    for (GiftProductItemInfo* gpii in gpi.products)
    {
        if ([[gpii._spec_value_ids attributeForKey:firstSepc.sId] isEqualToString:strSpecValue])
        {
            NSString* tempSpecValue = [gpii._spec_value_ids attributeForKey:lastSepc.sId];
            SpecValues* specValue = nil;
            for (SpecValues* sv in gpi.spec_values)
            {
                if ([sv.svid isEqualToString:tempSpecValue])
                {
                    specValue = sv;
                    break;
                }
            }
            if (marrSize.count > 0) {
                BOOL has = NO;
                for (int i = 0; i < marrSize.count; ++i)
                {
                    SpecValues* recordColor = [marrSize objectAtIndex:i isArray:nil];
                    if ([recordColor.spec_alias isEqualToString:specValue.spec_alias]) {
                        has = YES;
                    }
                }
                if (!has) {
                    [marrSize addObject:specValue];
                }
            }else{
                [marrSize addObject:specValue];
            }
        }
    }

    
    [self createtoolbarandpicker];
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
    btnCurSize = button;
}

-(void)createtoolbarandpicker{
    //toolbar上地按钮
    UIBarButtonItem *buttonForCancel_Number=[[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel_Number.tintColor = [UIColor whiteColor];
    }
    buttonForCancel_Number.tag=101;
    UIBarButtonItem *buttonForFix_Number=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix_Number.width=210;
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
    UIBarButtonItem *buttonForCancel=[[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel.tintColor = [UIColor whiteColor];
    }
    buttonForCancel.tag=101;
    UIBarButtonItem *buttonForFix=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix.width=210;
    UIBarButtonItem *buttonForDone=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForDone.tintColor = [UIColor whiteColor];
    }
    buttonForDone.tag=102;
    [toolBarForPicker setItems:[NSArray arrayWithObjects:buttonForCancel,buttonForFix,buttonForDone,nil]];
    
    
    UIBarButtonItem *buttonForCancel_size=[[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel_size.tintColor = [UIColor whiteColor];
    }
    buttonForCancel_size.tag=101+100;
    UIBarButtonItem *buttonForFix_size=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix_size.width=210;
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
        SpecValues* sepcValueInfo = [marrColor objectAtIndex:currentColor isArray:nil];
        [btnCurColor setTitle:sepcValueInfo.spec_alias forState:UIControlStateNormal];
        
        PackageSpecInfo* firstSepc = (PackageSpecInfo*)[curGPI.specs firstObject];
        PackageSpecInfo* lastSepc = (PackageSpecInfo*)[curGPI.specs lastObject];
        if (!marrSize) {
            marrSize = [[NSMutableArray alloc] initWithCapacity:1];
        }
        [marrSize removeAllObjects];
        NSString* strSpecValue = [curGPI.currentProduct._spec_value_ids attributeForKey:firstSepc.sId];
        for (GiftProductItemInfo* gpii in curGPI.products)
        {
            if ([[gpii._spec_value_ids attributeForKey:firstSepc.sId] isEqualToString:strSpecValue])
            {
                NSString* tempSpecValue = [gpii._spec_value_ids attributeForKey:lastSepc.sId];
                SpecValues* specValue = nil;
                for (SpecValues* sv in curGPI.spec_values)
                {
                    if ([sv.svid isEqualToString:tempSpecValue])
                    {
                        specValue = sv;
                        break;
                    }
                }
                if (marrSize.count > 0) {
                    BOOL has = NO;
                    for (int i = 0; i < marrSize.count; ++i)
                    {
                        SpecValues* recordColor = [marrSize objectAtIndex:i isArray:nil];
                        if ([recordColor.spec_alias isEqualToString:specValue.spec_alias]) {
                            has = YES;
                        }
                    }
                    if (!has) {
                        [marrSize addObject:specValue];
                    }
                }else{
                    [marrSize addObject:specValue];
                }
            }
        }

        currentSize = 0;
        SpecValues* lastSepcValueInfo = [marrSize objectAtIndex:currentSize isArray:nil];
        [btnCurSize setTitle:lastSepcValueInfo.spec_alias forState:UIControlStateNormal];
        
        for (GiftProductItemInfo* gpii in curGPI.products) {
            NSString* firstSepcValue = [gpii._spec_value_ids attributeForKey:firstSepc.sId];
            NSString* lastSepcValue = [gpii._spec_value_ids attributeForKey:lastSepc.sId];
            if ([firstSepcValue isEqualToString:sepcValueInfo.svid] && [lastSepcValue isEqualToString:lastSepcValueInfo.svid]) {
                [curGPI setCurrentProduct:gpii];
                break;
            }
        }
    }
    else if(barButton.tag==102+100)
    {
        
        PackageSpecInfo* firstSepc = (PackageSpecInfo*)[curGPI.specs firstObject];
        PackageSpecInfo* lastSepc = (PackageSpecInfo*)[curGPI.specs lastObject];
        
        GiftProductItemInfo* curGPII = [curGPI currentProduct];
        NSString* firstSepcValue = [curGPII._spec_value_ids attributeForKey:firstSepc.sId];
        SpecValues* firstSepcValueInfo = nil;
        for (SpecValues* sv in curGPI.spec_values) {
            if ([sv.svid isEqualToString:firstSepcValue]) {
                firstSepcValueInfo = sv;
                break;
            }
        }
        
        if (!firstSepcValueInfo) {
            return;
        }
        
        SpecValues* sepcValueInfo = [marrSize objectAtIndex:currentSize isArray:nil];
        [btnCurSize setTitle:sepcValueInfo.spec_alias forState:UIControlStateNormal];
        
        for (GiftProductItemInfo* gpii in curGPI.products) {
            NSString* firstSepcValue = [gpii._spec_value_ids attributeForKey:firstSepc.sId];
            NSString* lastSepcValue = [gpii._spec_value_ids attributeForKey:lastSepc.sId];
            if ([firstSepcValue isEqualToString:firstSepcValueInfo.svid] && [lastSepcValue isEqualToString:sepcValueInfo.svid]) {
                [curGPI setCurrentProduct:gpii];
                break;
            }
        }
    }
}

-(void)checkOutGift:(UIButton*)sender
{
    if (_mgi.address.address_id != nil) {
        NSMutableString* products = [[NSMutableString alloc] initWithCapacity:1];
        for (GiftProductInfo* gpi in _mgi.productlist) {
            [products appendFormat:@"%@,", gpi.currentProduct.pid];
        }
        [_mainSer submitGiftOrderWithAddress:_mgi.address.address_id andCode:_couponInfo.code andProducts:[products substringToIndex:products.length - 1]];
    }
}

-(void)addNewAddress:(UIButton*)sender
{
    //地址选择
    AddAddressViewController *tempAddAddress = [[AddAddressViewController alloc] initWithNibName:@"AddAddressViewController" bundle:nil];
    tempAddAddress.addOrEdit = YES;
    tempAddAddress.covc = self;
    tempAddAddress.isFromcheck = NO;
    [self.navigationController pushViewController:tempAddAddress animated:YES];
}

-(void)changeAddress:(UIButton*)sender
{
    //地址选择
    AddressViewController* addressView = [[AddressViewController alloc] initWithNibName:@"AddressViewController" bundle:nil];
    addressView.chectOutViewC = self;
    addressView.PublicStringAddressId=self.straddressID;
    addressView.isCar = YES;
    [self.navigationController pushViewController:addressView animated:YES];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == pickerForSelectColor) {
        currentColor = row;
    }else if (pickerView == pickerForSelectSize) {
        currentSize = row;
    }
}

@end
