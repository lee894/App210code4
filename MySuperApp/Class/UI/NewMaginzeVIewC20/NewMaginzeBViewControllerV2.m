//
//  NewMaginzeBViewControllerV2.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/2.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewMaginzeBViewControllerV2.h"
#import "NewMaginzeAViewController.h"
#import "MYMacro.h"
#import "MyButton.h"
#import <QuartzCore/QuartzCore.h>
#import "ProductlistViewController.h"
#import "BrandListViewController.h"
#import "ProductDetailViewController.h"
#import "NewBrandDetail20ViewController.h"

#import "NewMaginzeListInfo.h"
#import "NewMaginzeParser.h"
#import "SHLUILabel.h"
#import "UIImage+ImageEffects.h"


#define OneSepWidth 8
//#define ScreenWidth 320

@interface NewMaginzeBViewControllerV2 ()<OTPageScrollViewDataSource,OTPageScrollViewDelegate>
{
    UrlImageView *bgimageV; //背景图
    MainpageServ *mainSev;
    NewMaginzeDetailInfo *_mdetailinfo;
    
    UITableView *myTableV;
    NSMutableArray *arr_maginzelist;
    UIButton *likebtn;
}
@end

@implementation NewMaginzeBViewControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtnWithType:0];
    self.title = @"专辑";
    
    arr_maginzelist = [[NSMutableArray alloc] initWithCapacity:8];
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [mainSev getMageinzeDetail20data:self.strMaginzeId];
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    
    //背景图片
    bgimageV = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:bgimageV];
    
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
    
    
    PScrollView = [[OTPageView alloc] initWithFrame:CGRectMake(0, 30, [[UIScreen mainScreen] bounds].size.width,  ScreenHeight -130)];
    PScrollView.pageScrollView.dataSource = self;
    PScrollView.pageScrollView.delegate = self;
    PScrollView.pageScrollView.padding =OneSepWidth * 2;
    PScrollView.pageScrollView.leftRightOffset = 0;
    PScrollView.pageScrollView.frame = CGRectMake(OneSepWidth*2, 0, (ScreenWidth - OneSepWidth*4) , ScreenHeight -130);
    [PScrollView.pageScrollView reloadData];
    [self.view addSubview:PScrollView];
}


-(void)rightButAction{
    
    
    if (![SingletonState sharedStateInstance].userHasLogin) {

        [self changeToMyaimer];
        return;
    }
    
    //添加收藏
    if (!likebtn.selected) {
        //未中状态 添加收藏
        [mainSev getFavoriteadd:self.strMaginzeId andType:@"magazine" anduk:@""];
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
    
    NewMaginzeDetailInfo_dataB* dataB = [arr_maginzelist objectAtIndex:0 isArray:nil];
    
    NSString *sharetitle = [dataB.title description].length>0?[dataB.title description]:@"爱慕分享";
    
    
    NSString *imageurl = [self ImageSize:[_mdetailinfo.magazine_info_b.info_index.backgroud_img_path description] Size:@"200x200"];
    UrlImageView *buynowV = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 225)];
    [buynowV setImageFromUrl:NO withUrl:imageurl];
    
    
    NSString *shareContent = [NSString stringWithFormat:@"%@ http://m.aimer.com.cn/method/xiazai @爱慕官方商城",[dataB.synopsis_text description].length>0?[dataB.synopsis_text description]:@"我在爱慕发现了一款好的产品，欢迎下载"];
    
    
    [ShareUnit ShareSDKwithTitle:sharetitle
                         content:shareContent
                  defaultContent:shareContent
                             img:buynowV.image
                             url:@"http://m.aimer.com.cn/method/xiazai"
                     description:shareContent
                        imageUrl:imageurl];
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [PScrollView setHidden:NO];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //移除所有的View
    [PScrollView setHidden:YES];
}



#pragma mark--- pageScrollView代理
- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    
    NSString *brandstr = _mdetailinfo.magazine_info_b.info_footer.brand_name;
    NSString *imagestr = _mdetailinfo.magazine_info_b.info_footer.img_path;

    if ([brandstr isEqualToString:@""] && [imagestr isEqualToString:@""]) {
        return [arr_maginzelist count] -1;
    }
    
    return [arr_maginzelist count];
}

- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    
        NewMaginzeDetailInfo_dataB* dataB = [arr_maginzelist objectAtIndex:index isArray:nil];
        UIView *cell = [self createCardWithobject:dataB andIndex:index];
        
    return cell;
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
{
    return CGSizeMake((ScreenWidth - OneSepWidth*6), ScreenHeight -130);
}

- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}


//创建
- (UIView*)createCardWithobject:(NewMaginzeDetailInfo_dataB* )sender andIndex:(int)aindex
{
    CGFloat width = CGRectGetWidth(PScrollView.pageScrollView.frame);//(ScreenWidth - OneSepWidth*4);//CGRectGetWidth(scrollView.frame);
    CGFloat height = CGRectGetHeight(PScrollView.pageScrollView.frame);
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (ScreenWidth - OneSepWidth*4), height)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.cornerRadius = 8.;
    view.clipsToBounds = YES;
    view.tag = aindex;
    UIGestureRecognizer* gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellOnTap:)];
    [view addGestureRecognizer:gr];
    
    
    if ([arr_maginzelist count] < 1) {
        return view;
    }
    
    if (aindex == 0) {
        //封面
        UIView *bgV = [[UIView alloc] initWithFrame:view.frame];
        bgV.backgroundColor = [UIColor colorWithHexString:@"#fdfdfd"];
        bgV.alpha = 0.8;
        [view addSubview:bgV];
        
        
        UILabel *titlelab = [[UILabel alloc] initWithFrame:CGRectMake(10, 106, width -20, 30)];
        [titlelab setNumberOfLines:1];
        [titlelab setTextAlignment:NSTextAlignmentLeft];
        titlelab.text = [NSString stringWithFormat:@"%@",sender.title];
        titlelab.font = [UIFont systemFontOfSize:LabBigSize];
        [titlelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
        [view addSubview:titlelab];
        
        
        SHLUILabel *secondlab = [[SHLUILabel alloc] initWithFrame:CGRectMake(10, 140, width -20, 50)];
        [secondlab setNumberOfLines:0];
        [secondlab setTextAlignment:NSTextAlignmentLeft];
        secondlab.text = [NSString stringWithFormat:@"%@",sender.synopsis_text];
        secondlab.font = [UIFont systemFontOfSize:LabMidSize];
        [secondlab setTextColor:[UIColor colorWithHexString:@"#666666"]];
        [view addSubview:secondlab];
        
        int contentHight = [secondlab getAttributedStringHeightWidthValue:width -20];
        [secondlab setFrame:CGRectMake(10, 140, width -20, contentHight)];
        
        
        UILabel *threelab = [[UILabel alloc] initWithFrame:CGRectMake(10,secondlab.frame.origin.y + contentHight + 40, width - 40, 180)];
        [threelab setNumberOfLines:0];
        [threelab setTextAlignment:NSTextAlignmentLeft];
        threelab.text = [NSString stringWithFormat:@"      %@",sender.content];
        threelab.font = [UIFont systemFontOfSize:LabSmallSize];
        [threelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
        [view addSubview:threelab];
        
        
        
    }else if (aindex == [arr_maginzelist count] -1)
    {
        //尾页
        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        bgV.backgroundColor = [UIColor colorWithHexString:@"#fdfdfd"];
        bgV.alpha = 0.8;
        [view addSubview:bgV];
        view.tag = aindex;
        UIGestureRecognizer* gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoBrandViewAciton)];
        [view addGestureRecognizer:gr];
        
        
        UrlImageView *buynowV = [[UrlImageView alloc] initWithFrame:CGRectMake(70, 100, 135, 95)];
        [buynowV setImageFromUrl:NO withUrl:sender.img_path];
        [view addSubview:buynowV];
        
        
            MyButton *okbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [okbtn setFrame:CGRectMake( 0, height - 64 , width , 64)];
            [okbtn setBackgroundColor:[UIColor colorWithHexString:@"cfcfc7"]];
            [okbtn setTitle:@"进入品牌馆" forState:UIControlStateNormal];
            [okbtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
            okbtn.titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
            okbtn.titleLabel.font = [UIFont systemFontOfSize:LabBigSize];
            [okbtn addTarget:self action:@selector(gotoBrandViewAciton) forControlEvents:UIControlEventTouchUpInside];
            okbtn.tag = 1111;
            
            [view addSubview:okbtn];
        
    }else{
        //中间页
        UrlImageView *buynowV1 = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [buynowV1 setImageFromUrl:NO withUrl:sender.img_path];
        [view addSubview:buynowV1];
        
        //lee999 这个地方很重要，为了背景图片 图片不拉伸
        [buynowV1 setContentScaleFactor:[[UIScreen mainScreen] scale]];
        buynowV1.contentMode =  UIViewContentModeScaleAspectFill;
        buynowV1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        buynowV1.clipsToBounds  = YES;
        
        
        
        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, height-86, width, 86)];
        bgV.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        bgV.alpha = 0.8;
        [view addSubview:bgV];
        
        
        UILabel *threelab = [[UILabel alloc] initWithFrame:CGRectMake(15, height-86, width - 30, 66)];
        [threelab setNumberOfLines:0];
        [threelab setTextAlignment:NSTextAlignmentLeft];
        threelab.text = [NSString stringWithFormat:@"%@",sender.content];
        threelab.font = [UIFont systemFontOfSize:LabSmallSize];
        [threelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
        [view addSubview:threelab];
        
        if ([[sender.content description] isEqualToString:@""]) {
            [bgV setHidden:YES];
        }
        
    }
    
    return view;
}


