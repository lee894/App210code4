//
//  MyCloset1ViewController.h
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

@interface MyCloset1ViewController : LBaseViewController
{

    __weak IBOutlet UILabel *titlenameLab;
    
    
    __weak IBOutlet UIButton *nextBtn;
}

@property(nonatomic,strong)NSString *strselecttype; //已选中的风格
@property(nonatomic,assign)BOOL isaddPeople; //已选中的风格


- (IBAction)typeSelectAction:(id)sender;


- (IBAction)nextBtnAction:(id)sender;




@end
