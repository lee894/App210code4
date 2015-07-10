//
//  CategoryView.m
//  Shop
//
//  Created by bonan on 13-8-27.
//  Copyright (c) 2014年 xiexianhui. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

- (id)initWithFrame:(CGRect)frame type:(NSInteger)theType delegate:(id<CategoryViewDelegate>)theDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        delegate = theDelegate;
        type = theType;
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 320, 2)];
        [imgView setImage:[UIImage imageNamed:@"devider_line"]];
        [imgView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:imgView];
    }
    return self;
}

- (void)loadViewWithDic:(NSDictionary *)theDic
{
    NSLog(@"%@",theDic);
    NSArray *tmpArr = [theDic objectForKey:@"subTitleArr"];
    self.dicData = theDic;

    NSInteger count = [tmpArr count];
    
    for (int i = 0; i < count; i++) {
        NSString *tmpName = [tmpArr objectAtIndex:i];
        
        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tmpBtn.tag = i+1;
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@"sort_bg_02"] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@"sort_bg_02_press"] forState:UIControlStateHighlighted];
        tmpBtn.frame = CGRectMake(5+(i%3)*105, 5+(i/3)*45, 100, 40);
        [tmpBtn setTitle:tmpName forState:UIControlStateNormal];
        [tmpBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [tmpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tmpBtn addTarget:self action:@selector(btnPinClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tmpBtn];
    }
    
    CGRect rect = self.frame;
    rect.size.height = ceil(count/3.0)*45 + 10;
    self.frame = rect;


    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 5, 320, 2)];
    [imgView setBackgroundColor:[UIColor clearColor]];
    [imgView setImage:[UIImage imageNamed:@"devider_line"]];
    [self addSubview:imgView];
}

#pragma mark-- 三级分类的按钮点击
- (void)btnPinClick:(UIButton *)sender
{
    //NSLog(@"%d",sender.tag);
    switch (type) {
        case 1:{//女士
            
        }break;
        case 2:{//男士
            
        }break;
        case 3:{//女童
            
        }break;
        case 4:{//男童
            
        }break;
        default:
            break;
    }
    NSString *str = [NSString stringWithFormat:@"%@/%@",self.titleStr,sender.titleLabel.text];
    
    NSLog(@"sendsender:%@",self.titleStr);
    
    if (delegate && [delegate respondsToSelector:@selector(categoryWithID:title:)]) {
        NSArray *tmpArrID = [self.dicData objectForKey:@"subIDArr"];
        NSString *tmpStrId = @"";
        if ([tmpArrID count] >= sender.tag) {
            tmpStrId = [tmpArrID objectAtIndex:sender.tag-1];
        } else {
            tmpStrId = @"无";
        }
        [delegate categoryWithID:tmpStrId title:str];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
