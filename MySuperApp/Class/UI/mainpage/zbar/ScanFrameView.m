//
//  ScanFrameView.m
//
//
//  Created by gaoge on 14-3-23.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ScanFrameView.h"

@implementation ScanFrameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        
    }
    return self;
}


- (void)lineImageViewAn  {
    [UIView animateWithDuration:4.0 animations:^(void) {
        self.lineImagView.frame = CGRectMake(0, 192, 200, 8);
    } completion:^(BOOL finish){
        self.lineImagView.frame = CGRectMake(0, 0, 200, 8);
        [self lineImageViewAn];
    }];

    
    
}

@end
