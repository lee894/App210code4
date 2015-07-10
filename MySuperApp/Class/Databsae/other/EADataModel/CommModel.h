//
//  CommModel.h
//  MySuperApp
//
//  Created by lee on 14-4-30.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseModel.h"

@interface CommModel : LBaseModel


@property (retain, nonatomic) NSString *errorMessage;
@property (nonatomic, assign) NSInteger requestTag; /*这个与相应的请求的tag是同步的*/
@property (nonatomic, retain) NSString *response;

@end


//
//@interface UnpayTNModel : LBaseModel
//
//
//@property (retain, nonatomic) NSString *errorMessage;
//@property (nonatomic, assign) NSInteger requestTag; /*这个与相应的请求的tag是同步的*/
//@property (nonatomic, retain) NSString *response;
//
//@end
//
//
//@implementation UnpayTNModel
//
//@synthesize requestTag,errorMessage,response;
//
//
//@end
