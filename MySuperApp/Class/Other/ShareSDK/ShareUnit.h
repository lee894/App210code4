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

+(NSString *)shareName:(NSString *)name;
+(NSString *)shareproductID:(NSString *)pid;


+(void)ShareSDKwithTitle:(NSString*)atitle
                 content:(NSString*)content
          defaultContent:(NSString*)acontent
                     img:(UIImage*)aimg
                     url:(NSString*)aurl
             description:(NSString*)adescription
                imageUrl:(NSString*)aimageURl;

@end
