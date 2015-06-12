//
//  ModifyCell.h
//  MySuperApp
//
//  Created by 念肆 on 14-9-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModifyCell;

typedef  void (^DeleteMessage) (NSInteger index); ///声明块



@protocol ModifyCellDelegate <NSObject>

- (void)selectReceiveview:(int)index;

//修改孩子的生日
-(void)changeChildBirthday:(int)index;

@end

@interface ModifyCell : UITableViewCell<UITextFieldDelegate>


@property (retain, nonatomic)  UILabel *headlineLabel;
@property (retain, nonatomic)  UITextField *statureTfield;
@property (nonatomic,retain) UITextField * nameLabel;
@property (nonatomic,retain) UIButton * birthdayLabelBtn;
@property (nonatomic,retain) NSString * gender;
@property (nonatomic,retain) UIButton * deleteBtn;

@property (nonatomic, assign) id<ModifyCellDelegate> delegate;


@property (nonatomic, copy) DeleteMessage deleteChirder;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)btnClick:(id)sender;


@end
