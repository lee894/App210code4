
//
//  ServiceBaseWithMK.m
//  MySuperApp
//
//  Created by lee on 14-3-10.
//  Copyright (c) 2014年 aimer. All rights reserved.
//
#import "YKMD5.h"
#import "MYMacro.h"
#import "YKBaseEntity.h"
#import "ServiceBaseWithMK.h"
#import "NSStringAdditions.h"
#import "AFNetworking.h"
#include <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "MYCommentAlertView.h"
#import "AppDelegate.h"
#import "UIDevice-hardware.h"
#import <AdSupport/AdSupport.h>
#import "TalkingData.h"
#import "UIDevice-hardware.h"
#import "OpenUDID.h"
#import "ASIHTTPRequest.h"
#import "MyAimerViewController.h"


@implementation ServiceBaseWithMK
@synthesize dataParams = dataParams_;
@synthesize delegate = delegate_;
@synthesize arr_dataParams;

@synthesize unpayTN;

@synthesize isuploadDATA; //是否上传照片


-(id)init
{
    if (self = [super init]) {
        handle = ELoginQQService;
    }
    return self;
}

//初始化请求，每次请求必先初始化
-(void) InitCommonParamsWithURL:(NSString*)APIUrl
{
    NSString *struid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if (struid==nil || [struid isEqualToString:@""])
    {
    }
}

//添加头数据
-(void)addHeaderData{
    
    NSString *userid =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    if (userid==nil || [userid isEqualToString:@""])
    {
        if (userid==nil || [userid isEqualToString:@""]) {
            userid = @"";
        }
    }
    NSLog(@"userID是：%@",userid);
}

