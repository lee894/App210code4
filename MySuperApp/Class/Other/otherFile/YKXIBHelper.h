//
//  YKXIBHelper.h
//  VANCL
//
//  Created by sihai on 10-11-24.
//  Copyright 2010 yek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YKXIBHelper : NSObject {

}

/*
 从xib中加载对象，对象类型如type
 参数：
	xibName：
		xib文件名，没.xib 后缀
	type:
		类型。xib中遍历top level object 返回第一个此类型的对象 [*** class];
 返回值：
	nil：
		未找到
 */
+(id)loadObjectFromXIBName:(NSString*) xibName type:(Class) type ;

/*
 从xib中加载对象，对象类型如type
 参数：
	 xibName：
		 xib文件名，没.xib 后缀
	 type:
		 类型。xib中遍历top level object 返回第一个此类型的对象 [*** class];
	index:
		序号，在xib中所有此类型中的第几个
 返回值：
	 nil：
		 未找到
 */
+(id)loadObjectFromXIBName:(NSString*) xibName type:(Class) type index:(int) index ;

@end
