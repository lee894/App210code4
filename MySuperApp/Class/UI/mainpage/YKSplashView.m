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
#import "JSON.h"



@implementation YKSplashView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //先判断是否是第一次使用
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        NSString* strFileName = @"s1136";
        //[NSString stringWithFormat:@"s%.0f", [UIScreen mainScreen].bounds.size.height * 2];
        
        if (![YKSplashView getIsOpenGuideView]) {
            //加载引导图
            //            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            
            _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
            _scrollView.delegate = self;
            _scrollView.bounces = NO;
            [_scrollView setShowsHorizontalScrollIndicator:NO];
            [_scrollView setShowsVerticalScrollIndicator:NO];
            [_scrollView setPagingEnabled:YES];
            [self addSubview:_scrollView];
            [self loadView];
            //如果第一次显示引导图 也要下载广告图
            NSString* strAdPic = @"";
            NSStringEncoding chineseEnc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString* str = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:SPlashViewUrl] encoding:chineseEnc error:nil];
            if ([str rangeOfString:@"{"].location != NSNotFound) {
                NSString* adPic = [str substringWithRange:NSMakeRange([str rangeOfString:@"{"].location, [str rangeOfString:@"}"].location - [str rangeOfString:@"{"].location + 1)];
                NSDictionary* adPicDic = [adPic JSONValue];
                if ([[adPicDic allKeys] containsObject:strFileName]) {
                    //有对应key 取值 值为ad图的url
                    strAdPic = [adPicDic objectForKey:strFileName];
                }
            }
            if (strAdPic.length > 0) {
                //本地无缓存 下载图片 储存至本地 跳过本页面
                dispatch_queue_t network_queue = dispatch_queue_create("adPic", nil);
                dispatch_async(network_queue, ^{
                    NSData* dzPic = [NSData dataWithContentsOfURL:[NSURL URLWithString:strAdPic]];
                    if (dzPic) {
                        NSDictionary* picDic = [NSDictionary dictionaryWithObject:dzPic forKey:strAdPic];
                        if (picDic) {
                            [picDic writeToFile:[documentsDirectory stringByAppendingPathComponent:strFileName] atomically:YES];
                        }
                    }
                } );
            }
        }else{
            //广告图
            NSString* strAdPic = @"";
            NSStringEncoding chineseEnc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString* str = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:SPlashViewUrl] encoding:chineseEnc error:nil];
            if ([str rangeOfString:@"{"].location != NSNotFound) {
                NSString* adPic = [str substringWithRange:NSMakeRange([str rangeOfString:@"{"].location, [str rangeOfString:@"}"].location - [str rangeOfString:@"{"].location + 1)];
                NSDictionary* adPicDic = [adPic JSONValue];
                if ([[adPicDic allKeys] containsObject:strFileName]) {
                    //有对应key 取值 值为ad图的url
                    strAdPic = [adPicDic objectForKey:strFileName];
                }
            }
            if (strAdPic.length > 0) {
                //获取到对应屏幕的广告图 图片地址
                if ([AppDelegate isFileExist:strFileName]) {
                    //本地有广告图缓存
                    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:strFileName]];
                    
                    if ([[dict allKeys] containsObject:strAdPic]) {
                        //广告图没换 直接本地读取 2秒后消失
                        NSData* picData = (NSData*)[dict objectForKey:strAdPic];
                        UIImage* image = [UIImage imageWithData:picData];
                        UIImageView* iv = [[UIImageView alloc] initWithFrame:self.frame];
                        [iv setImage:image];
                        [self addSubview:iv];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self btnGuideClick:nil];
                        });
                    }
                    else
                    {
                        //广告图换了 本地读取展示 2秒消失 后台下载新图片 下载完成后 清理本地缓存文件
                        
                        NSData* picData = (NSData*)[dict objectForKey:[[dict allKeys] firstObject]];
                        UIImage* image = [UIImage imageWithData:picData];
                        UIImageView* iv = [[UIImageView alloc] initWithFrame:self.frame];
                        [iv setImage:image];
                        [self addSubview:iv];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self btnGuideClick:nil];
                        });
                        dispatch_queue_t network_queue;
                        network_queue = dispatch_queue_create("adPic", nil);
                        dispatch_async(network_queue, ^{
                            NSData* dzPic = [NSData dataWithContentsOfURL:[NSURL URLWithString:strAdPic]];
                            if (dzPic) {
                                NSDictionary* picDic = [NSDictionary dictionaryWithObject:dzPic forKey:strAdPic];
                                if (picDic) {
                                    [picDic writeToFile:[documentsDirectory stringByAppendingPathComponent:strFileName] atomically:YES];
                                }
                            }
                        } );
                    }
                }else
                {
                    //本地无缓存 下载图片 储存至本地 跳过本页面
                    dispatch_queue_t network_queue;
                    network_queue = dispatch_queue_create("adPic", nil);
                    dispatch_async(network_queue, ^{
                        NSData* dzPic = [NSData dataWithContentsOfURL:[NSURL URLWithString:strAdPic]];
                        if (dzPic) {
                            NSDictionary* picDic = [NSDictionary dictionaryWithObject:dzPic forKey:strAdPic];
                            if (picDic) {
                                [picDic writeToFile:[documentsDirectory stringByAppendingPathComponent:strFileName] atomically:YES];
                            }
                        }
                    } );
                    [self btnGuideClick:nil];
                }
            }
            else
            {
                [self btnGuideClick:nil];
            }
        }
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
    
    if (index == 2) {//最后一页
        
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
    
    [self setBackgroundColor:[UIColor clearColor]];
    
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