//添加后缀参数
-(void) addParam:(NSString*) key withValue:(id <NSObject>) value{
    
    NSLog(@"key--%@------V:%@",key,value);
    
    
    NSString* upvalue = [[NSString stringWithFormat:@"%@",value] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
	if(key && value){
		if(!self.dataParams){
            self.dataParams = [[NSMutableDictionary alloc] init];
		}else{
        }
        
        //lee999 加判断，过滤掉上传的图片
        if (![key isEqualToString:@"Filedata"]) {
            [self.dataParams setValue:upvalue forKey:key];
        }else{
            imageData = (NSData*)value;
        }
	}
}


//-(void)getAnWoADSupportWithtag:(int)atag{
//
//    [self InitCommonParamsWithURL:@""];
//    
//    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    NSString *uid = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
//    NSString *code = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    NSString *ostype = [[UIDevice currentDevice] model];
//    NSString *openudid = [OpenUDID value];
//    
//    
//    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
//    double i=time;      //NSTimeInterval返回的是double类型
//    NSString *date = [NSString stringWithFormat:@"%.0f",i];
//    NSLog(@"1970timeInterval:%.0f",i);
//    
//    NSString *urlStr = [NSString stringWithFormat:@"http://offer.adwo.com/iofferwallcharge/ia?adalias=adwo&uid=%@&code=%@&ostype=%@&idfa=%@&openudid=%@&activateip=%@&acts=%@",uid,code,ostype,idfa,openudid,@"192.168.1.1",date];
//
//    NSLog(@"----urlStr:-----%@",urlStr);
//    
//    NSURL *url = [NSURL URLWithString:urlStr];
//    ASIHTTPRequest *asirequest1 = [ASIHTTPRequest requestWithURL:url];
//    self.asirequest = asirequest1;
//
//    [self.asirequest setCompletionBlock:^{
//        
//        NSString *backstr = [[NSString alloc] initWithData:[asirequest1 responseData] encoding:NSUTF8StringEncoding];
//        
//        [MYCommentAlertView showMessage:backstr target:nil];
//        
//        NSLog(@"2222222222是：\n%@------%d", backstr,atag);
//    }];
//    
//    [self.asirequest setFailedBlock:^{
//
//        NSString *backstr = [[NSString alloc] initWithData:[asirequest1 responseData] encoding:NSUTF8StringEncoding];
//        
//        [MYCommentAlertView showMessage:backstr target:nil];
//
//        
//        NSLog(@"2222222222是：\n%@------%d", backstr,atag);
//        
//    }];
//    [self.asirequest startAsynchronous];
//    
//    /*
//    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
//    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
//    client.tag = atag;
//    [client postPath:@"mobile/service" parameters:nil
//             success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         [self requesetADOK:responseObject andtag:atag];
//     }
//             failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         [self requesetADFail:error];
//     }];
//     */
//}

-(void)requesetADOK:(id)sender andtag:(int)atag{
    
    NSString *backstr = [[NSString alloc] initWithData:sender encoding:NSUTF8StringEncoding];
    NSLog(@"返回的数据是：\n%@------%d", backstr,atag);
}

-(void)requesetADFail:(NSError*)aerror{

}



-(void)sendPostWithURL:(NSString*)APIUrl tag:(int)atag beforeRequest:(Block)block
{
    
    [self.dataParams removeAllObjects];

    [self InitCommonParamsWithURL:APIUrl];
    block();

    //域名
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",OFFICIALDOMAIN,APIUrl];
    NSLog(@"请求的地址是：----%@----tag:%d",urlStr,atag);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.delegate serviceStarted:handle];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    client.tag = atag;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* currentZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:currentZone];
    NSString* stringFromDate = [formatter stringFromDate:[NSDate date]];
    
    NSString *strsession = @"";
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"usersession"]) {
        strsession = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"usersession"]];
    }
    NSLog(@"usersession----:%@",strsession);
    
    NSString* appversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString* osVerson = [[UIDevice currentDevice] systemVersion];
    NSString *aimerudid;
    if (isIOS7up) {
        aimerudid  = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];//[TalkingData getDeviceID];//;
    }else{
        aimerudid = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
    }
    
    
    
    //lee999recode 如果是上传图片  updata
    if (isuploadDATA) {
        
        NSLog(@"请求的地址是222222：----%@----tag:%d",urlStr,atag);

        ASIFormDataRequest *asirequest = nil;
        
        asirequest=[ASIFormDataRequest requestWithURL:url];
        [asirequest addData:[self.dataParams objectForKey:@"Filedata"] forKey:@"Filedata"];
        asirequest.tag = atag;
        asirequest.delegate = self;
        
        [asirequest addRequestHeader:@"appkey" value:@"9980998"];
        [asirequest addRequestHeader:@"udid" value:aimerudid];
        [asirequest addRequestHeader:@"os" value:@"ios"];
        [asirequest addRequestHeader:@"osversion" value:osVerson];
        [asirequest addRequestHeader:@"appversion" value:appversion];
        [asirequest addRequestHeader:@"timestamp" value:stringFromDate];
        [asirequest addRequestHeader:@"sourceid" value:AimerChannelId];
        [asirequest addRequestHeader:@"ver" value:appversion];
        [asirequest addRequestHeader:@"usersession" value:strsession];
        //sign
        NSMutableArray* ma0 = [[NSMutableArray  alloc] init];
        [ma0 addObject:[NSString stringWithFormat:@"appversion%@",appversion]];
        [ma0 addObject:[NSString stringWithFormat:@"Filedata%@",[self.dataParams objectForKey:@"Filedata"]]];
        [ma0 addObject:@"osios"];
        [ma0 addObject:[NSString stringWithFormat:@"osversion%@",osVerson]];
        [ma0 addObject:[NSString stringWithFormat:@"sourceid%@",AimerChannelId]];
        [ma0 addObject:[NSString stringWithFormat:@"timestamp%@",stringFromDate]];
        [ma0 addObject:[NSString stringWithFormat:@"udid%@",aimerudid]];
        [ma0 addObject:[NSString stringWithFormat:@"usersession%@",strsession]];
        //lee894sing增加业务参数
        NSArray *arrdataParams = [[NSArray alloc] init];
        arrdataParams = [self DictionaryToArray:self.dataParams];
        if ([arrdataParams count] > 0) {
            for (int i=0; i<[arrdataParams count]; i++) {
                [ma0 addObject:[arrdataParams objectAtIndex:i]];
            }
        }
        [ma0 addObject:[NSString stringWithFormat:@"ver%@",appversion]];
        NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *arr1 = [ma0 sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
        NSString* appsecrect=@"IMA!(@#*^ASDLSADHH";
        NSMutableString *aa=[[NSMutableString alloc]init];
        for (NSString *str in arr1) {
            [aa appendString:str];
        }
        NSString* signsrc = [NSString stringWithFormat:@"%@%@%@",appsecrect,aa,appsecrect];  //前面添加字符
        NSLog(@"签名之前的数据是--------：%@",signsrc);
        NSString *sign_ddd= YKMD5(signsrc);
        [asirequest addRequestHeader:@"sign" value:sign_ddd];

        [asirequest startAsynchronous];


        return;
    }
    //end
    
    

    [client setDefaultHeader:@"appkey" value:@"9980998"];
    [client setDefaultHeader:@"udid" value:aimerudid];
    [client setDefaultHeader:@"os" value:@"ios"];
    [client setDefaultHeader:@"osversion" value:osVerson];
    [client setDefaultHeader:@"appversion" value:appversion];
    [client setDefaultHeader:@"timestamp" value:stringFromDate];
    [client setDefaultHeader:@"sourceid" value:AimerChannelId];
    [client setDefaultHeader:@"ver" value:appversion];
    [client setDefaultHeader:@"usersession" value:strsession];


    //sign
    NSMutableArray* ma1 = [[NSMutableArray  alloc] init];
    [ma1 addObject:[NSString stringWithFormat:@"appversion%@",appversion]];
    [ma1 addObject:@"osios"];
    [ma1 addObject:[NSString stringWithFormat:@"osversion%@",osVerson]];
    [ma1 addObject:[NSString stringWithFormat:@"sourceid%@",AimerChannelId]];
    [ma1 addObject:[NSString stringWithFormat:@"timestamp%@",stringFromDate]];
    [ma1 addObject:[NSString stringWithFormat:@"udid%@",aimerudid]];
    [ma1 addObject:[NSString stringWithFormat:@"usersession%@",strsession]];
    //lee894sing增加业务参数
    NSArray *arrdataParams = [[NSArray alloc] init];
    arrdataParams = [self DictionaryToArray:self.dataParams];
    if ([arrdataParams count] > 0) {
        for (int i=0; i<[arrdataParams count]; i++) {
            [ma1 addObject:[arrdataParams objectAtIndex:i]];
        }
    }

    [ma1 addObject:[NSString stringWithFormat:@"ver%@",appversion]];
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    NSArray *arr1 = [ma1 sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    NSString* appsecrect=@"IMA!(@#*^ASDLSADHH";
    NSMutableString *aa=[[NSMutableString alloc]init];
    for (NSString *str in arr1) {
        [aa appendString:str];
    }
    NSString* signsrc = [NSString stringWithFormat:@"%@%@%@",appsecrect,aa,appsecrect];  //前面添加字符
    NSLog(@"签名之前的数据是--------：%@",signsrc);
    NSString *sign_ddd= YKMD5(signsrc);
    //end

    [client setDefaultHeader:@"sign" value:sign_ddd];
    
    //lee999签名之后增加新的参数
    NSString *openudid = [OpenUDID value];
    [client setDefaultHeader:@"openudid" value:openudid];

    NSLog(@"dataParams-----%@",self.dataParams);
    

    [client postPath:@"mobile/service" parameters:self.dataParams
    success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self requesetOK:responseObject andtag:atag];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self requesetFail:error];
        
    }];
}

