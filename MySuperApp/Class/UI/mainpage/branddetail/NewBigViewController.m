//
//  NewBigViewController.m
//  MySuperApp
//
//  Created by bonan on 14-4-22.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "NewBigViewController.h"
#import "ProductDetailViewController.h"
//#import "YKProductDetailController.h"
//#import "MillViewController.h"

@interface NewBigViewController ()

@end

@implementation NewBigViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [myImageScroll setShowsHorizontalScrollIndicator:NO];
    [myImageScroll setShowsVerticalScrollIndicator:NO];
    [myImageScroll setDelegate:self];
    [myImageScroll setMaximumZoomScale:3.0];
    [bigImageV setImageFromUrl:YES withUrl:self.imagePath];
    [bigImageV setTag:9712];
//    [self.view bringSubviewToFront:self.btnnavback];
    
    //隐藏footview
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.aktabBarRightController hideTabBar:AKShowHideFromLeft animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    //显示footview
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.aktabBarRightController showTabBar:AKShowHideFromLeft animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!self.productID) {
        goMillBut.hidden = YES;
    }
    
//    [self createBackBtn1];
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:9712];
}

//去商城看
- (IBAction)goMillButActionChicked:(id)sender {
    
    ProductDetailViewController* detail = [[ProductDetailViewController alloc] init];
    detail.thisProductId = self.productID;
    detail.isFromRight = YES;
    //跳转到竖屏的响应详情界面~~~~
//    [self jumpLeftView:detail];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 屏幕旋转
//iOS 5
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight||toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);}
//iOS 6
- (BOOL)shouldAutorotate{
	return YES;
}
- (NSUInteger)supportedInterfaceOrientations{
	return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
	return UIInterfaceOrientationLandscapeRight;
}

- (IBAction)pushback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
