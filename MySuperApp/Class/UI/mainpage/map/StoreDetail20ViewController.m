//
//  StoreDetail20ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/20.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "StoreDetail20ViewController.h"
#import "MainpageServ.h"
#import "AnnotationView.h"
#import "StoreViewController.h"
#import "SHLUILabel.h"

#import <BaiduMapAPI/BMKNavigation.h>//引入所有的头文件
//#import "BMKNavigation.h"


@interface StoreDetail20ViewController ()
{
    UIScrollView *myScrollView;
    int mapHight;

    
    UIButton *favbtn;

    BMKMapView* _mapView;
    BMKAnnotationView* newAnnotation;
    
    CLLocationCoordinate2D mycoor1;


    NSInteger firstRequestnum;//判断是否是第一次请求定位
    float oldReido;
    BMKMapRect MapRect;
    StoresStoresModel *storeModel;

    NSString *lan;
    NSString *lng;

    MainpageServ *mainSer;

    BOOL isloadingData;  //是否正在加载数据，加载中的话，就不在请求，防止多次请求数据
}

@end

@implementation StoreDetail20ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    mapHight = 174;


    [self createBackBtnWithType:0];
    self.title = @"门店详情";

    [self creatTableView];

    isloadingData = YES;
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, mapHight)];
    _mapView.zoomLevel = 13;
    _mapView.delegate = self;
//    oldReido = _mapView.zoomLevel;
    _mapView.scrollEnabled = YES;
    [self.view insertSubview:_mapView atIndex:0];
    _mapView.showsUserLocation = YES;


    firstRequestnum = 1;//判断是否是第一次请求
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;


    
    if (![self checkLocationState]) {
        return;
    }
}

-(void)rightButAction{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"您是否安装了百度地图App？如果安装我们将用百度地图为您导航；如果您未安装，我们将通过web为您导航" delegate:self cancelButtonTitle:@"未安装" otherButtonTitles:@"已安装", nil];
    alert.delegate = self;
    alert.tag = 100099;
    [alert show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 10000000 && buttonIndex == 1) {
        //切换到我的爱慕进行登录 来源于竖屏的商场~~
        [SingletonState sharedStateInstance].myaimerIsFrom = 2;
        [self changeToMyaimer];
    }
    
    
    if (alertView.tag == 100099) {
        if (buttonIndex == 0) {
        //未安装
            
            //----------web地图
            
            //初始化调启导航时的参数管理类
            BMKNaviPara* para = [[BMKNaviPara alloc]init];
            //指定导航类型
            para.naviType = BMK_NAVI_TYPE_WEB;
            
            //初始化起点节点
            BMKPlanNode* start = [[BMKPlanNode alloc]init];
            //指定起点经纬度
            CLLocationCoordinate2D coor1;
            coor1.latitude = mycoor1.latitude;
            coor1.longitude = mycoor1.longitude;
            start.pt = coor1;
            //指定起点名称
            start.name = @"我的位置";
            //指定起点
            para.startPoint = start;
            
            
            //初始化终点节点
            BMKPlanNode* end = [[BMKPlanNode alloc]init];
            CLLocationCoordinate2D coor2;
            
            coor2.latitude = [self.store.storeGpslat floatValue];
            coor2.longitude = [self.store.storeGpslng floatValue];
            end.pt = coor2;
            para.endPoint = end;
            //指定终点名称
            end.name = self.store.storeName;
            //指定调启导航的app名称
            para.appName = [NSString stringWithFormat:@"%@", @"testAppName"];
            //调启web导航
            [BMKNavigation openBaiduMapNavigation:para];

            
        }else{
        //已安装
            
            NSLog(@" installed");
            
            //-------客户端版本地图
            //初始化调启导航时的参数管理类
            BMKNaviPara* para = [[BMKNaviPara alloc]init];
            //指定导航类型
            para.naviType = BMK_NAVI_TYPE_NATIVE;
            
            //初始化终点节点
            BMKPlanNode* end = [[BMKPlanNode alloc]init];
            //指定终点经纬度
            CLLocationCoordinate2D coor2;
            coor2.latitude = [self.store.storeGpslat floatValue];
            coor2.longitude = [self.store.storeGpslng floatValue];;
            end.pt = coor2;
            //指定终点名称
            end.name = self.store.storeName;
            //指定终点
            para.endPoint = end;
            
            //指定返回自定义scheme，具体定义方法请参考常见问题
            para.appScheme = @"baidumapsdk://mapsdk.baidu.com";
            //调启百度地图客户端导航
            [BMKNavigation openBaiduMapNavigation:para];
            
        }
    }
    
    
}


