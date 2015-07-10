//
//  ShareUnit.m
//  teaShop
//
//  Created by lee on 14-8-10.
//  Copyright (c) 2014年 com.youzhong.iphone. All rights reserved.
//

#import "ShareUnit.h"
#import <ShareSDK/ShareSDK.h>
#import "MYCommentAlertView.h"
#import "SingletonState.h"
#import "UrlImageView.h"
#import "WeixinManager.h"


@implementation ShareUnit

+(void)ShareSDKwithTitle:(NSString*)atitle
                 content:(NSString*)content
          defaultContent:(NSString*)adefaultContent
                     img:(UIImage*)aimg
                     url:(NSString*)aurl
             description:(NSString*)adescription
                imageUrl:(NSString*)aimageURl
{
    
    NSLog(@"-------%@",[ShareSDK version]);
    
    
    
    [SingletonState sharedStateInstance].isShareSDK = YES;
    
    
    //    NSString* imagePath ;//= [aurl hasSuffix:@".jpg"]?[aurl stringByReplacingOccurrencesOfString:@".jpg" withString:@"_169x210.jpg"]:aurl;
    //
    //    UIImage *shareIMG;
    //    UrlImageView* ImgV;
    //    if (aimg.length<1) {
    //        imagePath = [[NSBundle mainBundle] pathForResource:@"icon120"  ofType:@"png"];
    //        shareIMG  =[UIImage imageNamed:@"imagePath"];
    //    }else{
    //        ImgV = [[UrlImageView alloc] init];
    //        [ImgV setImageWithURL:[NSURL URLWithString:imagePath]  placeholderImage:nil];
    //        shareIMG = ImgV.image;
    //    }
    //
    
    
    //    id<ISSContent> pengyouquanContent = [ShareSDK
    //                                         content:content
    //                                         defaultContent:content
    //                                         image:nil
    //                                         title:content
    //                                         url:aurl
    //                                         description:content
    //                                         mediaType:SSPublishContentMediaTypeText];
    
    id<ISSShareActionSheetItem> myItem = [ShareSDK shareActionSheetItemWithTitle:@"微信朋友圈"
                                                                            icon:[UIImage imageNamed:@"sns_icon_23.png"]
                                                                    clickHandler:^{
                                                                        NSLog(@"执行你的分享代码!");
                                                                        
                                                                        WeixinManager *wx = [[WeixinManager alloc] init];
                                                                        
                                                                        [wx sendImg:aimg
                                                                      andThumbImage:aimg
                                                                           orImgUrl:aurl andTitle:content andDescription:content withScene:1];
                                                                        
                                                                    }];
    
    NSArray *shareList = [ShareSDK customShareListWithType:
                          SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                          SHARE_TYPE_NUMBER(ShareTypeQQSpace),
                          SHARE_TYPE_NUMBER(ShareTypeQQ),
                          SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                          myItem,
                          SHARE_TYPE_NUMBER(ShareTypeDouBan),
                          SHARE_TYPE_NUMBER(ShareTypeRenren),
                          nil];
    
    
    
    //    NSArray *shareList = [ShareSDK getShareListWithType:
    //                          ShareTypeSinaWeibo,
    //                          ShareTypeQQSpace,
    //                          ShareTypeQQ,
    //                          ShareTypeWeixiSession,
    //                          pengyouquanItem,
    //                          ShareTypeDouBan,
    //                          ShareTypeRenren,
    //                          nil];
    
    
    
    
    
    //构造分享内容
    
    /**
     *	@brief	创建分享内容对象，根据以下每个字段适用平台说明来填充参数值
     *
     *	@param 	content 	分享内容（新浪、腾讯、网易、搜狐、豆瓣、人人、开心、有道云笔记、facebook、twitter、邮件、打印、短信、微信、QQ、拷贝）
     *	@param 	defaultContent 	默认分享内容（新浪、腾讯、网易、搜狐、豆瓣、人人、开心、有道云笔记、facebook、twitter、邮件、打印、短信、微信、QQ、拷贝）
     *	@param 	image 	分享图片（新浪、腾讯、网易、搜狐、豆瓣、人人、开心、facebook、twitter、邮件、打印、微信、QQ、拷贝）
     *	@param 	title 	标题（QQ空间、人人、微信、QQ）
     *	@param 	url 	链接（QQ空间、人人、instapaper、微信、QQ）
     *	@param 	description 	主体内容（人人）
     *	@param 	mediaType 	分享类型（QQ、微信）
     *
     *	@return	分享内容对象
     */
    
//    id<ISSContent> publishContent = [ShareSDK content:content
//                                       defaultContent:adefaultContent
//                                                image:[ShareSDK pngImageWithImage:aimg]//[ShareSDK imageWithUrl:imagePath]//
//                                                title:atitle
//                                                  url:aurl
//                                          description:adescription
//                                            mediaType:SSPublishContentMediaTypeNews];

    
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:adefaultContent
                                                image: aimageURl.length< 1 ? [ShareSDK pngImageWithImage:aimg]:[ShareSDK imageWithUrl:aimageURl]
                                                title:atitle
                                                  url:aurl
                                          description:adescription
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    /**
     *	@brief	显示分享菜单
     *
     *	@param 	container 	用于显示分享界面的容器，如果只显示在iPhone客户端可以传入nil。如果需要在iPad上显示需要指定容器。
     *	@param 	shareList 	平台类型列表
     *	@param 	content 	分享内容
     *  @param  statusBarTips   状态栏提示标识：YES：显示； NO：隐藏
     *  @param  authOptions 授权选项，用于指定接口在需要授权时的一些属性（如：是否自动授权，授权视图样式等），默认可传入nil
     *  @param  shareOptions    分享选项，用于定义分享视图部分属性（如：标题、一键分享列表、功能按钮等）,默认可传入nil
     *  @param  result  分享返回事件处理
     */
    ///#end
    
    
    id<ISSShareOptions> shareOptions = [ShareSDK simpleShareOptionsWithTitle:content shareViewDelegate:nil];
    
    
    [ShareSDK showShareActionSheet:nil
                         shareList:shareList
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions: shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateBegan) {
                                    //开始分享
                                    
                                }
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    [MYCommentAlertView showMessage:@"分享成功" target:nil];
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    [MYCommentAlertView showMessage:@"分享失败" target:nil];
                                    
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                }
                                
                                [SingletonState sharedStateInstance].isShareSDK = NO;
                                
                            }];
}


@end
