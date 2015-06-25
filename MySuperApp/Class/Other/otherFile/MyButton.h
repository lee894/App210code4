//
//  MyButton.h
//  paipaiiphone
//
//  Created by yanglee on 14-8-25.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton

@property(nonatomic,assign) BOOL btnisSelected;

@property(nonatomic,retain) NSString *btntype;
@property(nonatomic,retain) NSString *addstring;

@property(nonatomic,retain) NSString *addtitle;

@property(nonatomic,retain) NSString *addimageurl;


@property(nonatomic,assign) int btntypeid;
@property(nonatomic,assign)  int btngroup;
@property(nonatomic,retain) NSString *btntitle;

@property(nonatomic,retain) NSString *btnname;


@property(nonatomic,assign) BOOL isOpenCell;
@property(nonatomic,assign) NSInteger index;



@end
