//
//  YKEntity.h
//  YKDataSource
//
//  Created by lee on 14-3-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YKEntity

-(void) setAttribute:(id) aobj forKey:(id) akey;
-(id) attributeForKey:(id) akey;

@end
