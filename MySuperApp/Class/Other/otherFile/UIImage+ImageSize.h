//
//  UIImage+ImageSize.h
//  MySuperApp
//
//  Created by bonan on 14-4-7.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageSize)

- (UIImage *)resizableImageWithCap:(UIEdgeInsets )frame;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

@end
