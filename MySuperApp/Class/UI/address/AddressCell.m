//
//  AddressCell.m
//  MySuperApp
//
//  Created by LEE on 14-4-1.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "AddressCell.h"
#import "SingletonState.h"
#import "NSString+WPAttributedMarkup.h"

@implementation AddressCell
@synthesize imageCheck;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) {
        UIImageView *tempArrow = (UIImageView *) [self viewWithTag:31];
        
        
        
        CGRect oldF = lineView.frame;
        oldF.size = CGSizeMake(ScreenWidth, 0.5);
        [lineView setFrame:oldF];
        
        
        tempArrow.hidden = NO;
//        imageBackground.image =[UIImage imageNamed:@"list_bg_edit.png"];
        //lee给view设置为圆角，不再使用图片了。 -140512
//        [SingletonState setViewRadioSider:imageBackground];
//        imageBackground.frame = CGRectMake(25, imageBackground.frame.origin.y, 255, 84);
//        labelName.frame = CGRectMake(35, imageBackground.frame.origin.y +7, 150, 21);
//        labelMessage.frame = CGRectMake(35, imageBackground.frame.origin.y +30, 230, 30);
//        labelPhone.frame = CGRectMake(33, imageBackground.frame.origin.y+55, 150, 21);
//        tempArrow.frame = CGRectMake(265,imageBackground.frame.origin.y+35, 7, 11);
        
        labelName.frame = CGRectMake(25, 20, lee1fitAllScreen(100), 21);
        labelMessage.frame = CGRectMake(25, 43, lee1fitAllScreen(220), 30);
        labelPhone.frame = CGRectMake(24, 73, lee1fitAllScreen(200), 21);

    }else{
        [[self viewWithTag:31] setHidden:YES];
//        imageBackground.image = [UIImage imageNamed:@"list_bg_edit.png"];//IMAGE(@"list_bg_suggest", @"png");
        //lee给view设置为圆角，不再使用图片了。 -140512
//        [SingletonState setViewRadioSider:imageBackground];
//        imageBackground.frame = CGRectMake(10, imageBackground.frame.origin.y, 300, 96);
        labelName.frame = CGRectMake(25, 20, lee1fitAllScreen(150), 21);
        labelMessage.frame = CGRectMake(25, 43, lee1fitAllScreen(270), 30);
        labelPhone.frame = CGRectMake(24, 73, lee1fitAllScreen(200), 21);
    }
}

- (void)setContentWithArray:(AddressAddresslist *)address
{
    
    NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14],
                             @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:14],
                             @"red": [UIColor redColor]};
    
    if ([address.defaultFlag isEqualToString:@"yes"]) {
        
        labelName.attributedText = [[NSString stringWithFormat:@"%@     <red>默认地址</red>",address.userName] attributedStringWithStyleBook:style1];        
    }else{
        labelName.text = address.userName;
    }
    
    labelMessage.text = [NSString stringWithFormat:@"地址：%@%@%@%@",address.province,address.city,address.county,address.address];
    labelPhone.text = [NSString stringWithFormat:@"电话：%@",address.mobile];
    
}

@end
