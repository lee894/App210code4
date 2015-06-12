//
//  YKSplashView.m
//  LafasoGroupBuy
//
//  Created by HQS on 12-10-30.
//
//

#import "YKSplashView.h"
#import "MYMacro.h"
#import "AppDelegate.h"


@implementation YKSplashView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setPagingEnabled:YES];
        [self addSubview:_scrollView];
        
//        _pageControl = [[BluePageControl alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
//        [_pageControl  setBackgroundColor:[UIColor clearColor]];
//        _pageControl.center = CGPointMake(ScreenHeight/2, 320-10);
//        [self addSubview:_pageControl];
//        _pageControl.activeImage = [UIImage imageNamed:@"guide_dot_red.png"];
//        _pageControl.inactiveImage = [UIImage imageNamed:@"guide_dot_white.png"];
//        _pageControl.imgSize = CGSizeMake(9, 9);
        [self loadView];
        
    }
    return self;
}


+ (BOOL)getIsOpenGuideView
{
    BOOL isOneOpen = [[NSUserDefaults standardUserDefaults] boolForKey:@"ishasOpenapp"];
    
    return isOneOpen;
}

- (void)rectTextWithIndex:(NSInteger)index isPhone5H:(BOOL)states imgView:(UIImageView *)theImgView
{
    theImgView.userInteractionEnabled = YES;
    
//    CGRect rect;
//    UIImageView *imgView = [[UIImageView alloc] init];
//    CGSize size = CGSizeMake(288/2, 126/2);
//    switch (index) {
//        case 0:
//            if (states) {//是iPhone5
//                rect = CGRectMake(736/2, 338/2, 0, 0);
//            } else {
//                rect = CGRectMake(568/2, 338/2, 0, 0);
//            }
//            break;
//        case 1:
//            if (states) {//是iPhone5
//                rect = CGRectMake(60/2, 290/2, 0, 0);
//            } else {
//                rect = CGRectMake(26/2, 290/2, 0, 0);
//            }
//            break;
//        case 2:
//            if (states) {//是iPhone5
//                rect = CGRectMake(526/2, 228/2, 0, 0);
//            } else {
//                rect = CGRectMake(440/2, 228/2, 0, 0);
//            }
//            break;
//        case 3:
//            size = CGSizeMake(382/2, 48/2);
//            if (states) {//是iPhone5
//                rect = CGRectMake(640/2, 478/2, 0, 0);
//            } else {
//                rect = CGRectMake(498/2, 478/2, 0, 0);
//            }
//            break;
//        default:
//            break;
//    }
    
    //引导图上的文字
//    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_0%d_word.png",index+1]];
//    rect.size = size;
//    imgView.frame = rect;
//    [theImgView addSubview:imgView];
    
    if (index == 2) {//最后一页
//        CGRect btnRect = CGRectMake(0, 478/2, 200/2, 100/2);
////        imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_start_logo.png"]];
//        if (states) {//是iPhone5
////            rect = CGRectMake(792/2, 34/2, 288/2, 72/2);
//            btnRect.origin.x = 1030/2;
//        } else {
//            btnRect.origin.x = 884/2;
////            rect = CGRectMake(648/2, 34/2, 288/2, 72/2);
//        }
//        imgView.frame = rect;
//        [theImgView addSubview:imgView];
        
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [clickBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        clickBtn.frame = self.frame;
        [clickBtn addTarget:self action:@selector(btnGuideClick:) forControlEvents:UIControlEventTouchUpInside];
        [theImgView addSubview:clickBtn];
    }
    
}

//登录主界面
- (void)btnGuideClick:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ishasOpenapp"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app createAKtableBar];
    [self removeFromSuperview];
}

- (void)loadView
{
    int num = 3;
    [_pageControl setNumberOfPages:num];
    [_pageControl setCurrentPage:0];
    
    
    for (int i = 0 ; i < num; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        NSString *tmpImgName = @"";
        if (isiPhone5) {
            [self rectTextWithIndex:i isPhone5H:YES imgView:imgView];
            tmpImgName = [NSString stringWithFormat:@"guide_0%d_6401136.jpg",i+1];
        } else {
            [self rectTextWithIndex:i isPhone5H:NO imgView:imgView];
            tmpImgName = [NSString stringWithFormat:@"guide_0%d_640960.jpg",i+1];
        }
        imgView.image = [UIImage imageNamed:tmpImgName];
        [_scrollView addSubview:imgView];
    }
    
    [_scrollView setContentSize:CGSizeMake(ScreenWidth*num, 320)];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / ScreenWidth;
    //    if (page < 3) {
    [_pageControl setHidden:NO];
    _pageControl.currentPage = page;
    //    } else {
    //        [_pageControl setHidden:YES];
    //    }
}

//登录主界面
-(void)gotoMainView{
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app finalLoadMainView];

}

@end
