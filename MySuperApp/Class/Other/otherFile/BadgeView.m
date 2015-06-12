//
//  BadgeView.h
//  letao
//
//  Created by caiting on 11-7-26.
//  Copyright 2011 yek. All rights reserved.
//

#import "BadgeView.h"
//#import "MYMacro.h"

@implementation BadgeView
@synthesize badgeValue;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		nums=[[NSMutableArray alloc] initWithCapacity:10];
		[nums removeAllObjects];
		//UIImage *image =[YK_MyImage getUIImage:@"number_bg.png"];
        //		UIImage *image =[UIImage imageNamed:@"pic174.png"];
        //		bg_img = [image stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        //         if (isRetina) {
        //              bg_img = [image stretchableImageWithLeftCapWidth:15 topCapHeight:0];
        //         }else{
        //              bg_img = [image stretchableImageWithLeftCapWidth:15 topCapHeight:0];
        //         }
		
		iv_bg=[[UIImageView alloc]initWithImage:bg_img];
		
		for(int i=0;i<10;i++)
		{
			NSString *filePath = [[NSString alloc] initWithFormat:@"num%d.png",i];
			[nums addObject:[UIImage imageNamed:filePath]];
		}
		[self setUserInteractionEnabled: NO];
		self.backgroundColor=[UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	if (badgeValue == 0)
		return;
	if(badgeValue>=1000)
	{
		[[UIImage imageNamed:@"pic176.png"] drawInRect:CGRectMake(0, 0, 49, 24)];
		[(UIImage *)[nums objectAtIndex:badgeValue/1000] drawAtPoint:CGPointMake(9,4)];
		[(UIImage *)[nums objectAtIndex:(badgeValue-(badgeValue/1000)*1000)/100] drawAtPoint:CGPointMake(16,4)];
		[(UIImage *)[nums objectAtIndex:(badgeValue-(badgeValue/100)*100)/10] drawAtPoint:CGPointMake(23,4)];
		[(UIImage *)[nums objectAtIndex:badgeValue-(badgeValue/10)*10] drawAtPoint:CGPointMake(30,4)];
	}
	else if(badgeValue>=100)
	{
		
		[[UIImage imageNamed:@"pic176.png"] drawInRect:CGRectMake(0, 0, 41, 24)];
		[(UIImage *)[nums objectAtIndex:badgeValue/100] drawAtPoint:CGPointMake(9,4)];
		[(UIImage *)[nums objectAtIndex:(badgeValue-(badgeValue/100)*100)/10] drawAtPoint:CGPointMake(16,4)];
		[(UIImage *)[nums objectAtIndex:badgeValue-(badgeValue/10)*10] drawAtPoint:CGPointMake(23,4)];
	}
	else if(badgeValue>=10)
	{
		[[UIImage imageNamed:@"pic175.png"] drawInRect:CGRectMake(0, 0, 32, 24)];
		[(UIImage *)[nums objectAtIndex:badgeValue/10] drawAtPoint:CGPointMake(9,4)];
		[(UIImage *)[nums objectAtIndex:badgeValue-(badgeValue/10)*10] drawAtPoint:CGPointMake(16,4)];
	}
	else if(badgeValue>0)
	{
		//		[bg_img drawAtPoint:CGPointMake(0,0)];
		[[UIImage imageNamed:@"pic174.png"] drawInRect:CGRectMake(5, 0, 24, 24)];
		[(UIImage *)[nums objectAtIndex:badgeValue] drawAtPoint:CGPointMake(14,4)];
	}
	
	
	
}

-(void)setBadge:(int)_badgeValue
{
	badgeValue=_badgeValue;
	[self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.nextResponder touchesBegan:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.nextResponder touchesMoved:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.nextResponder touchesEnded:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.nextResponder touchesCancelled:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
}
//- (void)dealloc {
//	for (UIView *view in [self subviews]) {
//		[view removeFromSuperview];
//	}
//	[self removeFromSuperview];
//}


@end


@implementation UIView (addbadge)

-(BadgeView*) badgeView{
	BadgeView* ret=(BadgeView*)[self viewWithTag:YK_TAG_BADGE_VIEW_SUBVIEW];
	if(ret==nil){
		float selfWidth=self.frame.size.width;
		float badgeWidth=50;
		float badgeHeight=33;
		CGRect badgeFrame=CGRectMake(selfWidth-badgeWidth, 0 , badgeWidth, badgeHeight);
		ret=[[BadgeView alloc] initWithFrame:badgeFrame];
		ret.tag=YK_TAG_BADGE_VIEW_SUBVIEW;
		[self addSubview:ret];
	}
	assert([ret isKindOfClass:[BadgeView class]]);
	
	return ret;
}
-(void) setBadgeNum:(int)anum{
	BadgeView* badgeView=[self badgeView];
	assert(badgeView!=nil);
	[badgeView setBadge:anum];
	badgeView.hidden=(anum==0);
}
-(int) badgeNum{
	BadgeView* badgeView=[self badgeView];
	assert(badgeView!=nil);
	return [badgeView badgeValue];
}

@end

