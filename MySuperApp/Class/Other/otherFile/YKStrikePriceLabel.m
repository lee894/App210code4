//
//  YKStrikePriceLabel.m
//  letao
//
//  Created by jiang bonan on 11-9-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "YKStrikePriceLabel.h"

@implementation YKStrikePriceLabel

- (id)init
{

    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGFloat black[4] = {129.0f/255, 129.0f/255, 129.0f/255, 1.0f};
    CGContextSetStrokeColor(c, black);
    CGContextSetLineWidth(c, 1.0f);
    CGContextBeginPath(c);
    CGFloat halfWayUp = (self.bounds.size.height - self.bounds.origin.y) / 2.0;
    CGContextMoveToPoint(c, self.bounds.origin.x, halfWayUp);
    CGContextAddLineToPoint(c, self.bounds.origin.x + self.bounds.size.width, halfWayUp);
    CGContextStrokePath(c);
    [super drawRect:rect];
}
@end
