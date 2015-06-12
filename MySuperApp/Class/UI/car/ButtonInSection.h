//
//  ButtonInSection.h
//  ChiHao
//
//  Created by user on 12-2-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@protocol ButtonInSeactionDelegate;

@interface ButtonInSection : UIView
{
    MBProgressHUD *HUD;//提示框

}
@property(nonatomic,retain)UILabel *sectionLable;
@property(nonatomic,retain)UIButton *sectionButton;
@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)id<ButtonInSeactionDelegate> delegate;
@property(nonatomic,assign)BOOL opened;
@property(nonatomic,retain)NSArray *arr;
@property(nonatomic,retain)NSDictionary *dataDic;

-(id)initWithFrame:(CGRect)frame title:(id)otherID section:(NSInteger )sectionnumber opened:(BOOL)isopened delegate:(id<ButtonInSeactionDelegate>)aDelegate;
-(IBAction)toggleAction:(id)sender;

@end




@protocol ButtonInSeactionDelegate <NSObject>

@optional
-(void)sectionHeaderView:(ButtonInSection*)sectionHeaderView sectionClosed:(NSInteger)section;
-(void)sectionHeaderView:(ButtonInSection*)sectionHeaderView sectionOpened:(NSInteger)section;
@end
