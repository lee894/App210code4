//
//  UIImage+ImageSize.m
//  MySuperApp
//
//  Created by bonan on 14-4-7.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "UIImage+ImageSize.h"

@implementation UIImage (ImageSize)

- (UIImage *)resizableImageWithCap:(UIEdgeInsets )frame {
    UIImage *changeImage = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
     changeImage = [self resizableImageWithCapInsets:frame resizingMode:UIImageResizingModeStretch];
//
    } else {
      changeImage = [self stretchableImageWithLeftCapWidth:frame.left topCapHeight:frame.top];
    }
    
    return changeImage;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
