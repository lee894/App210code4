//
//  ImproveInformationViewController.m
//  爱慕商场
//
//  Created by 念肆 on 14-9-17.
//  Copyright (c) 2014年 zan. All rights reserved.
//会员卡入会  完善个人资料

#import "ImproveInformationViewController.h"
#import "ModifyCell.h"
#import "SBPublicFormatValidation.h"


#define PicekTag 1086
#define PicekTagCellOne 1087
#define PicekTagCellTwo 1089

@interface ImproveInformationViewController  ()
{
    UIDatePicker *datepicker;
    UIToolbar *toolBarForNumber;
    
    
    UIToolbar *toolbar;// 内容选择
    UIPickerView * pickerView;

    
    
    UIButton * addBtn;
}

@end

@implementation ImproveInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//lee999 隐藏这个界面的tablebar
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏footview
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [app.aktabBarVerticalController hideTabBar:AKShowHideFromLeft animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self hiddleAllshowView];

    //显示footview
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [app.aktabBarVerticalController showTabBar:AKShowHideFromLeft animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentData = 0;
    children = 1;
    deleteRow = 0;
    
    self.title = @"完善个人资料";
    [self createBackBtnWithType:0];
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    scrollView.frame = CGRectMake(0, 0, 320, NowViewsHight);
    
    tableViewDataArray = [[NSMutableArray alloc] init];
    
    NSDictionary *dic = @{@"name":@"",@"sex":@"",@"Birthday":@"",@"height":@""};
    [tableViewDataArray addObject:dic];
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, NowViewsHight, 320, 216)];
    datepicker.datePickerMode = UIDatePickerModeDate;
    [datepicker setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:datepicker];
    
    
    //创建toolbar
    toolBarForNumber=[[UIToolbar alloc] initWithFrame:CGRectMake(0, NowViewsHight+20, 320, 44)];
    toolBarForNumber.barStyle=UIBarStyleBlackTranslucent;
    [self.view addSubview:toolBarForNumber];
    
    //toolbar上地按钮
    //lee999recode
    
    //这个是选择生日
    UIBarButtonItem *buttonForCancel_Number=[[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
    [buttonForCancel_Number setTintColor:[UIColor whiteColor]];
    }
    buttonForCancel_Number.tag = 107;
    UIBarButtonItem *buttonForFix_Number=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    buttonForFix_Number.width=210;
    UIBarButtonItem *buttonForDone_Number=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
    [buttonForDone_Number setTintColor:[UIColor whiteColor]];
    }
    buttonForDone_Number.tag = 108;
    [toolBarForNumber setItems:[NSArray arrayWithObjects:buttonForCancel_Number,buttonForFix_Number,buttonForDone_Number,nil]];
    
    
    scrollView.contentSize = CGSizeMake(320, 1520);
    scrollView.userInteractionEnabled = YES;
    scrollView.delegate = self;
    
    nameTField.delegate = self;
    nicknameTField.delegate = self;
    telephoneTFiled.delegate = self;
    verificationCodeTField.delegate = self;
    addressTField.delegate = self;
    postcodeTField.delegate = self;
    emailTField.delegate = self;
    
    
