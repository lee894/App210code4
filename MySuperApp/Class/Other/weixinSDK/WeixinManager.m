//
//  WeixinManager.m
//  透明爱
//
//  Created by 郝 建军 on 13-5-27.
//  Copyright (c) 2014年 hao. All rights reserved.
//

#import "WeixinManager.h"

@implementation WeixinManager
@synthesize shareImg,shareTitle,imgStr,delegate;

#pragma mark-微信分享
-(void)weixinShare{
    [self sendImg];
    [delegate changeScene:WXSceneTimeline];
}
- (void)sendImgToTimeline{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"爱慕商城";
        message.description = @"爱慕商城手机端支付";
        [message setThumbImage:[UIImage imageNamed:@"share_sian_p.png"]];
        
        WXImageObject *ext = [WXImageObject object];
        ext.imageUrl = @"";
        ext.imageData = nil;
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];
        
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
    }
}

- (void)sendImg{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"爱慕商城";
        message.description = @"爱慕商城手机端支付";
        [message setThumbImage:[UIImage imageNamed:@"imageback_07.png"]];
        
        WXImageObject *ext = [WXImageObject object];
        ext.imageUrl = @"http://www.toumingai.com/upload/201304/s_20130401142727199.jpg";
        ext.imageData = nil;
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = _scene;
        
        [WXApi sendReq:req];
        
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
    }
    
}
- (void)sendImg:(UIImage *)shareimg andThumbImage:(UIImage *)thumbImg
       orImgUrl:(NSString *)imgUrl
       andTitle:(NSString *)title
 andDescription:(NSString *)descrip
      withScene:(enum WXScene)sence{
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = descrip;
        [message setThumbImage:thumbImg];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = imgUrl;
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = sence;//_scene 或者 WXSceneTimeline
        
        [WXApi sendReq:req];
        
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
    }
}


- (void) sendTextContent:(NSString*)nsText withScene:(enum WXScene)sence
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = YES;
        req.text = nsText;
        req.scene = sence;
        [WXApi sendReq:req];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *weiXinLink = @"itms-apps://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weiXinLink]];
    }
}

- (void) sendImageContent
{
    //发送内容给微信
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:[UIImage imageNamed:@"share_sian_p"]];
        message.description = @"我的图片分享";
        
        WXWebpageObject *ext = [WXWebpageObject object];
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = _scene;
        
        [WXApi sendReq:req];
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
    }
}

//文字加图片
-(void)sharetitle:(NSString *)title andText:(NSString *)text andImageURL:(NSString *)url{
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = text;
        
        WXImageObject * imgdata = [WXImageObject object];
        imgdata.imageUrl = url;
        
        message.mediaObject = imgdata;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.text = title;
        
        req.message = message;
        req.scene = WXSceneTimeline;//;WXSceneTimeline
        
        [WXApi sendReq:req];
        UIImage * thumImg = [UIImage imageNamed:@""];
        [message setThumbImage:thumImg];
        [delegate changeScene:WXSceneTimeline];
    }
}


-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize//获取缩略图
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)sendVideoContent
{
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"爱慕商城";
        message.description = @"爱慕商城手机端支付";
        [message setThumbImage:[UIImage imageNamed:@"pic.png"]];
        
        WXVideoObject *ext = [WXVideoObject object];
        
        ext.videoUrl = @"http://www.tudou.com/programs/view/6vx5h884JHY/?fr=1";
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = _scene;
        
        [WXApi sendReq:req];
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
    }
}

//微信分享到好友
- (void)sendMusicContent
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"五月天<后青春期的诗>";
        message.description = @"人群中哭着你只想变成透明的颜色\
        你再也不会梦或痛或心动了\
        你已经决定了你已经决定了\
        你静静忍着紧紧把昨天在拳心握着\
        而回忆越是甜就是越伤人\
        越是在手心留下密密麻麻深深浅浅的刀割\
        重新开始活着";
        [message setThumbImage:[UIImage imageNamed:@"pic.png"]];
        
        WXMusicObject *ext = [WXMusicObject object];
        ext.musicUrl = @"http://y.qq.com/i/song.html#p=7B22736F6E675F4E616D65223A22E4BDA0E4B88DE698AFE79C9FE6ADA3E79A84E5BFABE4B990222C22736F6E675F5761704C69766555524C223A22687474703A2F2F74736D7573696332342E74632E71712E636F6D2F586B303051563558484A645574315070536F4B7458796931667443755A68646C2F316F5A4465637734356375386355672B474B304964794E6A3770633447524A574C48795333383D2F3634363232332E6D34613F7569643D32333230303738313038266469723D423226663D312663743D3026636869643D222C22736F6E675F5769666955524C223A22687474703A2F2F73747265616D31382E71716D757369632E71712E636F6D2F33303634363232332E6D7033222C226E657454797065223A2277696669222C22736F6E675F416C62756D223A22E5889BE980A0EFBC9AE5B08FE5B7A8E89B8B444E414C495645EFBC81E6BC94E594B1E4BC9AE5889BE7BAAAE5BD95E99FB3222C22736F6E675F4944223A3634363232332C22736F6E675F54797065223A312C22736F6E675F53696E676572223A22E4BA94E69C88E5A4A9222C22736F6E675F576170446F776E4C6F616455524C223A22687474703A2F2F74736D757369633132382E74632E71712E636F6D2F586C464E4D31354C5569396961495674593739786D436534456B5275696879366A702F674B65356E4D6E684178494C73484D6C6A307849634A454B394568572F4E3978464B316368316F37636848323568413D3D2F33303634363232332E6D70333F7569643D32333230303738313038266469723D423226663D302663743D3026636869643D2673747265616D5F706F733D38227D";
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = _scene;
        
        [WXApi sendReq:req];
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"你的iPhone上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
    }
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        
    }
    
}

-(void) changeScene:(NSInteger)scene{
    _scene = scene;
}

@end
