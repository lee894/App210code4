//
//  NewBigViewController.h
//  MySuperApp
//
//  Created by bonan on 14-4-22.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LBaseViewController.h"

@interface NewBigViewController : LBaseViewController<UIScrollViewDelegate> {

    IBOutlet UIButton *goMillBut;

    __weak IBOutlet UIScrollView *myImageScroll;
    IBOutlet UrlImageView *bigImageV;
}

@property (nonatomic, retain) NSString *imagePath;

@property (nonatomic, retain) NSString *productID;
- (IBAction)pushback:(id)sender;

@end
