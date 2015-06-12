//
//  YKGetAddressInfo.m
//  YKProduct
//
//  Created by caiting on 11-12-29.
//  Copyright 2011 yek. All rights reserved.
//

#import "YKGetAddressInfo.h"

static YKGetAddressInfo *sharedManagerSqliteDao = nil;
@implementation YKGetAddressInfo
+ (YKGetAddressInfo *)sharedManager{
	@synchronized(self) {
		if (sharedManagerSqliteDao == nil) {
			sharedManagerSqliteDao = [[self alloc] init];
		}
	}
	return sharedManagerSqliteDao;
}
//打开数据库
-(void)openDatabase
{
	NSString *fullPath =[[NSBundle mainBundle] pathForResource:@"aimer_regions" ofType:@"db"];
	if (sqlite3_open([fullPath UTF8String], &database)==SQLITE_OK) { }	
}
//关闭数据库
-(void) closeDataBase
{  
	if (database!=nil) {
		sqlite3_close(database);
		database=nil;
	}
}

-(NSMutableArray *)getCityList
{
    [self openDatabase];	
	NSMutableArray* array = [[NSMutableArray alloc] init];
	
	NSString *sql=@"select id,cn_name from am_regions where parent_id = '0'";
	const char *selectSql=[sql UTF8String]; 
    sqlite3_stmt *statement; 
    if (sqlite3_prepare_v2(database, selectSql, -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *cityId = (char *)sqlite3_column_text(statement, 0);
			char *cityName = (char *)sqlite3_column_text(statement, 1);
            if(cityId!=nil && cityName!=nil){
                NSString *cityno = [NSString stringWithUTF8String:(const char *)cityId];
				NSString *cityname = [NSString stringWithUTF8String:(const char *)cityName];
				//NSLog(@"==%@:%@",cityno,cityname);
				NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:cityno,@"cityId",cityname,@"cityName",nil];
				[array addObject:dic];
            }
        }
        sqlite3_finalize(statement);
    } 
	[self closeDataBase];
	return array;
}
-(NSMutableArray *)getTownList:(NSString*)parentId{
	[self openDatabase];	
	NSMutableArray* array = [[NSMutableArray alloc] init];
	
	NSString *sql=[NSString stringWithFormat:@"select id,cn_name from am_regions where parent_id = '%@'",parentId];
	const char *selectSql=[sql UTF8String]; 
    sqlite3_stmt *statement; 
    if (sqlite3_prepare_v2(database, selectSql, -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *cityId = (char *)sqlite3_column_text(statement, 0);
			char *cityName = (char *)sqlite3_column_text(statement, 1);
            if(cityId!=nil && cityName!=nil){
                NSString *cityno = [NSString stringWithUTF8String:(const char *)cityId];
				NSString *cityname = [NSString stringWithUTF8String:(const char *)cityName];
				//NSLog(@"====%@:%@",cityno,cityname);
				NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:cityno,@"cityId",cityname,@"cityName",nil];
				[array addObject:dic];
            }
        }
        sqlite3_finalize(statement);
    } 
	[self closeDataBase];
	return array;
}
@end
