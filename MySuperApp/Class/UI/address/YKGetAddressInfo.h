//
//  YKGetAddressInfo.h
//  YKProduct
//
//  Created by caiting on 11-12-29.
//  Copyright 2011 yek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface YKGetAddressInfo : NSObject {
	sqlite3 *database;
}
+ (YKGetAddressInfo *)sharedManager;
-(void)openDatabase;
-(void) closeDataBase;
-(NSMutableArray *)getCityList;
-(NSMutableArray *)getTownList:(NSString*)parentId;

@end
