//
//  StarLevelView.m
//  趣付
//
//  Created by user on 13-3-29.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "StarLevelView.h"

@implementation StarLevelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat startWidth = self.frame.size.width/5.0;

        for (int i = 0; i < 5; i++) {
            UIButton *startBut = [UIButton buttonWithType:UIButtonTypeCustom];
            [startBut setImage:[UIImage imageNamed:@"evaluate_star_gray.png"] forState:UIControlStateNormal];
            [startBut setImage:[UIImage imageNamed:@"evaluate_star_red.png"] forState:UIControlStateSelected];
            startBut.tag = 100+i;
            startBut.frame = CGRectMake(startWidth*i, 0, 22, 22);
            [startBut addTarget:self action:@selector(evaluationStarLevel:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:startBut];
        }
    }
    return self;
}

-(void)chooseStarLevelAction:(NSInteger)star {
    
    [self evaluationStarLevel:(UIButton *)[self viewWithTag:star+99]];
}

- (void)evaluationStarLevel:(UIButton *)sender {
        
    self.starLevel = [NSString stringWithFormat:@"%i",sender.tag - 99];
    
    for (int i = 0; i < 5; i++) {
        [(UIButton *)[self viewWithTag:i+100] setSelected:NO];
    }

    for (int j = 0; j<= sender.tag-100; j++) {
        [(UIButton *)[self viewWithTag:j+100] setSelected:YES];
    }


}

@end
