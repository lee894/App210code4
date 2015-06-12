//
//  YKBaseEntity.m
//  YKProduct
//
//  Created by lee on 14-3-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YKBaseEntity.h"
#import "JSON.h"
//#import "YKStringHelper.h"

@implementation YKBaseEntity
@synthesize type = type_;
@synthesize attributeDic = attributeDic_;
-(id) init{
    if((self=[super init])){
        attributeDic_=[[NSMutableDictionary alloc] init];
    }
    return self;
    
}

-(id) attributeForKey:(id)akey{
    return [attributeDic_ objectForKey:akey];
}

-(void) setAttribute:(id)aobj forKey:(id)akey{
    assert(akey!=nil);
    if(aobj==nil){
        [attributeDic_ removeObjectForKey:akey];
    }else{
        [attributeDic_ setObject:aobj forKey:akey];
    }
}

-(BOOL) hasError{
    BOOL ret=YES;
    NSString* result=[self attributeForKey:KEY_RESULT];
    if(result!=nil && [result isEqualToString:VALUE_RESULT_SUCCESS]){
        ret=NO;
    }
    return ret;
}
//这个方法是重写方法
-(NSString *) description{
    
    NSString* ret=[NSString stringWithFormat:@"%@ {\n",[self class]];
    NSArray* keyArray=[attributeDic_ allKeys];
    for(id key in keyArray){
        ret=[ret stringByAppendingFormat:@"\t%@=%@,\n",key,[attributeDic_ objectForKey:key]];
    }
    ret=[ret stringByAppendingString:@"}"];
    
    return ret;
}

@end