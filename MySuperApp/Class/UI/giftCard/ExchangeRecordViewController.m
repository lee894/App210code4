//
//  ExchangeRecordViewController.m
//  爱慕商场
//
//  Created by malan on 14-9-26.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ExchangeRecordViewController.h"

@interface ExchangeRecordViewController ()

@end

@implementation ExchangeRecordViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"自助兑换记录";
    
    //创建返回按钮
    [self createBackBtnWithType:0];
    
    _arrData = [[NSMutableArray alloc] init];
    
    _tableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, NowViewsHight-20)];
    if (isIOS7up) {
        _tableView.frame = CGRectMake(0, new20ViewY, 320, self.view.frame.size.height-new20ViewY);
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.isCloseHeader = YES;
    _tableView.isCloseFooter = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    [mainSer getexchangescorerecord:self.cardId];
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
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    if (model.requestTag == Http_getexchangescorerecord_Tag) {
        if (!model.errorMessage) {
            self.getexchangescorerecordGetModel = (GetexchangescorerecordGetModel *)model;
            if ([self.getexchangescorerecordGetModel.record count]== 0) {
                [SBPublicAlert showMBProgressHUD:@"您还没有积分使用记录" andWhereView:self.view hiddenTime:0.6];
                return;
            }
            [_arrData removeAllObjects];
            [_arrData addObjectsFromArray:(NSMutableArray *)self.getexchangescorerecordGetModel.record];
            
            [_tableView reloadData:YES];
            
        } else {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
        }
    } else if (model.requestTag == 10086){
        
        [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [_arrData count]+1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifierFirstRow = @"CellFirstRow";
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierFirstRow];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    
    if (!cell) {
        
        if (indexPath.row == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierFirstRow];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 82/2+20)];
            view.backgroundColor = [UIColor clearColor];
            
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exchange_history_list_02"]];
            imgView.frame = CGRectMake(10, 20, 300, 82/2);
            [view addSubview:imgView];

            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+10, 80, 21)];
            label1.backgroundColor = [UIColor clearColor];
            label1.font = [UIFont systemFontOfSize:15.0f];
            label1.textColor = [UIColor redColor];
            label1.text = @"操作时间";
            [view addSubview:label1];

            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+30, label1.frame.origin.y, 80, label1.frame.size.height)];
            label2.backgroundColor = [UIColor clearColor];
            label2.font = [UIFont systemFontOfSize:15.0f];
            label2.textColor = [UIColor redColor];
            label2.text = @"积分变化";
            [view addSubview:label2];

            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width+10, label1.frame.origin.y, 100, label1.frame.size.height)];
            label3.backgroundColor = [UIColor clearColor];
            label3.font = [UIFont systemFontOfSize:15.0f];
            label3.textColor = [UIColor redColor];
            label3.text = @"会员卡变化";
            [view addSubview:label3];

            
            [cell addSubview:view];

        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exchange_history_list_02"]];
            imgView.frame = CGRectMake(10, 0, 300, 98/2);
            imgView.tag = 4;
            [cell addSubview:imgView];

            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0+4, 80, 40)];
            label1.backgroundColor = [UIColor clearColor];
            label1.font = [UIFont systemFontOfSize:15.0f];
            label1.numberOfLines = 0;
            label1.tag = 1;
     
            [cell addSubview:label1];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+30, 14, 80, 21)];
            label2.backgroundColor = [UIColor clearColor];
            label2.font = [UIFont systemFontOfSize:15.0f];
            label2.tag = 2;
      
            [cell addSubview:label2];
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width+10, label2.frame.origin.y, 100, label2.frame.size.height)];
            label3.backgroundColor = [UIColor clearColor];
            label3.font = [UIFont systemFontOfSize:15.0f];
            label3.tag = 3;

            [cell addSubview:label3];
        }
    }
    if (indexPath.row == 0) {//啥也不做
        return cell;
    } else if (indexPath.row == [_arrData count]) {//最后一行
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:4];
        imgView.frame = CGRectMake(10, 0, 300, 100/2);
        imgView.image = [UIImage imageNamed:@"exchange_history_list_02"];
    } else {
        UIImageView *imgView = (UIImageView *)[cell viewWithTag:4];
        imgView.frame = CGRectMake(10, 0, 300, 98/2);
        imgView.image = [UIImage imageNamed:@"exchange_history_list_02"];
        
    }
    GetexchangescorerecordRecord *record = [_arrData objectAtIndex:indexPath.row-1];
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text = record.createTime;
    UILabel *label2 = (UILabel *)[cell viewWithTag:2];
    label2.text = record.userChangeScore;
    UILabel *label3 = (UILabel *)[cell viewWithTag:3];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[record.userChangeTicket floatValue]]];
    label3.text = [NSString stringWithFormat:@"￥%@",formattedNumberString];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (![_arrData count]) {
        return 0;
    }
    return 0;
    return 82/2+20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (![_arrData count]) {
            return nil;
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 82/2+20)];
        view.backgroundColor = [UIColor clearColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exchange_history_list_02"]];
        imgView.frame = CGRectMake(10, 20, 300, 82/2);
        [view addSubview:imgView];

        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+10, 80, 21)];
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:15.0f];
        label1.textColor = [UIColor redColor];
        label1.text = @"操作时间";
        [view addSubview:label1];

        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+30, label1.frame.origin.y, 80, label1.frame.size.height)];
        label2.backgroundColor = [UIColor clearColor];
        label2.font = [UIFont systemFontOfSize:15.0f];
        label2.textColor = [UIColor redColor];
        label2.text = @"积分变化";
        [view addSubview:label2];

        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width+10, label1.frame.origin.y, 100, label1.frame.size.height)];
        label3.backgroundColor = [UIColor clearColor];
        label3.font = [UIFont systemFontOfSize:15.0f];
        label3.textColor = [UIColor redColor];
        label3.text = @"会员卡变化";
        [view addSubview:label3];

        
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((indexPath.row == [_arrData count])? 100/2 : (indexPath.row==0 ? 82/2+20 : 98/2));
}
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