//    actionSheet = [[UIActionSheet alloc]initWithTitle:@"\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    //----------------//
    
    toolbar = [[UIToolbar alloc]init];
    toolbar.frame = CGRectMake(0, NowViewsHight+20, 320, 40);
    toolbar.barStyle = UIBarStyleBlackOpaque;
    
    //lee999recode
    UIBarButtonItem *buttonForCancel_Number2=[[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(hiddenActionSheet)];
    if (isIOS7up) {
        buttonForCancel_Number2.tintColor = [UIColor whiteColor];
    }
    
    UIBarButtonItem *okBbi = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(bbiClick)];
    if (isIOS7up) {
        [okBbi setTintColor:[UIColor whiteColor]];        
    }
    UIBarButtonItem *spaceBbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    spaceBbi.width=210;
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonForCancel_Number2,spaceBbi,okBbi, nil]];
    [self.view addSubview:toolbar];
    
    pickerView = [[UIPickerView alloc]init];
    pickerView.frame = CGRectMake(0, NowViewsHight, 320, 160);
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    
    
    //--------------//

    //默认性别
    gender = @"f";
    
    NSArray * incomeArray = @[@"5000以内",@"5000-10000",@"10000-20000",@"20000-30000",@"30000-50000",@"50000以上"];
    NSArray * professionArray = @[@"私人企业拥有者",@"中高层管理者",@"职员",@"专业技术人员",@"军人",@"医生",@"教师",@"家庭主妇",@"学生",@"其它"];
    NSArray * underwearArray = @[@"A70",@"A75",@"A80",@"A85",@"A90",@"B70",@"B75",@"B80",@"B85",@"B90",@"C70",@"C75",@"C80",@"C85",@"C90"];
    NSArray * underpantsArray = @[@"女士64（S）",@"女士70（M）",@"女士76（L）",@"女士82（XL）",@"女士90（XXL）",@"男士165/80",@"男士170/85",@"男士175/90",@"男士180/95",@"男士185/100",@"男士190/105"];
    NSArray * adultArray = @[@"女士155（S）",@"女士160（M）",@"女士165（L）",@"女士170（XL）",@"女士175（XXL）",@"男士165（XS）",@"男士170（S）",@"男士175（M）",@"男士180（L）",@"男士185（XL）",@"男士190(XXL)"];

    dataArray = [[NSMutableArray alloc] initWithObjects:incomeArray,professionArray,underwearArray,underpantsArray,adultArray, nil];
    lastSelectArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0", nil];

    
    mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 930, 320, 260 *children) style:UITableViewStylePlain];
    mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mytableView.backgroundColor = [UIColor clearColor];
    mytableView.bounces = NO;
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [scrollView addSubview:mytableView];
    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitleColor:UIColorFromRGB(0xB90023) forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColorFromRGB(0xB90023) forState:UIControlStateHighlighted];
    [addBtn setTitle:@"增加一个儿童信息" forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor clearColor];
    addBtn.frame = CGRectMake(25,children * 260 + 930, 150, 30);
    addBtn.tag = 50;
    [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addBtn];
    
    [confirmBtn setY:addBtn.frame.origin.y + addBtn.frame.size.height + 20];
    [remarkLabel setY:confirmBtn.frame.origin.y + confirmBtn.frame.size.height + 20];
}

