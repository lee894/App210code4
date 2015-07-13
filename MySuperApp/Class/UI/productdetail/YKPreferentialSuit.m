//
//  YKPreferentialSuit.m
//  YKProduct
//
//  Created by 耶客 on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YKPreferentialSuit.h"
#import "ProductDetailViewController.h"
#import "CarpageViewController.h"

#import "YKItem.h"
#import "UrlImageButton.h"
#import "UIColorAdditions.h"

#define PickShowHigh 265.

#define YKPRODUCT_BARBUTTON_CANCEL 101
#define YKPRODUCT_BARBUTTON_DONE 102

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation YKPreferentialSuit
@synthesize strStuit;
@synthesize isFromMyAimer;
@synthesize isHiddenBar;


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    
    [self hiddenPicker];
    
    [self BarButtonClick:(UIBarButtonItem *)[toolBarForPicker viewWithTag:YKPRODUCT_BARBUTTON_CANCEL]];
    [self BarButtonClick:(UIBarButtonItem *)[toolBarForPicker viewWithTag:YKPRODUCT_BARBUTTON_CANCEL+100]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"--------%@",NSStringFromCGRect(self.view.frame));
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"优惠套装";
    
    //创建返回按钮
    [self createBackBtnWithType:0];
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    isAddtoCar = NO;
    
    mytable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
    mytable.backgroundColor = [UIColor clearColor];
    mytable.delegate = self;
    mytable.dataSource = self;
    //lee999注释掉这个地方
    mytable.separatorColor = [UIColor clearColor];
    [mytable setFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-60)];
    [self.view addSubview:mytable];
    
    [self createRequest];
}


-(void)hiddenPicker{
    //隐藏picker
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    pickerForSelectColor.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 216);
    toolBarForPicker.frame=CGRectMake(0, ScreenHeight+20, ScreenWidth, 44);
    [UIView setAnimationDidStopSelector:@selector(hiddle)];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    pickerForSelectSize.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 216);
    toolBarForSizePicker.frame=CGRectMake(0, ScreenHeight+20, ScreenWidth, 44);
    [UIView setAnimationDidStopSelector:@selector(hiddle)];
    
    [UIView commitAnimations];
}

#pragma mark 请求的开始 与  回调
- (void)createRequest {
    [mainSer getSuitinfo:strStuit];
    [SBPublicAlert showMBProgressHUD:@"正在请求" andWhereView:self.view states:NO];
}

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
        case Http_SuitInfo_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];

                //标记: 数量
                self.suitListModel = (SuitServiceModel *)model;
                [self createTableCells];
                //lee999 新增：
                mytable.tableFooterView = [self createTableFooterView];
                [self createPickerView];
                [mytable reloadData];
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
            case Http_Addsuittocar_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                NSInteger indexd = [[[NSUserDefaults standardUserDefaults] objectForKey:@"totalNUM"] intValue];
                NSString * strInfo = [[NSString alloc] initWithFormat:@"%ld", (long)indexd];
                [[NSUserDefaults standardUserDefaults]setObject:strInfo forKey:@"totalNUM"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TotleNumber" object:nil];

                //[UIApplication sharedApplication].applicationIconBadgeNumber = [[[NSUserDefaults standardUserDefaults]objectForKey:@"totalNUM"] intValue];
                
                UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"提醒" message: @"成功加入购物车" delegate: self cancelButtonTitle: @"去购物车" otherButtonTitles: @"继续购物",nil];
                someError.tag = 110011;
                [someError show];
            } else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
            case 10086:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];

        }
            break;
        default:
            break;
    }
}

