//
//  PicsView.m
//  ThreePicViewTry
//
//  Created by user on 13-10-11.
//  Copyright (c) 2014年 eastedge. All rights reserved.
//

#import "PicsView.h"
#import "NogiftsItem.h"
#import "UrlImageButton.h"
#import "MYMacro.h"

@implementation PicsView

CGFloat RowHeight = 165;
CGFloat Margin = 9;
CGFloat InnerMargin = 4;

+ (CGFloat)heightForDatas:(NSArray *)datas type:(NSInteger)theType
{
    if (theType == 1) {
    }
    return RowHeight * (datas.count/3 + 1) + 20;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithDatas:(NSArray *)datas andDic:(NSDictionary *)theDic
{
    NSInteger theType = [[theDic objectForKey:@"isSelect"] integerValue];
    
    NSString *str = [theDic objectForKey:@"select"];
    
    NSInteger numberOfLines = datas.count / 3 + 1;
    CGFloat width = (320 - Margin*2)/3.0;
    self.array = datas;
    self = [self initWithFrame:CGRectMake(0, 0, 320, numberOfLines * RowHeight)];
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, 320, 20)];
    _labelTitle.font = [UIFont systemFontOfSize:14];
    _labelTitle.backgroundColor = [UIColor clearColor];
    [_labelTitle setTextColor:RGBACOLOR(190, 0, 38, 1)];
    _labelTitle.textAlignment = UITextAlignmentCenter;
    _labelTitle.text = @"您还没有达到赠品要求，暂时不能选择此赠品";
    [self addSubview:_labelTitle];
    
    if (str.length != 0) {
        _labelTitle.text = str;
    }
    
    for (int i=0; i < datas.count; i++) {
        
        NogiftsItem *nogifts = [datas objectAtIndex:i];
        NSInteger column = i%3;
        NSInteger row = i/3;
        NSLog(@"%d %d", i, column);
        NSLog(@"----%f", Margin + width * column);
        UIImageView *imvBg = [[UIImageView alloc] initWithFrame:CGRectMake(Margin + width * column , row * RowHeight, width, 120)];
        imvBg.image = [UIImage imageNamed:@"same_pic_bg"];

        [self addSubview:imvBg];

        
        UrlImageButton *btn = [[UrlImageButton alloc] initWithFrame:CGRectMake(Margin + InnerMargin + width * column , row * RowHeight + InnerMargin, width - InnerMargin * 2, 120 - 2 * InnerMargin)];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnsTapped:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImageWithURL:[NSURL URLWithString:nogifts.img_url] placeholderImage:nil];
        [self addSubview:btn];
        [btn setBackgroundColor:[UIColor clearColor]];

        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14 + width * column, row * RowHeight +  131, 88, 28)];
        label.text = nogifts.goos_name;//@"爱慕梦幻水晶1/2中模杯。。。。。。。。";
        label.font = [UIFont systemFontOfSize:12];
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithWhite:45/255.0 alpha:1];
        [self addSubview:label];
        
        if (i == datas.count - 1) {
            CGRect rect = _labelTitle.frame;
            rect.origin.y = label.frame.size.height + label.frame.origin.y + 5;
            _labelTitle.frame = rect;
        }
    }

    if (theType == 1) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(81, 2, 28, 28)];
        imgView.image = [UIImage imageNamed:@"choice_checked.png"];
        [self addSubview:imgView];
    }
    
    return self;
}

- (void)btnsTapped:(UIButton *)btn
{
    NSInteger index = btn.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [_delegate didSelectItemAtIndex:[self.array objectAtIndex:index]];
    }
}

@end
