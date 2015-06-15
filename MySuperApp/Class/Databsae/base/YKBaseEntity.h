//
//  YKBaseEntity.h
//  YKProduct
//
//  Created by lee on 14-3-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//const
static NSString*  KEY_RESULT;
static NSString*  VALUE_RESULT_SUCCESS;

@protocol BaseEntityDelegate <NSObject>

-(id) attributeForKey:(id)akey;

-(void) setAttribute:(id)aobj forKey:(id)akey;

-(NSString *) description;
@end

@interface YKBaseEntity : NSObject <BaseEntityDelegate> {
    int nType_;
    NSMutableDictionary* attributeDic_;
}
@property (nonatomic) int nType;
@property (nonatomic, retain) NSMutableDictionary* attributeDic;
-(BOOL) hasError;
@end