-(void)createPickerView
{
    //创建picker
    pickerForSelectColor=[[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 216)];    [pickerForSelectColor setDelegate:self];
    [pickerForSelectColor setDataSource:self];
    pickerForSelectColor.showsSelectionIndicator=YES;
    [pickerForSelectColor setBackgroundColor:[UIColor whiteColor]];
    [[MyAppDelegate window] addSubview:pickerForSelectColor];

    pickerForSelectSize=[[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 216)];
    [pickerForSelectSize setDelegate:self];
    [pickerForSelectSize setDataSource:self];
    pickerForSelectSize.showsSelectionIndicator=YES;
    [pickerForSelectSize setBackgroundColor:[UIColor whiteColor]];
    [[MyAppDelegate window] addSubview:pickerForSelectSize];

    //创建toolbar
    toolBarForPicker=[[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight+20, ScreenWidth, 44)];
    toolBarForPicker.barStyle=UIBarStyleBlackTranslucent;
    [[MyAppDelegate window] addSubview:toolBarForPicker];

    toolBarForSizePicker=[[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight+20, ScreenWidth, 44)];
    toolBarForSizePicker.barStyle=UIBarStyleBlackTranslucent;
//    [self.view addSubview:toolBarForSizePicker];
    [[MyAppDelegate window] addSubview:toolBarForSizePicker];

    //toolbar上地按钮
    UIBarButtonItem *buttonForCancel=[[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel.tintColor = [UIColor whiteColor];
    }
    buttonForCancel.tag=YKPRODUCT_BARBUTTON_CANCEL;
    UIBarButtonItem *buttonForFix=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix.width=lee1fitAllScreen(210);
    UIBarButtonItem *buttonForDone=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForDone.tintColor = [UIColor whiteColor];
    }
    buttonForDone.tag=YKPRODUCT_BARBUTTON_DONE;
    [toolBarForPicker setItems:[NSArray arrayWithObjects:buttonForCancel,buttonForFix,buttonForDone,nil]];
    
   
    UIBarButtonItem *buttonForCancel_size=[[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel_size.tintColor = [UIColor whiteColor];
    }
    buttonForCancel_size.tag=YKPRODUCT_BARBUTTON_CANCEL+100;
    UIBarButtonItem *buttonForFix_size=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix_size.width=lee1fitAllScreen(210);
    UIBarButtonItem *buttonForDone_size=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForDone_size.tintColor = [UIColor whiteColor];
    }
    buttonForDone_size.tag=YKPRODUCT_BARBUTTON_DONE+100;
    [toolBarForSizePicker setItems:[NSArray arrayWithObjects:buttonForCancel_size,buttonForFix_size,buttonForDone_size,nil]];
}

/** 
 *	picker上的toolbar上左右两个按钮响应事件
 *	@param  (id)sender 左右两个UIBarButtonItem
 *  @return (void)
 */

