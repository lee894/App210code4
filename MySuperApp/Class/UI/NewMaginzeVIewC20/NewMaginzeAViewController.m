//
//  NewMaginze2ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/11.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewMaginzeAViewController.h"
#import "MYMacro.h"
#import "MyButton.h"
#import <QuartzCore/QuartzCore.h>
#import "ProductlistViewController.h"
#import "BrandListViewController.h"
#import "ProductDetailViewController.h"
#import "NewBrandDetail20ViewController.h"

#import "UIImage+ImageEffects.h"
#import "NewMaginzeListInfo.h"
#import "NewMaginzeParser.h"
#import "SHLUILabel.h"
#import "UIImage+LK.h"


#define productcellH 200 //单行商品的高度

@interface NewMaginzeAViewController ()
{

    MainpageServ *mainSev;
    NewMaginzeDetailInfo *_mdetailinfo;
    
    UITableView *myTableV;
    UIButton *likebtn;
    
    int contentHight; //描述文字的高度
}

@end

@implementation NewMaginzeAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    contentHight = 10;
    
    [self createBackBtnWithType:0];
    self.title = @"专辑";

    [self creatTableView];
    
    [self NewHiddenTableBarwithAnimated:YES];


    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [mainSev getMageinzeDetail20data:self.strMaginzeId];
    

    //收藏按钮
    //创建右边按钮
    
    UIView * rightButtonParentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    rightButtonParentView.backgroundColor = [UIColor clearColor];
    
    
    likebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *unSelectedImg = [UIImage imageNamed:@"t_ico_like_normal.png"];
    UIImage *selectedImg = [UIImage imageNamed:@"t_ico_like2_hover.png"];
    [likebtn setBackgroundImage:unSelectedImg forState:UIControlStateNormal];
    [likebtn setBackgroundImage:selectedImg forState:UIControlStateSelected];
    [likebtn addTarget:self action:@selector(rightButAction) forControlEvents:UIControlEventTouchUpInside];
    likebtn.frame = CGRectMake(30, 10, 25, 25);
    likebtn.tag = 1001;
    [rightButtonParentView addSubview:likebtn];
    
    //sharebtn
    UIButton *sharebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *unshareSelectedImg = [UIImage imageNamed:@"t_ico_share_normal.png"];
    UIImage *selectesharebtndImg = [UIImage imageNamed:@"t_ico_share_hover.png"];
    [sharebtn setBackgroundImage:unshareSelectedImg forState:UIControlStateNormal];
    [sharebtn setBackgroundImage:selectesharebtndImg forState:UIControlStateHighlighted];
    [sharebtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    sharebtn.frame = CGRectMake(70, 10, 25, 25);
    sharebtn.tag = 1002;
    [rightButtonParentView addSubview:sharebtn];
    
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButtonParentView];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    //end
}

-(void)rightButAction{
    
    if (![SingletonState sharedStateInstance].userHasLogin) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录",nil];
        alert.tag = 10000000;
        alert.delegate = self;
        [alert show];
        
        return;
    }
    
    //添加收藏
    if (!likebtn.selected) {
        //未中状态 添加收藏
        [mainSev getFavoriteadd:self.strMaginzeId andType:@"magazine"];
    }else{
        //选中状态 取消收藏
        [mainSev getFavoritedel:self.strMaginzeId andType:@"magazine"];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 10000000 && buttonIndex == 1) {
        //切换到我的爱慕进行登录 来源于竖屏的商场~~
        [SingletonState sharedStateInstance].myaimerIsFrom = 2;
        [self changeToMyaimer];
    }
}

-(void)shareBtnAction{
    
    NSString *imageurl = [self ImageSize:[_mdetailinfo.magazine_info_a.background_url description] Size:@"200x200"];
    
    UrlImageView *buynowV = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 225)];
    [buynowV setImageFromUrl:NO withUrl:imageurl];
    
