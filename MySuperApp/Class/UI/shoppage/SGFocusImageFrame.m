//
//  SGFocusImageFrame.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2014年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageFrame.h"

#import "SGFocusImageItem.h"
#import <objc/runtime.h>
#import "UrlImageView.h"

#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "UrlImageButton.h"
#import <objc/runtime.h>
#import "UIImage+ImageSize.h"
#import "BluePageControl.h"
#import "MYMacro.h"



//#define ITEM_WIDTH 320.0

@interface SGFocusImageFrame () {
    UIScrollView *_scrollView;
    BluePageControl *_pageControl;
}

- (void)setupViews;
- (void)switchFocusImageItems;
@end

static NSString *SG_FOCUS_ITEM_ASS_KEY = @"loopScrollview";

static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL = 8.0; //switch interval time

@implementation SGFocusImageFrame
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItems:(SGFocusImageItem *)firstItem, ...
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *imageItems = [NSMutableArray array];
        SGFocusImageItem *eachItem;
        va_list argumentList;
        if (firstItem)
        {
            [imageItems addObject: firstItem];
            va_start(argumentList, firstItem);
            while((eachItem = va_arg(argumentList, SGFocusImageItem *)))
            {
                [imageItems addObject: eachItem];
            }
            va_end(argumentList);
        }
        
        objc_setAssociatedObject(self, (const void *)CFBridgingRetain(SG_FOCUS_ITEM_ASS_KEY), imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = YES;
        [self setupViews];
        
        [self setDelegate:delegate];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSMutableArray *imageItems = [NSMutableArray arrayWithArray:items];
        objc_setAssociatedObject(self, (const void *)CFBridgingRetain(SG_FOCUS_ITEM_ASS_KEY), imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = isAuto;
        [self setupViews];
        
        [self setDelegate:delegate];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items
{
    return [self initWithFrame:frame delegate:delegate imageItems:items isAuto:YES];
}

#pragma mark - private methods
- (void)setupViews
{
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)CFBridgingRetain(SG_FOCUS_ITEM_ASS_KEY));
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;

    CGSize size = CGSizeMake(_scrollView.frame.size.width, 0);
    _pageControl = [[BluePageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width *.5 - size.width *.5, self.bounds.size.height - size.height-14, size.width, size.height)];
    [_pageControl  setBackgroundColor:[UIColor clearColor]];
    _pageControl.imgSize = CGSizeMake(9, 9);
    
//    UIImageView *pageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - size.height-28, ScreenWidth, 30)];
//    [pageView setImage:[UIImage imageNamed:@"banner_dot_bg.png"]];
    //    [self addSubview:pageView];

    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];

    /*
     _scrollView.layer.cornerRadius = 10;
     _scrollView.layer.borderWidth = 1 ;
     _scrollView.layer.borderColor = [[UIColor lightGrayColor ] CGColor];
     */
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _pageControl.numberOfPages = imageItems.count>1?imageItems.count -2:imageItems.count;
    _pageControl.currentPage = 0;
    
    _scrollView.delegate = self;
    
    // single tap gesture recognizer
//    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
//    tapGestureRecognize.delegate = self;
//    tapGestureRecognize.numberOfTapsRequired = 1;
//    [_scrollView addGestureRecognizer:tapGestureRecognize];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * imageItems.count, _scrollView.frame.size.height);
    
    for (int i = 0; i < imageItems.count; i++) {
        
        SGFocusImageItem *item = [imageItems objectAtIndex:i];
        UrlImageView * imageView = [[UrlImageView alloc] init];
        [imageView setFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        
        
        [imageView setImageFromUrl:YES withUrl:item.image];
        
        [imageView setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:nil];
        imageView.userInteractionEnabled = YES;
        
        imageView.tag = item.tag;

        
        UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
        tapGestureRecognize.delegate = self;
        tapGestureRecognize.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tapGestureRecognize];
        
        [_scrollView addSubview:imageView];
    }
    if ([imageItems count]>1)
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:NO] ;
        if (_isAutoPlay)
        {
            [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
        }
        
    }
    
}

- (void)switchFocusImageItems
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)CFBridgingRetain(SG_FOCUS_ITEM_ASS_KEY));
    targetX = (int)(targetX/_scrollView.frame.size.width) * _scrollView.frame.size.width;
    [self moveToTargetPosition:targetX];
    
    if ([imageItems count]>1 && _isAutoPlay)
    {
        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
    }
    
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __FUNCTION__);
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)CFBridgingRetain(SG_FOCUS_ITEM_ASS_KEY));
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > -1 && page < imageItems.count) {
//        SGFocusImageItem *item = [imageItems objectAtIndex:page];
        if ([self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
            [self.delegate foucusImageFrame:self didSelectItem:gestureRecognizer];
        }
    }
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
    BOOL animated = YES;
    //    NSLog(@"moveToTargetPosition : %f" , targetX);
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float targetX = scrollView.contentOffset.x;
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)CFBridgingRetain(SG_FOCUS_ITEM_ASS_KEY));
    if ([imageItems count]>=3)
    {
        if (targetX >= _scrollView.frame.size.width * ([imageItems count] -1)) {
            targetX = _scrollView.frame.size.width;
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if(targetX <= 0)
        {
            targetX = _scrollView.frame.size.width *([imageItems count]-2);
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    NSInteger page = (_scrollView.contentOffset.x+_scrollView.frame.size.width/2.0) / _scrollView.frame.size.width;

    if ([imageItems count] > 1)
    {
        page --;
        if (page >= _pageControl.numberOfPages)
        {
            page = 0;
        }else if(page <0)
        {
            page = _pageControl.numberOfPages -1;
        }
    }
    if (page!= _pageControl.currentPage)
    {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(foucusImageFrame:currentItem:)])
            {
                [self.delegate foucusImageFrame:self currentItem:page];
            }
        }
     
    }
    _pageControl.currentPage = page;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (int)(targetX/_scrollView.frame.size.width) * _scrollView.frame.size.width;
        [self moveToTargetPosition:targetX];
    }
}


- (void)scrollToIndex:(NSInteger)aIndex
{
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)CFBridgingRetain(SG_FOCUS_ITEM_ASS_KEY));
    if ([imageItems count]>1)
    {
        if (aIndex >= ([imageItems count]-2))
        {
            aIndex = [imageItems count]-3;
        }
        [self moveToTargetPosition:_scrollView.frame.size.width*(aIndex+1)];
    }else
    {
        [self moveToTargetPosition:0];
    }
    [self scrollViewDidScroll:_scrollView];
    
}
@end