- (void)hiddle {
    toolBarForPicker.hidden = YES;
    toolBarForSizePicker.hidden = YES;
}
-(void)BarButtonClick:(UIBarButtonItem *)barButton
{
    if (currentSelectRow < 0 || currentSelectRow >= [self.suitListModel.suitArray count]) {
        return;
    }
    YKSuitItem *item = [self.suitListModel.suitArray objectAtIndex:currentSelectRow];
    
    //隐藏picker
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    pickerForSelectColor.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 216);
    toolBarForPicker.frame=CGRectMake(0, ScreenHeight+20, ScreenWidth, 44);
    [UIView setAnimationDidStopSelector:@selector(hiddle)];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    pickerForSelectSize.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 216);
    toolBarForSizePicker.frame=CGRectMake(0, ScreenHeight+20, ScreenWidth, 44);
    [UIView setAnimationDidStopSelector:@selector(hiddle)];

    [UIView commitAnimations];
    
    if(barButton.tag == YKPRODUCT_BARBUTTON_DONE){
  
        [pickerForSelectColor selectRow:item.currentColor inComponent:0 animated:NO];
        [pickerForSelectColor reloadAllComponents];
        [item.buttonForSelect setTitle:[[item.colorlist objectAtIndex:item.currentColor] Spec_alias] forState:UIControlStateNormal];
        
        //重置尺寸内容
        item.currentSize = 0;
        NSString* selectedSize;
        if (item.currentSize < 0 || item.currentSize >= [item.array_size count]) {
            selectedSize = [[[[item.array_size objectAtIndex:item.currentColor] objectForKey:[[item.colorlist objectAtIndex:item.currentColor] ID]] objectAtIndex:0]objectForKey:@"spec_alias"];
        }
        else {
            selectedSize =  [[[[item.array_size objectAtIndex:item.currentColor] objectForKey:[[item.colorlist objectAtIndex:item.currentColor] ID]] objectAtIndex:item.currentSize]objectForKey:@"spec_alias"];
        }
        [item.buttonForSize setTitle:selectedSize forState:UIControlStateNormal];
        [pickerForSelectSize reloadAllComponents];
    }
    else if(barButton.tag == YKPRODUCT_BARBUTTON_DONE+100){
        if ([item.array_size count] != 0) {
            NSString* selectedSize = [[[[item.array_size objectAtIndex:item.currentColor] objectForKey:[[item.colorlist objectAtIndex:item.currentColor] ID]] objectAtIndex:item.currentSize]objectForKey:@"spec_alias"];
            [item.buttonForSize setTitle:selectedSize forState:UIControlStateNormal];
        }
    }
    
    if (item.currentSize >= 0) {
        NSMutableString *str_append = [NSMutableString stringWithCapacity:1];
        
        [str_append appendFormat:@"%@|",[[item.colorlist objectAtIndex:item.currentColor] ID]];
        [str_append appendFormat:@"%@|",[[[[item.array_size objectAtIndex:item.currentColor] objectForKey:[[item.colorlist objectAtIndex:item.currentColor] ID]] objectAtIndex:item.currentSize]objectForKey:@"id"]];

        
        for (int i=0; i<[item.array_color_size count]; i++) {
            if ([[item.array_color_size objectAtIndex:i] isEqualToString:str_append]) {
                item.productSubId = [[item.productlist objectAtIndex:i] ID];
            }
        }
    }
}

-(UIView*)createTableFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 0, lee1fitAllScreen(300), 93)];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
////    imageView.image = [UIImage imageNamed:@"edit_infor_bg.png"];
//    //lee给view设置为圆角，不再使用图片了。 -140512
//    [SingletonState setViewRadioSider:imageView];
//    [view addSubview:imageView];
    
    int xOffset = 15;
    int yOffset = 8;
    int strWidth = 0;
    int nHeight = (93-yOffset * 2)/3;
    UIFont *font = [UIFont systemFontOfSize:13];
    NSString *str = @"套装价: ";
    strWidth = [str sizeWithFont:font].width;
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, strWidth, nHeight)];
    desc.text = str;
    desc.font = font;
    desc.backgroundColor = [UIColor clearColor];
    [view addSubview:desc];

    str = [NSString stringWithFormat:@"￥%.2f", self.suitListModel.discountprice];
    desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset+strWidth, yOffset, 200, nHeight)];
    desc.backgroundColor = [UIColor clearColor];
    desc.font = font;
    desc.textColor = [UIColor redColor];
    desc.text = str;
    [view addSubview:desc];

    yOffset += nHeight;
    
    desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, 250, nHeight)];
    desc.backgroundColor = [UIColor clearColor];
    desc.font = font;
    desc.text = [NSString stringWithFormat:@"原   价: ￥%.2f", self.suitListModel.price];
    [view addSubview:desc];

    yOffset += nHeight;
    
    desc = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, 250, nHeight)];
    desc.backgroundColor = [UIColor clearColor];
    desc.font = font;
    desc.text = [NSString stringWithFormat:@"立   省: ￥%.2f", self.suitListModel.save];
    [view addSubview:desc];

