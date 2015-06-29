////
////  HasUsedViewController.m
////  爱慕商场
////
////  Created by mac  on 14-9-1.
////  Copyright (c) 2014年 zan. All rights reserved.
////
//
//#import "HasUsedViewController.h"
//#import "BonusCell.h"
//#import "V6CardCell.h"
//#import "CFunction.h"
//
//@interface HasUsedViewController ()
//
//@end
//
//@implementation HasUsedViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (IBAction)goBack:(UIButton *)btn
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    
//    self.title = @"已使用优惠劵";
//    
//    [self createBackBtnWithType:0];
//    
//    
//    
//    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStyleGrouped];
//    //判断如果是IOS7的话，适配屏幕的宽度和高度
//    if (isIOS7up) {
//        [tableList setFrame:CGRectMake(0, 0, ScreenWidth, NowViewsHight)];
//    }else if (isIOS6Down) {
//        [tableList setFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
//    } else{
//        [tableList setFrame:CGRectMake(0, 0, ScreenWidth, NowViewsHight)];
//    }
//    tableList.backgroundColor = [UIColor clearColor];
//    tableList.backgroundView = nil;
//    tableList.delegate = self;
//    tableList.dataSource = self;
//    [self.view addSubview:tableList];
//    
//}
//
////单元格上按钮的点击事件
//- (void)btnClicked:(UIButton *) btn onCell:(UITableViewCell *)cell
//{
//    self.checkOutViewCtrl.vouId = nil;
//    self.checkOutViewCtrl.v6useCardId = nil;
//    [self goBack:nil];
//}
//
//#pragma mark -- 全部订单取消
//- (void)cancelOrder
//{
//}
//
//#pragma mark -- UITableView delegate and datesource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if(self.checkout_usecouponcard) {
//        static NSString *CellIdentifier = @"BonusCellIdentifier";
//        BonusCell *cell = (BonusCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"BonusCell" owner:self options:nil] lastObject];
//            cell.parent = self;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell.btnBonus setImage:[UIImage imageNamed:@"card_lb03"] forState:UIControlStateNormal];
//            [cell.buttonUsed setTitle:@"取消" forState:UIControlStateNormal];
//        }
//        
//        cell.labelTitle.text = [self.checkout_usecouponcard objectForKey:@"title"];
//        cell.labelDesc.text = [self.checkout_usecouponcard objectForKey:@"desc"];
//        NSString *startTime = LegalObject([self.checkout_usecouponcard objectForKey:@"time"],[NSString class]);
//        NSString *failtime = LegalObject([self.checkout_usecouponcard objectForKey:@"time"],[NSString class]);
//        if ([startTime isEqualToString:@""] || !startTime) {
//            startTime = @"0000-00-00 00:00:00";
//        }
//        if ([failtime isEqualToString:@""] || !failtime) {
////            failtime = @"0000-00-00 00:00:00";
//        }
//        
//        cell.labelTime.text = startTime;
//        cell.labelPrice.text = [self.checkout_usecouponcard objectForKey:@"price"];
//        
//        
//        return cell;
//        
//    }else  {
//        static NSString *CellIdentifier = @"V6CardCell";
//        V6CardCell *cell = (V6CardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"V6CardCell" owner:self options:nil] lastObject];
//            cell.parent = self;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        NSDictionary *dic = [self.checkout_usev6cards lastObject];
//
//        cell.labelTitle.text = [dic objectForKey:@"name"];
//        cell.labelId.text = [NSString stringWithFormat:@"NO. %@",[dic objectForKey:@"card_id"]];
//        cell.labelBalance.text = [dic objectForKey:@"balance"];
//        cell.labelFrozenBalance.text = [NSString stringWithFormat:@"%@",LegalObject([dic objectForKey:@"frozenBalance"],[NSNumber class])];
//        
//        return cell;
//    }
//    return nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return ([self.checkout_usev6cards count] ? 161.0f : 136.0f);
//}
//
//#pragma mark -- 屏幕旋转
////iOS 5
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//}
////iOS 6
//- (BOOL)shouldAutorotate
//{
//	return NO;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//	return UIInterfaceOrientationMaskPortrait;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//	return UIInterfaceOrientationPortrait;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end
