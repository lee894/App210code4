//
//  YKBaseEntityList.m
//  YKProduct
//
//  Created by kangbo on 11-10-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YKBaseEntityList.h"

NSString* const YK_KEY_PAGE_COUNT=@"total_pages";
NSString* const YK_KEY_CURRENT_PAGE=@"current_page";
NSString* const YK_KEY_COUNT=@"total_count";


@implementation YKBaseEntityList

-(id) init{
	self=[super init];
	if(nil!=self){
	}
	return self;
}

-(NSMutableArray*) childArray{
	NSMutableArray* ret=nil;
	ret=[self attributeForKey:@"childArray"];
	if(ret==nil){
		ret=[[NSMutableArray alloc] init];
		[self setAttribute:ret forKey:@"childArray"];
//		[ret release];
	}
	assert(ret!=nil);
	return ret;
}

//-(void) dealloc{
//	[super dealloc];
//}

-(int) count{
	return [[self childArray] count];
}

-(id) objectAtIndex:(NSUInteger)index{
	//	assert(index>=0 && index<[[self childArray] count]);
	return [[self childArray] objectAtIndex:index];
}

-(void) addObject:(id)object{
	[[self childArray] addObject:object];
}
-(void) addList:(id)alist{
    //lee999 150608
	for(int i=0;i<[(NSArray*)alist count];++i){
		[self addObject:[alist objectAtIndex:i]];
	}
}
-(void) removeAllObjects{
	[[self childArray] removeAllObjects];
}

-(void) removeObject:(id) object{
	[[self childArray] removeObject:object];
}

-(int) currentPage{
	int ret=0;
	NSNumber* num=[self attributeForKey:YK_KEY_CURRENT_PAGE];	
	if(nil!=num){
		ret=[num intValue];
	}
	return ret;
}

-(void) setCurrentPage:(int)page{
	[self setAttribute:[NSNumber numberWithInt:page] forKey:YK_KEY_CURRENT_PAGE];
}



-(int) pageCount{
	int ret=0;
	NSNumber* num=[self attributeForKey:YK_KEY_PAGE_COUNT];
	if(num!=nil){
		ret=[num intValue];
	}
	return ret;
}

-(void) setPageCount:(int)pageCount{
	[self setAttribute:[NSNumber numberWithInt:pageCount] forKey:YK_KEY_PAGE_COUNT];
}

-(int)totalCount{
	return [[self attributeForKey:@"total_count"] intValue];
}
-(void) setTotalCount:(int) aTotalCount{
	[self setAttribute:[NSString stringWithFormat:@"%d",aTotalCount] forKey:@"total_count"];
}


-(void) exchangeObjectAtIndex:(int) a withObjectAtIndex:(int) b{
	[[self childArray] exchangeObjectAtIndex:a withObjectAtIndex:b];
}

-(NSUInteger) indexOfObject:(id)anObject{
	return [[self childArray] indexOfObject:anObject];
}

@end
