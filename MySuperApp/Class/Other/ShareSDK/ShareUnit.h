//
//  ShareUnit.h
//  teaShop
//
//  Created by lee on 14-8-10.
//  Copyright (c) 2014年 com.youzhong.iphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DplusMobClick.h"

@interface ShareUnit : NSObject

+(void)ShareSDKwithTitle:(NSString*)atitle
                 content:(NSString*)content
          defaultContent:(NSString*)acontent
                     img:(UIImage*)aimg
                     url:(NSString*)aurl
             description:(NSString*)adescription
                imageUrl:(NSString*)aimageURl
              statistics:(NSArray*)arr; //分享的统计  0 类型   1，名字  2，id

@end
