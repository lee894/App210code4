//
//  UrlImageButton.h
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageCompat.h"
#import "SDWebImageManagerDelegate.h"
typedef void (^UrlImageBlock)(UIImage* image);
@interface UrlImageView : UIImageView <SDWebImageManagerDelegate> {	
	NSInteger iconIndex;

	CGSize scaleSize;
	BOOL    isScale;

	BOOL    _animated;
     CGRect frame_final;
    NSArray *sizeDestArray;
    NSArray *sizeArray;
    
    UIImage *defaultImg;
}
@property (nonatomic, assign) BOOL    _animated;
@property (nonatomic, assign) NSInteger iconIndex;

- (void) setImageFromUrl:(BOOL) animated withUrl:(NSString *)iconUrl;

- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder afterDownload:(UrlImageBlock)block;
- (void)cancelCurrentImageLoad;

//lee新增
-(void)setDefaultImage:(UIImage*)image;

-(void)scaleToSize:(CGSize)size ;
@end