//请求成功
-(void)requesetOK:(id)sender andtag:(int)atag{
    
    NSString *backstr = [[NSString alloc] initWithData:sender encoding:NSUTF8StringEncoding];
    NSLog(@"返回的数据是：\n%@", backstr);
    NSDictionary *jsonDic = [backstr JSONValue];
    
    if ([[jsonDic objectForKey:@"response"] isEqualToString:@"error"]) {
        
        //lee999 特殊处理，需要绑定手机的话
        if ([[[jsonDic objectForKey:@"error"] objectForKey:@"text"] isEqualToString:@"您还未绑定手机号码"]) {
            handle = ENeedbindPhone;
            [self.delegate serviceFailed:handle];
            return;
        }
        
        //请先登录
        if ([[[jsonDic objectForKey:@"error"] objectForKey:@"text"] isEqualToString:@"请先登录"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:[[jsonDic objectForKey:@"error"] objectForKey:@"text"] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
           [alert show];
            alert.tag = 100012;
            
            handle = ENeedGotoLogin;
            [self.delegate serviceFailed:handle];
            return;
        }
        //end
        
        [MYCommentAlertView showMessage:[NSString stringWithFormat:@"%@",[[jsonDic objectForKey:@"error"] objectForKey:@"text"]] target:nil];

        
        [self.delegate serviceFailed:handle];
        return ;
    }
    
    //lee999增加银联交易流水码
    if (atag == Http_TrdnoByOrderld_Tag) {
        unpayTN = [jsonDic objectForKey:@"tradno"];
    }
    //end
    
    //lee999 200版本开始
    if (atag >200) {
        
        /*
        LBaseModel *model = [[LBaseModel alloc] init];
        model.requestTag = atag;
        model.responseDic = jsonDic;
        */
        handle = atag;
        [self.delegate serviceFinished:handle withmodel:jsonDic];
    }else{
        handle = ELoginQQService;
        LBaseModel *model = [ModelManager parseModelWithDictionary:jsonDic tag:atag];
        [self.delegate serviceFinished:handle withmodel:model];
    }
}

//请求失败
-(void)requesetFail:(NSError*)aerror{
    
    NSLog(@"竟然执行到了错误界面：--%ld", (long)aerror.code);
    [self.delegate serviceFailed:handle];
    //提示失败的错误
    if([aerror code] == 1){
        [MYCommentAlertView showMessage:@"您的网络环境不佳，请稍候再试" target:nil];
    }
    else if([aerror code] == 2){
        [MYCommentAlertView showMessage:@"网络请求超时" target:nil];
        
    }else if([aerror code] == -1009){
        [MYCommentAlertView showMessage:@"您的网络环境不佳，请稍候再试" target:nil];
    }else{
        [MYCommentAlertView showMessage:@"瞧瞧出了点小问题，请您稍候再试" target:nil];
    }
}

-(void)parseJson:(NSString*)jsonString{
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100012 && buttonIndex == 0) {
     
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        MyAimerViewController *loginvc = [[MyAimerViewController alloc] initWithNibName:@"MyAimerViewController" bundle:nil];
        UINavigationController *navCtl = [[UINavigationController alloc] initWithRootViewController:loginvc];
        [app.mytabBarController presentViewController:navCtl animated:YES completion:^{}];        
    }
}