- (void)BarButtonClick:(UIBarButtonItem *)sender {

    switch (sender.tag) {
        case 107://取消
        {
            [UIView commitAnimations];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            datepicker.frame=CGRectMake(0-5.5, ScreenHeight, 320, 216);
            toolBarForNumber.frame=CGRectMake(0, ScreenHeight+20, 320, 44)
            ;
            [UIView commitAnimations];
        }
            break;
        case 108://确定
        {
            
            if (datepicker.tag == PicekTag) {
                [UIView commitAnimations];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.3];
                datepicker.frame=CGRectMake(0-5.5, ScreenHeight, 320, 216);
                toolBarForNumber.frame=CGRectMake(0, ScreenHeight+20, 320, 44)
                ;
                [UIView setAnimationDidStopSelector:@selector(hiddleAllshowView)];
                [UIView commitAnimations];
                NSDateFormatter*formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy"];
                NSString *yearStr = [formatter stringFromDate:datepicker.date];
                
                [formatter setDateFormat:@"MM"];
                NSString *monthStr = [formatter stringFromDate:datepicker.date];
                
                [formatter setDateFormat:@"dd"];
                NSString *dayStr = [formatter stringFromDate:datepicker.date];
                
                
                
                [yearBtn setTitle:yearStr forState:UIControlStateNormal];
                [monthBtn setTitle:monthStr forState:UIControlStateNormal];
                [dayBtn setTitle:dayStr forState:UIControlStateNormal];
            }else if (datepicker.tag == PicekTagCellOne) {
                [UIView commitAnimations];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.3];
                datepicker.frame=CGRectMake(0-5.5, ScreenHeight, 320, 216);
                toolBarForNumber.frame=CGRectMake(0, ScreenHeight+20, 320, 44)
                ;
                [UIView setAnimationDidStopSelector:@selector(hiddleAllshowView)];
                [UIView commitAnimations];
                NSDateFormatter*formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy"];
                NSString *yearStr = [formatter stringFromDate:datepicker.date];
                
                [formatter setDateFormat:@"MM"];
                NSString *monthStr = [formatter stringFromDate:datepicker.date];
                
                [formatter setDateFormat:@"dd"];
                NSString *dayStr = [formatter stringFromDate:datepicker.date];
                
                
                ModifyCell *cell = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                cell.delegate = self;
//                cell.birthdayLabel.text = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
                [cell.birthdayLabelBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr] forState:UIControlStateNormal];
              
            }else if (datepicker.tag == PicekTagCellTwo) {
                
                [UIView commitAnimations];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.3];
                datepicker.frame=CGRectMake(0-5.5, ScreenHeight, 320, 216);
                toolBarForNumber.frame=CGRectMake(0, ScreenHeight+20, 320, 44)
                ;
                [UIView setAnimationDidStopSelector:@selector(hiddleAllshowView)];
                [UIView commitAnimations];
                NSDateFormatter*formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy"];
                NSString *yearStr = [formatter stringFromDate:datepicker.date];
                
                [formatter setDateFormat:@"MM"];
                NSString *monthStr = [formatter stringFromDate:datepicker.date];
                
                [formatter setDateFormat:@"dd"];
                NSString *dayStr = [formatter stringFromDate:datepicker.date];
                
              ModifyCell *cell2 = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                cell2.delegate = self;
//                cell2.birthdayLabel.text = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
                
                [cell2.birthdayLabelBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr] forState:UIControlStateNormal];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark-- 隐藏所有的键盘picker

- (void)hiddleAllshowView {
//    toolBarForNumber.hidden = YES;
    [self hiddenActionSheet];
    datepicker.frame=CGRectMake(0-5.5, ScreenHeight, 320, 216);
    toolBarForNumber.frame=CGRectMake(0, ScreenHeight+20, 320, 44);
    
    
    [nameTField resignFirstResponder];
    [nicknameTField resignFirstResponder];
    [telephoneTFiled resignFirstResponder];
    [verificationCodeTField resignFirstResponder];
    [addressTField resignFirstResponder];
    [postcodeTField resignFirstResponder];
    [emailTField resignFirstResponder];
    
    
    ModifyCell *cell = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.delegate = self;
//    NSArray *arrCell2 = [cell2.birthdayLabel.text componentsSeparatedByString:@"-"];
    [cell.statureTfield resignFirstResponder];
    [cell.nameLabel resignFirstResponder];
    
    ModifyCell *cell2 = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell2.delegate = self;
//    NSArray *arrCell2 = [cell2.birthdayLabel.text componentsSeparatedByString:@"-"];
    [cell2.statureTfield resignFirstResponder];
    [cell2.nameLabel resignFirstResponder];
}


-(void)popBackAnimate:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)bbiClick
{
    [self hiddleAllshowView];
    
    UIButton * btn = (UIButton *)[self.view viewWithTag:currentData+27];
    [btn setTitle:[[dataArray objectAtIndex:currentData] objectAtIndex:[[lastSelectArray objectAtIndex:currentData] intValue] ] forState:UIControlStateNormal];
    
//    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    toolbar.frame = CGRectMake(0, NowViewsHight+20, 320, 40);
    pickerView.frame = CGRectMake(0, NowViewsHight, 320, 160);

}

