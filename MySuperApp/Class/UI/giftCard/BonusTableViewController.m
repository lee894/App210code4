//
//  BonusTableViewController.m
//  爱慕商场
//
//  Created by malan on 14-9-25.
//  Copyright (c) 2014年 zan. All rights reserved.
//  

#import "BonusTableViewController.h"

@interface BonusTableViewController ()

@end

@implementation BonusTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.title = @"积分优惠";
    
    //lee999 防止位置偏移
    if (isIOS7up) {
        self.mytableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-65);
    }
    //end
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
