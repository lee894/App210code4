////
////  YKCoverFlow.m
////  YKTemplateIOS5
////
////  Created by jiang bonan on 12-2-2.
////  Copyright 2012年 __MyCompanyName__. All rights reserved.
////
//
////#import "YKImageMacro.h"
////#import "YKMacroImage.h"
//#import "YKCoverFlow.h"
////#import "YKDetailScrollView_fix2.h"
////#import "YKKillScrollView_fix2.h"
//
//@implementation UIImage (AFUIImageReflection)
//
//- (UIImage *)addImageReflection:(CGFloat)reflectionFraction {
//	int reflectionHeight = self.size.height * reflectionFraction;
//	
//    // create a 2 bit CGImage containing a gradient that will be used for masking the
//    // main view content to create the 'fade' of the reflection.  The CGImageCreateWithMask
//    // function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
//	CGImageRef gradientMaskImage = NULL;
//	
//    // gradient is always black-white and the mask must be in the gray colorspace
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
//    
//    // create the bitmap context
//    CGContextRef gradientBitmapContext = CGBitmapContextCreate(nil, 1, reflectionHeight,
//                                                               8, 0, colorSpace, kCGImageAlphaNone);
//    
//    // define the start and end grayscale values (with the alpha, even though
//    // our bitmap context doesn't support alpha the gradient requires it)
//    CGFloat colors[] = {0.0, 1.0, 1.0, 1.0};
//    
//    // create the CGGradient and then release the gray color space
//    CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
//    CGColorSpaceRelease(colorSpace);
//    
//    // create the start and end points for the gradient vector (straight down)
//    CGPoint gradientStartPoint = CGPointMake(0, reflectionHeight);
//    CGPoint gradientEndPoint = CGPointZero;
//    
//    // draw the gradient into the gray bitmap context
//    CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint,
//                                gradientEndPoint, kCGGradientDrawsAfterEndLocation);
//	CGGradientRelease(grayScaleGradient);
//	
//	// add a black fill with 50% opacity
//	CGContextSetGrayFillColor(gradientBitmapContext, 0.0, 0.5);
//	CGContextFillRect(gradientBitmapContext, CGRectMake(0, 0, 1, reflectionHeight));
//    
//    // convert the context into a CGImageRef and release the context
//    gradientMaskImage = CGBitmapContextCreateImage(gradientBitmapContext);
//    CGContextRelease(gradientBitmapContext);
//	
//    // create an image by masking the bitmap of the mainView content with the gradient view
//    // then release the  pre-masked content bitmap and the gradient bitmap
//    CGImageRef reflectionImage = CGImageCreateWithMask(self.CGImage, gradientMaskImage);
//    CGImageRelease(gradientMaskImage);
//	
//	CGSize size = CGSizeMake(self.size.width, self.size.height + reflectionHeight);
//	
//	UIGraphicsBeginImageContext(size);
//	
//	[self drawAtPoint:CGPointZero];
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	CGContextDrawImage(context, CGRectMake(0, self.size.height, self.size.width, reflectionHeight), reflectionImage);
//	
//	UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//    CGImageRelease(reflectionImage);
//	
//	return result;
//}
//@end
//
//@implementation YKCoverFlow
//@synthesize delegate_cf;
//@synthesize dataSource_cf;
//@synthesize type;
//@synthesize carousel;
//
//- (id)initWithFrame:(CGRect)frame andCoverFlowType:(YKCoverFlowType)_type andWrap:(BOOL)_wrap andDelegate:(id<YKCoverFlowDelegate>)_delegate_cf andDataSource:(id<YKCoverFlowDataSource>)_dataSource_cf andCurIndex:(NSInteger)_curIndex
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        //        [self setBackgroundColor:[UIColor blueColor]];
//        type = _type;
//        wrap = _wrap;
//        delegate_cf = _delegate_cf;
//        dataSource_cf = _dataSource_cf;
//        carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        carousel.delegate = self;
//        carousel.dataSource = self;
//        //        if ([delegate_cf isKindOfClass:[YKDetailScrollView_fix2 class]] || [delegate_cf isKindOfClass:[YKKillScrollView_fix2 class]])
//        //        {
//        //            carousel.select_move = YES;
//        //        }
//        carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        switch (type) {
//            case YKCoverFlowTypeBanner:
//                carousel.type = iCarouselTypeLinear;
//                [carousel setScrollSpeed:0.0f];
//                break;
//            case YKCoverFlowTypeCoverFlow:
//                carousel.type = iCarouselTypeRotary;
//                break;
//            case YKCoverFlowTypeDetailProductList:
//                carousel.type = iCarouselTypeLinear;
//                [carousel setScrollSpeed:0.0f];
//                break;
//            case YKCoverFlowTypeBannerOne:
//                carousel.type = iCarouselTypeLinear;
//                [carousel setScrollSpeed:0.0f];
//                break;
//            default:
//                break;
//        }
//        [self insertSubview:carousel atIndex:0];
//        [carousel release];
//        [carousel scrollToItemAtIndex:_curIndex animated:NO];
//        if (type == YKCoverFlowTypeBanner) {
//            if (dataSource_cf && [dataSource_cf respondsToSelector:@selector(timeIntervalOfBanner:)]) {
//                timer = [NSTimer scheduledTimerWithTimeInterval:[dataSource_cf timeIntervalOfBanner:self] target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//            }
//        }
//        if (dataSource_cf && [dataSource_cf respondsToSelector:@selector(originOfPageControlInBanner:)]) {
//            pc = [[YKPageControl alloc] initWithDataSource:self];
//            [self insertSubview:pc atIndex:1];
//            [pc release];
//        }
//    }
//    return self;
//}
//
//-(void)timerAction
//{
//    [carousel scrollToItemAtIndex:carousel.currentItemIndex + 1 animated:YES];
//}
//
//-(void)killTimer
//{
//    if (type == YKCoverFlowTypeBanner) {
//        [timer invalidate];
//    }
//}
//
//#pragma mark -
//#pragma mark iCarousel methods
//
//- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
//{
//    if (dataSource_cf && [dataSource_cf respondsToSelector:@selector(numberOfItemsInCoverFlow:)]) {
//        return [dataSource_cf numberOfItemsInCoverFlow:self];
//    }
//    return 0;
//}
//
//- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
//{
//    if (delegate_cf && [delegate_cf respondsToSelector:@selector(coverFlow:viewForItemAtIndex:)]) {
//        return [delegate_cf coverFlow:self viewForItemAtIndex:index];
//    }
//    return nil;
//    
//    //    if (USE_BUTTONS)
//    //    {
//    //        //create a numbered button
//    //        //        UIImage *image = [UIImage imageNamed:@"page.png"];
//    //        //        UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)] autorelease];
//    //        //        [button setBackgroundImage:image forState:UIControlStateNormal];
//    //        UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 133)] autorelease];
//    //        [button setBackgroundColor:[UIColor whiteColor]];
//    //        [button setTitle:[[items objectAtIndex:index] stringValue] forState:UIControlStateNormal];
//    //        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //        button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
//    //        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    //        button.tag = index;
//    //        return button;
//    //    }
//    //    else
//    //    {
//    //        //create a numbered view
//    //        UIView *view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page.png"]] autorelease];
//    //        UILabel *label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
//    //        label.text = [[items objectAtIndex:index] stringValue];
//    //        label.backgroundColor = [UIColor clearColor];
//    //        label.textAlignment = UITextAlignmentCenter;
//    //        label.font = [label.font fontWithSize:50];
//    //        [view addSubview:label];
//    //        return view;
//    //    }
//}
//
////- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
////{
////	//note: placeholder views are only displayed on some carousels if wrapping is disabled
////	return 0;
////}
//
////- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index
////{
////create a placeholder view
////	UIView *view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page.png"]] autorelease];
////	UILabel *label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
////	label.text = (index == 0)? @"[": @"]";
////	label.backgroundColor = [UIColor clearColor];
////	label.textAlignment = UITextAlignmentCenter;
////	label.font = [label.font fontWithSize:50];
////	[view addSubview:label];
////	return view;
////    return nil;
////}
//
//- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
//{
//    //limit the number of items views loaded concurrently (for performance reasons)
//    switch (type) {
//        default:
//            return 3;
//            break;
//    }
//}
//
//- (CGFloat)carouselItemWidth:(iCarousel *)aCarousel
//{
//    //slightly wider than item view
//	switch (type) {
//        case YKCoverFlowTypeBanner:
//            return 320;
//            break;
//        case YKCoverFlowTypeDetailProductList:
//            return ((UIView*)[self carousel:aCarousel viewForItemAtIndex:0]).bounds.size.width + 10;
//            break;
//        case YKCoverFlowTypeCoverFlow:
//            return 120;
//            break;
//        case YKCoverFlowTypeBannerOne:
//            //lee1122修改
//            return self.frame.size.width+100;
//            break;
//            
//        default:
//            return 0;
//            break;
//    }
//}
//
////- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
////{
////    //implement 'flip3D' style carousel
////
////    //set opacity based on distance from camera
////    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
////    //do 3d transform
////    CATransform3D transform = CATransform3DIdentity;
////    transform.m34 = carousel.perspective;
////    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
////    return CATransform3DTranslate(transform, 0.0, 0.0, offset * carousel.itemWidth);
////}
//
//- (BOOL)carouselShouldWrap:(iCarousel *)carousel
//{
//    //wrap all carousels
//    return wrap;
//}
//
//-(void)carouselDidScroll:(iCarousel *)carousel
//{
//    [pc setNeedsDisplay];
//}
//
//- (void)carouselWillBeginDragging:(iCarousel *)aCarousel
//{
//    //	NSLog(@"Carousel will begin dragging");
//    [self performSelector:@selector(killTimer)];
//}
//
//- (void)carouselDidEndDragging:(iCarousel *)aCarousel willDecelerate:(BOOL)decelerate
//{
//    //	NSLog(@"Carousel did end dragging and %@ decelerate", decelerate? @"will": @"won't");
//    if (type == YKCoverFlowTypeBanner) {
//        timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    }
//}
//
//- (void)carouselWillBeginDecelerating:(iCarousel *)aCarousel
//{
//    //	NSLog(@"Carousel will begin decelerating");
//}
//
//- (void)carouselDidEndDecelerating:(iCarousel *)carousel
//{
//    //	NSLog(@"Carousel did end decelerating");
//}
//
//- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel
//{
//    //	NSLog(@"Carousel will begin scrolling");
//}
//
//- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
//{
//    //	NSLog(@"Carousel did end scrolling");
//}
//
//- (void)carousel:(iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
//{
//    if (delegate_cf && [delegate_cf respondsToSelector:@selector(coverFlow:didSelectItemAtIndex:)]) {
//        [delegate_cf coverFlow:self didSelectItemAtIndex:index];
//    }
//    //	if (index == carousel.currentItemIndex)
//    //	{
//    //		//note, this will only ever happen if USE_BUTTONS == NO
//    //		//otherwise the button intercepts the tap event
//    ////		NSLog(@"Selected current item");
//    //	}
//    //	else
//    //	{
//    ////		NSLog(@"Selected item number %i", index);
//    //	}
//}
//
//#pragma mark -
//#pragma mark Button tap event
//
//- (void)buttonTapped:(UIButton *)sender
//{
//    //    [[[[UIAlertView alloc] initWithTitle:@"Button Tapped"
//    //                                 message:[NSString stringWithFormat:@"You tapped button number %i", sender.tag]
//    //                                delegate:nil
//    //                       cancelButtonTitle:@"OK"
//    //                       otherButtonTitles:nil] autorelease] show];
//}
//
//
///*
// // Only override drawRect: if you perform custom drawing.
// // An empty implementation adversely affects performance during animation.
// - (void)drawRect:(CGRect)rect
// {
// // Drawing code
// }
// */
//
//
//-(NSInteger)numberOfPageInPageControl
//{
//    if (dataSource_cf && [dataSource_cf respondsToSelector:@selector(numberOfItemsInCoverFlow:)]) {
//        return [dataSource_cf numberOfItemsInCoverFlow:self];
//    }
//    return 0;
//}
//-(float)spacingOfRowInPageControl;
//{
//    return 10;
//}
//
//- (NSString *)nameOfCurNodePic
//{
//    return @"banner_dot_red.png";
//}
//- (NSString *)nameOfOtherNodePic
//{
//    return @"banner_dot_white.png";
//}
//
//-(CGPoint)originOfPageControl
//{
//    return [dataSource_cf originOfPageControlInBanner:self];;
//}
//-(NSInteger)currentPageIndex;
//{
//    return carousel.currentItemIndex;
//}
//@end
