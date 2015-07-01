//
//  MyCloset3ViewController.h
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

@interface MyCloset3ViewController : LBaseViewController

@property(nonatomic,retain) MyClosetInfo *closetinfo;

@property(nonatomic,retain) NSMutableArray *arr_selectStyle;



- (IBAction)nextBtnAction:(id)sender;

@end
