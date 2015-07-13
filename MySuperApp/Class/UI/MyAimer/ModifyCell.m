//
//  ModifyCell.m
//  MySuperApp
//
//  Created by 念肆 on 14-9-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ModifyCell.h"
#import "MYMacro.h"
#import "SingletonState.h"

@implementation ModifyCell
@synthesize delegate = _delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setCell];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setCell
{
    
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(keyboardWillShowOnDelay22:)
//                                                name:UIKeyboardWillShowNotification
//                                              object:nil];
    
    
    _headlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 8, 73, 31)];
    _headlineLabel.font = [UIFont systemFontOfSize:15];
    _headlineLabel.backgroundColor = [UIColor clearColor];
    _headlineLabel.text = @"儿童信息";
    [self addSubview:_headlineLabel];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(125, 10, 100, 20);
    [_deleteBtn setTitleColor:[UIColor colorWithHexString:@"0xB90023"] forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor colorWithHexString:@"0xB90023"] forState:UIControlStateHighlighted];
    [_deleteBtn setTitle:@"*删除" forState:UIControlStateNormal];
    _deleteBtn.tag = 50;
    [_deleteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteBtn];
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 52, 66, 22)];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"姓名:";
    [self addSubview:nameLabel];
    
    UIImageView * statureImageView2 = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"list_input.png"]
    //lee给view设置为圆角，不再使用图片了。 -140512
    [statureImageView2 setBackgroundColor:[UIColor whiteColor]];
//    [SingletonState setViewRadioSider:statureImageView2];
    statureImageView2.frame = CGRectMake(105, 41, 195, 40);
    [self addSubview:statureImageView2];
    
    _nameLabel = [[UITextField alloc] initWithFrame:CGRectMake(125, 41, 150, 40)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.tag=1;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.delegate = self;
    [self addSubview:_nameLabel];
    
    UILabel * genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 102, 35, 19)];
    genderLabel.font = [UIFont systemFontOfSize:15];
    genderLabel.backgroundColor = [UIColor clearColor];
    genderLabel.text = @"性别:";
    [self addSubview:genderLabel];
    
    UIButton * boyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    boyBtn.frame = CGRectMake(115, 100, 22, 22);
    boyBtn.tag = 21;
    [boyBtn setImage:[UIImage imageNamed:@"choice_checked.png"] forState:UIControlStateNormal];
    [boyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:boyBtn];
    
    UILabel * boyLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 102, 31, 19)];
    boyLabel.font = [UIFont systemFontOfSize:15];
    boyLabel.backgroundColor = [UIColor clearColor];
    boyLabel.text = @"男孩";
    [self addSubview:boyLabel];
    
    UIButton * girlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    girlBtn.frame = CGRectMake(214, 100, 22, 22);
    girlBtn.tag = 22;
    [girlBtn setImage:[UIImage imageNamed:@"choice_unchecked.png"] forState:UIControlStateNormal];
    [girlBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:girlBtn];
    
    UILabel * girlLabel = [[UILabel alloc] initWithFrame:CGRectMake(244, 102, 31, 19)];
    girlLabel.font = [UIFont systemFontOfSize:15];
    girlLabel.backgroundColor = [UIColor clearColor];
    girlLabel.text = @"女孩";
    [self addSubview:girlLabel];
    
    UILabel * birthdayLaebl = [[UILabel alloc] initWithFrame:CGRectMake(25, 152, 68, 21)];
    birthdayLaebl.font = [UIFont systemFontOfSize:15];
    birthdayLaebl.backgroundColor = [UIColor clearColor];
    birthdayLaebl.text = @"出生日期:";
    [self addSubview:birthdayLaebl];
    
    UIImageView * statureImageView1 = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"list_input.png"]
    //lee给view设置为圆角，不再使用图片了。 -140512
//    [SingletonState setViewRadioSider:statureImageView1];
    [statureImageView1 setBackgroundColor:[UIColor whiteColor]];
    statureImageView1.frame = CGRectMake(105, 141, 195, 40);
    [self addSubview:statureImageView1];
    
    _birthdayLabelBtn = [[UIButton alloc] initWithFrame:CGRectMake(125, 141, 150, 40)];
    _birthdayLabelBtn.backgroundColor = [UIColor clearColor];
    _birthdayLabelBtn.tag =2;
    [_birthdayLabelBtn setTitle:@"" forState:UIControlStateNormal];
    [_birthdayLabelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _birthdayLabelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_birthdayLabelBtn addTarget:self action:@selector(changeMyChildBrith:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_birthdayLabelBtn];
    
    UILabel * statureLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 200, 40, 20)];
    statureLabel.font = [UIFont systemFontOfSize:15];
    statureLabel.backgroundColor = [UIColor clearColor];
    statureLabel.text = @"身高:";
    [self addSubview:statureLabel];
    
    UIImageView * statureImageView = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"list_input.png"]
    //lee给view设置为圆角，不再使用图片了。 -140512
//    [SingletonState setViewRadioSider:statureImageView];
    statureImageView.frame = CGRectMake(105, 190, 170, 40);
    [statureImageView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:statureImageView];
    
    _statureTfield = [[UITextField alloc] initWithFrame:CGRectMake(115, 190, 190, 40)];
    _statureTfield.keyboardType = UIKeyboardTypeNumberPad;
    _statureTfield.textColor = [UIColor lightGrayColor];
    _statureTfield.delegate = self;
    _statureTfield.tag = 3;
    _statureTfield.font = [UIFont systemFontOfSize:14.];
    [self addSubview:_statureTfield];
    
    UILabel * CMLabel = [[UILabel alloc] initWithFrame:CGRectMake(277, 195, 40, 30)];
    CMLabel.font = [UIFont systemFontOfSize:15];
    CMLabel.backgroundColor = [UIColor clearColor];
    CMLabel.text = @"CM";
    [self addSubview:CMLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}


//- (void)keyboardWillShowOnDelay22:(NSNotification *)notification
//{
//    NSDictionary *userInfo = [notification userInfo];
//    NSLog(@"----%@",userInfo);
//    
////    if (_birthdayLabel) {
////        [_statureTfield resignFirstResponder];
////        [_nameLabel resignFirstResponder];
////
////    }
//}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([_delegate respondsToSelector:@selector(selectReceiveview:)])
    {
        [_delegate selectReceiveview:textField.tag];
    }
    return YES;
}

-(void)changeMyChildBrith:(id)sender{

    UIButton *btn = (UIButton*)sender;
    if ([_delegate respondsToSelector:@selector(changeChildBirthday:)]) {
        [_delegate changeChildBirthday:btn.tag];
    }
    
}


- (void)btnClick:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    if (btn.tag == 21) {
        UIButton * girlBtn = (UIButton *)[self viewWithTag:22];
        [btn setImage:[UIImage imageNamed:@"choice_checked.png"] forState:UIControlStateNormal];
        [girlBtn setImage:[UIImage imageNamed:@"choice_unchecked.png"] forState:UIControlStateNormal];
        self.gender = @"m";
    } else if (btn.tag == 22) {
        UIButton * boyBtn = (UIButton *)[self viewWithTag:21];
        [btn setImage:[UIImage imageNamed:@"choice_checked.png"] forState:UIControlStateNormal];
        [boyBtn setImage:[UIImage imageNamed:@"choice_unchecked.png"] forState:UIControlStateNormal];
        self.gender = @"f";
    }else {
        
        if (self.deleteChirder) {
            
            self.deleteChirder(self.tag);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