#pragma mark ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSString *responseStr = [request responseString];
    NSLog(@"\n+++++++++++\n%@\n++++++++++++++request.tag:----%ld",responseStr,(long)request.tag);
    
    self.isuploadDATA = NO;
    
//    NSDictionary *jsonDic = [responseStr JSONValue];
//    BaseModel *model = [ModelManager parseModelWithDictionary:jsonDic tag:request.tag];
//    /*请求成功*/
//    //    if (!_delegate) {
//    if ([_delegate respondsToSelector:@selector(netRequestFinished:)]) {
//        [_delegate netRequestFinished:model];
//    }
//    //    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    self.isuploadDATA = NO;

//    if (request.tag == Http_Productlist_Tag) {
//        BaseModel *model = [ModelManager parseModelWithFaileResult:@"10086" tag:100861];
//        /*请求超时*/
//        if ([_delegate respondsToSelector:@selector(netRequestFinished:)]) {
//            [_delegate netRequestFinished:model];
//        }
//        return;
//    }
//    
//    BaseModel *model = [ModelManager parseModelWithFaileResult:@"10086" tag:10086];
//    NSLog(@"\n+++++++++++\n%@\n++++++++++++++",@"请求超时");
//    
//    /*请求超时*/
//    if ([_delegate respondsToSelector:@selector(netRequestFinished:)]) {
//        [_delegate netRequestFinished:model];
//    }
    
}

#pragma mark-获取网络信号
-(NSString*)getWantype{
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    NSString* netType = @"无网络";
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    if (num == nil) {
        netType = @"无网络";
    }else{
        int n = [num intValue];
        if (n == 0) {
            netType = @"无网络";
        }else if (n == 1){
            netType = @"2G网络";
        }else if (n == 2){
            netType = @"3G网络";
        }else{
            netType = @"wifi网络";
        }
        
    }
    return netType;
}
#pragma mark- 获取运营商
-(NSString*)getcarrierName{
    
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];
    NSString *carrierCode;
    if (carrier == nil) {
        carrierCode = @"WiFi";
    }else {
        carrierCode = [carrier carrierName];
    }
    return carrierCode;
}


//字典转数组的方法  把key 和value 拼接成一个字符串 添加到数组里面
- (NSArray *)DictionaryToArray:(NSDictionary *)dic {
    
    if (dic == nil || dic.count < 1) {
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSString *keyStr in dic) {
        NSString *mutStr = [NSString stringWithFormat:@"%@%@",keyStr,[dic objectForKey:keyStr]];
        [arr addObject:mutStr];
    }
    return arr;
}


