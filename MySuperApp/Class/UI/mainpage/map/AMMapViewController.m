//
//  AMMapViewController.m
//  MySuperApp
//
//  Created by yang on 14-3-25.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "AMMapViewController.h"
#import "MainpageServ.h"
#import "AnnotationView.h"
#import "StoreViewController.h"
#import "StoreDetail20ViewController.h"
#import "SHLUILabel.h"

//lee999附近的店200

#define macroot 13

@interface AMMapViewController ()
{
    
    UITableView *myTableV;
    int mapHight;

    BMKLocationService* _locService;
    BMKMapView* _mapView;
    BMKAnnotationView* newAnnotation;
    
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

@implementation AMMapViewController

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
    
    
    [self createBackBtnWithType:0];
    self.title = @"查找门店";
    
    mapHight = 174;
    
    isloadingData = YES;
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:200.f];
    //初始化BMKLocationService
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    if (_mapView) {
        [_mapView removeFromSuperview];
    }
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, mapHight)];
    _mapView.zoomLevel = macroot;
    oldReido = _mapView.zoomLevel;
    _mapView.scrollEnabled = YES;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];

    
    UIImage *image = [UIImage imageNamed:@"pin_purple.png"]; //pin_red2.png
    UIImageView *iamgeV = [[UIImageView alloc] initWithImage:image];
    [iamgeV setFrame:CGRectMake((ScreenWidth-image.size.width)/2, (mapHight-image.size.height)/2, image.size.width, image.size.height)];
    [iamgeV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:iamgeV];
        
    
    firstRequestnum = 1;//判断是否是第一次请求
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    
    [self creatTableView];
    
    if (![self checkLocationState]) {
        return;
    }
}

//创建表格
-(void)creatTableView{
    
    myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, mapHight, ScreenWidth, ScreenHeight - mapHight-64) style:UITableViewStylePlain];
    myTableV.delegate = self;
    myTableV.dataSource = self;
    [self.view addSubview:myTableV];
    [myTableV setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
}


-(BOOL)checkLocationState
{
    int status=[CLLocationManager authorizationStatus];
    
    //判断用户定位服务是否开启
    if (![CLLocationManager locationServicesEnabled]||status < 3) {
        
        LCommentAlertView *alert = [[LCommentAlertView alloc] initWithTitle:@"爱慕提醒" Message:@"检测到您没有开启定位开关,请您在设置--隐私--定位服务，允许获取您的位置信息" tag:99988 btns:@"确定", nil];
        alert.delegate = self;
        [alert show];
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
    _locService.delegate = self;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;

}

#pragma mark -- 按钮事件 放大或缩小地图

- (IBAction)changeMapFrame:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag) {
        case 11://放大
            _mapView.zoomLevel++;
            break;
        case 12://缩小
            _mapView.zoomLevel--;
            break;
        default:
            break;
    }
}


#pragma mark -- netrequest delegate
-(void)serviceStarted:(ServiceType)aHandle{

    isloadingData = YES;
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    isloadingData = NO;
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    
    isloadingData = NO;
    
    switch (model.requestTag) {
        case Http_Store_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                storeModel = (StoresStoresModel *)model;
                
                BOOL deleteFinish = NO;
                do {
                    
                    if (![[_mapView annotations] count]) {
                        
                        deleteFinish = YES;
                    } else  {
                        
                        if ([[_mapView annotations] count]) {
                            [_mapView removeAnnotation:((BMKPointAnnotation *)([[_mapView annotations] lastObject]))];
                        }
                    }
                    
                } while (!deleteFinish);
                
                indexex = 100;
                CLLocationCoordinate2D coor;
                for (int i = 0; i < storeModel.stores.count; i++) {
                    BMKPointAnnotation *annotationPoint = [[BMKPointAnnotation alloc]init];
                    StoresStores *store = (StoresStores *)[storeModel.stores objectAtIndex:i];
                    coor.latitude = [store.storeGpslat floatValue];
                    coor.longitude = [store.storeGpslng floatValue];
                    annotationPoint.coordinate = coor;
                    annotationPoint.title = [NSString stringWithFormat:@"  %@",store.storeName];
                    
                    [_mapView addAnnotation:annotationPoint];
                }
                
                [myTableV reloadData];
                
                return;
            }else{
                
                [SBPublicAlert hideYESMBprogressHUDcontent:model.errorMessage isSuccess:NO hiddenTime:0.6];
            }
            break;
        case 10086:
            [SBPublicAlert hideYESMBprogressHUDcontent:model.errorMessage isSuccess:NO hiddenTime:0.6];
            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
    
    BOOL deleteFinish = NO;
    do {
        if (![[_mapView annotations] count]) {
            deleteFinish = YES;
        } else  {
            if ([[_mapView annotations] count]) {
                [_mapView removeAnnotation:((BMKPointAnnotation *)([[_mapView annotations] lastObject]))];
            }
        }
    } while (!deleteFinish);
}


