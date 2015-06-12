//
//  YKHttpRequest.h
//  testHTTP
//
//  Created by inzaghi on 10-11-17.
//  Copyright 2010 yek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
/*
 异步HTTP request 事件处理
 */
@protocol YKHttpRequestDelegate<NSObject>
@optional 
/*
 http requst 加载完成 
	responseString表示server 响应
 */
-(void) onLoadFinished:(NSString*) responseString;
/*
 http request 加载出错
	error:错误信息
 */
-(void) onLoadFailed:(NSError*) error;

@end



/*
 http post 请求封装
 示例：
	1.NSString* html=[YKHttpRequest loadUrl:@"http://www.google.com" params:nil];
	2.[YKHttpRequest startLoadUrl:@"http://www.google.com" delegate:****     params:nil];
 */
@interface YKHttpRequest : NSObject<ASIHTTPRequestDelegate> {
	id<YKHttpRequestDelegate> requestDelegate;
}
@property(nonatomic,retain) id<YKHttpRequestDelegate> requestDelegate;
/*
 同步HTTP POST提交参数至url,返回取回的内容，如果出错返回nil
 ！！！不要在主线程调用，会阻塞直到返回
 参数列表：
	url:网址 ，不能为空
	params: 参数, key:参数名, value:参数值如果不是NSString 使用[value description]。 params==nil 表示没有参数。
 返回值：
	nil:出错
	其它:页面内容，如果网址内容不是text，可能会有问题。
 */
+(NSString *) loadUrl:(NSURL*) url params:(NSDictionary*) params;
+(NSString *) loadUrl:(NSURL *)url params:(NSDictionary *)params  extraHeaders:(NSDictionary*) extraHeaderDic;
+(NSString *) loadUrlString:(NSString*) urlString  params:(NSDictionary*) params;
+(NSString *) loadUrlString:(NSString *)urlString params:(NSDictionary *)params   extraHeaders:(NSDictionary*) extraHeaderDic;

/*
 异步HTTP POST提交参数至url,解析出
 参数列表：
	url:网址
	delegate:request 代理，处理request finish 事件、 request error 事件
	params: 参数, key:参数名, value:参数值如果不是NSString 使用[value description]。 params==nil 表示没有参数。
 */
+(void) startLoadUrl:(NSURL*) url delegate:(id<YKHttpRequestDelegate>)delegate params:(NSDictionary*) params;
+(void) startLoadUrl:(NSURL *)url delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params extraHeaders:(NSDictionary*) extraHeaderDic;
+(void) startLoadUrlString:(NSString*) urlString delegate:(id<YKHttpRequestDelegate>)delegate  params:(NSDictionary*) params;
+(void) startLoadUrlString:(NSString *)urlString delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params extraHeaders:(NSDictionary*) extraHeaderDic;
@end



