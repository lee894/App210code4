//
//  SizeViewController.h
//  MySuperApp
//
//  Created by lee on 14-3-27.
//  Copyright (c) 2014年 aimer. All rights reserved.
//


#import "LBaseViewController.h"

@interface SizeViewController : LBaseViewController<UIScrollViewDelegate>

{
    IBOutlet UIView *myallView;
    
    IBOutlet UIScrollView *myscrollingV;

}

- (IBAction)changeType:(UIButton *)sender;
@end
