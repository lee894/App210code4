//
//  AnnotationView.m
//  MySuperApp
//
//  Created by LEE on 14-4-8.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "AnnotationView.h"

@implementation AnnotationView
@synthesize imageAnnotation;
@synthesize tag;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        if (self.tag ==11) {
            UIImageView *tempImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin_green.png"] highlightedImage:[UIImage imageNamed:@"pin_green.png"]];
            tempImage.frame = CGRectMake(0, 0, 30, 30.);
            self.imageAnnotation = tempImage;
            [self addSubview:self.imageAnnotation];
        }else{
            UIImageView *tempImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shop_icon_location.png"] highlightedImage:[UIImage imageNamed:@"shop_icon_location_press.png"]];
            tempImage.frame = CGRectMake(0, 0, 30, 30.);
            self.imageAnnotation = tempImage;
            [self addSubview:self.imageAnnotation];
        }
        
    }
    
    return self;
}


@end
