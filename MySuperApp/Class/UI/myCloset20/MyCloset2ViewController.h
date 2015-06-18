//
//  MyCloset2ViewController.h
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "MyClosetParser.h"


@interface MyCloset2ViewController : LBaseViewController

@property(nonatomic,assign) NSInteger selectType; //1 女士，2 男士 3，儿童  4定制

@property(nonatomic,retain) MyClosetInfo *closetinfo;



- (IBAction)nextBtnAction:(id)sender;



@end
