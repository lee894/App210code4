//
//  ImageViewCell.h
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-12.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WaterFlowViewCell.h"
#import "UrlImageView.h"

@interface ImageViewCell : WaterFlowViewCell
{
    UrlImageView *imageView;
}

@property(nonatomic,strong)    UrlImageView *imageView;


-(void)setImageWithURL:(NSString *)imageUrl;
-(void)setImage:(UIImage *)image;
-(void)relayoutViews;

@end
