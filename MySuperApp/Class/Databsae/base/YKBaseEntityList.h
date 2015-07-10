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
-(NSInteger) count;

-(NSMutableArray*) childArray;

-(id) objectAtIndex:(NSUInteger)index;
-(void) addObject:(id) object;
-(void) addList:(YKBaseEntityList*) alist;
-(void) removeAllObjects;
-(void) removeObject:(id) object;

-(NSInteger) pageCount;
-(void) setPageCount:(int) pageCount;

-(NSInteger) currentPage;
-(void)setCurrentPage:(int) page;

-(NSInteger)totalCount;
-(void) setTotalCount:(int) aTotalCount;


-(void) exchangeObjectAtIndex:(int) a withObjectAtIndex:(int) b;
-(NSUInteger)indexOfObject:(id)anObject;
@end