//创建表格
-(void)creatTableView{

    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mapHight, ScreenWidth, ScreenHeight - mapHight - 70)];
    [myScrollView setDelegate:self];
    [myScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:myScrollView];
    

    int  spX = 10;  //距离左边边距
    int viewHight = 10;
    
    
    //标题
    UILabel *titlelab = [[UILabel alloc] initWithFrame:CGRectMake(spX, viewHight, ScreenWidth-spX*2 -40, 26)];
    [titlelab setNumberOfLines:1];
    [titlelab setTextAlignment:NSTextAlignmentLeft];
    [titlelab setBackgroundColor:[UIColor clearColor]];
    titlelab.text = [NSString stringWithFormat:@"%@",self.store.storeName];
    titlelab.font = [UIFont systemFontOfSize:LabBigSize];
    [titlelab setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [myScrollView addSubview:titlelab];
    
    //收藏按钮
    UIImage *imag = [UIImage imageNamed:@"like_small_normal.png"];
    favbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [favbtn setFrame:CGRectMake(ScreenWidth - 30- imag.size.width,viewHight ,25,25)];
    favbtn.titleLabel.font = [UIFont systemFontOfSize:LablitileSmallSize];
    [favbtn setBackgroundImage:[UIImage imageNamed:@"like_small_normal.png"] forState:UIControlStateNormal];
    [favbtn setBackgroundImage:[UIImage imageNamed:@"t_ico_like_hover.png"] forState:UIControlStateSelected];
    [favbtn setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
    [favbtn addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:favbtn];
    [favbtn setTag:1009];
    if ([self.store.is_favorite intValue] == 0) {
        //未收藏
        favbtn.selected = NO;
    }else if([self.store.is_favorite intValue] == 1){
        //已收藏
        favbtn.selected = YES;
    }
    
    viewHight += 30;

    //地址
    UILabel *addresslab = [[UILabel alloc] initWithFrame:CGRectMake(spX, viewHight, ScreenWidth-spX*2, 26)];
    [addresslab setNumberOfLines:1];
    [addresslab setTextAlignment:NSTextAlignmentLeft];
    addresslab.text = @"地址：";
    addresslab.font = [UIFont systemFontOfSize:LabSmallSize];
    [addresslab setTextColor:[UIColor colorWithHexString:@"#C90C2E"]];
    [myScrollView addSubview:addresslab];

    SHLUILabel *addresslab2 = [[SHLUILabel alloc] initWithFrame:CGRectMake(20 + 30, viewHight + 6, ScreenWidth-spX*2-40, 20)];
    [addresslab2 setNumberOfLines:2];
    [addresslab2 setTextAlignment:NSTextAlignmentLeft];
    addresslab2.text = [NSString stringWithFormat:@"%@",self.store.storeAddress];
    addresslab2.font = [UIFont systemFontOfSize:LabSmallSize];
    [addresslab2 setTextColor:[UIColor colorWithHexString:@"#444444"]];
    [myScrollView addSubview:addresslab2];
    
    int contentHight = [addresslab2 getAttributedStringHeightWidthValue:ScreenWidth-spX*2-40];
    [addresslab2 setFrame:CGRectMake(20 + 30, viewHight + 6, ScreenWidth-spX*2-40, contentHight)];
    
    //品牌
    viewHight += contentHight + 10;

    UILabel *brandlab = [[UILabel alloc] initWithFrame:CGRectMake(spX, viewHight, ScreenWidth-spX*2, 26)];
    [brandlab setNumberOfLines:1];
    [brandlab setTextAlignment:NSTextAlignmentLeft];
    brandlab.text = @"主营品牌：";
    brandlab.font = [UIFont systemFontOfSize:LabSmallSize];
    [brandlab setTextColor:[UIColor colorWithHexString:@"#C90C2E"]];
    [myScrollView addSubview:brandlab];
    
    
//    SHLUILabel *namelab = [[SHLUILabel alloc] initWithFrame:CGRectMake(15, 20, ScreenWidth-30, contentHight)];

    SHLUILabel *brandlab2 = [[SHLUILabel alloc] initWithFrame:CGRectMake(20 +55, viewHight+6, ScreenWidth-spX*2-60, 50)];
    [brandlab2 setNumberOfLines:2];
    [brandlab2 setTextAlignment:NSTextAlignmentLeft];
    brandlab2.text = [self.store.brand stringByAppendingString:@""];
    brandlab2.font = [UIFont systemFontOfSize:LabSmallSize];
    [brandlab2 setTextColor:[UIColor colorWithHexString:@"#444444"]];
    int contentHight2 = [brandlab2 getAttributedStringHeightWidthValue:ScreenWidth-spX*2-60];
    [brandlab2 setFrame:CGRectMake(20 +55, viewHight +6, ScreenWidth-spX*2-60, contentHight2)];
    [myScrollView addSubview:brandlab2];

    viewHight += contentHight2 + 10;

    
    //营业时间
    if ([self.store.business_hours description].length > 1)
    {
      
//        viewHight += 55;
        
        UILabel *timelab = [[UILabel alloc] initWithFrame:CGRectMake(spX, viewHight, ScreenWidth-spX*2, 26)];
        [timelab setNumberOfLines:1];
        [timelab setTextAlignment:NSTextAlignmentLeft];
        timelab.text = @"营业时间：";
        timelab.font = [UIFont systemFontOfSize:LabSmallSize];
        [timelab setTextColor:[UIColor colorWithHexString:@"#C90C2E"]];
        [myScrollView addSubview:timelab];
        
        UILabel *timelab2 = [[UILabel alloc] initWithFrame:CGRectMake(20 +60, viewHight -2, ScreenWidth-spX*2-50, 30)];
        [timelab2 setNumberOfLines:2];
        [timelab2 setTextAlignment:NSTextAlignmentLeft];
        timelab2.text = @"123123";//self.store.business_hours;
        timelab2.font = [UIFont systemFontOfSize:LabSmallSize];
        [timelab2 setTextColor:[UIColor colorWithHexString:@"#444444"]];
        [myScrollView addSubview:timelab2];
    }
    
    //促销信息
    if ([self.store.promotion_message description].length > 1)
    {
    
        viewHight += 45;

        UIImage* imag = [UIImage imageNamed:@"big_btn_w_mormal.png"];
        UIButton *commbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commbtn setFrame:CGRectMake((ScreenWidth-imag.size.width)/2, viewHight,imag.size.width, imag.size.height)];
        commbtn.titleLabel.font = [UIFont systemFontOfSize:LabMidSize];
        [commbtn setTitle:@"促销信息" forState:UIControlStateNormal];
        [commbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_w_mormal.png"] forState:UIControlStateNormal];
        [commbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_w_hover.png"] forState:UIControlStateSelected];
        [commbtn setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
        [commbtn addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];

        [myScrollView addSubview:commbtn];
        [commbtn setTag:1010];
    }


    //电话
        if ([self.store.storeTel description].length > 1)
    {
        viewHight += 45;
        UIImage* imag = [UIImage imageNamed:@"big_btn_g_normal.png"];
        UIButton *commbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commbtn setFrame:CGRectMake((ScreenWidth-imag.size.width)/2, viewHight,imag.size.width, imag.size.height)];
        commbtn.titleLabel.font = [UIFont systemFontOfSize:LabMidSize];
        [commbtn setTitle:[self.store.storeTel description] forState:UIControlStateNormal];
        [commbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_g_normal.png"] forState:UIControlStateNormal];
        [commbtn setBackgroundImage:[UIImage imageNamed:@"big_btn_g_hover.png"] forState:UIControlStateSelected];
        [commbtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [commbtn addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
        [myScrollView addSubview:commbtn];
        
        [commbtn setTag:1011];
    }
    
    viewHight += 130;
    [myScrollView setContentSize:CGSizeMake(ScreenWidth, viewHight)];
}

-(void)btnAciton:(id)sender{
    UIButton *btn = (UIButton*)sender;
    
    
    if (btn.tag == 1009) {
        
        if (![SingletonState sharedStateInstance].userHasLogin) {

            [self changeToMyaimer];
            
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录",nil];
//            alert.tag = 10000000;
//            alert.delegate = self;
//            [alert show];
            
            return;
        }
        
        
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        
        //添加收藏
        if (!favbtn.selected) {
            //未中状态 添加收藏
            [mainSer getFavoriteadd:self.store.storeid andType:@"store" anduk:@""];
        }else{
            //选中状态 取消收藏
            [mainSer getFavoritedel:self.store.storeid andType:@"store"];
        }
        
    }else if (btn.tag == 1010) {
        
        //促销信息
        
        NSString *msg  = @"";
        if([self.store.promotion_message description].length > 1) {
            msg = [self.store.promotion_message description];
        }else{
            msg = @"该门店暂无促销信息";
        }
        
        LCommentAlertView *alert = [[LCommentAlertView alloc] initWithTitle:@"爱慕提醒" Message:msg tag:999 btns:@"确定", nil];
        [alert show];
    }
    
    if (btn.tag == 1011) {
        [self dialPhoneNumber:self.store.storeTel];
    }
}


#pragma mark -- 打电话
- (void)dialPhoneNumber:(NSString *)aPhoneNumber
{
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",aPhoneNumber]];
    [[UIApplication sharedApplication] openURL:phoneNumberURL];
}

-(BOOL)checkLocationState
{
    int status=[CLLocationManager authorizationStatus];

    //判断用户定位服务是否开启
    if (![CLLocationManager locationServicesEnabled]||status < 3) {

        LCommentAlertView *alert = [[LCommentAlertView alloc] initWithTitle:@"爱慕提醒" Message:@"检测到您没有开启定位开关,请您在设置--隐私--定位服务，允许获取您的位置信息" tag:999 btns:@"确定", nil];
        [alert show];
        alert.delegate = self;
        return NO;
    }
    else
    {
        return YES;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
        
    CLLocationCoordinate2D coor;
    BMKPointAnnotation *annotationPoint = [[BMKPointAnnotation alloc]init];
    coor.latitude = [self.store.storeGpslat floatValue];
    coor.longitude = [self.store.storeGpslng floatValue];
    annotationPoint.coordinate = coor;
    annotationPoint.title = [NSString stringWithFormat:@"  %@",self.store.storeName];
    _mapView.zoomLevel = 13;  //设置缩放比例
    [_mapView setCenterCoordinate:coor animated:YES]; //设置中心点  为店铺的位置
    [_mapView addAnnotation:annotationPoint];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //lee999修改，不是每次都定位----
//    firstRequestnum = 1;//判断是否是第一次请求
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}


- (IBAction)enLargeOrShrinkMap:(UIButton *)sender//
{
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
    if ([amodel isKindOfClass:[LBaseModel class]] &&
        model.requestTag < 200) {
        switch (model.requestTag) {
            case Http_FavoriteAdd_Tag : {
                if (!model.errorMessage) {
                    [SBPublicAlert showMBProgressHUD:@"收藏成功" andWhereView:self.view hiddenTime:0.6];
                    favbtn.selected = !favbtn.selected;
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(sureFavStore:withIndex:)]) {
                        [self.delegate sureFavStore:YES withIndex:self.index];
                    }
                    
                }else {
                    [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
                }
            }
                break;
            case Http_FavoriteDel_Tag:
            {
                if (!model.errorMessage) {
                    [SBPublicAlert showMBProgressHUD:@"删除收藏" andWhereView:self.view hiddenTime:0.6];
                    favbtn.selected = !favbtn.selected;
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(sureFavStore:withIndex:)]) {
                        [self.delegate sureFavStore:NO withIndex:self.index];
                    }
                    
                }else {
                    [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
                }
            }
                
            default:
                break;
        }
        return;
    }
}
 


static NSInteger indexex = 100;

#pragma mark -- 百度地图代理
//自定义大头针和弹出的view
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"renameMark";

    // 检查是否有重用的缓存
    BMKAnnotationView* _newAnnotation = [_mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];

    if (_newAnnotation == nil) {

        _newAnnotation = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        _newAnnotation.canShowCallout = YES;
        UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        tempButton.tag = indexex;
        [tempButton setImage:[UIImage imageNamed:@"shop_icon_more.png"] forState:UIControlStateNormal];
        _newAnnotation.rightCalloutAccessoryView = tempButton;
        indexex ++;
        return _newAnnotation;
    } else {
        _newAnnotation.canShowCallout = YES;
        UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        tempButton.tag = indexex;
        [tempButton setImage:[UIImage imageNamed:@"shop_icon_more.png"] forState:UIControlStateNormal];
        _newAnnotation.rightCalloutAccessoryView = tempButton;
        indexex ++;
    }
    return _newAnnotation;
}

/**
*用户位置更新后，会调用此函数
*@param mapView 地图View
*@param userLocation 新的用户位置
*/
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"%@",NSStringFromCGRect(mapView.frame));
    NSString *lat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];

    NSString *maplat = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.latitude];
    NSString *maplon = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.longitude];

    NSLog(@"lat：-----------%@------lon：--------%@",lat,lon);
    NSLog(@"maplat：--------%@----maplon：--------%@",maplat,maplon);

    
    mycoor1 = userLocation.location.coordinate;

    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *unSelectedImg = [UIImage imageNamed:@"t_ico_location_normal.png"];
    UIImage *selectedImg = [UIImage imageNamed:@"t_ico_location_hover.png"];
    [photoBtn setBackgroundImage:unSelectedImg forState:UIControlStateNormal];
    [photoBtn setBackgroundImage:selectedImg forState:UIControlStateHighlighted];
    [photoBtn addTarget:self action:@selector(rightButAction) forControlEvents:UIControlEventTouchUpInside];
    photoBtn.frame = CGRectMake(10, 3, 20, 20);
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:photoBtn];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    /*
    
    if (firstRequestnum == 1) {
        if (!storeModel) {

            [mainSer getShopLocation:lat andLng:lon andDistance:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        }
        firstRequestnum = 2;

        CLLocationCoordinate2D location;
        location.latitude = userLocation.location.coordinate.latitude;
        location.longitude = userLocation.location.coordinate.longitude;
        [_mapView setCenterCoordinate:location];
        [_mapView setZoomLevel:13];

    }else if(firstRequestnum == 2){

        if (([lan floatValue] > [maplat floatValue] + 0.002 || [lan floatValue] < [maplat floatValue] - 0.002)  && ([lng floatValue] > [maplon floatValue] + 0.002 || [lng floatValue] < [maplon floatValue] - 0.002)) {


            if (storeModel) {

                //数据正在加载中的话，就不在请求数据
                if (isloadingData) {
                    return;
                }

                [mainSer getShopLocation:maplat andLng:maplon andDistance:@"10"];
                [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
            }
            //lee999 重置地图的中心位置！！
            //[_mapView setCenterCoordinate:_mapView.centerCoordinate];
            //[_mapView setZoomLevel:13];
        }
    }
     
     */
     
    lan = maplat;
    lng = maplon;
}


