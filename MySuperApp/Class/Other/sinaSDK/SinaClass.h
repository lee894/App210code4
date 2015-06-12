//
//  SinaClass.h
//  透明爱
//
//  Created by 郝 建军 on 13-5-25.
//  Copyright (c) 2014年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "SinaDefine.h"
@protocol sinaLoginDelegate <NSObject>
@optional
-(void)shareSuccess;
-(void)cancelShare;
- (void)failed;
-(void)getuserInfo:(NSString *)userName;
- (void)tranferUserInfo:(NSMutableDictionary *)userInfo;
@end

@interface SinaClass : NSObject <NSCoding,SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
    NSString * openID;
    NSString * actionToken;
    NSDate * expiraDate;
    SinaWeibo * sinaWB;
//    id<sinaLoginDelegate> loginDelegate;
}
@property (nonatomic, retain) NSString * openID;
@property (nonatomic, retain) NSString * actionToken;
@property (nonatomic, retain) NSDate * expiraDate;
@property (nonatomic, retain) SinaWeibo * sinaWB;
@property (nonatomic, retain) NSString *status;

@property (nonatomic, retain) NSString *shareText;
@property (nonatomic, retain) UIImage *shareImage;



@property (nonatomic, assign) id<sinaLoginDelegate> loginDelegate;
+(SinaClass *)setWB:(SinaClass *)sina;
+(SinaClass *)shareWBInfo;//获取单例对象
+(void)sinaLogin;//登录
+(void)loginOut;//注销
+(void)sendShare:(NSString *)text andImage:(UIImage *)weiboImg;//分享内容提交
@end
