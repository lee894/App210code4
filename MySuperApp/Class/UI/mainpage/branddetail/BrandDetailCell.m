////
////  BrandDetailCell.h
////  aimeronle
////
////  Created by gaoge on 14-3-25.
////  Copyright (c) 2014年 zan. All rights reserved.
////
//
//#import "BrandDetailCell.h"
//#import "MYMacro.h"
//
//@implementation BrandDetailCell
//@synthesize buttonProduct,buttonStory,buttonNew,buttonMessage,buttonWeibo,imageViewWeibo,labelWeibo;
//
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//}
//
//#pragma mark -- 设置背景图片
//
//- (void)setKindImageWithArray:(NSArray *)arrayKind//设置各个小模块的背景图片
//{
//    
//    [self.buttonProduct setBackgroundImageFromUrl:YES withUrl:[arrayKind objectAtIndex:0]];
//    [self.buttonNew setBackgroundImageFromUrl:YES withUrl:[arrayKind objectAtIndex:2]];
//    [self.buttonMessage setBackgroundImageFromUrl:YES withUrl:[arrayKind objectAtIndex:3]];
//    [self.buttonStory setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[arrayKind objectAtIndex:1]]] forState:UIControlStateNormal];
//    [self.buttonStory setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[arrayKind objectAtIndex:1]]] forState:UIControlStateHighlighted];
//}
//
//- (void)attentionWeibo:(NSString *)content//关注微博文字内容和微博图片
//{
//    self.labelWeibo.text = content;
//    if ([self.labelWeibo.text isEqualToString:@"暂未开通"]) {
//        self.imageViewWeibo.image = [UIImage imageNamed:@"sina00_icon_gray.png"];
//        self.buttonWeibo.enabled = NO;
//    }
//}
//@end
