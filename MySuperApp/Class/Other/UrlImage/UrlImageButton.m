//
//  UrlImageButton.m
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UrlImageButton.h"
#import "SDWebImageManager.h"
#import "NSURLAdditions.h"

@implementation UrlImageButton

@synthesize iconIndex;
@synthesize picUrl;

@synthesize cellIndex;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        iconIndex = -1;
        frame_final=frame;
        isScale = NO;
    }
    return self;
}



- (void)setImage:(BOOL)animated withUrl:(NSString *)iconUrl withIsBkg:(BOOL)isBkg
{
    _animated = animated;
    _isBackgroundImage = isBkg;
    
    //lee999 容错，判断如果没有的话，不崩溃。
    if ([iconUrl description].length<1) {
        return;
    }
    
    picUrl = [[NSString alloc] initWithString:iconUrl];
    if(isBkg)
    {
        [self setBackgroundImage:[self getDefaultImage] forState:UIControlStateNormal];
    }
    else {
        [self setImage:[self getDefaultImage] forState:UIControlStateNormal];
    }
    
    NSURL* tempUrl = [NSURL URLWithString:iconUrl];
    
    NSURL* finallyUrl = nil;
    if([NSURL isWebURL:tempUrl])
    {
        finallyUrl = tempUrl;
    }
    else {
    }
    
    [self setImageWithURL:finallyUrl];
}

- (void) setBackgroundImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl
{
    [self setImage:animated withUrl:iconUrl withIsBkg:YES];
}

- (void) setImageFromUrl:(BOOL) animated withUrl:(NSString *)iconUrl
{
    [self performSelector:@selector(loadImage:) withObject:iconUrl afterDelay:0.1];
    
}
-(void)loadImage:(id)sender{
    NSString *icon=(NSString *)sender;
    [self setImage:NO withUrl:icon withIsBkg:NO];
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
    if(_isBackgroundImage)
    {
        if (placeholder) {
            [self setBackgroundImage:placeholder forState:UIControlStateNormal];
        }else
        {
            UIImage* image = [UIImage imageNamed:@"aimerLogoDefault"];
            if(image.size.width > self.frame.size.width)
            {
                [self setContentMode:UIViewContentModeScaleAspectFit];
            }else
            {
                [self setContentMode:UIViewContentModeCenter];
            }
            self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
            [self setBackgroundImage:image forState:UIControlStateNormal];
        }
    }
    else {
        if (placeholder) {
            [self setImage:placeholder forState:UIControlStateNormal];
        }else
        {
            UIImage* image = [UIImage imageNamed:@"aimerLogoDefault"];
            if(image.size.width > self.frame.size.width)
            {
                [self setContentMode:UIViewContentModeScaleAspectFit];
            }else
            {
                [self setContentMode:UIViewContentModeCenter];
            }
            self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
            [self setImage:image forState:UIControlStateNormal];
        }
    }
    
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
//    else if(frameSize.width ==55&&frameSize.height==55){
//        return [UIImage  imageNamed:@"55x55.png"];
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
//    else if(frameSize.width ==296&&frameSize.height==70){
//        return [UIImage  imageNamed:@"540-140.png"];
//    }
//    else if(frameSize.width ==65&&frameSize.height==85){
//        return [UIImage  imageNamed:@"pic60_80.png"];
//    }
//    
//    else if(frameSize.width ==145&&frameSize.height==93){
//        return [UIImage  imageNamed:@"145x95.png"];
//    }
//    else if(frameSize.width ==145*2&&frameSize.height==93*2){
//        return [UIImage  imageNamed:@"145x95.png"];
//        
//    }else if(frameSize.width ==ScreenWidth&&frameSize.height==150){
//        
//        return [UIImage  imageNamed:@"pic_default_mall_banner.png"];
//    }
    
    return nil;
}



