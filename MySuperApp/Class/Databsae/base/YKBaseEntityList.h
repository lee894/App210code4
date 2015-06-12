//
//  YKBaseEntityList.h
//  YKProduct
//
//  Created by kangbo on 11-10-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseEntity.h"

@interface YKBaseEntityList : YKBaseEntity {
}
-(int) count;

-(NSMutableArray*) childArray;

-(id) objectAtIndex:(NSUInteger)index;
-(void) addObject:(id) object;
-(void) addList:(YKBaseEntityList*) alist;
-(void) removeAllObjects;
-(void) removeObject:(id) object;

-(int) pageCount;
-(void) setPageCount:(int) pageCount;

-(int) currentPage;
-(void)setCurrentPage:(int) page;

-(int)totalCount;
-(void) setTotalCount:(int) aTotalCount;


-(void) exchangeObjectAtIndex:(int) a withObjectAtIndex:(int) b;
-(NSUInteger)indexOfObject:(id)anObject;
@end
