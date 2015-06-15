//
//  UrlImageButton.m
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UrlImageView.h"
#import "NSURLAdditions.h"
#import "UIColorAdditions.h"
#import "SDWebImageManager.h"
#import "MYMacro.h"
@interface UIImage (scale)

-(UIImage*)scaleToSize:(CGSize)size;

@end

@implementation UIImage (scale)

-(UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end

@implementation UrlImageView

@synthesize iconIndex;
@synthesize _animated;
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        iconIndex = -1;
        frame_final=frame;
        isScale= NO;
        _animated = NO;
        scaleSize = CGSizeZero;
    }
    return self;
}

-(void)setDefaultImage:(UIImage*)image{
    defaultImg = image;
}


-(UIImage*) getDefaultImage
{
//    CGSize frameSize = self.frame.size;
//    if(frameSize.width == 24 &&frameSize.height == 32)
//    {
//        return [UIImage  imageNamed:@"pic24_32.png"];
//    }
//    else if(frameSize.width == 90 && frameSize.height == 120){
//        return [UIImage  imageNamed:@"pic90_120.png"];
//    }
//    else if(frameSize.width ==30&&frameSize.height==30){
//        return [UIImage  imageNamed:@"pic30_30.png"];
//    }
//    else if(frameSize.width ==60 &&frameSize.height==30){
//        return [UIImage  imageNamed:@"pic60_30.png"];
//    }
//    else if(frameSize.width ==60&&frameSize.height==80){
//        return [UIImage  imageNamed:@"pic60_80.png"];
//    }
//    else if(frameSize.width ==65&&frameSize.height==85){
//        return [UIImage  imageNamed:@"pic60_80.png"];
//    }
//    else if(frameSize.width ==64&&frameSize.height==64){
//        return [UIImage  imageNamed:@"pic64_64.png"];
//    }
//    else if(frameSize.width ==66&&frameSize.height==66){
//        return [UIImage  imageNamed:@"132-132.png"];
//    }
//    else if(frameSize.width ==80&&frameSize.height==50){
//        return [UIImage  imageNamed:@"pic80_50.png"];
//    }
//    else if(frameSize.width ==100&&frameSize.height==33){
//        return [UIImage  imageNamed:@"pic100_33.png"];
//    }
//    else if(frameSize.width ==101&&frameSize.height==54){
//        return [UIImage  imageNamed:@"pic101_54.png"];
//    }
//    else if(frameSize.width ==130&&frameSize.height==130){
//        return [UIImage  imageNamed:@"260-260.png"];
//    }
//    else if(frameSize.width ==150&&frameSize.height==200){
//        return [UIImage  imageNamed:@"pic150_200.png"];
//    }
//    else if(frameSize.width ==154&&frameSize.height==80){
//        return [UIImage  imageNamed:@"pic310_150.png"];
//    }
//    else if(frameSize.width ==180&&frameSize.height==240){
//        return [UIImage  imageNamed:@"360-480.png"];
//    }
//    else if(frameSize.width ==220&&frameSize.height==300){
//        return [UIImage  imageNamed:@"pic220_300.png"];
//    }
//    else if(frameSize.width ==222&&frameSize.height==211){
//        return [UIImage  imageNamed:@"pic222_211.png"];
//    }
//    else if(frameSize.width ==270&&frameSize.height==361){
//        return [UIImage  imageNamed:@"pic270_360.png"];
//    }
//    else if(frameSize.width ==270&&frameSize.height==70){
//        return [UIImage  imageNamed:@"540-140.png"];
//    }
//    else if(frameSize.width ==305&&frameSize.height==99){
//        return [UIImage  imageNamed:@"pic305_100.png"];
//    }
//    else if(frameSize.width ==305&&frameSize.height==140){
//        return [UIImage  imageNamed:@"pic305_140.png"];
//    }
//    else if(frameSize.width ==310&&frameSize.height==150){
//        return [UIImage  imageNamed:@"pic310_150.png"];
//    }
//    else if(frameSize.width ==310&&frameSize.height==93){
//        return [UIImage  imageNamed:@"pic305_100.png"];
//    }
//    else if(frameSize.width ==76&&frameSize.height==102){
//        return [UIImage  imageNamed:@"pic90_120.png"];
//    }
//    else if(frameSize.width ==60&&frameSize.height==40){
//        return [UIImage  imageNamed:@"pic60_40.png"];
//    }
//    else if(frameSize.width ==90&&frameSize.height==60){
//        return [UIImage  imageNamed:@"pic90_60.png"];
//    }
//    else if(frameSize.width ==120&&frameSize.height==160){
//        return [UIImage  imageNamed:@"pic120_160.png"];
//    }
//    else if(frameSize.width ==200&&frameSize.height==90){
//        return [UIImage  imageNamed:@"pic200_90.png"];
//    }
//    else if(frameSize.width ==55&&frameSize.height==55){
//        return [UIImage  imageNamed:@"55x55.png"];
//    }
//    else if(frameSize.width ==296&&frameSize.height==70){
//        return [UIImage  imageNamed:@"540-140.png"];
//    }
//    
//    else if(frameSize.width ==145&&frameSize.height==93){
//        return [UIImage  imageNamed:@"145x95.png"];
//    }
//    else if(frameSize.width ==145*2&&frameSize.height==93*2){
//        return [UIImage  imageNamed:@"145x95.png"];
//    }
//    //专辑的最下面的图片
//    else if (frameSize.width ==300&&frameSize.height==50){
//        return [UIImage  imageNamed:@"pic_default_notice_banner.png"];
//    }
//    //首页banner
//    else if (frameSize.width ==320&&frameSize.height==320){
//        return [UIImage  imageNamed:@"pic_default2.png"];
//    }
//    //首页banner
//    else if (frameSize.width ==320&&frameSize.height==325){
//        return [UIImage  imageNamed:@"pic_default2.png"];
//    }
//    
//    //增加不需要背景图的可能
//    if (self.tag == 999) {
//        return nil;
//    }
    //lee新增
    return nil;
    
}


