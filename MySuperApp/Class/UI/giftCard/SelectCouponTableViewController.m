//
//  SelectCouponTableViewController.m
//  爱慕商场
//
//  Created by malan on 13-12-11.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "SelectCouponTableViewController.h"
#import "BonusCardCell.h"
#import "BonusCell.h"
#import "MYMacro.h"
#import "CFunction.h"


@interface SelectCouponTableViewController ()
{
    UITextField *name3;
//    UIButton *doneButton;
    UITableView *myTableV;
}
@end

@implementation SelectCouponTableViewController


- (void)initRequest
{
//    doneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 163, 106, 53)];
    
    [self.arrCard removeAllObjects];
    if (self.couponcardListModel.checkoutCards && [self.couponcardListModel.checkoutCards count]) {
        [self.arrCard addObjectsFromArray:(NSMutableArray *)self.couponcardListModel.checkoutCards];
    }
    
    [self.contentArr removeAllObjects];
    
    if (self.couponcardListModel.checkoutCouponcard && [self.couponcardListModel.checkoutCouponcard count]) {
        [self.contentArr addObjectsFromArray:(NSMutableArray *)self.couponcardListModel.checkoutCouponcard];
    }
    
    self.mytableView.isCloseHeader = YES;
    //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
    [self.mytableView reloadData:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(keyboardWillShowOnDelay:)
//                                                name:UIKeyboardWillShowNotification
//                                              object:nil];

    
}
-(void)viewWillDisappear:(BOOL)animated{
    
//    doneButton.hidden = YES;
//    [[NSNotificationCenter defaultCenter]removeObserver:self
//                                                   name:UIKeyboardWillShowNotification
//                                                 object:nil];
}

#pragma mark 数字键盘加完成按钮
//- (void)keyboardWillShowOnDelay:(NSNotification *)notification
//{
//    [self performSelector:@selector(keyboardWillShow:) withObject:nil afterDelay:0];
//}
//
//- (void)keyboardWillShow:(NSNotification *)notification
//{
//    [doneButton setTitle:@"完成" forState:(UIControlStateNormal)];
//    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
//    UIWindow * tempWindow = [[[UIApplication sharedApplication]windows]objectAtIndex:1];
//    UIView * keyBoard = nil;
//    NSLog(@"%@",tempWindow);
//    for (int i = 0; i < tempWindow.subviews.count; i ++) {
//        keyBoard = [tempWindow.subviews objectAtIndex:i];
//        
//        [keyBoard addSubview:doneButton];
//    }
//}
//
//- (void)doneButton:(UIButton *)btn{
//    //    NSLog(@"kongyu");
//    [name3 resignFirstResponder];
//}


-(void)textFieldDidBeginEditing:(UITextField *)textField{

    NSLog(@"12312312");
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == name3 || textField == nametextfield) {
        
        [myTableV setContentOffset:CGPointMake(0, 50)];
        
//        doneButton.hidden = NO;
    }else{
//        doneButton.hidden = YES;
    }
    return YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [name3 resignFirstResponder];
    
}



