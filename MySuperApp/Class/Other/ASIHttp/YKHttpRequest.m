//
//  YKHttpRequest.m
//  testHTTP
//
//  Created by inzaghi on 10-11-17.
//  Copyright 2010 yek. All rights reserved.
//

#import "YKHttpRequest.h"


@implementation YKHttpRequest
@synthesize requestDelegate;
-(void) dealloc{
	[requestDelegate release];
	[super dealloc];
}

/*
创建同步请求，将需要发送的数据，封装到 ASIFormDataRequest
 先通过读取parmas 里面的Key，然后找出Value，将Key－Value添加到  ASIFormDataRequest
 如果需要添加头信息，则也是通过这种方法添加进去
 
 */
+(ASIFormDataRequest*) buildRequest:(NSURL *)url params:(NSDictionary *)params  extraHeaders:(NSDictionary*) extraHeaderDic{
	NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
	ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:url];
	NSArray* keys=[params allKeys];
	for(id key in keys){
		id val=[params objectForKey:key];
		[request setPostValue:val forKey:key];
	}
	if(extraHeaderDic!=nil){
		NSArray* keys2=[extraHeaderDic allKeys];
		for(id key in keys2){
			id val=[extraHeaderDic objectForKey:key];
			[request addRequestHeader:key value:val];
		}
	}
	[pool release];
	return [request autorelease];
}


/*
   同步请求
 请求数据，先调用上面的方法，封装好请求的数据
 然后   startSynchronous 
 判断返回的数据是否有效。
 赋值给String并返回
 
 */
+(NSString *) loadUrl:(NSURL *)url params:(NSDictionary *)params  extraHeaders:(NSDictionary*) extraHeaderDic{
	
	NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
	NSString* ret=nil;
	ASIFormDataRequest *request = [YKHttpRequest buildRequest:url params:params extraHeaders:extraHeaderDic];
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		ret=[response copy];
	}else{
		ret=nil;
	}
	[pool release];
	return [ret autorelease];
}

+(NSString *) loadUrl:(NSURL *)url params:(NSDictionary *)params{
	return [YKHttpRequest loadUrl:url params:params extraHeaders:nil];
}

+(NSString *) loadUrlString:(NSString *)urlString params:(NSDictionary *)params   extraHeaders:(NSDictionary*) extraHeaderDic{
	return [YKHttpRequest loadUrl:[NSURL URLWithString:urlString] params:params extraHeaders:extraHeaderDic];
}

+(NSString *) loadUrlString:(NSString *)urlString params:(NSDictionary *)params{
	return [YKHttpRequest loadUrlString:urlString params:params extraHeaders:nil];
}

/*异步请求
 */

+(void) startLoadUrl:(NSURL *)url delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params extraHeaders:(NSDictionary*) extraHeaderDic{
	NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];

	YKHttpRequest* asidelegate=[[YKHttpRequest alloc] init];
	ASIFormDataRequest *request = [YKHttpRequest buildRequest:url params:params extraHeaders:extraHeaderDic];
	
	request.timeOutSeconds=30;
	request.requestMethod=@"GET";  
	asidelegate.requestDelegate=delegate;   //delegate 里面帮助执行的是代理方法  就是结束后怎么操作
	[request setDelegate:asidelegate];
	[request startAsynchronous];
	[pool release];
}


+(void) startLoadUrl:(NSURL *)url delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params{
	[YKHttpRequest startLoadUrl:url delegate:delegate params:params extraHeaders:nil];
}


/*
 程序中的数据请求主要调用此方法    都是用的异步请求
*/
+(void) startLoadUrlString:(NSString *)urlString delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params extraHeaders:(NSDictionary*) extraHeaderDic{
	[YKHttpRequest startLoadUrl:[NSURL URLWithString:urlString] delegate:delegate params:params extraHeaders:extraHeaderDic];
}


+(void) startLoadUrlString:(NSString *)urlString delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params{
	[YKHttpRequest startLoadUrlString:urlString delegate:delegate params:params extraHeaders:nil];
}


/*
 ASIHTTPRequest 的代理方法(ASIFormDataRequest 继承自ASIHTTPRequest)，异步请求来数据之后，调用这两个方法 
 然后调用
 
 */
-(void) requestFinished:(ASIHTTPRequest *)request{
	if(requestDelegate!=nil){
		if([requestDelegate respondsToSelector:@selector(onLoadFinished:)]){
			
			[requestDelegate onLoadFinished:[request responseString]];
		}
	}
	[self release];
}
-(void) requestFailed:(ASIHTTPRequest *)request{
	if(requestDelegate!=nil){
		if([requestDelegate respondsToSelector:@selector(onLoadFailed:)]){
			[requestDelegate onLoadFailed:[request error]];
		}
	}
	[self release];
}

@end
