//
//  UIView+ChangeFrame.m
//  ZhaoKaifaAPP
//
//  Created by upworld on 13-5-22.
//  Copyright (c) 2014年 eastedge. All rights reserved.
//

#import "UIView+ChangeFrame.h"

@implementation UIView (ChangeFrame)

-(void)setOrigin:(CGPoint)origin{
    CGRect oldFrame=self.frame;
    oldFrame.origin=origin;
    self.frame=oldFrame;
}
-(void)setSize:(CGSize)size{
    CGRect oldFrame=self.frame;
    oldFrame.size=size;
    self.frame=oldFrame;
}
@end