//    UIImage *imageV = [UIImage imageNamed:@"icon@2x.png"];
    
    NSString *shareTitle = [_mdetailinfo.magazine_info_a.title description].length>0?[_mdetailinfo.magazine_info_a.title description]:@"爱慕提示";
    

    NSString *shareContent = [NSString stringWithFormat:@"%@ http://m.aimer.com.cn/method/xiazai @爱慕官方商城",[_mdetailinfo.magazine_info_a.synopsis_text description].length>0?[_mdetailinfo.magazine_info_a.synopsis_text description]:@"我在爱慕发现了一款好的产品，欢迎下载"];
    
    
    [ShareUnit ShareSDKwithTitle:shareTitle
                         content:shareContent
                  defaultContent:shareContent
                             img:buynowV.image
                             url:@"http://m.aimer.com.cn/method/xiazai"
                     description:shareContent
                        imageUrl:imageurl];
}


//创建表格
-(void)creatTableView{
    
    myTableV = [[UITableView alloc] init];
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (app.mytabBarController.selectedIndex == 0) {
        [myTableV setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- 50)];
    }else{
        [myTableV setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- 50)];
    }
    
    myTableV.delegate = self;
    myTableV.dataSource = self;
    [self.view addSubview:myTableV];
    [myTableV setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
    
    
    
    //添加下拉刷新
    [myTableV addHeaderWithTarget:self action:@selector(headerRereshing)];
}

-(void)headerRereshing{
    [mainSev getMageinzeDetail20data:self.strMaginzeId];
}


#pragma mark-- service
-(void)serviceStarted:(ServiceType)aHandle{
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    [myTableV headerEndRefreshing];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [myTableV headerEndRefreshing];
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    LBaseModel *model = (LBaseModel *)amodel;
    if ([amodel isKindOfClass:[LBaseModel class]] &&
        model.requestTag < 200) {
        switch (model.requestTag) {
            case Http_FavoriteAdd_Tag : {
                if (!model.errorMessage) {
                    [SBPublicAlert showMBProgressHUD:@"收藏成功" andWhereView:self.view hiddenTime:0.6];
                    likebtn.selected = !likebtn.selected;
                }else {
                    [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
                }
            }
                break;
            case Http_FavoriteDel_Tag:
            {
                if (!model.errorMessage) {
                    [SBPublicAlert showMBProgressHUD:@"删除收藏" andWhereView:self.view hiddenTime:0.6];
                    likebtn.selected = !likebtn.selected;
                }else {
                    [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
                }
            }
                
            default:
                break;
        }
        return;
    }
    
    _mdetailinfo = [[NewMaginzeParser alloc] parseMaginzeDetailInfo:amodel];
    
    if ([_mdetailinfo.magazine_info_a.content description].length >0) {
        SHLUILabel *namelab = [[SHLUILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth-30, 20)];
        namelab.text = _mdetailinfo.magazine_info_a.content;
        namelab.font = [UIFont systemFontOfSize:LabSmallSize];
        namelab.lineBreakMode = NSLineBreakByWordWrapping;
        namelab.numberOfLines = 0;
        contentHight = [namelab getAttributedStringHeightWidthValue:ScreenWidth-30]  + 40;
    }
    
    
    for (NSString *str in _mdetailinfo.magazine_info_a.pic_file_path) {
        
        if ([str description].length < 1) {
            [_mdetailinfo.magazine_info_a.pic_file_path removeObject:str];
        }
    }
    
    //lee999 判断是否被收藏过
    if ([_mdetailinfo.is_favorite intValue] == 0) {
        likebtn.selected = NO;
    }else if ([_mdetailinfo.is_favorite intValue] == 1){
        likebtn.selected = YES;
    }

    
    [myTableV reloadData];
}





#pragma mark-- tableView

// Section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

// row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    switch (section) {
        case 0:
            //header头图
            return 1;
            break;
            
        case 1:
            //图片数组
            if ([_mdetailinfo.magazine_info_a.pic_file_path respondsToSelector:@selector(objectAtIndex:)]) {
                return _mdetailinfo.magazine_info_a.pic_file_path.count;
            }
            return 0;
            break;
            
        case 2:
            //描述文字  一段
            return 1;
            break;
            
        case 3:
            //商品推荐
            return 1;
            break;
            
        case 4:
            //进入品牌馆
            return 1;
            break;
            
        default:
            break;
    }
    
    return 1;
}

// Section的 head高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