-(void)hiddenActionSheet{
    
    datepicker.frame=CGRectMake(0-5.5, ScreenHeight, 320, 216);
    toolBarForNumber.frame=CGRectMake(0, ScreenHeight+20, 320, 44);
//    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    toolbar.frame = CGRectMake(0, NowViewsHight+20, 320, 40);
    pickerView.frame = CGRectMake(0, NowViewsHight, 320, 160);
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self hiddenActionSheet];
    datepicker.frame=CGRectMake(0-5.5, ScreenHeight, 320, 216);
    toolBarForNumber.frame=CGRectMake(0, ScreenHeight+20, 320, 44);
    
    
    
    if (textField.tag == 42) {
        [scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    } else if (textField.tag == 43) {
        [scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    } else if (textField.tag == 44) {
        [scrollView setContentOffset:CGPointMake(0, 280) animated:YES];
    } else if (textField.tag == 45) {
        [scrollView setContentOffset:CGPointMake(0, 350) animated:YES];
    } else if (textField.tag == 46) {
        [scrollView setContentOffset:CGPointMake(0, 430) animated:YES];
    } else if (textField.tag == 47) {
        [scrollView setContentOffset:CGPointMake(0, 500) animated:YES];
    } else if (textField.tag > 100 && textField.tag % 2 != 0&&textField.tag <1000) {
        
        [scrollView setContentOffset:CGPointMake(0, 920 + (260 * ((textField.tag - 101) / 10))) animated:YES];
    }else if (textField.tag == 102){
        [scrollView setContentOffset:CGPointMake(0, 1220 + (260 * ((textField.tag - 101) / 10))) animated:YES];
        
    } else if (textField.tag > 100 && textField.tag % 2 == 0&&textField.tag <1000) {

        [scrollView setContentOffset:CGPointMake(0, 920 + (260 * ((textField.tag - 101) / 10))) animated:YES];
    }else if (textField.tag == 1000){
        [textField resignFirstResponder];
        
        //lee999
//        [self hiddenActionSheet];
//        [self hiddleAllshowView];
        
        [nameTField resignFirstResponder];
        [nicknameTField resignFirstResponder];
        [telephoneTFiled resignFirstResponder];
        [verificationCodeTField resignFirstResponder];
        [addressTField resignFirstResponder];
        [postcodeTField resignFirstResponder];
        [emailTField resignFirstResponder];
        
        ModifyCell *cell = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.delegate = self;
        //    NSArray *arrCell2 = [cell2.birthdayLabel.text componentsSeparatedByString:@"-"];
        [cell.statureTfield resignFirstResponder];
        [cell.nameLabel resignFirstResponder];
        
        ModifyCell *cell2 = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell2.delegate = self;
        //    NSArray *arrCell2 = [cell2.birthdayLabel.text componentsSeparatedByString:@"-"];
        [cell2.statureTfield resignFirstResponder];
        [cell2.nameLabel resignFirstResponder];
        
        datepicker.tag = PicekTagCellOne;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        toolBarForNumber.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
        datepicker.frame = CGRectMake(0, ScreenHeight-216, 320, 216);
        toolBarForNumber.hidden = NO;
        
        
        [UIView commitAnimations];
    }else if (textField.tag == 1001){
        [textField resignFirstResponder];
        datepicker.tag = PicekTagCellTwo;

        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        toolBarForNumber.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
        datepicker.frame = CGRectMake(0, ScreenHeight-216, 320, 216);
        toolBarForNumber.hidden = NO;
        
        [UIView commitAnimations];
    }
    if (textField.tag == 10086) {
        [nameTField resignFirstResponder];
        [nicknameTField resignFirstResponder];
        [telephoneTFiled resignFirstResponder];
        [verificationCodeTField resignFirstResponder];
        [addressTField resignFirstResponder];
        [postcodeTField resignFirstResponder];
        [emailTField resignFirstResponder];
        
        ModifyCell *cell = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.delegate = self;
        //    NSArray *arrCell2 = [cell2.birthdayLabel.text componentsSeparatedByString:@"-"];
        [cell.statureTfield resignFirstResponder];
        [cell.nameLabel resignFirstResponder];
        
        ModifyCell *cell2 = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell2.delegate = self;
        //    NSArray *arrCell2 = [cell2.birthdayLabel.text componentsSeparatedByString:@"-"];
        [cell2.statureTfield resignFirstResponder];
        [cell2.nameLabel resignFirstResponder];
    }
    
    //lee999recode
    
}

-(void)changeChildBirthday:(NSInteger)index{

    //NSLog(@"-----index-----%d",index);
    [self.view endEditing:YES];
    
    if (index == 1000){
        //lee999
        ModifyCell *cell = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.delegate = self;
        //    NSArray *arrCell2 = [cell2.birthdayLabel.text componentsSeparatedByString:@"-"];
        [cell.statureTfield resignFirstResponder];
        [cell.nameLabel resignFirstResponder];
        
        ModifyCell *cell2 = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell2.delegate = self;
        //    NSArray *arrCell2 = [cell2.birthdayLabel.text componentsSeparatedByString:@"-"];
        [cell2.statureTfield resignFirstResponder];
        [cell2.nameLabel resignFirstResponder];
        
        datepicker.tag = PicekTagCellOne;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        toolBarForNumber.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
        datepicker.frame = CGRectMake(0, ScreenHeight-216, 320, 216);
        toolBarForNumber.hidden = NO;
        
        
        [UIView commitAnimations];
    }else if (index == 1001){
        datepicker.tag = PicekTagCellTwo;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        toolBarForNumber.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
        datepicker.frame = CGRectMake(0, ScreenHeight-216, 320, 216);
        toolBarForNumber.hidden = NO;
        
        [UIView commitAnimations];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

    [self hiddleAllshowView];
}


#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //lee999 150608
    return [(NSArray*)[dataArray objectAtIndex:currentData isArray:nil] count];
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 320;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 320, 20);
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.text = [NSString stringWithFormat:@"%@",[[dataArray objectAtIndex:currentData] objectAtIndex:row]];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [lastSelectArray replaceObjectAtIndex:currentData withObject:[NSString stringWithFormat:@"%d",row]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableViewDataArray.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ModifyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[ModifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.delegate = self;
    
    if (tableViewDataArray.count > 0) {
        NSDictionary *dic = [tableViewDataArray objectAtIndex:indexPath.row];
        
        cell.headlineLabel.text = [NSString stringWithFormat:@"儿童信息%d",indexPath.row+1];
        //姓名
        cell.nameLabel.text = ([cell.nameLabel.text isEqualToString:@""]?[dic objectForKey:@"name"]:cell.nameLabel.text);
        cell.nameLabel.tag = 100086;
        
        cell.gender = ([cell.gender isEqualToString:@""]?[dic objectForKey:@"sex"]:cell.gender);
        //年纪
        cell.birthdayLabelBtn.tag = 1000+indexPath.row;
//        cell.birthdayLabel.text = ([cell.birthdayLabel.text isEqualToString:@""]?[dic objectForKey:@"Birthday"]:cell.birthdayLabel.text);
        NSString *strl = ([cell.birthdayLabelBtn.titleLabel.text isEqualToString:@""]?[dic objectForKey:@"Birthday"]:cell.birthdayLabelBtn.titleLabel.text);
        
        [cell.birthdayLabelBtn setTitle:strl forState:UIControlStateNormal];
        
        cell.statureTfield.text = ([cell.statureTfield.text isEqualToString:@""]?[dic objectForKey:@"height"]:cell.statureTfield.text);
        deleteRow = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cell.statureTfield.delegate = self;
        cell.statureTfield.tag = 101+indexPath.row;
        cell.tag = 100+indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.deleteChirder = ^(NSInteger index){
            children --;
            NSLog(@"进入了块，运行了块");
            [addBtn setY:children * 260 + 920];
            [addBtn setHidden:NO];
            
            [mytableView reloadData];
        };
    };
    return cell;
}


- (void)selectReceiveview:(NSInteger)index{

}


- (void)deleteBtnClick
{
    [tableViewDataArray removeObjectAtIndex:deleteRow];
    [mytableView reloadData];
    [mytableView setHeight:250 * tableViewDataArray.count];
    [confirmBtn setY:addBtn.frame.origin.y + addBtn.frame.size.height
     +20];

    [remarkLabel setY:confirmBtn.frame.origin.y + confirmBtn.frame.size.height + 20];
    scrollView.contentSize = CGSizeMake(320, remarkLabel.frame.origin.y + remarkLabel.frame.size.height+30);
}


- (IBAction)btnClick:(id)sender {
    
    //lee999
    [self hiddleAllshowView];
    
    UIButton * btn = (UIButton *)sender;
    if (btn.tag == 21) {
        UIButton * gentlemanBtn2 = (UIButton *)[self.view viewWithTag:22];
        [btn setImage:[UIImage imageNamed:@"radio_btn_checked.png"] forState:UIControlStateNormal];
        [gentlemanBtn2 setImage:[UIImage imageNamed:@"radio_btn_unchecked.png"] forState:UIControlStateNormal];
        gender = @"f";
    } else if (btn.tag == 22) {
        UIButton * ladyBtn2 = (UIButton *)[self.view viewWithTag:21];
        [btn setImage:[UIImage imageNamed:@"radio_btn_checked.png"] forState:UIControlStateNormal];
        [ladyBtn2 setImage:[UIImage imageNamed:@"radio_btn_unchecked.png"] forState:UIControlStateNormal];
        gender = @"m";
    } else if (btn.tag == 23||btn.tag == 24||btn.tag == 25) {
        
        datepicker.tag = PicekTag;
        toolBarForNumber.hidden = NO;
        [UIView commitAnimations];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        datepicker.frame=CGRectMake(0-5.5, ScreenHeight-216, 320, 216);
        toolBarForNumber.frame=CGRectMake(0, ScreenHeight-216-44, 320, 44)
        ;
        [UIView commitAnimations];
        //  年
    }

    else if (btn.tag == 26) {
        if ([NSString isValidTelephoneNum2:telephoneTFiled.text]) {
            
            [telephoneTFiled resignFirstResponder];
            
            [mainSer getAchievecode:telephoneTFiled.text];
            
            [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
        }else{
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请输入正确的手机号码"];
        }
        
        //  立即验证
    } else if (btn.tag >= 27 && btn.tag <= 31) {
        //  月收入  职业  内衣尺码  底裤尺码  成衣尺码
        currentData = btn.tag - 27;
        
        toolbar.frame=CGRectMake(0, ScreenHeight-216-44, 320, 44);
        
        [pickerView reloadAllComponents];
        [pickerView selectRow:[[lastSelectArray objectAtIndex:currentData] intValue] inComponent:0 animated:NO];
        pickerView.frame=CGRectMake(0-5.5, ScreenHeight-216, 320, 216);

        
    } else if (btn.tag == 50) {
        children++;
        
        NSDictionary *dic = @{@"name":@"",@"sex":@"",@"Birthday":@"",@"height":@""};
        [tableViewDataArray addObject:dic];
        
        [mytableView reloadData];
        mytableView.height = children * 260;
        [addBtn setY:children * 260 + 930];
        [confirmBtn setY:addBtn.frame.origin.y + addBtn.frame.size.height];
        [remarkLabel setY:confirmBtn.frame.origin.y + confirmBtn.frame.size.height];
        scrollView.contentSize = CGSizeMake(320, remarkLabel.frame.origin.y + remarkLabel.frame.size.height + 30);
        
        if (children == 2) {
            addBtn.hidden = YES;
        }

    }else if (btn.tag == 32) { //完善资料的确定按钮
        
        
        if (nameTField.text.length==0) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请填写您的姓名"];
            return;
        }
        if (yearBtn.titleLabel.text.length==0) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请填写您的出生日期"];
            return;
        }
        if (telephoneTFiled.text==0) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请填写您的手机号码"];
            return;
        }
        if (verificationCodeTField.text==0) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请填写验证码"];
            return;
        }
        if (addressTField.text==0) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请填写您的地址"];
            return;
        }
