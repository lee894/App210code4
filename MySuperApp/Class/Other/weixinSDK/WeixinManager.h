//
//  WeixinManager.h
//  透明爱
//
//  Created by 郝 建军 on 13-5-27.
//  Copyright (c) 2014年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"
#import "WXApi.h"
@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) sendMusicContent ;
- (void) sendVideoContent ;
- (void) changeScene:(NSInteger)scene;
@end

@interface WeixinManager : NSObject <WXApiDelegate,sendMsgToWeChatViewDelegate, UIAlertViewDelegate>
{
     enum WXScene _scene;
}
@property (nonatomic, retain) NSString * shareTitle;
@property (nonatomic, retain) UIImage * shareImg;
@property (nonatomic, retain) NSString * imgStr;

@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;

-(void)weixinShare;
-(void)sharetitle:(NSString *)title andText:(NSString *)text andImageURL:(NSString *)url;
- (void)sendImgToTimeline;

//- (void)sendImg:(UIImage *)shareimg
//  andThumbImage:(UIImage *)thumbImg
//       orImgUrl:(NSString *)imgUrl
//       andTitle:(NSString *)title
// andDescription:(NSString *)descrip;//发送完整图片和文字


- (void)sendImg:(UIImage *)shareimg
  andThumbImage:(UIImage *)thumbImg
       orImgUrl:(NSString *)imgUrl
       andTitle:(NSString *)title
 andDescription:(NSString *)descrip
      withScene:(enum WXScene)sence;//微信发送给好友或者朋友圈

- (void) sendTextContent:(NSString*)nsText withScene:(enum WXScene)sence;//发送纯文本

//文字加图片
//-(void)sharetitle:(NSString *)title andText:(NSString *)text andImageURL:(NSString *)url;
@end