//点击弹出的paopao触发的事件
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    if (view.rightCalloutAccessoryView.tag != 0) {
        if (view.rightCalloutAccessoryView.tag - 100 < [storeModel.stores count]) {

//            [self gotoStoreVC:view.rightCalloutAccessoryView.tag-100];
        }
    }
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{

}
/**
*在地图View将要启动定位时，会调用此函数
*@param mapView 地图View
*/
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"MapView UserLocation");

}

/**
*定位失败后，会调用此函数
*@param mapView 地图View
*@param error 错误号，参考CLError.h中定义的错误号
*/
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"mapViewUserLocation Error");
}


- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState {

}

//移动完成之后 执行
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {

    NSString *maplat = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.latitude];
    NSString *maplon = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.longitude];
    NSLog(@"maplat：-222-----%@----maplon：-------%@",maplat,maplon);

    //    sizelab.text = [NSString stringWithFormat:@"%@公里",[arr objectAtIndex:(NSInteger)_mapView.zoomLevel -3]];
}



#pragma mark-- tableView
/*
// Section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return storeModel.stores.count;
}

// row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Section的 head高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 66;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 66)];
    [bgv setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];


    StoresStores *store = (StoresStores *)[storeModel.stores objectAtIndex:section];


    UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 240, 30)];
    [namelab setNumberOfLines:1];
    [namelab setTextAlignment:NSTextAlignmentLeft];
    namelab.font = [UIFont systemFontOfSize:LabBigSize];
    [namelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
    [namelab setText:store.storeName];
    [bgv addSubview:namelab];


    UILabel *desclab = [[UILabel alloc] initWithFrame:CGRectMake(15, 38, 290, 20)];
    [desclab setNumberOfLines:1];
    [desclab setTextAlignment:NSTextAlignmentLeft];
    desclab.font = [UIFont systemFontOfSize:LablitileSmallSize];
    [desclab setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [desclab setText:store.storeAddress];
    [bgv addSubview:desclab];


    UIView *bglv = [[UIView alloc] initWithFrame:CGRectMake(0, 65.5, ScreenWidth, 0.5)];
    [bglv setBackgroundColor:[UIColor colorWithHexString:@"999999"]];
    [bgv addSubview:bglv];


    UIImage*img = [UIImage imageNamed:@"dl_zc_arrow.png"];
    UIImageView*imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-15-img.size.width, 30, img.size.width, img.size.height)];
    [imageV setImage:img];
    [bgv addSubview:imageV];


    UIButton *sortbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sortbtn setFrame:bgv.frame];
    [sortbtn addTarget:self action:@selector(gotoStoreAction:) forControlEvents:UIControlEventTouchUpInside];
    sortbtn.tag = section;
    [bgv addSubview:sortbtn];



    return bgv;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

// row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //todo
    if ([storeModel.stores objectAtIndex:[indexPath section]]) {
    }
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:showUserInfoCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }

    // Configure the cell.
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}


-(void)gotoStoreAction:(id)sender{

    UIButton*btn = (UIButton*)sender;
    [self gotoStoreVC:btn.tag];
}


-(void)gotoStoreVC:(int)index{
 
    
    StoresStores *store = (StoresStores *)[storeModel.stores objectAtIndex:index];
    NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:store.storeName, @"storename",nil];
    [TalkingData trackEvent:@"5007" label:@"查找门店" parameters:dic1];

    StoreViewController *tempStore = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
    tempStore.num = index;
    tempStore.myPositionJinduString = lng;
    tempStore.myPositionWeiduString = lan;
    [self.navigationController pushViewController:tempStore animated:YES];
}
*/



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
