//
//  NoticeinfoViewController.m
//  MySuperApp
//
//  Created by lee on 14-4-10.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "NoticeinfoViewController.h"
#import "NoticeListViewController.h"
#import "SHLUILabel.h"


@interface NoticeinfoViewController ()

@end

@implementation NoticeinfoViewController

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
	[mainSev getNoticelist];
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    
    //创建右边按钮
//    [self createRightBtn];
//    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_mine.png"] forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"" forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"" forState:UIControlStateHighlighted];
//    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_mine_press.png"] forState:UIControlStateHighlighted];
//    [self.navbtnRight setFrame:CGRectMake(0, 10, 25, 25)];
//    [self.navbtnRight addTarget:self action:@selector(gotoUserCenter) forControlEvents:UIControlEventTouchUpInside];
    
    
    makedonetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
    makedonetable.backgroundColor = [UIColor clearColor];
    makedonetable.backgroundView = nil;
    makedonetable.delegate = self;
    makedonetable.dataSource = self;
    [self.view addSubview:makedonetable];
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
        case Http_NoticeList_Tag:
        {
            if (!model.errorMessage) {
                
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                noticeModel = (NoticeListNoticeListModel *)model;
                
                [makedonetable reloadData];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view states:NO];
            }
        }
            break;
            
        default:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            break;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([noticeModel.notice count]>0)
//    {
//        tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
//    }
    
    return noticeModel.notice.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 245, 14)];
    label.font = [UIFont systemFontOfSize:14];
    [label setTextAlignment:NSTextAlignmentLeft];
    label.backgroundColor = [UIColor clearColor];
    label.textColor =  [UIColor colorWithHexString:@"0xB90023"] ;//UIColorFromRGB();
    [cell addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 245, 14)];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor =  [UIColor colorWithHexString:@"0xB90023"];// UIColorFromRGB(0xB90023);
    [label1 setTextAlignment:NSTextAlignmentLeft];
    [cell addSubview:label1];
    
    NoticeListNotice *a;
    a = [noticeModel.notice objectAtIndex:indexPath.section];
    label.text = a.time;
    label1.text = a.title;
    
    //显示内容
    NSString * str = a.content;
    SHLUILabel *label3 = [[SHLUILabel alloc] initWithFrame:CGRectMake(20, 60, ScreenWidth-40, 20)];
    label3.text = str;
    label3.font = [UIFont systemFontOfSize:LabSmallSize];
//    label3.lineBreakMode = NSLineBreakByWordWrapping;
    label3.numberOfLines = 0;
    int contentHight = [label3 getAttributedStringHeightWidthValue:ScreenWidth-60]  + 20;
    [label3 setTextAlignment:NSTextAlignmentLeft];
    label3.frame = CGRectMake(20, 60, ScreenWidth-40, contentHight);


    [cell addSubview:label3];
    
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

//    NSString *content = a.content;
//    SHLUILabel *namelab = [[SHLUILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth-30, 20)];
//    namelab.text = content;
//    namelab.font = [UIFont systemFontOfSize:LabSmallSize];
//    namelab.lineBreakMode = NSLineBreakByWordWrapping;
//    namelab.numberOfLines = 0;
//    int contentHight = [namelab getAttributedStringHeightWidthValue:ScreenWidth-30]  + 70;
    UIView *splineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [splineV setBackgroundColor:[UIColor colorWithHexString:splineBGC]];
    [cell addSubview:splineV];
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NoticeListNotice *a = [noticeModel.notice objectAtIndex:indexPath.section];
    NSString *content = a.content;
    
    SHLUILabel *namelab = [[SHLUILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth-30, 20)];
    namelab.text = content;
    namelab.font = [UIFont systemFontOfSize:LabSmallSize];
    namelab.lineBreakMode = NSLineBreakByWordWrapping;
    namelab.numberOfLines = 0;
    int contentHight = [namelab getAttributedStringHeightWidthValue:ScreenWidth-30]  + 70;
    
    return contentHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NoticeListNotice *aasd = [noticeModel.notice objectAtIndex:indexPath.section];
    NoticeListViewController *noticeDetil = [[NoticeListViewController alloc] init];
    noticeDetil.noticeID = aasd.noticeIdentifier;
    [self.navigationController pushViewController:noticeDetil animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
