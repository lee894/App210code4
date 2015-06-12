//
//  BluePageController.h
//  ReadNovelProject
//
//  Created by eastedge on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BluePageControl : UIPageControl<UIScrollViewDelegate>{
    UIImage *activeImage;
    UIImage *inactiveImage;
}
@property (nonatomic,retain)    UIImage *activeImage;
@property (nonatomic,retain)    UIImage *inactiveImage;


@property (nonatomic,assign) CGSize imgSize;


@end
