//
//  ShowcomMentViewController.m
//  MySuperApp
//
//  Created by bonan on 14-4-9.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ShowcomMentViewController.h"
#import "StarLevelView.h"
#import "ShowComMentView.h"
#import "MyAimerViewController.h"
#import "MoreRateViewController.h"
#import "AccessViewController.h"
#import "SingletonState.h"

//由于原来的位置问题，增加一下 contentSize的高度
#define AddContentHight 40


@interface ShowcomMentViewController ()

@end

@implementation ShowcomMentViewController
@synthesize isFromMyAimer;
@synthesize isHiddenBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //lee999 来自我的爱慕的话 增加高度
    
    scrollContent.contentSize = CGSizeMake(ScreenWidth, 500+ AddContentHight);
    scrollContent.frame = CGRectMake(0, 0, ScreenWidth, isFromMyAimer? self.view.frame.size.height: self.view.frame.size.height-50);
    scrollContent.frame = CGRectMake(0, 0, ScreenWidth, isHiddenBar? self.view.frame.size.height: self.view.frame.size.height-50);

    
    self.title = @"商品评价";
    [self createBackBtnWithType:0];
    
    
    for (int i = 0; i<3; i++) {
        StarLevelView *starView = [[StarLevelView alloc] initWithFrame:CGRectMake(83, 47+i*30, 150, 30)];
        [starView chooseStarLevelAction:5];
        [viewBackground addSubview:starView];
        starView.tag = 1000+i;
        for (int j = 0; j < 5; j++) {
            [starView viewWithTag:100+j].userInteractionEnabled = NO;
        }
    }
    
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    [mainSev getShowcomment:self.goodId andPage:@"1" andPer_page:@"10"];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

