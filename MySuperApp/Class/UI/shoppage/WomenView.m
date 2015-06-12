////
////  WomenView.m
////  Shop
////
////  Created by bonan on 13-8-26.
////  Copyright (c) 2014年 xiexianhui. All rights reserved.
////
//
//#import "WomenView.h"
//#import "AimerShopViewController.h"
//#import "CategoryView.h"
//#import "MYMacro.h"
//
//#define kTag 1000
//#define kBtnHeight 64
//#define kBtnPinHeight 44
//
//@implementation WomenView
//
//- (id)initWithFrame:(CGRect)frame type:(NSInteger)theType
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        type = theType;
//        [self setBackgroundColor:[UIColor clearColor]];
//    }
//    return self;
//}
//
//#pragma mark 加图片 标题
//- (void)loadBtnWithTitle:(NSString *)theTitle imgName:(NSString *)theImgName btn:(UIButton *)theBtn
//{
//    [theBtn setBackgroundImage:[UIImage imageNamed:@"sort_bg_02.png"] forState:UIControlStateNormal];
//    [theBtn setBackgroundImage:[UIImage imageNamed:@"sort_bg_02_press.png"] forState:UIControlStateHighlighted];
//    
//    UIImageView *tmpImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, kBtnHeight/2-3, 10, 6)];
//    tmpImgView.tag = 100;
//    tmpImgView.image = [UIImage imageNamed:@"sort_arrow_down.png"];
//    [theBtn addSubview:tmpImgView];
//    
//    UILabel *tmpLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 70, kBtnHeight)];
//    tmpLabelTitle.text = theTitle;
//    tmpLabelTitle.tag = 101;
//    [tmpLabelTitle setBackgroundColor:[UIColor clearColor]];
//    [tmpLabelTitle setFont:[UIFont systemFontOfSize:14]];
//    [theBtn addSubview:tmpLabelTitle];
//    
//    UIImageView *tmpImgViewContent = [[UIImageView alloc] initWithFrame:CGRectMake(100, kBtnHeight/2-20, 40, 40)];
//    tmpImgViewContent.image = [UIImage imageNamed:theImgName];
//    [theBtn addSubview:tmpImgViewContent];
//}
//
//#pragma mark 加载数据
//- (void)loadViewWithArray:(NSArray *)theArr
//{
//    arrData = [[NSArray alloc] initWithArray:theArr];
//    
//    NSArray *tmpArr = [arrData objectAtIndex:0];
//    int count = [tmpArr count];
//    for (int i = 0; i < count; i++) {
//        NSDictionary *tmpDic = [tmpArr objectAtIndex:i];
//        NSString *tmpStrTitle = [tmpDic objectForKey:@"title"];
//        NSString *tmpImgName = [tmpDic objectForKey:@"imgName"];
//        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        tmpBtn.tag = i+1;
//        tmpBtn.frame = CGRectMake(5+(i%2)*160, 5+(i/2)*(kBtnHeight +6), 150, kBtnHeight);
//        [tmpBtn addTarget:self action:@selector(btnCareClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:tmpBtn];
//        
//        [self loadBtnWithTitle:tmpStrTitle imgName:tmpImgName btn:tmpBtn];
//        
//    }
//    
//    /**
//     品牌
//     */
//    CGFloat height = ceil(count/2.0)*(kBtnHeight +6)+10;
//    
//    pinView = [[UIView alloc] initWithFrame:CGRectMake(0, height, 320, 0)];
//    [pinView setBackgroundColor:[UIColor clearColor]];
//    [self addSubview:pinView];
//    
//    UIImageView *tmpImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 2)];
//    tmpImgView.image = [UIImage imageNamed:@"devider_line-1"];
//    [pinView addSubview:tmpImgView];
//    
//    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
//    [tmpLabel setFont:[UIFont systemFontOfSize:14]];
//    [tmpLabel setBackgroundColor:[UIColor clearColor]];
//    [tmpLabel setTextAlignment:NSTextAlignmentCenter];
//    tmpLabel.text = @"品牌";
//    [pinView addSubview:tmpLabel];
//    
//    tmpImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 320, 2)];
//    tmpImgView.image = [UIImage imageNamed:@"devider_line-1"];
//    [pinView addSubview:tmpImgView];
//    
//    NSArray *tmpPinArr = [arrData objectAtIndex:1];
//    int pinCount = [tmpPinArr count];
//    for (int i = 0; i < pinCount; i++) {
//        NSString *tmpName = [tmpPinArr objectAtIndex:i];
//        
//        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        tmpBtn.tag = i+1;
//        tmpBtn.frame = CGRectMake(5+(i%3)*102, 30+(i/3)*(kBtnPinHeight+6), 98, kBtnPinHeight);
//        [tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 4, 2, 4)];
//        [tmpBtn setImage:[UIImage imageNamed:tmpName] forState:UIControlStateNormal];
//        [tmpBtn setBackgroundImage:[UIImage imageNamed:@"sort_bg_02"] forState:UIControlStateNormal];
//        [tmpBtn setBackgroundImage:[UIImage imageNamed:@"sort_bg_02_press"] forState:UIControlStateHighlighted];
//        [tmpBtn addTarget:self action:@selector(btnPinClick:) forControlEvents:UIControlEventTouchUpInside];
//        [pinView addSubview:tmpBtn];
//    }
//    
//    CGRect rect = pinView.frame;
//    rect.size.height = ceil(pinCount/3.0)*(kBtnPinHeight+6)+40;
//    pinView.frame = rect;
//    
//    rect = self.frame;
//    rect.size.height = height + pinView.frame.size.height;
//    self.frame = rect;
//    
//}
//
//#pragma mark 加载儿童的数据
//- (void)loadViewKidsWithArray:(NSArray *)theArr
//{
//    arrData = [[NSArray alloc] initWithArray:theArr];
//    CGFloat height = 0;
//    
//    UILabel *tmpLabelKids = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 310, 20)];
//    tmpLabelKids.text = @"女童";
//    [tmpLabelKids setBackgroundColor:[UIColor clearColor]];
//    [tmpLabelKids setFont:[UIFont systemFontOfSize:14]];
//    [tmpLabelKids setTextColor:[UIColor colorWithHexString:@"0xB90023"]];//UIColorFromRGB(0xB90023)];
//    [self addSubview:tmpLabelKids];
//    
//    height = 25;
//    /**
//     女童
//     */
//    NSArray *tmpArr = [arrData objectAtIndex:0];
//    int count = [tmpArr count];
//    for (int i = 0; i < count; i++) {
//        NSDictionary *tmpDic = [tmpArr objectAtIndex:i];
//        NSString *tmpStrTitle = [tmpDic objectForKey:@"title"];
//        NSString *tmpImgName = [tmpDic objectForKey:@"imgName"];
//        
//        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        tmpBtn.tag = i+1;
//        tmpBtn.frame = CGRectMake(5+(i%2)*160, height+(i/2)*(kBtnHeight +6), 150, kBtnHeight);
//        [tmpBtn addTarget:self action:@selector(btnCareClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:tmpBtn];
//        
//        [self loadBtnWithTitle:tmpStrTitle imgName:tmpImgName btn:tmpBtn];
//        
//    }
//    
//    height += ceil(count/2.0)*(kBtnHeight +6);
//    
//    tmpLabelKids = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 310, 20)];
//    tmpLabelKids.tag = 300;
//    tmpLabelKids.text = @"男童";
//    [tmpLabelKids setBackgroundColor:[UIColor clearColor]];
//    [tmpLabelKids setFont:[UIFont systemFontOfSize:14]];
//    [tmpLabelKids setTextColor:[UIColor colorWithHexString:@"0xB90023"]];
//    [self addSubview:tmpLabelKids];
//    
//    height +=25;
//    /**
//     男童
//     */
//    if (count%2==1) {
//        count++;
//    }
//    
//    tmpArr = [arrData objectAtIndex:1];
//    int mencount = [tmpArr count];
//    for (int i = 0; i < mencount; i++) {
//        NSDictionary *tmpDic = [tmpArr objectAtIndex:i];
//        NSString *tmpStrTitle = [tmpDic objectForKey:@"title"];
//        NSString *tmpImgName = [tmpDic objectForKey:@"imgName"];
//        
//        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        tmpBtn.tag = count+i+1;
//        tmpBtn.frame = CGRectMake(5+(i%2)*160, height+(i/2)*(kBtnHeight +6), 150, kBtnHeight);
//        [tmpBtn addTarget:self action:@selector(btnCareClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:tmpBtn];
//        
//        [self loadBtnWithTitle:tmpStrTitle imgName:tmpImgName btn:tmpBtn];
//        
//    }
//    
//    //    count +=  [tmpArr count];
//    /**
//     品牌
//     */
//    height += ceil(mencount/2.0)*(kBtnHeight +6)+10;
//    
//    pinView = [[UIView alloc] initWithFrame:CGRectMake(0, height, 320, 0)];
//    [pinView setBackgroundColor:[UIColor clearColor]];
//    [self addSubview:pinView];
//    
//    UIImageView *tmpImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 2)];
//    tmpImgView.image = [UIImage imageNamed:@"devider_line"];
//    [pinView addSubview:tmpImgView];
//    
//    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
//    [tmpLabel setFont:[UIFont systemFontOfSize:14]];
//    [tmpLabel setBackgroundColor:[UIColor clearColor]];
//    [tmpLabel setTextAlignment:NSTextAlignmentCenter];
//    tmpLabel.text = @"品牌";
//    [pinView addSubview:tmpLabel];
//    
//    tmpImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 320, 2)];
//    tmpImgView.image = [UIImage imageNamed:@"devider_line"];
//    [pinView addSubview:tmpImgView];
//    
//    NSArray *tmpPinArr = [arrData objectAtIndex:2];
//    int pinCount = [tmpPinArr count] ;
//    for (int i = 0; i < pinCount; i++) {
//        NSString *tmpName = [tmpPinArr objectAtIndex:i];
//        
//        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        tmpBtn.tag = i+1;
//        tmpBtn.frame = CGRectMake(5+(i%3)*102, 30+(i/3)*(kBtnPinHeight+6), 98, kBtnPinHeight);
//        [tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 4, 2, 4)];
//        [tmpBtn setImage:[UIImage imageNamed:tmpName] forState:UIControlStateNormal];
//        
//        [tmpBtn setBackgroundImage:[UIImage imageNamed:@"sort_bg_02"] forState:UIControlStateNormal];
//        [tmpBtn setBackgroundImage:[UIImage imageNamed:@"sort_bg_02_press"] forState:UIControlStateHighlighted];
//        
//        [tmpBtn addTarget:self action:@selector(btnPinClick:) forControlEvents:UIControlEventTouchUpInside];
//        [pinView addSubview:tmpBtn];
//    }
//    
//    CGRect rect = pinView.frame;
//    rect.size.height = ceil(pinCount/3.0)*(kBtnPinHeight+6)+40;
//    pinView.frame = rect;
//    
//    rect = self.frame;
//    rect.size.height = height + pinView.frame.size.height;
//    self.frame = rect;
//}
//
//#pragma mark 二级分类的按钮事件
//- (void)btnCareClick:(UIButton *)sender
//{
//    
//    //    CGRect oldFrame = self.viewCtrl.contentView.frame;
//    //    oldFrame.origin.y -=30;
//    //    self.viewCtrl.contentView.frame = oldFrame;
//    //
//    //    CGFloat height = 0;
//    //    CGRect rect1 = self.viewCtrl.contentView.frame;
//    //    rect1.size.height = height;
//    //    self.viewCtrl.contentView.frame = rect1;
//    //    CGSize size = CGSizeMake(320, height+rect1.origin.y);
//    //
//    //    [self.viewCtrl.scrollview setContentSize:size];
//    //    //lee894设置首页的高度~~
//    //    //适配屏幕及系统版本
//    //    rect1 = self.viewCtrl.scrollview.frame;
//    //    if (isIOS7up) {
//    //        rect1.size.height =  ScreenHeight-50;
//    //    }else if(isIOS6Down){
//    //        rect1.size.height =  ScreenHeight-50-44;
//    //    }else{
//    //        rect1.size.height =  ScreenHeight-50-64;
//    //    }
//    //    self.viewCtrl.scrollview.frame = rect1;
//    
//    
//    
//    NSLog(@"分类%d-----",sender.tag);
//    UILabel *labelTitle = (UILabel *)[sender viewWithTag:101];
//    
//    NSMutableString *strTitle = [NSMutableString string];
//    if (type == 1) {//女士
//        [strTitle appendFormat:@"女士/%@",labelTitle.text];
//    } else if (type == 2) {//男士
//        [strTitle appendFormat:@"男士/%@",labelTitle.text];
//    } else {
//    }
//    
//    //标题label
//    NSLog(@"%@",labelTitle.text);
//    CGRect rect = sender.frame;
//    rect.origin.x = 0;
//    rect.origin.y = sender.frame.origin.y + sender.frame.size.height;
//    rect.size.width = 320;
//    if (type != 3) {//女士  男士
//        
//        NSArray *tmpArr = [arrData objectAtIndex:0];
//        NSInteger tmpIndex = 0;
//        
//        if (type == 3) {
//            if (sender.tag > [tmpArr count]) {//点击的是男童
//                tmpIndex = sender.tag - [tmpArr count] - 2;
//                tmpArr = [arrData objectAtIndex:1];
//                
//            } else {
//                tmpIndex = sender.tag - 1;
//            }
//        } else {
//            tmpIndex = sender.tag - 1;
//        }
//        
//        
//        NSMutableDictionary *tmpDic = [tmpArr objectAtIndex:tmpIndex];
//        NSInteger isOpen = [[tmpDic objectForKey:@"isOpen"] integerValue];
//        CategoryView *tmpView = (CategoryView *)[self viewWithTag:sender.tag + kTag];
//        if (tmpView == nil) {
//            tmpView = [[CategoryView alloc] initWithFrame:rect type:type delegate:self.viewCtrl];
//            tmpView.tag = sender.tag + kTag;
//            [tmpView loadViewWithDic:tmpDic];
//            [self addSubview:tmpView];
//        } else {
//            //lee9999888866666
//            rect.size.height = tmpView.frame.size.height;
//            tmpView.frame = rect;
//        }
//        tmpView.titleStr = strTitle;
//        
//        NSInteger tmpTag = 0;//计算跟当前点击按钮在一行的按钮tag
//        if ((sender.tag - 1)%2 == 0) {//后一个按钮
//            tmpTag = sender.tag + 1;
//        } else if ((sender.tag - 1)%2 == 1) {//前一个按钮
//            tmpTag = sender.tag - 1;
//        }
//        CategoryView *tmpLastView = (CategoryView *)[self viewWithTag:tmpTag + kTag];
//        if (tmpLastView && tmpView.frame.origin.y == tmpLastView.frame.origin.y) {
//            //当之前点击的和当前点击的是同一行的时候  重新设置self的rect
//            NSMutableDictionary *tmpLastDic = [tmpArr objectAtIndex:tmpTag-1];
//            
//            if (!tmpLastView.hidden && tmpLastView) {//已经出现
//                UIButton *tmpLastBtn = (UIButton *)[self viewWithTag:tmpTag];
//                UIImageView *tmpImgViewCurrent = (UIImageView *)[tmpLastBtn viewWithTag:100];
//                tmpImgViewCurrent.transform = CGAffineTransformMakeRotation(2*M_PI);
//                [tmpLastView setHidden:YES];
//                [tmpLastDic setObject:@"0" forKey:@"isOpen"];
//                [self removeLastViewWithRect:tmpLastView.frame tag:tmpTag isMoveStates:NO];
//            }
//        }
//        
//        rect = self.frame;
//        rect.size.height = self.frame.size.height + tmpView.frame.size.height;
//        self.frame = rect;
//        
//        UIImageView *tmpImgViewCurrent = (UIImageView *)[sender viewWithTag:100];
//        //////////当前点击的按钮释放打开
//        NSInteger moveY = 0;
//        if (isOpen == 0) {//关闭状态
//            tmpImgViewCurrent.transform = CGAffineTransformMakeRotation(-M_PI);
//            isOpen = 1;
//            moveY = tmpView.frame.size.height;
//            [tmpView setHidden:NO];
//        } else {
//            tmpImgViewCurrent.transform = CGAffineTransformMakeRotation(2*M_PI);
//            moveY = -tmpView.frame.size.height;
//            [tmpView setHidden:YES];
//            isOpen = 0;
//        }
//        [tmpDic setObject:[NSString stringWithFormat:@"%d",isOpen] forKey:@"isOpen"];
//        
//        
//        
//        NSInteger vTag = sender.tag;
//        if ((sender.tag - 1)%2 == 0) {
//            if (type == 3) {
//                if ([tmpArr count]%2==0 || sender.tag <= [[arrData objectAtIndex:0] count]) {
//                    vTag++;
//                }
//            } else {
//                vTag++;
//            }
//        }
//        //设置按钮的位置
//        for (UIView *v in [self subviews]) {
//            if (v.tag > vTag && v.tag < kTag) {
//                CGRect rectV = v.frame;
//                if (type == 3) {
//                    if (sender.tag <= [[arrData objectAtIndex:0] count]) {
//                        rectV.origin.y = v.frame.origin.y + moveY;
//                    } else {
//                        if (v.tag != 300) {
//                            rectV.origin.y = v.frame.origin.y + moveY;
//                        }
//                    }
//                } else {
//                    rectV.origin.y = v.frame.origin.y + moveY;
//                }
//                v.frame = rectV;
//                
//            }
//        }
//        //根据按钮的位置来设置子视图的位置
//        for (UIView *v in [self subviews]) {
//            if (v.tag > kTag) {
//                UIButton *tmpBtn = (UIButton *)[self viewWithTag:v.tag - kTag];
//                CGRect rectV = v.frame;
//                rectV.origin.y = tmpBtn.frame.origin.y + tmpBtn.frame.size.height;
//                v.frame = rectV;
//            }
//        }
//        
//        rect = pinView.frame;
//        rect.origin.y = pinView.frame.origin.y + moveY;
//        pinView.frame = rect;
//        
//        
//        rect = self.frame;
//        rect.size.height = pinView.frame.origin.y + pinView.frame.size.height;
//        self.frame = rect;
//        //lee999这个地方看着好像有点意思
//        [self.viewCtrl viewWithHeight:self.frame type:type];
//        
//        if (!sender.selected) {
//            [self.viewCtrl.scrollview setContentOffset:CGPointMake(0, sender.frame.origin.y + self.frame.origin.y)animated:YES];
//        }
//        sender.selected = !sender.selected;
//        
//    } else {
//        NSArray *tmpArr = [arrData objectAtIndex:0];
//        NSInteger grilCount = [tmpArr count];
//        NSInteger tmpIndex = 0;
//        NSInteger subIndex = 1;
//        NSInteger theType = type;
//        
//        if (sender.tag > grilCount) {//点击的是男童
//            if (grilCount%2==1) {//当女童是奇数的时候，subIndex需要加1
//                subIndex++;
//            }
//            tmpIndex = sender.tag - grilCount - subIndex;
//            tmpArr = [arrData objectAtIndex:1];
//            theType = type + 1;
//            
//            [strTitle appendFormat:@"男童/%@",labelTitle.text];
//            
//        } else {
//            tmpIndex = sender.tag - 1;
//            [strTitle appendFormat:@"女童/%@",labelTitle.text];
//        }
//        
//        NSMutableDictionary *tmpDic = [tmpArr objectAtIndex:tmpIndex];
//        NSInteger isOpen = [[tmpDic objectForKey:@"isOpen"] integerValue];
//        CategoryView *tmpView = (CategoryView *)[self viewWithTag:sender.tag + kTag];
//        if (tmpView == nil) {
//            
//            
//            tmpView = [[CategoryView alloc] initWithFrame:rect type:theType delegate:self.viewCtrl];
//            tmpView.tag = sender.tag + kTag;
//            [tmpView loadViewWithDic:tmpDic];
//            [self addSubview:tmpView];
//        } else {
//            rect.size.height = tmpView.frame.size.height;
//            tmpView.frame = rect;
//        }
//        
//        tmpView.titleStr = strTitle;
//        
//        
//        BOOL state = NO;
//        NSInteger tmpTag = 0;//计算跟当前点击按钮在一行的按钮tag
//        NSInteger tmpArrIndex = 0;
//        if ((tmpIndex)%2 == 0) {//取同行的后面一个
//            if (sender.tag <= grilCount) {//当前点击的是女童
//                tmpTag = sender.tag + 1;
//                tmpArrIndex = tmpTag - 1;
//            } else {//当前点击的是男童
//                state = YES;
//                tmpTag =  sender.tag + 1;
//                tmpArrIndex = tmpTag - grilCount -subIndex;
//            }
//        } else if ((tmpIndex)%2 == 1) {//取同行的前面一个
//            
//            if (sender.tag <= grilCount) {//当前点击的是女童
//                tmpTag = sender.tag - 1;
//                tmpArrIndex = tmpTag - 1;
//            } else {//当前点击的是男童
//                state = YES;
//                tmpTag = sender.tag-1;
//                tmpArrIndex = tmpTag - grilCount -subIndex;
//            }
//        }
//        CategoryView *tmpLastView = (CategoryView *)[self viewWithTag:tmpTag + kTag];
//        if (tmpLastView && tmpView.frame.origin.y == tmpLastView.frame.origin.y) {
//            //当之前点击的和当前点击的是同一行的时候  重新设置self的rect
//            NSMutableDictionary *tmpLastDic = [tmpArr objectAtIndex:tmpArrIndex];
//            
//            if (!tmpLastView.hidden && tmpLastView) {//已经出现
//                UIButton *tmpLastBtn = (UIButton *)[self viewWithTag:tmpTag];
//                UIImageView *tmpImgViewCurrent = (UIImageView *)[tmpLastBtn viewWithTag:100];
//                tmpImgViewCurrent.transform = CGAffineTransformMakeRotation(2*M_PI);
//                
//                [tmpLastView setHidden:YES];
//                [tmpLastDic setObject:@"0" forKey:@"isOpen"];
//                [self removeLastViewWithRect:tmpLastView.frame tag:tmpTag isMoveStates:state];
//            }
//        }
//        
//        rect = self.frame;
//        rect.size.height = self.frame.size.height + tmpView.frame.size.height;
//        self.frame = rect;
//        
//        UIImageView *tmpImgViewCurrent = (UIImageView *)[sender viewWithTag:100];
//        //////////当前点击的按钮释放打开
//        NSInteger moveY = 0;
//        if (isOpen == 0) {//关闭状态
//            isOpen = 1;
//            tmpImgViewCurrent.transform = CGAffineTransformMakeRotation(-M_PI);
//            moveY = tmpView.frame.size.height;
//            [tmpView setHidden:NO];
//        } else {
//            tmpImgViewCurrent.transform = CGAffineTransformMakeRotation(2*M_PI);
//            moveY = -tmpView.frame.size.height;
//            [tmpView setHidden:YES];
//            isOpen = 0;
//        }
//        [tmpDic setObject:[NSString stringWithFormat:@"%d",isOpen] forKey:@"isOpen"];
//        
//        
//        NSInteger vTag = sender.tag;
//        if ((sender.tag - 1)%2 == 0) {
//            if (type == 3) {
//                if ([tmpArr count]%2==0 || sender.tag <= [[arrData objectAtIndex:0] count]) {
//                    vTag++;
//                }
//            } else {
//                vTag++;
//            }
//        }
//        //设置按钮的位置
//        for (UIView *v in [self subviews]) {
//            if (v.tag > vTag && v.tag < kTag) {
//                CGRect rectV = v.frame;
//                if (type == 3) {
//                    if (v.tag != 300) {
//                        rectV.origin.y = v.frame.origin.y + moveY;
//                    } else {
//                        if (sender.tag <= grilCount) {
//                            rectV.origin.y = v.frame.origin.y + moveY;
//                        }
//                    }
//                } else {
//                    rectV.origin.y = v.frame.origin.y + moveY;
//                }
//                
//                v.frame = rectV;
//            }
//        }
//        
//        //根据按钮的位置来设置子视图的位置
//        for (UIView *v in [self subviews]) {
//            if (v.tag > kTag) {
//                UIButton *tmpBtn = (UIButton *)[self viewWithTag:v.tag - kTag];
//                CGRect rectV = v.frame;
//                rectV.origin.y = tmpBtn.frame.origin.y + tmpBtn.frame.size.height;
//                v.frame = rectV;
//            }
//        }
//        
//        rect = pinView.frame;
//        rect.origin.y = pinView.frame.origin.y + moveY;
//        pinView.frame = rect;
//        
//        
//        rect = self.frame;
//        rect.size.height = pinView.frame.origin.y + pinView.frame.size.height;
//        self.frame = rect;
//        
//        [self.viewCtrl viewWithHeight:self.frame type:type];
//        
//        if (!sender.selected) {
//            [self.viewCtrl.scrollview setContentOffset:CGPointMake(0, sender.frame.origin.y + self.frame.origin.y)animated:YES];
//        }
//        sender.selected = !sender.selected;
//    }
//    
//    //    CGPoint oldponit = self.viewCtrl.scrollview.contentOffset;
//    //    oldponit.y +=30;
//    //    [self.viewCtrl.scrollview setContentOffset:oldponit];
//}
//
//
//#pragma mark 品牌的按钮事件
//- (void)btnPinClick:(UIButton *)sender
//{
//    
//    NSMutableString *strTitle = [NSMutableString string];
//    if (type == 1) {//女士
//        [strTitle appendFormat:@"女士/%@",@""];
//    } else if (type == 2) {//男士
//        [strTitle appendFormat:@"男士/%@",@""];
//    } else {
//        [strTitle appendFormat:@"儿童/%@",@""];
//    }
//    
//    
//    NSArray *tmpArrID = [arrData lastObject];
//    NSString *tmpStrId = @"";
//    if ([tmpArrID count] >= sender.tag) {
//        NSString *tmpStr = [tmpArrID objectAtIndex:sender.tag-1];
//        NSArray *arrayIDAndTitle = [tmpStr componentsSeparatedByString:@"--"];
//        tmpStrId = [arrayIDAndTitle objectAtIndex:0];
//        if (tmpStrId.length == 0) {
//            tmpStrId = @"";
//        }
//        strTitle = [arrayIDAndTitle lastObject];
//        
//    } else {
//        tmpStrId = @"";
//    }
//    [self.viewCtrl brandWithID:tmpStrId title:strTitle];
//}
//
//
//#pragma mark 当之前点击的和当前点击的是同一行的时候  重新设置self的rect
//- (void)removeLastViewWithRect:(CGRect)theRect tag:(NSInteger)theTag isMoveStates:(BOOL)isStates
//{
//    CGRect rect = self.frame;
//    rect.size.height = self.frame.size.height - theRect.size.height;
//    self.frame = rect;
//    
//    NSInteger moveY = -theRect.size.height;
//    
//    NSInteger vTag = theTag;
//    if ((theTag - 1)%2 == 0) {
//        vTag++;
//    }
//    for (UIView *v in [self subviews]) {
//        if (v.tag > vTag && v.tag < kTag) {
//            CGRect rectV = v.frame;
//            if (type == 3) {
//                if (isStates) {//点击的是男童 一行
//                    if (v.tag == 300) {
//                        rectV.origin.y = v.frame.origin.y;
//                    } else {
//                        rectV.origin.y = v.frame.origin.y + moveY;
//                    }
//                } else {
//                    rectV.origin.y = v.frame.origin.y + moveY;
//                }
//                
//            } else {
//                rectV.origin.y = v.frame.origin.y + moveY;
//            }
//            
//            v.frame = rectV;
//        }
//    }
//    
//    rect = pinView.frame;
//    rect.origin.y = pinView.frame.origin.y + moveY;
//    pinView.frame = rect;
//    
//    
//    rect = self.frame;
//    rect.size.height = pinView.frame.origin.y + pinView.frame.size.height;
//    self.frame = rect;
//}
//
//@end