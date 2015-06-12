//
//  ServiceBaseWithMK.h
//  MySuperApp
//
//  Created by lee on 14-3-10.
//  Copyright (c) 2014年 aimer. All rights reserved.
//
//#import "MKNetworkEngine.h"
#import <Foundation/Foundation.h>
#import "MYMacro.h"
#import "LBaseModel.h"
#import "ModelManager.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


typedef void(^Block)(void);
typedef enum ServiceHandle
{
    EServiceNone,
    ERegisterSevice,
    EUserInfoService,
    ELoginService,
    ELoginQQService,
    EOrderdetailData,
    ECancelOrder,
    EVersionService,
    EgetAppkeyService,
    EFav,
    EAlipaywaletService,
    
    
    //lee999 200版本开发
    EMageinzeList20_Tag,
    
}ServiceType;

@protocol ServiceDelegate <NSObject>
@optional
-(void)serviceStarted:(ServiceType) aHandle;
-(void)serviceFinished:(ServiceType) aHandle withmodel:(id)amodel;
-(void)serviceFailed:(ServiceType) aHandle;
@end



@interface ServiceBaseWithMK : NSObject<ASIHTTPRequestDelegate>
{
    id<ServiceDelegate> delegate_;
    NSMutableDictionary *headerFields;
    NSMutableDictionary* dataParams_;
    NSMutableDictionary* muDictClassNames;

    @private
    ServiceType handle;

    NSData *imageData;
}
@property(nonatomic, retain)NSMutableDictionary* arr_dataParams;
@property (nonatomic, strong) NSMutableDictionary* dataParams;
@property (nonatomic, retain) id<ServiceDelegate> delegate;

@property (nonatomic, assign) BOOL isuploadDATA; //是否上传照片
@property(nonatomic,strong) NSString* unpayTN;//银联支付交易号码！！！


@property (nonatomic, strong) ASIHTTPRequest *asirequest;


-(void)sendPostWithURL:(NSString*)APIUrl tag:(int)atag beforeRequest:(Block)block;
-(void) addParam:(NSString*) key withValue:(id <NSObject>) value;

@end