// row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch ([indexPath section]) {
        case 0:
            //header头图
            return 225;
            break;
            
        case 1:
        {
            //图片数组  改为动态图片
            
            
//            NSString *imageurl = [_mdetailinfo.magazine_info_a.pic_file_path objectAtIndex:[indexPath row] isArray:nil];
//            UrlImageView *buynowV = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 320)];
//            [buynowV setImageFromUrl:NO withUrl:imageurl];
//            CGSize size = CGSizeMake(0, 0);
//            
//            size  = [UIImage downloadImageSizeWithURL:imageurl];
//            NSLog(@"----%.2f",size.height);
            
            return 325;
        }
            break;
            
        case 2:
            //描述文字
            return contentHight;
            break;
            
        case 3:
            //商品推荐
            if ([_mdetailinfo.magazine_info_a.goods_info respondsToSelector:@selector(objectAtIndex:)]) {
                
                int i = [_mdetailinfo.magazine_info_a.goods_info count];
                int line = i%2 == 0? i/2: i/2+1;
                return 50 + line *productcellH +10;
            }
            return 50;
            break;
            
        case 4:
            //进入品牌馆
            return 80;
            break;
            
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // 定义唯一标识
    static NSString *CellIdentifier = @"Cell";
    // 通过indexPath创建cell实例 每一个cell都是单独的
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
//    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
//    
////    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (cell == nil)
//    {
//        // Create a cell to display an ingredient.
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    
//    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopGoodsView"];
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"ShopGoodsView"];
//    }
    
    
    // Configure the cell.
    cell.backgroundColor = [UIColor clearColor];
    
    switch ([indexPath section]) {
        case 0:
            //header头图
        {
            UIView *headerV = [[UIView alloc] init];
            [headerV setFrame:CGRectMake(0, 0, ScreenWidth, 225)];
            [headerV setBackgroundColor:[UIColor whiteColor]];
            
            UrlImageView *buynowV = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 225)];
            [buynowV setImageFromUrl:NO withUrl:_mdetailinfo.magazine_info_a.background_url];
            [headerV addSubview:buynowV];
            
            //lee999 这个地方很重要，毛玻璃效果
            [buynowV setImage:[buynowV.image applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil]];
            
            
                //lee999 这个地方很重要，为了 图片不拉伸
            [buynowV setContentScaleFactor:[[UIScreen mainScreen] scale]];
            buynowV.contentMode =  UIViewContentModeScaleAspectFill;
            buynowV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            buynowV.clipsToBounds  = YES;
            
            
//            UIView *blackV = [[UIView alloc] initWithFrame:buynowV.frame];
//            [blackV setBackgroundColor:[UIColor blackColor]];
//            [blackV setAlpha:0.5];
//            [buynowV addSubview:blackV];
            
            
            UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, headerV.frame.size.height-60, ScreenWidth, 60)];
            [bgv setBackgroundColor:[UIColor whiteColor]];
            [bgv setAlpha:0.5];
