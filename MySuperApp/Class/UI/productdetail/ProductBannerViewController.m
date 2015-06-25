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
    
    //[ImageScrollVIew setContentOffset:CGPointMake(ScreenWidth*self.indexPage, 0)];
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
    
    
    
    ImageScrollVIew.contentSize = CGSizeMake(ScreenWidth*self.arrayForImg.childArray.count, productImageHeight);
    
    NSLog(@"self.view.frame is %@",NSStringFromCGRect(self.view.frame));
    NSLog(@"self.view.bounds is %@",NSStringFromCGRect(self.view.bounds));
    
    //lee999 增加适配IPhone 4寸屏幕
    if (IS4InchScreen) {
        CGRect oldsize = ImageScrollVIew.frame;
        oldsize.origin.y = 30;
        [ImageScrollVIew setFrame:oldsize];
    }
    
    for (int index = 0; index < self.arrayForImg.childArray.count; index ++) {
        
        UrlImageView* imageView = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,  productImageHeight)];
        imageView.clipsToBounds = YES;
        if (isRetina) {
            [imageView setImageWithURL:[NSURL URLWithString:[self ImageSize:[[self.arrayForImg objectAtIndex:index] BannerPic] Size:@"640x760"]] placeholderImage:nil];
        }else{
            [imageView setImageWithURL:[NSURL URLWithString:[self ImageSize:[[self.arrayForImg objectAtIndex:index] BannerPic] Size:@"320x380"]] placeholderImage:nil];
        }
        UIScrollView* svScan = [[UIScrollView alloc] initWithFrame:CGRectMake(ScreenWidth*index, 0, ScreenWidth,  productImageHeight)];
        [svScan setShowsHorizontalScrollIndicator:NO];
        [svScan setShowsVerticalScrollIndicator:NO];
        [svScan setDelegate:self];
        svScan.tag = 10098;
        [imageView setTag:9712];
        [svScan setMaximumZoomScale:3.0];
        [svScan setContentSize:CGSizeMake(ScreenWidth,productImageHeight)];
        [svScan addSubview:imageView];
        
        
        [ImageScrollVIew addSubview:svScan];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
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