//我要评价
//lee999 要求注释掉，不在这个界面进行评价了，只能在订单里面进行评价
- (void)rightButAction {
    BOOL islogin = [SingletonState sharedStateInstance].userHasLogin;
    
	if (islogin) {
        AccessViewController *accessCtrl = [[AccessViewController alloc]init];
        accessCtrl.goodId = self.goodId;
        [self.navigationController pushViewController:accessCtrl animated:YES];
    } else {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录",nil];
		alert.tag = 10;
		[alert show];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (alertView.tag == 10) {
		if (buttonIndex == 1) {

            [self changeToMyaimer];
		}
	}
}

#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    switch (model.requestTag) {            
        case Http_Showcomment_Tag:
        {
            if (!model.errorMessage) {
                
                showModel = (ShowcomMentModel *)model;
                
                ShowcomMentScore *showScore = showModel.score;
                
                
                if ([showModel.type_name rangeOfString:@"文胸"].location != NSNotFound) {
                    
                }else if ([showModel.type_name rangeOfString:@"保暖"].location != NSNotFound||[showModel.type_name rangeOfString:@"睡衣"].location != NSNotFound) {
                    
                    labelTitleTow.text = @"面料薄厚";
                 
                    for (int i = 91; i < 94; i++) {
                        [(UILabel *)[viewBackground viewWithTag:i] setHidden:YES];
                    }
                    
                    [labelTitileThree setHidden:YES];
                    [labelThree setHidden: YES];
                    [labelThree2 setHidden: YES];
                    [labelThree3 setHidden:YES];
                    
                    imageOrder_three.hidden = YES;
                    labelTitileThree.hidden = YES;
                    
                }else if ([showModel.type_name rangeOfString:@"家居"].location != NSNotFound) {
                    labelTitleTow.text = @"面料薄厚";
                    [(UILabel *)[viewBackground viewWithTag:81] setText:@"薄款"];
                    [(UILabel *)[viewBackground viewWithTag:83] setText:@"厚款"];
                    
                    for (int i = 91; i < 94; i++) {
                        [(UILabel *)[viewBackground viewWithTag:i] setHidden:YES];
                    }
                    
                    [labelTitileThree setHidden:YES];
                    [labelThree setHidden: YES];
                    [labelThree2 setHidden: YES];
                    [labelThree3 setHidden:YES];
                    imageOrder_three.hidden = YES;
                    
                    labelTitileThree.hidden = YES;
                }else {
                    
                    for (int i = 81; i < 84; i++) {
                        [(UILabel *)[viewBackground viewWithTag:i] setHidden:YES];
                    }
                    
                    for (int i = 91; i < 94; i++) {
                        [(UILabel *)[viewBackground viewWithTag:i] setHidden:YES];
                    }
                    
                    [labelTitileThree setHidden:YES];
                    [labelThree setHidden: YES];
                    [labelThree2 setHidden: YES];
                    [labelThree3 setHidden:YES];
                    
                    [labelTitleTow setHidden:YES];
                    [labelTow setHidden: YES];
                    [labelTow2 setHidden: YES];
                    [labelTow3 setHidden:YES];
                    
                    imageOrder_three.hidden = YES;
                    imageOrder_tow.hidden = YES;
                    
                    labelTitleTow.hidden = YES;
                    labelTitileThree.hidden = YES;
                }
                
       
            
              NSString *str1 = [showScore.zongheScore stringByReplacingOccurrencesOfString:@"%" withString:@""];
              NSString *str2 = [showScore.waiguanScore stringByReplacingOccurrencesOfString:@"%" withString:@""];
              NSString *str3 = [showScore.sushiduScore stringByReplacingOccurrencesOfString:@"%" withString:@""];
                
                
                [(StarLevelView *)[viewBackground viewWithTag:1000] chooseStarLevelAction:[str1 integerValue]/20];
                [(StarLevelView *)[viewBackground viewWithTag:1001] chooseStarLevelAction:[str2 integerValue]/20];
                [(StarLevelView *)[viewBackground viewWithTag:1002] chooseStarLevelAction:[str3 integerValue]/20];

                
                chimaScore1Label.text = showScore.chimaScore1;
                chimaScore2Label.text = showScore.chimaScore2;
                chimaScore3Label.text = showScore.chimaScore3;
                
                zhaobeiScore1Label.text = showScore.zhaobeiScore1;
                zhaobeiScore2Label.text = showScore.zhaobeiScore2;
                zhaobeiScore3Label.text = showScore.zhaobeiScore3;
                
                juScore1Label.text = showScore.juScore1;
                juScore2Label.text = showScore.juScore2;
                juScore3Label.text = showScore.juScore3;

                if (showModel.rate.count > 0) {
                    int i = 0;
                    for (ShowcomMentRate *rate in showModel.rate) {
                        
                        ShowComMentView *show = [[[NSBundle mainBundle] loadNibNamed:@"ShowComMentView" owner:self options:nil]lastObject];
                        show.selectionStyle = UITableViewCellSelectionStyleNone;
                        if (i==0) {
                            show.upLineImageView.hidden = NO;
                        }else{
                            show.upLineImageView.hidden = YES;
                            show.lineImageView.hidden = NO;
                        }
                        show.timeLbael.text = rate.created;
                        show.contentLabel.text = rate.content;
                        show.userLabel.text = rate.nickname;
                        [show setFrame:CGRectMake(0, dingweiUserLabel.frame.origin.y + 30+(i*71), ScreenWidth, 71)];
                        [scrollContent addSubview:show];
                        i++;

                        if (i == 10&&[self.pingjian intValue] > 10) {
                            
                        
                            NSString *str = [NSString stringWithFormat:@"显示其余%d条评价",[self.pingjian intValue] - 10];
                            
                            UIButton *nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
                            [nextBut setFrame:CGRectMake(0, dingweiUserLabel.frame.origin.y + 30+(i*71), ScreenWidth, 40)];

                            [nextBut setTitle:str forState:UIControlStateNormal];
                            [nextBut setTitle:str forState:UIControlStateHighlighted];
                            [nextBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                            [nextBut setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];

                            
                            [nextBut addTarget:self action:@selector(checkMore:) forControlEvents:UIControlEventTouchUpInside];
                            
                            [scrollContent addSubview:nextBut];
                        }
                        
                    }
                    if (showModel.rate.count != 0) {
                        //lee999 高度加了50，为了防止显示其他评价按钮不显示
                        scrollContent.contentSize = CGSizeMake(ScreenWidth, dingweiUserLabel.frame.origin.y+showModel.rate.count*71+40+ AddContentHight+ 40 +50);
                    }
                }
                [SBPublicAlert hideMBprogressHUD:self.view];
                
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
        case 10086:
            
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            break;
        default:
        {
            [SBPublicAlert hideMBprogressHUD:self.view];
        }
            break;
    }
}

- (void)checkMore:(UIButton *)sender {

    MoreRateViewController *moerCtrl = [[MoreRateViewController alloc] init];
    moerCtrl.goodid = self.goodId;
    moerCtrl.isFromMyAimer = self.isFromMyAimer;
    moerCtrl.isHiddenBar = self.isHiddenBar;

    [self.navigationController pushViewController:moerCtrl animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//iOS 5
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
//iOS 6
- (BOOL)shouldAutorotate
{
	return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationPortrait;
}


@end