//        if (postcodeTField.text.length>0) {
            if (postcodeTField.text.length != 6) {
                [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请您填写正确的邮编"];
                return;
            }
//        }
        if (emailTField.text==0) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请填写您的邮箱"];
            return;
        }
        
        if (yearBtn.titleLabel.text.length==1) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请填写您出生年月日"];
            return;
        }
        
        ModifyCell *cell = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSArray *arrCell = [cell.birthdayLabelBtn.titleLabel.text componentsSeparatedByString:@"-"];
        cell.delegate = self;

        
        ModifyCell *cell2 = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        NSArray *arrCell2 = [cell2.birthdayLabelBtn.titleLabel.text componentsSeparatedByString:@"-"];
        cell2.delegate = self;
        
        [mainSer getDealapplyZunxiang:@"尊享"
                               andKey:self.key
                              andName:nameTField.text
                               andSex:gender
                         andNick_Name:nicknameTField.text
                            andMobile:telephoneTFiled.text
                       andAk_Height_1:cell.statureTfield.text
                       andAk_Height_2:cell2.statureTfield.text
                         andCheckcode:verificationCodeTField.text
                          andAk1_Year:arrCell.count > 0?[arrCell objectAtIndex:0]:@""
                         andAk1_Month:arrCell.count > 1?[arrCell objectAtIndex:1]:@""
                           andAk1_Day:arrCell.count > 2?[arrCell objectAtIndex:2]:@""
                          andAk2_Year:arrCell2.count > 0?[arrCell2 objectAtIndex:0]:@""
                         andAk2_Month:arrCell2.count > 1?[arrCell2 objectAtIndex:1]:@""
                           andAk2_Day:arrCell2.count > 2?[arrCell2 objectAtIndex:2]:@""
                         andAk_Name_1:cell.nameLabel.text
                         andAk_Name_2:cell2.nameLabel.text
                       andV6User_Year:yearBtn.titleLabel.text
                      andV6User_Month:monthBtn.titleLabel.text
                        andV6User_Day:dayBtn.titleLabel.text
                          andAk_Sex_1:cell.gender
                          andAk_Sex_2:cell2.gender
                           andAddress:addressTField.text
                             andEmail:emailTField.text
                           andZipcode:postcodeTField.text
                               andAge:nil
                            andIncome:incomeBtn.titleLabel.text
                        andProfession:professionBtn.titleLabel.text
                           andBrasize:underwearBtn.titleLabel.text
                        andUnderpants:underpantsBtn.titleLabel.text
                         andClothsize:adultBtn.titleLabel.text];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

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
        case Http_addCouponcard_Tag:
        {
            if (!model.errorMessage) {
                
                [SBPublicAlert showMBProgressHUDTextOnly:((ChengeMyInfo *)model).res andWhereView:self.view hiddenTime:2.0];
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
        case Http_Dealapply_Tag:
        {
            if (!model.errorMessage) {
                
                [SBPublicAlert showMBProgressHUDTextOnly:((ChengeMyInfo *)model).res andWhereView:self.view hiddenTime:2.0];
                
                [self performSelector:@selector(popBackAnimate:) withObject:nil afterDelay:1.2];
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:1.0];
            break;
        default:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
        }
            break;
    }
}



@end