#pragma mark-- table

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==0) {
//        static NSString *CellIdentifier = @"BonusCardCellIdentifier";
//        BonusCardCell *cell = (BonusCardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        // Configure the cell...
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"BonusCardCell" owner:self options:nil] lastObject];
//            cell.parent = self;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        //    cell.imageCard.image = [UIImage imageNamed:@"card_aimer01"];
//        NSDictionary *dic = [self.arrCard objectAtIndex:indexPath.row];
//        cell.labelTitle.text = [NSString stringWithFormat:@"%@",LegalObject([dic objectForKey:@"name"],[NSString class])];
//        cell.labelId.text = [NSString stringWithFormat:@"NO. %@",[dic objectForKey:@"card_id"]];
//        cell.labelBalance.text = [dic objectForKey:@"balance"];
//        cell.labelFrozenBalance.text = [NSString stringWithFormat:@"%@",LegalObject([dic objectForKey:@"frozenBalance"],[NSNumber class])];
//        cell.labelIntegral.text = [NSString stringWithFormat:@"冻结%@   可用%@",
//                                   LegalObject([dic objectForKey:@"frozenScore"],[NSNumber class]),LegalObject([dic objectForKey:@"canUseScore"],[NSNumber class])];
//        if ([[dic objectForKey:@"canUseScore"] integerValue] < 2000) {
//            [cell.btnExchange setEnabled:NO];
//        }
//        return cell;
//    } else if(indexPath.section==1) {
//        
//        
//        UITableViewCell *Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                                       reuseIdentifier:nil];
//        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 44)];
////        view.image = [UIImage imageNamed:@"list_one.png"];
//        //lee给view设置为圆角，不再使用图片了。 -140512
//        [SingletonState setViewRadioSider:view];
//        
//        [Cell.contentView addSubview:view];
//        
//        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 100, 25)];
//        name.backgroundColor = [UIColor clearColor];
//        name.font = [UIFont systemFontOfSize:14];
//        name.text = @"优惠券号码：";
//        [Cell.contentView addSubview:name];
//
//        name3 = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 210, 25)];
//        name3.delegate = self;
//        name3.backgroundColor = [UIColor clearColor];
//        name3.placeholder = @"请输入您的优惠券号";
//        name3.font = [UIFont systemFontOfSize:14];
//        name3.keyboardType = UIKeyboardTypeNumberPad;
//        [Cell.contentView addSubview:name3];
//        
//        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//        [but setFrame:CGRectMake(230, 8, 60, 30)];
//        [but setTitle:@"使用" forState:UIControlStateNormal];
//        [but setTitle:@"使用" forState:UIControlStateHighlighted];
//        but.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        
//        [but setBackgroundImage:[UIImage imageNamed:@"nav_btn.png"] forState:UIControlStateNormal];
//        [but setImage:[UIImage imageNamed:@"nav_btn.png"] forState:UIControlStateHighlighted];
//        
//        [but addTarget:self action:@selector(UserCouns:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [Cell addSubview:but];
//        
//        return Cell;
//    }
//    else if(indexPath.section==2) {
//        static NSString *CellIdentifier = @"BonusCellIdentifier";
//        BonusCell *cell = (BonusCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"BonusCell" owner:self options:nil] lastObject];
//            cell.parent = self;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        NSDictionary *dic = [self.contentArr objectAtIndex:indexPath.row];
//
//        cell.labelTitle.text = LegalObject([dic objectForKey:@"title"],[NSString class]);;//@"线上全场通用券";
//        cell.labelDesc.text = LegalObject([dic objectForKey:@"desc"],[NSString class]);;
//        cell.labelTime.text = [dic objectForKey:@"time"];
//        
//        NSComparisonResult compareResult = NSOrderedAscending;
//        
//        NSString *status = @"未使用";
//        
//        if ([status isEqualToString:@"已过期优惠劵"]||[status isEqualToString:@"已过期优惠劵状态"]) {
//            
//            BtnSetImg(cell.btnBonus, @"card_ticket02.png", @"", @"")
//            cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_out.png"];
//            cell.buttonUsed.hidden = YES;
//            
//            //lee999 已经过期的优惠券不可点击
//            cell.btnBonus.enabled = NO;
//            //end
//            
//        } else if ([status isEqualToString:@"未使用"])
//        {
//            if(compareResult == NSOrderedAscending || compareResult == NSOrderedSame) {//没有过期
//                [cell.btnBonus setImage:[UIImage imageNamed:@"card_aimer01.png"] forState:UIControlStateNormal];
//                cell.imageViewIsUsed.image = [UIImage imageNamed:@""];
//                cell.buttonUsed.hidden = NO;
//            } else if (compareResult == NSOrderedDescending){//已过期
//                BtnSetImg(cell.btnBonus, @"card_ticket02.png", @"", @"")
//                cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_out.png"];
//                cell.buttonUsed.hidden = YES;
//                
//                //lee999 已经过期的优惠券不可点击
//                cell.btnBonus.enabled = NO;
//                //end
//            }
//        }
//        else if ([status isEqualToString:@"已使用"]){//已使用
//            BtnSetImg(cell.btnBonus,@"card_aimer01.png",@"",@"");
//            cell.buttonUsed.hidden = YES;
//            cell.imageViewIsUsed.image = [UIImage imageNamed:@"ticket_status_used.png"];
//            
//        }
//        
//        cell.labelPrice.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]==nil?@"":[dic objectForKey:@"price"]];
//        
//        //lee增加o2o优惠券的显示
//        NSString *cardtype = @"";
//        cardtype = LegalObject([dic objectForKey:@"type"],[NSString class]);
//        NSLog(@"cardtype---:%@",cardtype);
//        if ([cardtype isEqualToString:@"o2o"]) {
//            [cell.btnBonus setImage:[UIImage imageNamed:@"card_lb03.png"] forState:UIControlStateNormal];
////            cell.labelTitle.text = @"线上线下通用O2O券";
//        }
//        return cell;
//    }
//    return nil;
//}

//- (void)UserCouns:(UIButton *)sender {
//    
////    if (name3.text.length == 14) {
//        self.checkOutViewCtrl.vouId = name3.text;
//    
//        [self popBackAnimate:nil];
////    }else {
////        [SBPublicAlert showMBProgressHUD:@"请输入正确的优惠劵号码" andWhereView:self.view hiddenTime:1.];
////    }
//}

-(void)popBackAnimate:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