static NSInteger indexex = 100;

#pragma mark -- 百度地图代理
#pragma mark ---  定位的相关代码

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


//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    //普通态
    //以下_mapView为BMKMapView对象
    //_mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
    
    
    CLLocationCoordinate2D location;
    location.latitude = userLocation.location.coordinate.latitude;
    location.longitude = userLocation.location.coordinate.longitude;
    [_mapView setCenterCoordinate:location];
    [_mapView setZoomLevel:macroot];
    
}


#pragma mark--- 地图相关回调
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
    
    
//    if (firstRequestnum == 1) {
//        if (!storeModel) {
//            
//            [mainSer getShopLocation:lat andLng:lon andDistance:@"10"];
//            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
//        }
//        firstRequestnum = 2;
//        
//        CLLocationCoordinate2D location;
//        location.latitude = userLocation.location.coordinate.latitude;
//        location.longitude = userLocation.location.coordinate.longitude;
//        [_mapView setCenterCoordinate:location];
//        [_mapView setZoomLevel:macroot];
//        
//    }else if(firstRequestnum == 2){
//        
//        if (([lan floatValue] > [maplat floatValue] + 0.002 || [lan floatValue] < [maplat floatValue] - 0.002)  && ([lng floatValue] > [maplon floatValue] + 0.002 || [lng floatValue] < [maplon floatValue] - 0.002)) {
//            
//            
//            if (storeModel) {
//                
//                //数据正在加载中的话，就不在请求数据
//                if (isloadingData) {
//                    return;
//                }
//                
//                [mainSer getShopLocation:maplat andLng:maplon andDistance:@"10"];
//                [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
//            }
//            //lee999 重置地图的中心位置！！
//            [_mapView setCenterCoordinate:_mapView.centerCoordinate];
//            //[_mapView setZoomLevel:13];
//        }
//    }
//    lan = maplat;
//    lng = maplon;
}


//点击弹出的paopao触发的事件
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    if (view.rightCalloutAccessoryView.tag != 0) {
        if (view.rightCalloutAccessoryView.tag - 100 < [storeModel.stores count]) {
            
            [self gotoStoreVC:view.rightCalloutAccessoryView.tag-100];
        }
    }
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
}

- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState {
    
}

//移动完成之后 执行
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    NSString *maplat = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.latitude];
    NSString *maplon = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.longitude];
    NSLog(@"maplat：-222-----%@----maplon：-------%@",maplat,maplon);
    
    
    //lee999999
    
    if (firstRequestnum == 1) {
        if (!storeModel) {
            
            [mainSer getShopLocation:maplat andLng:maplon andDistance:@"10"];
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        }
        firstRequestnum = 2;
        
        CLLocationCoordinate2D location;
       // location.latitude = mapView.userLocation.location.coordinate.latitude;
       // location.longitude = mapView.userLocation.location.coordinate.longitude;
        [_mapView setCenterCoordinate:location];
        [_mapView setZoomLevel:macroot];
        
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
            [_mapView setCenterCoordinate:_mapView.centerCoordinate];
            //[_mapView setZoomLevel:13];
        }
    }
    lan = maplat;
    lng = maplon;
}