//            [buynowV addSubview:bgv];
            
            
            UILabel *titlelab = [[UILabel alloc] initWithFrame:CGRectMake(0, headerV.frame.size.height-57, ScreenWidth, 26)];
            [titlelab setNumberOfLines:1];
            [titlelab setTextAlignment:NSTextAlignmentCenter];
            titlelab.text = [NSString stringWithFormat:@"%@",[_mdetailinfo.magazine_info_a.title description].length>0?[_mdetailinfo.magazine_info_a.title description]:@""];
            titlelab.font = [UIFont systemFontOfSize:LabBigSize];
            [titlelab setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
            [headerV addSubview:titlelab];
            titlelab.shadowColor = [UIColor darkGrayColor];
            titlelab.shadowOffset = CGSizeMake(0, 1.0);
            
            if ([_mdetailinfo.magazine_info_a.title description].length < 1) {
                [bgv setHidden:YES];
            }
            
            
            UILabel *desclab = [[UILabel alloc] initWithFrame:CGRectMake(0, headerV.frame.size.height-32, ScreenWidth, 30)];
            [desclab setNumberOfLines:2];
            [desclab setTextAlignment:NSTextAlignmentCenter];
            NSString *str = [[_mdetailinfo.magazine_info_a.synopsis_text description].length>0? [_mdetailinfo.magazine_info_a.synopsis_text description]:@""  stringByAppendingString:@"\n "];
            
            desclab.text = [NSString stringWithFormat:@"%@",str];
            desclab.font = [UIFont systemFontOfSize:LablitileSmallSize];
            [desclab setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
            [headerV addSubview:desclab];
            
            desclab.shadowColor = [UIColor darkGrayColor];
            desclab.shadowOffset = CGSizeMake(0, 1.0);
            
            [cell addSubview:headerV];
            
        }
            break;
            
        case 1:
            //图片数组
        {
            if ([_mdetailinfo.magazine_info_a.pic_file_path respondsToSelector:@selector(objectAtIndex:)]&& [_mdetailinfo.magazine_info_a.pic_file_path count] > 0) {
                
                NSString *imageurl = [_mdetailinfo.magazine_info_a.pic_file_path objectAtIndex:[indexPath row] isArray:nil];
                UrlImageView *buynowV = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 320)];
                [buynowV setImageFromUrl:NO withUrl:imageurl];
                
//                //lee999 这个地方很重要，为了 图片不拉伸
//                [buynowV setContentScaleFactor:[[UIScreen mainScreen] scale]];
//                buynowV.contentMode =  UIViewContentModeScaleAspectFill;
//                buynowV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//                buynowV.clipsToBounds  = YES;

                [cell addSubview:buynowV];
            }
        }
            break;
            
        case 2:
            //描述文字
        {
            
            if ([_mdetailinfo.magazine_info_a.content description].length > 0) {
                SHLUILabel *namelab = [[SHLUILabel alloc] initWithFrame:CGRectMake(15, 20, ScreenWidth-30, contentHight)];
                [namelab setNumberOfLines:0];
                [namelab setTextAlignment:NSTextAlignmentLeft];
                namelab.text = [NSString stringWithFormat:@"      %@",_mdetailinfo.magazine_info_a.content];
                namelab.font = [UIFont systemFontOfSize:LabSmallSize];
                [namelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
                [cell addSubview:namelab];
            }
        }
            break;
            
        case 3:
            //商品推荐
        {
         
            UIImage *imag = [UIImage imageNamed:@"zz_title_bg.png"];
            MyButton *commbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [commbtn setFrame:CGRectMake((ScreenWidth-imag.size.width)/2, 15,imag.size.width, imag.size.height)];
            commbtn.titleLabel.font = [UIFont systemFontOfSize:LablitileSmallSize];
            [commbtn setTitle:@"商品推荐" forState:UIControlStateNormal];
            [commbtn setBackgroundImage:imag forState:UIControlStateNormal];
            [commbtn setBackgroundImage:imag forState:UIControlStateSelected];
            [commbtn setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
            [cell addSubview:commbtn];
            
            [cell addSubview:[self createCellView:_mdetailinfo.magazine_info_a.goods_info]];
        }
            break;
            
        case 4:
            //进入品牌馆
        {
            
            //lee999999999999---
            NSString *brandstr = _mdetailinfo.magazine_info_a.brand_name;
            NSArray *arr1 = [brandstr componentsSeparatedByString:@","];
            NSMutableArray * marr = [NSMutableArray arrayWithArray:arr1];
            for (NSString *str in arr1) {
                if ([str isEqualToString:@""]) {
                    [marr removeObject:str];
                }
            }
            
            //判断如果多品牌的话，大于2，不显示品牌馆，而是显示一张图片
            if (marr && [marr respondsToSelector:@selector(objectAtIndex:)] &&[marr count] == 1) {
                
                MyButton *sortbtn = [MyButton buttonWithType:UIButtonTypeCustom];
                [sortbtn setFrame:CGRectMake(40, 4,ScreenWidth- 80, 35)];
                [sortbtn addTarget:self action:@selector(gotoBrandViewAciton) forControlEvents:UIControlEventTouchUpInside];
                [sortbtn setTitle:@"进入品牌馆" forState:UIControlStateNormal];
                [sortbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_w_mormal.png"] forState:UIControlStateNormal];
                [sortbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_w_hover.png"] forState:UIControlStateSelected];
                
                [sortbtn setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
                [cell addSubview:sortbtn];
                
            }else{
                
                
                UrlImageView *bgimageV = [[UrlImageView alloc] initWithFrame:CGRectMake(10, 4,ScreenWidth-20, 50)];
                [bgimageV setImageFromUrl:NO withUrl:[_mdetailinfo.magazine_info_a.bottom_img description]];
                //lee999 这个地方很重要，为了图片偏移
//                [bgimageV setContentScaleFactor:[[UIScreen mainScreen] scale]];
//                bgimageV.contentMode =  UIViewContentModeScaleAspectFill;
//                bgimageV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//                bgimageV.clipsToBounds  = YES;
                [cell addSubview:bgimageV];
                
            }
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}


-(UIView *)createCellView:(NSArray*)subSortArray{
    
    int bgvH = 40;
    

    int lineNum = 2; //每行的数量
    
    int ySP = 22;  //距离顶部的位置
    int SP = 22;  //间距
    int pW = 127;  //商品宽度
    int pH = 180;  //商品高度
    int imgH = 154; //商品图片的高度

    //行数
    int subSortbtnNum = ([subSortArray count]%lineNum == 0? [subSortArray count]/lineNum :[subSortArray count]/lineNum+1);
    
    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, bgvH, ScreenWidth, subSortbtnNum*100)];
    [bgv setBackgroundColor:[UIColor clearColor]];
    
    
    
    for (int i = 0; i<subSortbtnNum; i++) {
        
        int jcount = ([subSortArray count]-lineNum*i)>lineNum?lineNum:([subSortArray count]-lineNum*i);
        
        for (int j = 0; j<jcount; j++) {
            
            
            NewMaginzeDetailProduct *item = (NewMaginzeDetailProduct*)[subSortArray objectAtIndex:j + i*lineNum isArray:nil];
            
            UIView *sortV = [[UIView alloc] initWithFrame:CGRectMake(SP + j*(pW+SP), ySP + i*(pH + ySP), pW, pH)];
            sortV.layer.borderWidth = 0.5;
            sortV.layer.borderColor = [[UIColor colorWithHexString:@"e2e2e2"] CGColor];
            sortV.tag = j + i*lineNum;
            [bgv addSubview:sortV];
            
            [sortV setBackgroundColor:[UIColor whiteColor]];
            
            UrlImageView *buynowV = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, pW, imgH)];
            [buynowV setImageFromUrl:NO withUrl:[self ImageSize:item.good_img Size:ChangeImageURL]];
            [sortV addSubview:buynowV];
            
            UILabel *pricelab = [[UILabel alloc] initWithFrame:CGRectMake(0, imgH, pW, 26)];
            [pricelab setNumberOfLines:1];
            [pricelab setTextAlignment:NSTextAlignmentCenter];
            pricelab.text = [NSString stringWithFormat:@"￥%@",item.price];
            pricelab.font = [UIFont systemFontOfSize:LabSmallSize];
            [pricelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
            [sortV addSubview:pricelab];
            
            
            MyButton *sortbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [sortbtn setFrame:CGRectMake(SP + j*(pW+SP), ySP + i*(pH + ySP), pW, pH)];
            [sortbtn addTarget:self action:@selector(gotoProductDetailViewAciton:) forControlEvents:UIControlEventTouchUpInside];
            [sortbtn setBackgroundColor:[UIColor clearColor]];
            sortbtn.addstring = item.good_id;
            sortbtn.addtitle = item.good_name;
            [bgv addSubview:sortbtn];
        }
    }
    
    int H = SP + (pH +SP)* subSortbtnNum;
    [bgv setFrame:CGRectMake(0, bgvH, ScreenWidth, H)];
    
    return bgv;
}


#pragma mark--- 进入品牌馆
-(void)gotoBrandViewAciton{

    
    NewBrandDetail20ViewController *brandvc = [[NewBrandDetail20ViewController alloc] initWithNibName:@"NewBrandDetail20ViewController" bundle:nil];
    brandvc.brandname = _mdetailinfo.magazine_info_a.brand_name;
    [self.navigationController pushViewController:brandvc animated:YES];
}


-(void)gotoProductDetailViewAciton:(MyButton*)btn{
    
    ProductDetailViewController *jumpVC=[[ProductDetailViewController alloc]init];
    jumpVC.thisProductId=btn.addstring;
    jumpVC.ThisPorductName=btn.addtitle;
    jumpVC.source_id=@"1002";
    [self.navigationController pushViewController:jumpVC animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
