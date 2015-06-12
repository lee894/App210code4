////
////  NearByShopViewController.m
////  MyAimerApp
////
////  Created by yanglee on 15/4/15.
////  Copyright (c) 2015年 aimer. All rights reserved.
////
//
//#import "NearByShopViewController.h"
//#import "MainpageServ.h"
//#import "AnnotationView.h"
//#import "StoreViewController.h"
//
//
//@interface NearByShopViewController ()
//{
//    BMKMapView* _mapView;
//    BMKAnnotationView* newAnnotation;
//    
//    NSInteger firstRequestnum;//判断是否是第一次请求定位
//    float oldReido;
//    BMKMapRect MapRect;
//    StoresStoresModel *storeModel;
//    
//    NSString *lan;
//    NSString *lng;
//    
//    MainpageServ *mainSer;
//    
//    BOOL isloadingData;  //是否正在加载数据，加载中的话，就不在请求，防止多次请求数据
//}
//
//@end
//
//static NSInteger indexex = 100;
//
//@implementation NearByShopViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self createBackBtnWithType:0];
//    self.title = @"查找门店";
//    
//    
//    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 174)];
//    _mapView.zoomLevel = 3;
//    oldReido = _mapView.zoomLevel;
//    _mapView.scrollEnabled = YES;
//    [self.view insertSubview:_mapView atIndex:0];
//    _mapView.showsUserLocation = YES;
//    firstRequestnum = 1;//判断是否是第一次请求
//    
//    
//    mainSer = [[MainpageServ alloc] init];
//    mainSer.delegate = self;
//    
//    
//    
//    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *unSelectedImg = [UIImage imageNamed:@"t_ico_location_normal.png"];
//    UIImage *selectedImg = [UIImage imageNamed:@"t_ico_location_hover.png"];
//    [photoBtn setBackgroundImage:unSelectedImg forState:UIControlStateNormal];
//    [photoBtn setBackgroundImage:selectedImg forState:UIControlStateHighlighted];
//    [photoBtn addTarget:self action:@selector(gotomyWeizhi) forControlEvents:UIControlEventTouchUpInside];
//    photoBtn.frame = CGRectMake(10, 3, 20, 20);
//    
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:photoBtn];
//    self.navigationItem.rightBarButtonItem = rightBtn;
//}
//
//-(void)gotomyWeizhi{
//
//}
//
//
//#pragma mark -- netrequest delegate
//-(void)serviceStarted:(ServiceType)aHandle{
//    
//    isloadingData = YES;
//}
//
//-(void)serviceFailed:(ServiceType)aHandle{
//    [SBPublicAlert hideMBprogressHUD:self.view];
//    
//    isloadingData = NO;
//}
//
//-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
//{
//    [SBPublicAlert hideMBprogressHUD:self.view];
//    LBaseModel *model = (LBaseModel *)amodel;
//    
//    
//    isloadingData = NO;
//    
//    switch (model.requestTag) {
//        case Http_Store_Tag:
//            if (!model.errorMessage) {
//                [SBPublicAlert hideMBprogressHUD:self.view];
//                storeModel = (StoresStoresModel *)model;
//                
//                BOOL deleteFinish = NO;
//                do {
//                    
//                    if (![[_mapView annotations] count]) {
//                        
//                        deleteFinish = YES;
//                    } else  {
//                        
//                        if ([[_mapView annotations] count]) {
//                            [_mapView removeAnnotation:((BMKPointAnnotation *)([[_mapView annotations] lastObject]))];
//                        }
//                    }
//                    
//                } while (!deleteFinish);
//                
//                indexex = 100;
//                CLLocationCoordinate2D coor;
//                for (int i = 0; i < storeModel.stores.count; i++) {
//                    BMKPointAnnotation *annotationPoint = [[BMKPointAnnotation alloc]init];
//                    StoresStores *store = (StoresStores *)[storeModel.stores objectAtIndex:i];
//                    coor.latitude = [store.storeGpslat floatValue];
//                    coor.longitude = [store.storeGpslng floatValue];
//                    annotationPoint.coordinate = coor;
//                    annotationPoint.title = [NSString stringWithFormat:@"  %@",store.storeName];
//                    
//                    [_mapView addAnnotation:annotationPoint];
//                }
//                return;
//            }else{
//                
//                [SBPublicAlert hideYESMBprogressHUDcontent:model.errorMessage isSuccess:NO hiddenTime:0.6];
//            }
//            break;
//        case 10086:
//            [SBPublicAlert hideYESMBprogressHUDcontent:model.errorMessage isSuccess:NO hiddenTime:0.6];
//            break;
//        default:
//            [SBPublicAlert hideMBprogressHUD:self.view];
//            break;
//    }
//    
//    BOOL deleteFinish = NO;
//    do {
//        if (![[_mapView annotations] count]) {
//            deleteFinish = YES;
//        } else  {
//            if ([[_mapView annotations] count]) {
//                [_mapView removeAnnotation:((BMKPointAnnotation *)([[_mapView annotations] lastObject]))];
//            }
//        }
//    } while (!deleteFinish);
//}
//
//
//#pragma mark -- 百度地图代理
////自定义大头针和弹出的view
//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    // 生成重用标示identifier
//    NSString *AnnotationViewID = @"renameMark";
//    
//    // 检查是否有重用的缓存
//    BMKAnnotationView* _newAnnotation = [_mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//    
//    if (_newAnnotation == nil) {
//        
//        _newAnnotation = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//        _newAnnotation.canShowCallout = YES;
//        UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//        tempButton.tag = indexex;
//        [tempButton setImage:[UIImage imageNamed:@"shop_icon_more.png"] forState:UIControlStateNormal];
//        _newAnnotation.rightCalloutAccessoryView = tempButton;
//        indexex ++;
//        return _newAnnotation;
//    } else {
//        _newAnnotation.canShowCallout = YES;
//        UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//        tempButton.tag = indexex;
//        [tempButton setImage:[UIImage imageNamed:@"shop_icon_more.png"] forState:UIControlStateNormal];
//        _newAnnotation.rightCalloutAccessoryView = tempButton;
//        indexex ++;
//    }
//    return _newAnnotation;
//}
//
///**
// *用户位置更新后，会调用此函数
// *@param mapView 地图View
// *@param userLocation 新的用户位置
// */
//- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
//{
//    //    NSLog(@"%@",NSStringFromCGRect(mapView.frame));
//    NSString *lat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
//    NSString *lon = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
//    
//    NSString *maplat = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.latitude];
//    NSString *maplon = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.longitude];
//    
//    NSLog(@"lat：-----------%@------lon：--------%@",lat,lon);
//    NSLog(@"maplat：--------%@----maplon：--------%@",maplat,maplon);
//    
//    
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
//        [_mapView setZoomLevel:13];
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
//                [mainSer getShopLocation:maplat andLng:maplon andDistance:@"10"];
//                [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
//            }
//        }
//    }
//    lan = maplat;
//    lng = maplon;
//}
//
//
////点击弹出的paopao触发的事件
//- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
//{
//    if (view.rightCalloutAccessoryView.tag != 0) {
//        if (view.rightCalloutAccessoryView.tag - 100 < [storeModel.stores count]) {
//            
//            StoresStores *store = [storeModel.stores objectAtIndex:view.rightCalloutAccessoryView.tag-100];
//            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:store.storeName, @"storename",nil];
//            [TalkingData trackEvent:@"5007" label:@"查找门店" parameters:dic1];
//            
//            StoreViewController *tempStore = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
//            tempStore.num = view.rightCalloutAccessoryView.tag-100;
//            tempStore.myPositionJinduString = lng;
//            tempStore.myPositionWeiduString = lan;
//            [self.navigationController pushViewController:tempStore animated:YES];
//        }
//    }
//}
//
//- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
//{
//    
//}
///**
// *在地图View将要启动定位时，会调用此函数
// *@param mapView 地图View
// */
//- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
//{
//    NSLog(@"MapView UserLocation");
//    
//}
//
///**
// *定位失败后，会调用此函数
// *@param mapView 地图View
// *@param error 错误号，参考CLError.h中定义的错误号
// */
//- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
//{
//    NSLog(@"mapViewUserLocation Error");
//}
//
//
//- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
//   fromOldState:(BMKAnnotationViewDragState)oldState {
//    
//}
//
////移动完成之后 执行
//- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//    
//    NSString *maplat = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.latitude];
//    NSString *maplon = [NSString stringWithFormat:@"%f",_mapView.centerCoordinate.longitude];
//    NSLog(@"maplat：-222-----%@----maplon：-------%@",maplat,maplon);
//    
//    //    sizelab.text = [NSString stringWithFormat:@"%@公里",[arr objectAtIndex:(NSInteger)_mapView.zoomLevel -3]];
//}
//
//
//
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end