- (void) setImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl;
{
    
    _animated = animated;
    
    NSURL* tempUrl = [NSURL URLWithString:iconUrl];
    
    
    NSURL* finallyUrl = nil;
    if([NSURL isWebURL:tempUrl])
    {
        finallyUrl = tempUrl;
    }
    else {
    }
    
    
    [self setImageWithURL:finallyUrl placeholderImage:[self getDefaultImage]];
    
}

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:[self getDefaultImage]];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    if (placeholder) {
        self.image = placeholder;
    }else
    {
        self.image = [UIImage imageNamed:@"aimerLogoDefault"];
        if(self.image.size.width > self.frame.size.width)
        {
            [self setContentMode:UIViewContentModeScaleAspectFit];
        }else
        {
            [self setContentMode:UIViewContentModeCenter];
        }
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    }
    
    _animated=NO;
    if (url)
    {
        url = [self getChangedURL:url];
        [manager downloadWithURL:url delegate:self];
    }
    
}

-(NSURL*)getChangedURL:(NSURL*)url
{
    NSMutableString *strUrl = [NSMutableString stringWithString:url.absoluteString];
    //    if (!isRetina) {
    //        return url;
    //    }
    if (![strUrl hasPrefix:@"http://"]) {
        return url;
    }
    NSArray *array = [strUrl componentsSeparatedByString:@"/"];
    if ([array count] > 1) {
        NSString *strDest = [array objectAtIndex:[array count] - 2];
        if (!sizeArray) {
            [self initArray];
        }
        if ([sizeArray containsObject:strDest]) {
            NSRange range = [strUrl rangeOfString:strDest];
            NSInteger index = [sizeArray indexOfObject:strDest];
            [strUrl replaceCharactersInRange:range withString:[sizeDestArray objectAtIndex:index]];
        }
    }
    
    return (NSURL*)[NSURL URLWithString:strUrl];
}

