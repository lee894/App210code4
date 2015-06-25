//
//  MoreRateViewController.m
//  MySuperApp
//
//  Created by 昝驹 on 13-12-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "MoreRateViewController.h"
#import "ShowComMentView.h"

@interface MoreRateViewController ()

@end

@implementation MoreRateViewController
@synthesize isFromMyAimer;
@synthesize isHiddenBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    tableList.frame = CGRectMake(0, Nav_Hight, ScreenWidth, ScreenHeight-Nav_Hight-FootBarHeight-Screen_hight);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"查看更多评价";
    self.contentArr = [NSMutableArray array];

    //返回按钮
    [self createBackBtnWithType:0];
    
    if (isIOS7up) {
        tableList.frame = CGRectMake(0, 40, ScreenWidth, self.view.frame.size.height);
    }else{
    tableList.frame = CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height);
    }

    
    mainSev  = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    [self getData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArr.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ShowComMentView * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShowComMentView" owner:nil options:nil]lastObject];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.upLineImageView.hidden = YES;
    }
    
    ShowcomMentRate *rate = [self.contentArr objectAtIndex:indexPath.row];
    cell.timeLbael.text = rate.created;
    cell.contentLabel.text = rate.content;
    cell.userLabel.text = rate.nickname;
    
    return cell;
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
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                 ShowcomMentModel *showModel = (ShowcomMentModel *)model;

                if (current == 2) {
                    [self.contentArr removeAllObjects];
                    [self.contentArr addObjectsFromArray:(NSMutableArray *)showModel.rate];
                }else {
                    
                    [self.contentArr addObjectsFromArray:(NSMutableArray *)showModel.rate];
                }
                totalCount = [showModel.rateCount intValue]-10;
                [self updateTableViewCount:self.contentArr.count];
                
                [tableList reloadData];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            break;

        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
}


#pragma mark 刷新的代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger returnKey = [tableList tableViewDidEndDragging];
    if (returnKey != k_RETURN_DO_NOTHING) {
        NSString * key = [NSString stringWithFormat:@"%d", returnKey];
        [self updateThread:key];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger returnKey = [tableList tableViewDidDragging];
    if (returnKey == k_RETURN_LOADMORE) {
        NSString * key = [NSString stringWithFormat:@"%d", returnKey];
        [self updateThread:key];
    }
}

#pragma mark 刷新
-(void)getData
{
    current = 2;
    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
    [mainSev getShowcomment:self.goodid andPage:PageCurr andPer_page:@"10"];
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
}

#pragma mark 加载
- (void)nextPage
{
    current ++;
    NSString *PageCurr = [NSString stringWithFormat:@"%d",current];
//
    [mainSev getShowcomment:self.goodid andPage:PageCurr andPer_page:@"10"];
    
}

- (void)updateTableViewCount:(NSInteger)theCount
{
    BOOL status = NO;
    if (theCount < totalCount) {//小于
        status = YES;
    }
    tableList.isCloseFooter = !status;
    
    if (status) {//还有数据
        // 一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [tableList reloadData:NO];
    } else {//没有数据
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [tableList reloadData:YES];
    }
}
- (void)updateThread:(NSString *)returnKey{
    switch ([returnKey intValue]) {
        case k_RETURN_REFRESH:
            //            [data removeAllObjects];
            [self getData];
            break;
        case k_RETURN_LOADMORE:
            [self nextPage];
            break;
        default:
            break;
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