-(void)cellOnTap:(UITapGestureRecognizer*)gr
{
    
    NSInteger index = [gr.view tag];
    
    //NSLog(@"index------%d",index);
    
    //    good_id
    NewMaginzeDetailInfo_dataB* dataB = [arr_maginzelist objectAtIndex:index isArray:nil];
    
    if ([dataB.good_id description].length > 1) {
        
        ProductDetailViewController *jumpVC=[[ProductDetailViewController alloc]init];
        jumpVC.isPush = YES;
        jumpVC.thisProductId=dataB.good_id;
        jumpVC.ThisPorductName=@"商品详情";
        jumpVC.source_id=@"1002";
        jumpVC.isFromRight = NO;
        [self.navigationController pushViewController:jumpVC animated:YES];
    }
    
    // Grap th
    
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
    
    [arr_maginzelist addObject:_mdetailinfo.magazine_info_b.info_index];
    [arr_maginzelist addObjectsFromArray:_mdetailinfo.magazine_info_b.info_content];
    [arr_maginzelist addObject:_mdetailinfo.magazine_info_b.info_footer];
    
    
    //lee999 判断是否被收藏过
    if ([_mdetailinfo.is_favorite intValue] == 0) {
        likebtn.selected = NO;
    }else if ([_mdetailinfo.is_favorite intValue] == 1){
        likebtn.selected = YES;
    }
    
    //添加背景图
    if ([_mdetailinfo.magazine_info_b.info_index.backgroud_img_path description].length > 0) {
        [bgimageV setImageFromUrl:NO withUrl:[_mdetailinfo.magazine_info_b.info_index.backgroud_img_path description]];
        
        //lee999 这个地方很重要，为了背景图片不拉伸
        [bgimageV setContentScaleFactor:[[UIScreen mainScreen] scale]];
        bgimageV.contentMode =  UIViewContentModeScaleAspectFill;
        bgimageV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        bgimageV.clipsToBounds  = YES;
        
        //lee999 这个地方很重要，毛玻璃效果
        [bgimageV setImage:[bgimageV.image applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil]];
    }
    
    
    [PScrollView.pageScrollView reloadData];

}

#pragma mark--- 进入品牌馆
-(void)gotoBrandViewAciton{
    
    NewBrandDetail20ViewController *brandvc = [[NewBrandDetail20ViewController alloc] initWithNibName:@"NewBrandDetail20ViewController" bundle:nil];
    brandvc.brandname = _mdetailinfo.magazine_info_b.info_footer.brand_name;
    [self.navigationController pushViewController:brandvc animated:YES];
    
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
