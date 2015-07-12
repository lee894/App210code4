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
//    [bigImageV setImageFromUrl:YES withUrl:[self ImageSize:self.imagePath Size:@"640x853"]];
    [bigImageV setTag:9712];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle:@"潮流新品详情"];
    [self createBackBtnWithType:0];
    
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
    [self.navigationController pushViewController:detail animated:YES];
    
    //跳转到竖屏的响应详情界面~~~~
//    [self jumpLeftView:detail];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 屏幕旋转

- (IBAction)pushback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
