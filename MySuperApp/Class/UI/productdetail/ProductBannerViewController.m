//
//  ProductBannerViewController.m
//  MySuperApp
//
//  Created by bonan on 14-4-16.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ProductBannerViewController.h"

#define productImageHeight 396
#define IMG_PlaceHolder_time       @"pic_default_product_list.png"

@interface ProductBannerViewController ()

@end

@implementation ProductBannerViewController


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
    [ImageScrollVIew setContentOffset:CGPointMake(ScreenWidth*self.indexPage, 0)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"商品大图";
    //创建返回按钮
    [self createBackBtnWithType:0];
    
    [self addSubViewInScroll];
}

- (void)addSubViewInScroll {
    
    
    
    ImageScrollVIew.contentSize = CGSizeMake(320*self.arrayForImg.childArray.count, productImageHeight);
    
    NSLog(@"self.view.frame is %@",NSStringFromCGRect(self.view.frame));
    NSLog(@"self.view.bounds is %@",NSStringFromCGRect(self.view.bounds));
    
    //lee999 增加适配IPhone 4寸屏幕
    if (IS4InchScreen) {
        CGRect oldsize = ImageScrollVIew.frame;
        oldsize.origin.y = 30;
        [ImageScrollVIew setFrame:oldsize];
    }

    //lee注释掉，因为有可能导致崩溃
//    _pageControl = [[BluePageControl alloc] initWithFrame:CGRectMake(0,  self.view.frame.size.height-40, 320, 20)];
//    [_pageControl  setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:_pageControl];
//    _pageControl.activeImage = [UIImage imageNamed:@"guide_dot_red.png"];
//    _pageControl.inactiveImage = [UIImage imageNamed:@"guide_dot_white.png"];
//    _pageControl.imgSize = CGSizeMake(9, 9);
//    
//    [_pageControl setNumberOfPages:self.arrayForImg.childArray.count];
//    [_pageControl setCurrentPage:0];
    
    for (int index = 0; index < self.arrayForImg.childArray.count; index ++) {
        
        UrlImageView* imageView = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, 320,  productImageHeight)];
        imageView.clipsToBounds = YES;
        if (isRetina) {
            [imageView setImageWithURL:[NSURL URLWithString:[self ImageSize:[[self.arrayForImg objectAtIndex:index] BannerPic] Size:@"640x760"]] placeholderImage:[UIImage imageNamed:IMG_PlaceHolder_time]];
        }else{
            [imageView setImageWithURL:[NSURL URLWithString:[self ImageSize:[[self.arrayForImg objectAtIndex:index] BannerPic] Size:@"320x380"]] placeholderImage:[UIImage imageNamed:IMG_PlaceHolder_time]];
        }
        UIScrollView* svScan = [[UIScrollView alloc] initWithFrame:CGRectMake(320*index, 0, 320,  productImageHeight)];
        [svScan setShowsHorizontalScrollIndicator:NO];
        [svScan setShowsVerticalScrollIndicator:NO];
        [svScan setDelegate:self];
        svScan.tag = 10098;
        [imageView setTag:9712];
        [svScan setMaximumZoomScale:3.0];
        [svScan setContentSize:CGSizeMake(320,productImageHeight)];
        [svScan addSubview:imageView];
        
        
        [ImageScrollVIew addSubview:svScan];
    }
}

//lee注释掉，因为有可能导致崩溃
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.tag != 10098) {
//        NSInteger page = scrollView.contentOffset.x / ScreenWidth;
//        _pageControl.currentPage = page;
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    //    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    //    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ?
    //    scrollView.contentSize.width/2 : xcenter;
    //    //同上，此处修改y值
    //    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ?
    //    scrollView.contentSize.height/2 : ycenter;
    //    [[scrollView viewWithTag:9712] setCenter:CGPointMake(xcenter, ycenter)];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:9712];
}

#pragma mark -- 屏幕旋转
//iOS 5
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
//iOS 6
- (BOOL)shouldAutorotate
{
	return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationPortrait;
}

@end
