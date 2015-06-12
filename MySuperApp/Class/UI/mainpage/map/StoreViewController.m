//
//  StoreViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-8.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "StoreViewController.h"
#import <MapKit/MapKit.h>
#import "StoresStoresModel.h"
#import "ModelManager.h"
#import "MYMacro.h"

@interface StoreViewController ()

@end

@implementation StoreViewController
@synthesize num;
@synthesize labelTitle,labelAddr,labelBrand,buttonPhone;
@synthesize img;
@synthesize store;
@synthesize myPositionWeiduString;
@synthesize myPositionJinduString;
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
    
    StoresStoresModel *storeModel = [[ModelManager sharedModelManager] StoresStoresModel];
    self.store = [storeModel.stores objectAtIndex:self.num];
    self.labelTitle.text = store.storeName;
    self.labelAddr.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    self.labelAddr.text = store.storeAddress;
    self.labelBrand.text = store.brand;
    [self.buttonPhone setTitle:store.storeTel forState:UIControlStateNormal];
    [self.buttonPhone setTitle:store.storeTel forState:UIControlStateHighlighted];
    [self.img setImageWithURL:[NSURL URLWithString:store.filePath] placeholderImage:[UIImage imageNamed:@"pic_default_shop.png"]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 按钮事件
- (IBAction)quit:(id)sender//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)telPhone:(id)sender//打电话
{
    [self dialPhoneNumber:self.buttonPhone.titleLabel.text];

}

- (IBAction)mapNavigation:(id)sender
{
    
    
    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {//6.0以下，调用googleMap
        
        NSLog(@"6.0以下，调用googleMap");
        
        NSString * loadString=[NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%@,%@&daddr=%@,%@",self.myPositionWeiduString,self.myPositionJinduString,self.store.storeGpslat,self.store.storeGpslng];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:loadString]];  
    }else{
        
        CLLocationCoordinate2D to;
        
        //要去的目标经纬度
        
        to.latitude = [self.store.storeGpslat floatValue];
        to.longitude = [self.store.storeGpslng floatValue];
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];//调用自带地图（定位）
        //显示目的地坐标。画路线
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
        toLocation.name = self.store.storeName;
        
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                  forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
    }
}

#pragma mark -- 打电话
- (void)dialPhoneNumber:(NSString *)aPhoneNumber
{
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",aPhoneNumber]];
    [[UIApplication sharedApplication] openURL:phoneNumberURL];
    
//    NSURL *phoneURL=[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",aPhoneNumber]];
//    if (!phoneCallWebView) {
//        phoneCallWebView=[[UIWebView alloc]initWithFrame:CGRectZero];
//    }    
//    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

#pragma mark -- 屏幕旋转
//iOS 5
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}
//iOS 6
- (BOOL)shouldAutorotate
{
	return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationLandscapeLeft;
}

@end