-(id)parseDic:(NSDictionary*)dic byKey:(NSString*)key{
    id result = nil;
    if ([muDictClassNames objectForKey:key]) {
        Class c = NSClassFromString([muDictClassNames objectForKey:key]);
        if (c) {
            result = [[c alloc] init];
        }else{
            result = [[YKBaseEntity alloc] init];
        }
    }else
    {
        result = [[YKBaseEntity alloc] init];
    }
    NSArray* keys = [dic allKeys];
    
    //加入了 各类的解析类型 1列表 2对象
    
    for (int i = 0; i < [keys count]; ++i) {
        id item = [dic objectForKey:[keys objectAtIndex:i]];
        //        NSLog(@"%@", [keys objectAtIndex:i]);
        if ([item respondsToSelector:@selector(stringWithFormat:)])
        {
            [result setAttribute:item forKey:[keys objectAtIndex:i]];
        }
        else if ([item respondsToSelector:@selector(objectForKey:)])
        {
            [result setAttribute:[self parseDic:item byKey:[keys objectAtIndex:i]] forKey:[keys objectAtIndex:i]];
        }
        else if ([item respondsToSelector:@selector(removeLastObject)])
        {
            NSMutableArray* arr = [self parseArray:item byKey:[keys objectAtIndex:i]];
            [result setAttribute:arr forKey:[keys objectAtIndex:i]];
        }
        else if ([item class] != [NSNull class])
        {
            [result setAttribute:item forKey:[keys objectAtIndex:i]];
        }
        else
        {
            if ([muDictClassNames objectForKey:[keys objectAtIndex:i]]) {
                Class c = NSClassFromString([muDictClassNames objectForKey:[keys objectAtIndex:i]]);
                if (c) {
                    YKBaseEntity* temp = [[c alloc] init];
                    switch (temp.nType) {
                        case 1:
                        {
                            NSMutableArray* arr = [[NSMutableArray alloc] initWithCapacity:1];
                            [result setAttribute:arr forKey:[keys objectAtIndex:i]];
                        }
                            break;
                        case 2:
                        {
                            [result setAttribute:temp forKey:[keys objectAtIndex:i]];
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
            else
            {
                [result setAttribute:@"" forKey:[keys objectAtIndex:i]];
            }
        }
    }
    return result;
}

-(id)parseArray:(NSArray*)array byKey:(NSString*)key
{
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0; i < [array count]; ++i) {
        id item = [array objectAtIndex:i];
        if ([item respondsToSelector:@selector(objectForKey:)]) {
            [result addObject:[self parseDic:item byKey:key]];
        }else if([item respondsToSelector:@selector(removeLastObject)])
        {
            [result addObject:[self parseArray:item byKey:key]];
        }else if([item respondsToSelector:@selector(stringWithFormat:)])
        {
            [result addObject:item];
        }
        else if([item class] != [NSNull class])
        {
            [result addObject:item];
        }
        else
        {
            [result addObject:@""];
        }
    }
    return result;
}

@end


//        NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"" parameters:self.dataParams constructingBodyWithBlock:
//         ^(id <AFMultipartFormData>formData) {
//             //上传图片   9999999999
//             [formData appendPartWithFormData:imageData name:@"Filedata"];
//         }];
//        isuploadDATA = NO;
//        imageData = nil;
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//        [operation start];
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//         {
//             [self requesetOK:responseObject andtag:atag];
//
//         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             [self requesetFail:error];
//         }];
//        return;


//- (void) imagePicker{
//
//NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
//[myFormatter setDateFormat:@"yyyyMMddhhmmss"];
//NSString *strTime = [myFormatter stringFromDate:[NSDate date]] ;
//
//NSString *strName = [strTime stringByAppendingString:@".png"];
//NSString *strPath = [strDocPath stringByAppendingPathComponent:strName];
//NSData *imageDatass = UIImagePNGRepresentation(image);
//[imageDatass writeToFile:strPath atomically:YES];
//fileArray = [NSArray arrayWithObjects:strName,strPath,nil];
//
//
//AFAPIClient *client = [AFAPIClient sharedInstance];
//NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults]
//                          objectForKey:kWXYUserAccountInfoKey];
//
//NSString *uid = [userInfo objectForKey:@"userId"];
//NSDictionary *params = DICT(uid,              @"userId",
//                            strName,          @"fileName"
//                            );
//
//
//NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"/user/uploadCustomFile.do" parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
//    [formData appendPartWithFileData:imageDatass name:strTime fileName:strPath mimeType:@"image/png"];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setUploadProgressBlock:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
//    }];
//    [operation start];
//
//
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSLog(@"成功呢！json ===%@",operation.responseString);
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"Failure: %@", error);
//     }];
//    }
//}