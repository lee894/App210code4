//
//  SinaDefine.h
//  透明爱
//
//  Created by 郝 建军 on 13-5-25.
//  Copyright (c) 2014年 hao. All rights reserved.
//

#ifndef ____SinaDefine_h
#define ____SinaDefine_h
//获取保存好的新浪信息
#define getSina \
{\
    NSFileManager *fileManager = [NSFileManager defaultManager];\
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);\
    NSString *str = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"sina.plist"];\
    if([fileManager fileExistsAtPath:str])\
    {\
        NSArray * arr = [NSKeyedUnarchiver unarchiveObjectWithFile:str];\
        SinaClass * sina = [SinaClass shareWBInfo];\
        if(sina)\
            sina = [arr objectAtIndex:0];\
        [SinaClass setWB:sina];\
    }\
}

//保存新浪微博信息
#define sinaSave \
{\
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);\
NSString *str = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"sina.plist"];\
NSMutableArray * arr = [NSMutableArray array];\
[arr addObject:[SinaClass shareWBInfo]];\
[NSKeyedArchiver archiveRootObject:arr toFile:str];\
NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithFile:str]);\
}


//获取QQ信息
#define getQQ \
{\
    NSFileManager *fileManager = [NSFileManager defaultManager];\
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);\
    NSString *str = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"QQUser.plist"];\
    if([fileManager fileExistsAtPath:str])\
    {\
        NSArray * arr = [NSKeyedUnarchiver unarchiveObjectWithFile:str];\
        QQShareClass * QQuser = [QQShareClass shareQQInfo];\
        if(QQuser)\
            QQuser = [arr objectAtIndex:0];\
            [QQShareClass setQQ:QQuser];\
    }\
}


//保存QQ信息
#define saveQQ \
{\
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);\
    NSString *str = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"QQUser.plist"];\
    NSMutableArray * arr = [NSMutableArray array];\
    [arr addObject:[QQShareClass shareQQInfo]];\
    [NSKeyedArchiver archiveRootObject:arr toFile:str];\
    NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithFile:str]);\
}


#define saveUSER \
{\
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);\
    NSString *str = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"user.plist"];\
    NSMutableArray * arr = [NSMutableArray array];\
    [arr addObject:[UserInfo shareUserInfo]];\
    [NSKeyedArchiver archiveRootObject:arr toFile:str];\
    NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithFile:str]);\
}


#endif