#pragma mark-- tableView

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

    
    UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, ScreenWidth-90, 30)];
    [namelab setNumberOfLines:1];
    [namelab setTextAlignment:NSTextAlignmentLeft];
    namelab.font = [UIFont systemFontOfSize:LabMidSize];
    [namelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
    [namelab setText:store.storeName];
    [bgv addSubview:namelab];
    
    UILabel *desclab = [[UILabel alloc] initWithFrame:CGRectMake(15, 38, ScreenWidth-60, 20)];
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
    UIImageView*imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-15-img.size.width, 38, img.size.width, img.size.height)];
    [imageV setImage:img];
    [bgv addSubview:imageV];
    
    
    //距离
    UILabel *distancelab = [[UILabel alloc] initWithFrame:CGRectMake(160, 8, ScreenWidth-200, 30)];
    [distancelab setNumberOfLines:1];
    [distancelab setTextAlignment:NSTextAlignmentRight];
    distancelab.font = [UIFont systemFontOfSize:LabMidSize];
    [distancelab setTextColor:[UIColor colorWithHexString:@"#888888"]];
    [distancelab setText:[NSString stringWithFormat:@"%.2fkm",[store.distance floatValue]]];
    [bgv addSubview:distancelab];
    
    
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
    
    
    StoresStores *store = (StoresStores *)[storeModel.stores objectAtIndex:[indexPath section]];
    if ([store.promotion_message description].length > 1) {
        
        SHLUILabel *namelab = [[SHLUILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth-30, 20)];
        namelab.text = [store.promotion_message description];
        namelab.font = [UIFont systemFontOfSize:LabSmallSize];
        namelab.lineBreakMode = NSLineBreakByWordWrapping;
        namelab.numberOfLines = 0;
        int promotion_messageHight = [namelab getAttributedStringHeightWidthValue:ScreenWidth-30]  + 60;
        return promotion_messageHight;
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
    

    //如果有促销信息的话
    StoresStores *store = (StoresStores *)[storeModel.stores objectAtIndex:[indexPath section]];
    if ([store.promotion_message description].length > 1) {
        
        UIView *imageLineV = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 0.5, 90)];
        [imageLineV setBackgroundColor:[UIColor colorWithHexString:@"#999999"]];
        [cell addSubview:imageLineV];
        
        UIImage *image = [UIImage imageNamed:@"info_dot.png"];
        UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(16, 20, image.size.width,  image.size.height)];
        [imagev setImage:image];
        [cell addSubview:imagev];
        
        
        UIView *labbgv = [[UIView alloc] initWithFrame:CGRectMake(30, 5, ScreenWidth-60, 15)];
        [labbgv setBackgroundColor:[UIColor colorWithHexString:@"#F4F4F4"]];
        labbgv.layer.cornerRadius = 5.0;
        [cell addSubview:labbgv];
        
        SHLUILabel *namelab = [[SHLUILabel alloc] initWithFrame:CGRectMake(40, 10, ScreenWidth-80, 20)];
        namelab.text = [store.promotion_message description];
        namelab.font = [UIFont systemFontOfSize:LabSmallSize];
        namelab.lineBreakMode = NSLineBreakByWordWrapping;
        namelab.numberOfLines = 0;
        int promotion_messageHight = [namelab getAttributedStringHeightWidthValue:ScreenWidth-80];
        [namelab setFrame:CGRectMake(40, 10, ScreenWidth-80, promotion_messageHight)];
        [cell addSubview:namelab];
        
        [imageLineV setFrame:CGRectMake(20, 0, 0.5, promotion_messageHight+60)];
        [labbgv setFrame:CGRectMake(30, 5, ScreenWidth-60, promotion_messageHight+10)];
        
    }
    

    // Configure the cell.
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


-(void)gotoStoreAction:(id)sender{

    UIButton*btn = (UIButton*)sender;
    [self gotoStoreVC:btn.tag];
}


-(void)gotoStoreVC:(NSInteger)index{
    StoresStores *store = (StoresStores *)[storeModel.stores objectAtIndex:index];
    NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:store.storeName, @"storename",nil];
    [TalkingData trackEvent:@"5007" label:@"查找门店" parameters:dic1];
    
    StoreDetail20ViewController *stvc = [[StoreDetail20ViewController alloc] init];
    stvc.delegate = self;
    stvc.store = store;
    stvc.index = index;
    [self.navigationController pushViewController:stvc animated:YES];
    
    /*
    StoreViewController *tempStore = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
    tempStore.num = index;
    tempStore.myPositionJinduString = lng;
    tempStore.myPositionWeiduString = lan;
    [self.navigationController pushViewController:tempStore animated:YES];
     */
}


-(void)sureFavStore:(BOOL)isfav withIndex:(NSInteger)index{
    StoresStores *store = (StoresStores *)[storeModel.stores objectAtIndex:index];
    if (isfav) {
        store.is_favorite = @"1";
    }else{
        store.is_favorite = @"0";
    }
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
