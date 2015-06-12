//
//  AnnotationView.h
//  MySuperApp
//
//  Created by LEE on 14-4-8.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <BaiduMapAPI/BMKPinAnnotationView.h>//引入所有的头文件

//#import "BMKPinAnnotationView.h"

@interface AnnotationView : BMKPinAnnotationView
@property (nonatomic,retain) UIImageView *imageAnnotation;

@property (nonatomic,assign) int tag;

@end
