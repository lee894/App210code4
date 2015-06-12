//
//  LBaseModel.h
//  基类model，可以根据需要修改扩充
//
//  Created by lee on 14-4-4.
//  Copyright (c) 2014年 eastedge. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EADefine.h"


@interface LBaseModel : NSObject
{

}


@property (retain, nonatomic) NSString *response;


//lee999 新增处理的dic  针对200 以上的接口进行处理
@property (nonatomic,strong) NSDictionary *responseDic;

@property (nonatomic, assign) BOOL success; /*可以通过这个判断是否请求成功并且有数据*/

@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, assign) int requestTag; /*这个与相应的请求的tag是同步的*/


+ (LBaseModel *)modelObjectWithDictionary:(NSDictionary *)dict;


- (id)initWithResult:(NSString*)aResult;

- (id)initWithResult:(NSString*)aResult requestTag:(NSInteger)aRequestTag andErrorMessage:(NSDictionary *)error;

@end