-(void)initArray
{
    if (!sizeArray) {
        sizeArray = [[NSArray alloc] initWithObjects:@"ZoomImage",@"DetailImage",@"BigImage",@"NormalImage",@"ViewImage",@"SmallImage",@"ColorImage",@"ShowCaseImage",@"GridImage",@"LargeImage", nil];
    }
    
    if (!sizeDestArray) {
        sizeDestArray = [[NSArray alloc] initWithObjects:@"ZoomImage", @"ZoomImage", @"DetailImage", @"LargeImage", @"BigImage", @"ViewImage", @"SmallImage", @"GridImage", @"LargeImage", @"ZoomImage", nil];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

-(void)scaleToSize:(CGSize)size
{
    isScale= YES;
    scaleSize =size;
    UIImage* newImage = [self.image scaleToSize:size];
    self.image = newImage;
}


- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    if(_animated)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
        
        ////		[UIView beginAnimations:nil context:nil];
        ////		[UIView setAnimationDuration:1.0];
        ////		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
        //        self.frame=CGRectMake(frame_final.origin.x+frame_final.size.width/2, frame_final.origin.y+frame_final.size.height/2, 0, 0);
        //	    [UIView beginAnimations:nil context:nil];
        //	    [UIView setAnimationDuration:0.5];
        //        self.frame=frame_final;
        //	    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
        //        [UIView commitAnimations];
    }
    
    [self setContentMode:UIViewContentModeScaleToFill];
    self.image = image;
    
    if(_animated)
    {
        [UIView commitAnimations];
    }
    if ([NSStringFromCGSize(self.frame.size) isEqualToString:NSStringFromCGSize(CGRectZero.size)]) {
        if (self.contentMode != UIViewContentModeScaleToFill) {
            CGRect rcTemp = self.frame;
            rcTemp.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
            self.frame = rcTemp;
            return;
        }
        CGRect rcTemp = self.frame;
        rcTemp.size = CGSizeMake(lee1fitAllScreen(self.image.size.width), lee1fitAllScreen(self.image.size.height));
        self.frame = rcTemp;
    }
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error
{
    
    //    if(_animated)
    //	{
    //		[UIView beginAnimations:nil context:nil];
    //		[UIView setAnimationDuration:1.0];
    //		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
    //	}
    ////    self.image = [UIImage imageNamed:@""];
    //	CGSize frameSize = self.frame.size;
    //    if(frameSize.width == 24 &&frameSize.height == 32)
    //	{
    //		self.image = [UIImage  imageNamed:@"pic24_32.png"];
    //	}
    //	else if(frameSize.width == 90 && frameSize.height == 120){
    //		self.image = [UIImage  imageNamed:@"pic90_120.png"];
    //	}
    //	else if(frameSize.width ==30&&frameSize.height==30){
    //		self.image = [UIImage  imageNamed:@"pic30_30.png"];
    //	}
    //	else if(frameSize.width ==60 &&frameSize.height==30){
    //		self.image = [UIImage  imageNamed:@"pic60_30.png"];
    //	}
    //	else if(frameSize.width ==60&&frameSize.height==80){
    //		self.image = [UIImage  imageNamed:@"pic60_80.png"];
    //	}
    //    else if(frameSize.width ==64&&frameSize.height==64){
    //		self.image = [UIImage  imageNamed:@"pic64_64.png"];
    //	}
    //    else if(frameSize.width ==66&&frameSize.height==66){
    //		self.image = [UIImage  imageNamed:@"132-132.png"];
    //	}
    //    else if(frameSize.width ==80&&frameSize.height==50){
    //		self.image = [UIImage  imageNamed:@"pic80_50.png"];
    //	}
    //    else if(frameSize.width ==100&&frameSize.height==33){
    //		self.image = [UIImage  imageNamed:@"pic100_33.png"];
    //	}
    //    else if(frameSize.width ==101&&frameSize.height==54){
    //		self.image = [UIImage  imageNamed:@"pic101_54.png"];
    //	}
    //    else if(frameSize.width ==130&&frameSize.height==130){
    //		self.image = [UIImage  imageNamed:@"260-260.png"];
    //	}
    //    else if(frameSize.width ==150&&frameSize.height==200){
    //		self.image = [UIImage  imageNamed:@"pic150_200.png"];
    //	}
    //    else if(frameSize.width ==154&&frameSize.height==80){
    //		self.image = [UIImage  imageNamed:@"pic310_150.png"];
    //	}
    //    else if(frameSize.width ==180&&frameSize.height==240){
    //		self.image = [UIImage  imageNamed:@"360-480.png"];
    //	}
    //    else if(frameSize.width ==220&&frameSize.height==300){
    //		self.image = [UIImage  imageNamed:@"pic220_300.png"];
    //	}
    //    else if(frameSize.width ==222&&frameSize.height==211){
    //		self.image = [UIImage  imageNamed:@"pic222_211.png"];
    //	}
    //    else if(frameSize.width ==270&&frameSize.height==361){
    //		self.image = [UIImage  imageNamed:@"pic270_360.png"];
    //	}
    //    else if(frameSize.width ==55&&frameSize.height==55){
    //		self.image = [UIImage  imageNamed:@"55x55.png"];
    //	}
    //    else if(frameSize.width ==270&&frameSize.height==70){
    //		self.image = [UIImage  imageNamed:@"540-140.png"];
    //	}
    //    else if(frameSize.width ==296&&frameSize.height==70){
    //		self.image = [UIImage  imageNamed:@"540-140.png"];
    //	}
    //    else if(frameSize.width ==305&&frameSize.height==99){
    //		self.image = [UIImage  imageNamed:@"pic305_100.png"];
    //	}
    //    else if(frameSize.width ==305&&frameSize.height==140){
    //		self.image = [UIImage  imageNamed:@"pic305_140.png"];
    //	}
    //    else if(frameSize.width ==310&&frameSize.height==150){
    //		self.image = [UIImage  imageNamed:@"pic310_150.png"];
    //	}
    //    else if(frameSize.width ==310&&frameSize.height==93){
    //		self.image = [UIImage  imageNamed:@"pic305_100.png"];
    //	}
    //    else if(frameSize.width ==76&&frameSize.height==102){
    //		self.image = [UIImage  imageNamed:@"pic90_120.png"];
    //	}
    //    else if(frameSize.width ==60&&frameSize.height==40){
    //		self.image = [UIImage  imageNamed:@"pic60_40.png"];
    //	}
    //    else if(frameSize.width ==90&&frameSize.height==60){
    //		self.image = [UIImage  imageNamed:@"pic90_60.png"];
    //	}
    //    else if(frameSize.width ==120&&frameSize.height==160){
    //		self.image = [UIImage  imageNamed:@"pic120_160.png"];
    //	}
    //    else if(frameSize.width ==200&&frameSize.height==90){
    //		self.image = [UIImage  imageNamed:@"pic200_90.png"];
    //	}
    //    else if(frameSize.width ==65&&frameSize.height==85){
    //		self.image = [UIImage  imageNamed:@"pic60_80.png"];
    //	}
    //	if(_animated)
    //	{
    //		[UIView commitAnimations];	
    //	}
}


@end
