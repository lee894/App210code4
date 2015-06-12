//
//  YKRatingControl.h
//  RedBaby
//
//  Created by  on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//等级星星（评分）

#import <UIKit/UIKit.h>

@interface YKRatingControl : UIView
{
    UIImage* fullYellowStar;
    UIImage* fullGrayStar;
    int fullYellowCount;
    float persentOfNotFullStar; 
}
- (id)initWithRating:(float)rating andOrigin:(CGPoint)origin;
-(void)updateRatingControl;
@end