//    yOffset += nHeight;
    
    UIButton *buttonForAction=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonForAction.frame=CGRectMake(lee1fitAllScreen(185), 40, 110, 35);
    [buttonForAction setBackgroundImage:[UIImage imageNamed:@"lp_btn_normal.png"] forState:UIControlStateNormal];
    [buttonForAction setBackgroundImage:[UIImage imageNamed:@"lp_btn_select.png"] forState:UIControlStateHighlighted];
    [buttonForAction setTitle:@"加入购物车" forState:UIControlStateNormal];
    [buttonForAction addTarget:self action:@selector(clickToAddCart:) forControlEvents:UIControlEventTouchUpInside];
    buttonForAction.titleLabel.font = [UIFont systemFontOfSize:18];
    [view addSubview:buttonForAction];
    
    return view;
}

#pragma mark-- 添加购物车
-(void)clickToAddCart:(UIButton*)sender
{
    //lee999 加入购物车的判断
    if (![SingletonState sharedStateInstance].userHasLogin) {
        isAddtoCar = YES;
        [self changeToMyaimer];
        return;
    }
    
    
    for (int i = 0; i < [self.suitListModel.suitArray count]; i++) {
        YKSuitItem *item = [self.suitListModel.suitArray objectAtIndex:i];
        if (item.currentSize < 0&&item.productlist != nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请为所有商品选择对应的尺码" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    
    NSMutableString *suitString = [NSMutableString stringWithCapacity:1];
    for (int i = 0; i < [self.suitListModel.suitArray count]; i++) {
        YKSuitItem *item = [self.suitListModel.suitArray objectAtIndex:i];
        if (i == [self.suitListModel.suitArray count] - 1) {
            if (item.productSubId != nil) {
                [suitString appendFormat:@"%@:1:suit", item.productSubId];
                
            }
        }
        else {
            if (item.productSubId != nil) {
                [suitString appendFormat:@"%@:1:suit|", item.productSubId];
            }
        }
    }
    NSLog(@"suitString:%@", suitString);
    
    
    [mainSer getAddsuittocar:self.suitListModel.suitid andSuitid:suitString];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求" andWhereView:self.view states:NO];
    
    //套装
    
    [DplusMobClick track:@"加入购物车/套装" property:@{@"加入类型":@"套装",
                                                @"商品id":self.suitListModel.suitid,
                                                @"商品Sku":suitString,
                                                @"商品名称":@"套装详情",
                                                @"商品数量":@"1"}];
}


-(void)createTableCells
{
    if (!self.suitListModel) {
        return;
    }
    if (cellArray) {
        [cellArray removeAllObjects];
    }
    cellArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0; i < [self.suitListModel.suitArray count]; i++) {
        static NSString	*CellIdentifier = @"Cell1";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *cellBg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 164, ScreenWidth-20, 0.5)];
        [cellBg setBackgroundColor:[UIColor colorWithHexString:splineBGC]];
        //        [cellBg setImage:[UIImage imageNamed:@"edit_infor_bg.png"]];
        //lee给view设置为圆角，不再使用图片了。 -140512
        //        [SingletonState setViewRadioSider:cellBg];
        [cell.contentView addSubview:cellBg];
        
        
        //		UIImageView* bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cart_pic_bg.png"]];
        //		bgview.frame = CGRectMake(10, 21, 93, 113);
        //        bgview.backgroundColor = [UIColor clearColor];
        //		[cell.contentView addSubview:bgview];
        
        
        YKSuitItem *item = [self.suitListModel.suitArray objectAtIndex:i];
        UrlImageView* shoppingImg = [[UrlImageView alloc] init];
        [shoppingImg setImageWithURL:[NSURL URLWithString:item.pic]];
        shoppingImg.frame = CGRectMake(14, 26, 84, 103);
        [cell.contentView addSubview:shoppingImg];
        
        UILabel* desc = [[UILabel alloc] initWithFrame:CGRectMake(110, 10,lee1fitAllScreen(200), 45)];
        desc.backgroundColor = [UIColor clearColor];
        desc.numberOfLines = 0;
        desc.lineBreakMode = UILineBreakModeWordWrap;
        desc.text = item.productName;
        desc.font = [UIFont systemFontOfSize:13];
        desc.textColor = [UIColor blackColor];
        [cell.contentView addSubview:desc];
        
        if (item.productlist) {
            
            UIFont *font = [UIFont systemFontOfSize:12];
            desc = [[UILabel alloc] initWithFrame:CGRectMake(lee1fitAllScreen(110), 58, 75, 31)];
            desc.backgroundColor = [UIColor clearColor];
            desc.text = @"颜色：";
            desc.font = font;
            desc.textColor = [UIColor colorWithHexString:@"0x666666"];
            [cell.contentView addSubview:desc];
            
            //下拉列表选择颜色按钮
            item.buttonForSelect = [UrlImageButton buttonWithType:UIButtonTypeCustom];
            [item.buttonForSelect setFrame:CGRectMake(lee1fitAllScreen(175), 58, 79, 31)];
            [item.buttonForSelect setBackgroundImage:[UIImage imageNamed:@"lp_option.png"] forState:UIControlStateNormal];
            [item.buttonForSelect setBackgroundImage:[UIImage imageNamed:@"lp_option_hover.png"] forState:UIControlStateHighlighted];
            [item.buttonForSelect addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
            item.buttonForSelect.tag = i * 10 + 0;
            if ([item.colorlist count]!=0) {
                [item.buttonForSelect setTitle:[[item.colorlist objectAtIndex:item.currentColor] Spec_alias] forState:UIControlStateNormal];
            }
            UIEdgeInsets inserts = item.buttonForSelect.titleEdgeInsets;
            inserts.right = 20;
            item.buttonForSelect.titleEdgeInsets = inserts;
            item.buttonForSelect.titleLabel.font = font;
            [item.buttonForSelect setTitleColor:[UIColor colorWithHexString:@"0x666666"] forState:UIControlStateNormal];
            //lee999 添加向下箭头//sort_arrow_down.png  {top, left, bottom, right}
            //        [item.buttonForSelect setImageEdgeInsets:UIEdgeInsetsMake(12, 65, 12, 4)];
            //        [item.buttonForSelect setImage:[UIImage imageNamed:@"choice_btn_arrow.png"] forState:UIControlStateNormal];
            //            [item.buttonForSelect setImage:[UIImage imageNamed:@"choice_btn_arrow.png"] forState:UIControlStateHighlighted];
            [cell.contentView addSubview:item.buttonForSelect];
            
            
            desc = [[UILabel alloc] initWithFrame:CGRectMake(lee1fitAllScreen(110), 103, 75, 31)];
            desc.backgroundColor = [UIColor clearColor];
            desc.text = @"尺码：";
            desc.font = font;
            desc.textColor = [UIColor colorWithHexString:@"0x666666"];
            [cell.contentView addSubview:desc];
            
            
            item.buttonForSize=[UrlImageButton buttonWithType:UIButtonTypeCustom];
            [item.buttonForSize setFrame:CGRectMake(lee1fitAllScreen(175), 103, 79, 31)];
            [item.buttonForSize setBackgroundImage:[UIImage imageNamed:@"lp_option.png"] forState:UIControlStateNormal];
            [item.buttonForSize setBackgroundImage:[UIImage imageNamed:@"lp_option_hover.png"] forState:UIControlStateHighlighted];
            [item.buttonForSize addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
            item.buttonForSize.tag = i * 10 + 1;
            
//            //lee999 150708 增加默认选中的尺码
//            if ([item.array_size count]!=0) {
//                [item.buttonForSelect setTitle:[[item.colorlist objectAtIndex:item.currentColor] Spec_alias] forState:UIControlStateNormal];
//            }
//            //end
            
//            [[item.array_size objectAtIndex:item.currentColor] objectForKey:[[item.colorlist objectAtIndex:item.currentColor] ID]]
            NSDictionary *dicColor = [item.array_size objectAtIndex:0];
            if ([(NSArray*)[dicColor objectForKey:[[item.colorlist objectAtIndex:item.currentColor] ID]] count]!=0) {
                NSString* selectedSize;
                selectedSize = [[[[item.array_size objectAtIndex:item.currentColor] objectForKey:[[item.colorlist objectAtIndex:item.currentColor] ID]] objectAtIndex:item.currentSize]objectForKey:@"spec_alias"];
                
                item.currentSize = 0;
                [item.buttonForSize setTitle:selectedSize forState:UIControlStateNormal];
            }
            
            inserts = item.buttonForSize.titleEdgeInsets;
            inserts.right = 20;
            item.buttonForSize.titleEdgeInsets = inserts;
            item.buttonForSize.titleLabel.font = font;
            [item.buttonForSize setTitleColor:[UIColor colorWithHexString:@"0x666666"] forState:UIControlStateNormal];
            //lee999 添加向下箭头//sort_arrow_down.png  {top, left, bottom, right}
            //            [item.buttonForSize setImageEdgeInsets:UIEdgeInsetsMake(12, 65, 12, 4)];
            //            [item.buttonForSize setImage:[UIImage imageNamed:@"sort_arrow_down.png"] forState:UIControlStateNormal];
            //            [item.buttonForSize setImage:[UIImage imageNamed:@"sort_arrow_down.png"] forState:UIControlStateHighlighted];
            [cell.contentView addSubview:item.buttonForSize];
            
            if (i != [self.suitListModel.suitArray count]) {
            }
        }else {
            UIFont *font = [UIFont systemFontOfSize:18];
            desc = [[UILabel alloc] initWithFrame:CGRectMake(lee1fitAllScreen(110), 58, 180, 31)];
            desc.backgroundColor = [UIColor clearColor];
            desc.text = @"该产品已售完";
            desc.font = font;
            desc.textColor = [UIColor colorWithHexString:@"#c8002e"];
            [cell.contentView addSubview:desc];
            
        }
        [cellArray addObject:cell];
        
    }
}

/** 
 *	颜色picker的显示
 *	@param  (UIButton *)button 颜色按钮
 *  @return (void)
 */
-(void)showPicker:(UIButton *)button {
    currentSelectRow = button.tag/10;
    if (currentSelectRow < 0 || currentSelectRow >= [self.suitListModel.suitArray count]) {
        return;
    }
    YKSuitItem *item = [self.suitListModel.suitArray objectAtIndex:currentSelectRow];
    if (button.tag%10 == 0) {
        [pickerForSelectColor reloadAllComponents];//picker的数据源是会变的 reload后更换一套新的数据源
        [pickerForSelectColor selectRow:item.currentColor inComponent:0 animated:NO];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        pickerForSelectSize.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 216);
        toolBarForSizePicker.frame=CGRectMake(0, ScreenHeight+20, ScreenWidth, 44);
        
        pickerForSelectColor.frame=CGRectMake(0,ScreenHeight-PickShowHigh+50, ScreenWidth, 216);
        toolBarForPicker.frame=CGRectMake(0, ScreenHeight-PickShowHigh-44+50, ScreenWidth, 44);
        //end
        
        [UIView commitAnimations];
    }else{
        [pickerForSelectSize reloadAllComponents];//picker的数据源是会变的 reload后更换一套新的数据源
        [pickerForSelectSize selectRow:item.currentSize inComponent:0 animated:NO];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];

        pickerForSelectSize.frame=CGRectMake(0,ScreenHeight-PickShowHigh+50, ScreenWidth, 216);
        toolBarForSizePicker.frame=CGRectMake(0, ScreenHeight-PickShowHigh-44+50, ScreenWidth, 44);
        //end
        
        pickerForSelectColor.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 216);
        toolBarForPicker.frame=CGRectMake(0, ScreenHeight+20, ScreenWidth, 44);
        [UIView commitAnimations];
    }
}

