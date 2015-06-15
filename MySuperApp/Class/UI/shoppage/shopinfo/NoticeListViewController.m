//
//  NoticeListViewController.m
//  MySuperApp
//
//  Created by bonan on 14-4-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "NoticeListViewController.h"

#import "MyAimerViewController.h"
#import "MyAimerLoginViewController.h"

@interface NoticeListViewController ()

@end

@implementation NoticeListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"活动公告";

    [self createBackBtnWithType:0];
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    //创建右边按钮
//    [self createRightBtn];
//    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_mine.png"] forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"" forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"" forState:UIControlStateHighlighted];
//    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_mine_press.png"] forState:UIControlStateHighlighted];
//    [self.navbtnRight setFrame:CGRectMake(0, 10, 25, 25)];
//    [self.navbtnRight addTarget:self action:@selector(gotoUserCenter) forControlEvents:UIControlEventTouchUpInside];

    [mainSev getNotices:self.noticeID];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

    if (isIOS7up) {
        [myallView setFrame:CGRectMake(0, new20ViewY, 320, self.view.frame.size.height-new20ViewY)];
    }
}

//到用户中心  todo
-(void)gotoUserCenter{
    //切换到我的爱慕 来源于竖屏的商场~~
    [SingletonState sharedStateInstance].myaimerIsFrom = 2;
    [self changeToMyaimer];
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
        case Http_Notices_Tag:
        {
            if (!model.errorMessage) {
                
                noticeModel = (NoticesNoticesModel *)model ;
                NoticesNotice *not = [[noticeModel notice] objectAtIndex:0];
                [noticeImageView setImageWithURL:[NSURL URLWithString:not.imgUrl] placeholderImage:nil];
                noticeTextView.text = not.content;
                [SBPublicAlert hideMBprogressHUD:self.view];
                
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            
            }
        }
            break;
            case 10086:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
        }
            break;
            
        default:
            break;
    }
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
