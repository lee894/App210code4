//
//  ImageViewCell.m
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-12.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import "ImageViewCell.h"


#define TOPMARGIN 8.0f
#define LEFTMARGIN 8.0f

#define IMAGEVIEWBG [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]

@implementation ImageViewCell
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithIdentifier:(NSString *)indentifier
{
	if(self = [super initWithIdentifier:indentifier])
	{
        imageView = [[UrlImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.alpha = 0.6;
        [self addSubview:imageView];
	}
	
	return self;
}

-(void)setImageWithURL:(NSString *)imageUrl{

//    [imageView setImageFromUrl:NO withUrl:imageUrl];
    
    //lee999recode
    [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    
    imageView.alpha = 1.0;

}

-(void)setImage:(UIImage *)image{

    imageView.image = image;
}

//保持图片上下左右有固定间距
-(void)relayoutViews{

    float originX = 0.0f;
    float originY = 0.0f;
    float width = 0.0f;
    float height = 0.0f;
    
    originY = TOPMARGIN;
    height = CGRectGetHeight(self.frame) - TOPMARGIN;
    if (self.indexPath.column == 0) {
        
        originX = LEFTMARGIN;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN - 1/2.0*LEFTMARGIN;
        
    }else if (self.indexPath.column < self.columnCount - 1){
    
        originX = LEFTMARGIN/2.0;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN;
    }else{
    
        originX = LEFTMARGIN/2.0;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN - 1/2.0*LEFTMARGIN;
    }
    imageView.frame = CGRectMake( originX, originY,width, height);

    //lee999 修改位置 width/2
//    imageView.frame = CGRectMake( originX, originY,width/2, height);

    
    [super relayoutViews];

}

@end
