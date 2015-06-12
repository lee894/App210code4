//
//  YKRatingControl.m
//  RedBaby
//
//  Created by  on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#import <QuartzCore/QuartzCore.h>
#import "YKRatingControl.h"

@implementation YKRatingControl

- (id)initWithRating:(float)rating andOrigin:(CGPoint)origin
{
    if (self = [super init]) {
        // Initialization code
        fullGrayStar = [UIImage imageNamed:@"05_detial_star2.png"];
        fullYellowStar = [UIImage imageNamed:@"05_detial_star1.png"];
        
        [self setFrame:CGRectMake(origin.x, origin.y,  fullYellowStar.size.width, fullYellowStar.size.height)];
        
        fullYellowCount = rating / 1;
        persentOfNotFullStar = ((int)(rating * 10) % 10) / 10.0;
        NSLog(@"%f", persentOfNotFullStar);
        [self updateRatingControl];
    }
    return self;
}

-(void)updateRatingControl
{
    for (int i = 0; i < fullYellowCount; ++i) {
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(i * fullYellowStar.size.width, 0, fullYellowStar.size.width, fullYellowStar.size.height)];
        [img setImage:fullYellowStar];
        [self addSubview:img];
    }
    if (fullYellowCount < 5) {
        UIImageView* imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(fullYellowCount * fullYellowStar.size.width, 0, fullYellowStar.size.width, fullYellowStar.size.height)];
        [imgBg setImage:fullGrayStar];
        [self addSubview:imgBg];
        
        UIView* mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fullYellowStar.size.width * persentOfNotFullStar, fullYellowStar.size.height)];
        [mask.layer setMasksToBounds:YES];
        [mask setBackgroundColor:[UIColor clearColor]];
        [imgBg addSubview:mask];
        
        UIImageView* imgFullYellowStar = [[UIImageView alloc] initWithImage:fullYellowStar];
        [mask addSubview:imgFullYellowStar];
    }
    for (int i = fullYellowCount + 1; i < 5; ++i) {
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(i * fullGrayStar.size.width, 0, fullGrayStar.size.width, fullGrayStar.size.height)];
        [img setImage:fullGrayStar];
        [self addSubview:img];
    }
}
@end