#pragma mark - 
#pragma mark tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.suitListModel) {
        return 0;
    }
    return [self.suitListModel.suitArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] < [cellArray count]) {
        return [cellArray objectAtIndex:[indexPath row]];
    }
    else {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
} 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self BarButtonClick:[toolBarForPicker.items objectAtIndex:0]];
    [self BarButtonClick:[toolBarForSizePicker.items objectAtIndex:0]];

    if ([indexPath row] < 0 || [indexPath row] >= [self.suitListModel.suitArray count]) {
        return ;
    }
    YKSuitItem *item = [self.suitListModel.suitArray objectAtIndex:[indexPath row]];
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] init];
//    controller.mill_Tag = self.mill_Tag;
    controller.isPush = YES;
    controller.thisProductId = item.productId;
    controller.isFromMyAimer = self.isFromMyAimer;
    controller.isHiddenBar = self.isHiddenBar;
    [self.navigationController pushViewController:controller animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
{
    [mytable deselectRowAtIndexPath:[mytable indexPathForSelectedRow] animated:YES];
}

#pragma mark picker delegate&dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (currentSelectRow < 0 || currentSelectRow >= [self.suitListModel.suitArray count]) {
        return 0;
    }
    YKSuitItem *item = [self.suitListModel.suitArray objectAtIndex:currentSelectRow];
    if (pickerView==pickerForSelectColor) {
        return [item.colorlist count];
    }else{
        
        //lee999修改崩溃bug
        if ([item.array_size count] < 1) {
            return 0;
        }
        //end
        //lee999 150608
      return   [(NSArray*)[[item.array_size objectAtIndex:item.currentColor] objectForKey:[[item.colorlist objectAtIndex:item.currentColor] ID]] count];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (currentSelectRow < 0 || currentSelectRow >= [self.suitListModel.suitArray count]) {
        return nil;
    }
    YKSuitItem *item = [self.suitListModel.suitArray objectAtIndex:currentSelectRow];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 240, 44) ];
    NSString *pickerText=@"";
    UrlImageView *image=[[UrlImageView alloc]init];
    if (pickerView==pickerForSelectColor) {
        pickerText= [[item.colorlist objectAtIndex:row] Spec_alias];
        [image setImageWithURL:[NSURL URLWithString:[[item.colorlist objectAtIndex:row] ImageUrl]]];
    }else{
        
      pickerText= [[[[item.array_size objectAtIndex:item.currentColor] objectForKey:[[item.colorlist objectAtIndex:item.currentColor] ID]] objectAtIndex:row]objectForKey:@"spec_alias"];
    }
    titleLabel.text = pickerText;
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [ UIFont boldSystemFontOfSize:18];;
    titleLabel.opaque = NO;
    
    image.frame=CGRectMake(200, 4, 50, 36);
    UIView *view_image=[[UIView alloc]init];
    view_image.frame=CGRectMake(0, 0, ScreenWidth, 44);
    [view_image addSubview:image];

    [view_image addSubview:titleLabel];

    return view_image;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (currentSelectRow < 0 || currentSelectRow >= [self.suitListModel.suitArray count]) {
        return;
    }
    YKSuitItem *item = [self.suitListModel.suitArray objectAtIndex:currentSelectRow];
    if (pickerView==pickerForSelectColor) {
        item.currentColor=row;
    }else{
        item.currentSize=row;
    }
}

#pragma mark -
#pragma mark BaseServiceDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 111222 && buttonIndex == 1) {
        //切换到我的爱慕进行登录 来源于竖屏的商场~~
        [SingletonState sharedStateInstance].myaimerIsFrom = 2;
        [self changeToMyaimer];
        return;
    }
    
    
    if (alertView.tag == 110011) {
        if (buttonIndex == 0) {
            //去购物车
            //lee999 判断是否来自我的爱慕，如果是的话，先切换到商城
            [self.navigationController popToRootViewControllerAnimated:NO];
            [self performSelector:@selector(JumpToCarpage) withObject:nil afterDelay:0.2];

        }
    }
}

-(void)JumpToCarpage{
    [self changetableBarto:3];
}


#pragma mark--  登录成功之后的回调函数
-(void)loginOKCallBack:(NSString *)prama{
    if (isAddtoCar) {
        
        isAddtoCar = NO;
        [self clickToAddCart:nil];
    }
}



@end

