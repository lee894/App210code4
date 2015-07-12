//
//  DplusMobClick.h
//  cnzzsdk
//
//  Created by wangkai on 15-1-29.
//  Copyright (c) 2015年 wangkai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DplusMobClick;
@interface DplusMobClick : NSObject
typedef enum {
    START_SEND_MODEL = 0,       //启动发送
    INTERVAL_SEND_MODEL = 1,          //间隔发送
    
} dplusReportPolicy;

/**
 * 设置Token属性
 * 设置发送策略，可设置启动时发送或者间隔发送
 * 默认为间隔发送
 * 设置是否仅wifi下发送
 * 默认在有网络下发送
 * @param token
 * @param model START_SEND_MODEL or INTERVAL_SEND_MODEL
 *
 */;
+(void) setTokenProperty:(NSString *)token;
+(void) setTokenProperty:(NSString *)token model:(dplusReportPolicy) model wifi:(BOOL)wifi;
/**
 * 设置发送间隔，此设置只在发送类型为间隔发送的时候起作用
 * 默认为间隔90秒发送，设置值在90-86400（90秒到24小时）之间 ，超出范围取默认值
 * @param interval 间隔秒数
 */
+(void) setSendInterval:(int) interval;

/**
 * 设置LOG开启与否状态
 * @param flag 调试开关标签
 */
+(void) setDebugStatus:(BOOL) flag;

/**
 * 设置硬件属性，这些属性相对固定，比如分辨率，语言等，设置之后，这些属性不会根据事件不同而改变
 * 属性名自定义，属性值已经封装好部分常用方法，可供调用使用
 * @param property
 */
+(void) setDeviceProperty:(NSDictionary *) property;


/**
 * 增加事件
 * @param eventName
 * @param property 自定义属性
 */
+(void) track:(NSString *)eventName;
+(void) track:(NSString *)eventName property:(NSDictionary *) property;

//需要与track配合使用（需指定相同名称），为该事件添加duration属性，值为前后调用时间差
+(void) timeEvent:(NSString *)Event;

//清除timeEvent
+(void) clearTimedEvents:(NSString *)Event;
+(void) clearAllTimedEvents;


/**
 * 设置属性 键值对 会覆盖同名的key
 */
+(void) registerProperty:(NSDictionary *)property;

/**
 * 删除属性
 * @param key
 */
+(void) unregisterProperty:(NSString *)key;

/**
 * 获取某个KEY的属性值
 * @param key
 * @return
 */
+(NSString *)getProperty:(NSString *)key;
/**
 *返回当前用户的所有超级属性。
 */
+(NSDictionary *)getProperties;
/**
 *清除所有的超级属性
 */
+(void)clearProperties;


/**
 * 设置属性 键值对 会覆盖同名的key
 * 将该函数指定的key-value写入dplus专用文件；APP启动时会自动读取该文件的所有key-value，并将key-value自动作为后续所有track事件的属性。
 */
+(void) registerSuperProperty:(NSDictionary *)property;

/**
 *
 * 从dplus专用文件中删除指定key-value
 * @param key
 */
+(void) unregisterSuperProperty:(NSString *)key;

/**
 *
 * 返回dplus专用文件中key对应的value；如果不存在，则返回空。
 * @param key
 * @return
 */
+(NSString *)getSuperProperty:(NSString *)key;
/**
 *
 * 返回dplus专用文件中的所有key-value；如果不存在，则返回空。
 */
+(NSDictionary *)getSuperProperties;
/**
 *清空dplus专用文件中的所有key-value。
 */
+(void)clearSuperProperties;


/**
 *修改event 中的distinct_id，默认取did
 */
+(void)identify:(NSString *) distinct_id;
/**
 *清除所有的超级属性，如果设置了identify则重新取回did
 */
+(void) clear;

//获取distinct_id值
+(NSString *)getDistinctId;
@end