#pragma mark -

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    if(_animated)
    {
        //self.frame=CGRectMake(frame_final.origin.x, frame_final.origin.y, 0, 0);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        //self.frame=frame_final;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
        //        self.frame=CGRectMake(frame_final.origin.x+frame_final.size.width/2, frame_final.origin.y+frame_final.size.height/2, 0, 0);
        //	    [UIView beginAnimations:nil context:nil];
        //	    [UIView setAnimationDuration:0.5];
        //        self.frame=frame_final;
        //        [UIView commitAnimations];
    }
    [self setContentMode:UIViewContentModeScaleToFill];
    if(_isBackgroundImage)
    {
        [self setBackgroundImage:image forState:UIControlStateNormal];
    }
    else {
        [self setImage:image forState:UIControlStateNormal];
    }
    
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
        rcTemp.size = CGSizeMake(lee1fitAllScreen(image.size.width), lee1fitAllScreen(image.size.height));
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
    //    //    self.image = [UIImage imageNamed:@""];
    //    UIImage* image = nil;
    //	CGSize frameSize = self.frame.size;
    //    if(frameSize.width == 24 &&frameSize.height == 32)
    //	{
    //		image = [UIImage  imageNamed:@"pic24_32.png"];
    //	}
    //	else if(frameSize.width == 90 && frameSize.height == 120){
    //		image = [UIImage  imageNamed:@"pic90_120.png"];
    //	}
    //	else if(frameSize.width ==30&&frameSize.height==30){
    //		image = [UIImage  imageNamed:@"pic30_30.png"];
    //	}
    //	else if(frameSize.width ==60 &&frameSize.height==30){
    //		image = [UIImage  imageNamed:@"pic60_30.png"];
    //	}
    //	else if(frameSize.width ==60&&frameSize.height==80){
    //		image = [UIImage  imageNamed:@"pic60_80.png"];
    //	}
    //    else if(frameSize.width ==64&&frameSize.height==64){
    //        image = [UIImage  imageNamed:@"pic64_64.png"];
    //	}
    //    else if(frameSize.width ==66&&frameSize.height==66){
    //		image = [UIImage  imageNamed:@"132-132.png"];
    //	}
    //    else if(frameSize.width ==80&&frameSize.height==50){
    //		image = [UIImage  imageNamed:@"pic80_50.png"];
    //	}
    //    else if(frameSize.width ==100&&frameSize.height==33){
    //		image = [UIImage  imageNamed:@"pic100_33.png"];
    //	}
    //    else if(frameSize.width ==101&&frameSize.height==54){
    //		image = [UIImage  imageNamed:@"pic101_54.png"];
    //	}
    //    else if(frameSize.width ==130&&frameSize.height==130){
    //		image = [UIImage  imageNamed:@"260-260.png"];
    //	}
    //    else if(frameSize.width ==150&&frameSize.height==200){
    //		image = [UIImage  imageNamed:@"pic150_200.png"];
    //	}
    //    else if(frameSize.width ==154&&frameSize.height==80){
    //		image = [UIImage  imageNamed:@"pic310_150.png"];
    //	}
    //    else if(frameSize.width ==180&&frameSize.height==240){
    //		image = [UIImage  imageNamed:@"360-480.png"];
    //	}
    //    else if(frameSize.width ==220&&frameSize.height==300){
    //		image = [UIImage  imageNamed:@"pic220_300.png"];
    //	}
    //    else if(frameSize.width ==222&&frameSize.height==211){
    //		image = [UIImage  imageNamed:@"pic222_211.png"];
    //	}
    //    else if(frameSize.width ==270&&frameSize.height==361){
    //		image = [UIImage  imageNamed:@"pic270_360.png"];
    //	}
    //    else if(frameSize.width ==270&&frameSize.height==70){
    //		image = [UIImage  imageNamed:@"540-140.png"];
    //	}
    //    else if(frameSize.width ==305&&frameSize.height==99){
    //		image = [UIImage  imageNamed:@"pic305_100.png"];
    //	}
    //    else if(frameSize.width ==305&&frameSize.height==140){
    //		image = [UIImage  imageNamed:@"pic305_140.png"];
    //	}
    //    else if(frameSize.width ==310&&frameSize.height==150){
    //		image = [UIImage  imageNamed:@"pic310_150.png"];
    //	}
    //    else if(frameSize.width ==310&&frameSize.height==93){
    //		image = [UIImage  imageNamed:@"pic305_100.png"];
    //	}
    //    else if(frameSize.width ==76&&frameSize.height==102){
    //		image = [UIImage  imageNamed:@"pic90_120.png"];
    //	}
    //    else if(frameSize.width ==60&&frameSize.height==40){
    //		image = [UIImage  imageNamed:@"pic60_40.png"];
    //	}
    //    else if(frameSize.width ==90&&frameSize.height==60){
    //		image = [UIImage  imageNamed:@"pic90_60.png"];
    //	}
    //    else if(frameSize.width ==120&&frameSize.height==160){
    //		image = [UIImage  imageNamed:@"pic120_160.png"];
    //	}
    //    else if(frameSize.width ==200&&frameSize.height==90){
    //		image = [UIImage  imageNamed:@"pic200_90.png"];
    //	}
    //    else if(frameSize.width ==55&&frameSize.height==55){
    //		image = [UIImage  imageNamed:@"55x55.png"];
    //	}
    //    else if(frameSize.width ==296&&frameSize.height==70){
    //		image = [UIImage  imageNamed:@"540-140.png"];
    //	}
    //    else if(frameSize.width ==65&&frameSize.height==85){
    //		image = [UIImage  imageNamed:@"pic60_80.png"];
    //	}
    //    if(_isBackgroundImage)
    //	{
    //	    [self setBackgroundImage:image forState:UIControlStateNormal];
    //	}
    //	else {
    //		[self setImage:image forState:UIControlStateNormal];
    //	}
    //	if(_animated)
    //	{
    //		[UIView commitAnimations];
    //	}
}


@end
