//
//  LogisticsViewController.m
//  爱慕商场
//
//  Created by LEE on 14-8-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LogisticsViewController.h"
#import "LogisticsCell.h"


@interface LogisticsViewController ()

@end

@implementation LogisticsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"查看物流";
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    //创建返回按钮
    [self createBackBtnWithType:0];

    labelNum.text = self.expressid;//运单号
    
    [mainSer getLogistics:self.expressid andDelivery_type:self.delivery_type];
    [SBPublicAlert showMBProgressHUD:@"正在查找···" andWhereView:self.view states:NO];
    
    tableList.frame = CGRectMake(0, 0, ScreenWidth, NowViewsHight);
    
//    if (isIOS7up) {
//        tableList.frame = CGRectMake(0,60, 320, self.view.frame.size.height-60);
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark -- NETrequest delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_Logistics_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                LookCheckLookCheckModel *modelCheck = (LookCheckLookCheckModel *)model;
                checkDetail = modelCheck.details;
                labelDelivery.text = modelCheck.delivery_type;//快递公司名字

                
                [DplusMobClick track:@"查看物流" property:@{@"订单号": self.expressid,
                                                        @"快递公司":self.delivery_type}];

                
                
                if (!checkDetail.details) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"暂无此物流" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                    [alert show];
                    
//                    tableList.hidden = YES;
//                    nowuliuLab.hidden = NO;
                }else{
//                    nowuliuLab.hidden = YES;
//                    tableList.hidden = NO;
                }
                
                if ([checkDetail.details respondsToSelector:@selector(objectAtIndex:)]) {
                    if (checkDetail.details.count>0) {
                        tableList.hidden = NO;
                        nowuliuLab.hidden = YES;
                    }else{
                        tableList.hidden = YES;
                        nowuliuLab.hidden = NO;
                    }
                }
                
                
                [tableList reloadData];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            [self.navigationController popViewControllerAnimated:YES];

            break;
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
}

#pragma mark -- 按钮事件
-(void)popBackAnimate:(UIButton *)sender//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UITableView delegate  and  datesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([checkDetail.details respondsToSelector:@selector(objectAtIndex:)]) {
        return checkDetail.details.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    LogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LogisticsCell" owner:self options:nil] lastObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setBackgroundImageWithRow:indexPath.row withCount:checkDetail.details.count];
    
    NSString *time = [checkDetail.details objectAtIndex:indexPath.row];
    
    if (time.length >= 20) {
        cell.labelTime.text = [time substringToIndex:19];
        cell.labelAddr.text = [time substringFromIndex:20];
    }else {
    
        cell.labelAddr.text = time;
    }
    

    return cell;
}
#pragma mark -- 屏幕旋转
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
