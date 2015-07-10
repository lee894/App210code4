//
//  ModifyInformationViewController.m
//  MySuperApp
//
//  Created by 念肆 on 14-9-17.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "ModifyInformationViewController.h"
#import "ModifyCell.h"
#import "SBPublicFormatValidation.h"

@interface ModifyInformationViewController () {
    UIButton * addChildrenBtn ;
    
    
    UIToolbar *toolBarForPicker;
    UIDatePicker *pickerForSelectColor;
    
    
    UIToolbar *mytoolbar;
    UIPickerView * mypickerView;

}

@end

@implementation ModifyInformationViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        currentData = 0;
        deleteRow = 0;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (isIOS7up) {
        scrollView.frame = CGRectMake(0, -30, ScreenWidth, NowViewsHight+30);
    }else{
        scrollView.frame = CGRectMake(0, 0, ScreenWidth, NowViewsHight);
    }
    scrollView.contentSize = CGSizeMake(320, 1060);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self BarButtonClick:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillShowNotification
                                                 object:nil];
    
    [self hiddenKeyBoard];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"修改个人信息";
    [self createBackBtnWithType:0];

    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    [mainSer getuserInfo];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
    scrollView.userInteractionEnabled = YES;
    scrollView.delegate = self;
    
    
    nameLabel.delegate = self;

//    birthdayLabel.delegate = self;
    telephoneLabel.delegate = self;
    nicknameTField.delegate = self;
    addressTField.delegate = self;
    postcodeTField.delegate = self;
    emailTField.delegate = self;
    postcodeTField.keyboardType = UIKeyboardTypeNumberPad;
    telephoneLabel.keyboardType = UIKeyboardTypePhonePad;
    emailTField.keyboardType = UIKeyboardTypeEmailAddress;
    
    lastSelectArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
    dataArray = [[NSMutableArray alloc] init];
    
    tableViewDataArray = [[NSMutableArray alloc] init];
    
    NSDictionary *dic1 = @{@"name":@"",@"sex":@"",@"Birthday":@"",@"height":@""};
    [tableViewDataArray addObject:dic1];

    //儿童信息的tableView
    mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 680, 320, 250 * tableViewDataArray.count) style:UITableViewStylePlain];
    mytableView.backgroundColor = [UIColor clearColor];
    mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mytableView.bounces = NO;
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [scrollView addSubview:mytableView];
    
    //用于选择  职业，内衣尺码  等效果
    [self createUserInfoPicker];
    
    //创建日期picker
    [self createDatePicker];
    
    children = 1;
    
    addChildrenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addChildrenBtn setTitle:@"增加一个儿童信息" forState:UIControlStateNormal];
    [addChildrenBtn setTitleColor:[UIColor colorWithHexString:@"0xB90023"] forState:UIControlStateNormal];
    [addChildrenBtn setTitleColor:[UIColor colorWithHexString:@"0xB90023"] forState:UIControlStateHighlighted];
    addChildrenBtn.frame = CGRectMake(25,children * 270 + 660, 150, 30);

    addChildrenBtn.tag = 50;
    [addChildrenBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addChildrenBtn];
    
    [confirmBtn setY:addChildrenBtn.frame.origin.y + addChildrenBtn.frame.size.height];
    scrollView.contentSize = CGSizeMake(320, confirmBtn.frame.origin.y + confirmBtn.frame.size.height + 30);
}


#pragma mark--  生日的picker
-(void)createDatePicker{
    pickerForSelectColor=[[UIDatePicker alloc] init];
    pickerForSelectColor.datePickerMode = UIDatePickerModeDate;
    pickerForSelectColor.frame = CGRectMake(0, ScreenHeight, 320, 216);
    
    [pickerForSelectColor setBackgroundColor:[UIColor whiteColor]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate* minDate = [dateFormatter dateFromString:@"1900-01-01 00:00:00 -0500"];
    NSDate* maxDate = [dateFormatter dateFromString:@"2099-01-01 00:00:00 -0500"];
    
    pickerForSelectColor.minimumDate  = minDate;
    pickerForSelectColor.maximumDate  = maxDate;
    
    //创建toolbar
    toolBarForPicker=[[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight+20, 320, 44)];
    toolBarForPicker.barStyle=UIBarStyleBlackTranslucent;
    [self.view addSubview:toolBarForPicker];
    
    UIBarButtonItem *buttonForCancel=[[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    buttonForCancel.tag=103;
    if (isIOS7up) {
        buttonForCancel.tintColor = [UIColor whiteColor];
    }
    UIBarButtonItem *buttonForFix=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    buttonForFix.width=210;
    UIBarButtonItem *buttonForDone=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    buttonForDone.tag=105;
    if (isIOS7up) {
        buttonForDone.tintColor = [UIColor whiteColor];
    }
    [toolBarForPicker setItems:[NSArray arrayWithObjects:buttonForCancel,buttonForFix,buttonForDone,nil]];
    [self.view addSubview:pickerForSelectColor];
}

-(void)BarButtonClick:(UIBarButtonItem *)barButton{
    //	toolBarForPicker.hidden=YES;
    //	pickerForSelectColor.hidden=YES;
    //实例化一个NSDateFormatter对象
    
    if (barButton.tag == 105) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:pickerForSelectColor.date];
        //输出格式为：2010-10-27 10:22:13
        NSLog(@"currentDateStr:------%@",currentDateStr);
        if (pickerForSelectColor.tag == 40) {
            [birthdayLabelBtn setTitle:currentDateStr forState:UIControlStateNormal];
//            birthdayLabelBtn.titleLabel.text = ;
        }else if (pickerForSelectColor.tag == 102) {
            
            //儿童信息1
            ModifyCell *cell = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.delegate = self;
            [cell.birthdayLabelBtn setTitle:currentDateStr forState:UIControlStateNormal];
//            cell.birthdayLabel.text = currentDateStr;
        }else if (pickerForSelectColor.tag == 106) {
            
            //儿童信息2
            ModifyCell *cell = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell.delegate = self;
            [cell.birthdayLabelBtn setTitle:currentDateStr forState:UIControlStateNormal];
//            cell.birthdayLabel.text = currentDateStr;
        }
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    toolBarForPicker.frame = CGRectMake(0, ScreenHeight+20, 320, 44);
    pickerForSelectColor.frame = CGRectMake(0, ScreenHeight, 320, 216);
    
    [UIView commitAnimations];
    
}


#pragma mark  选择职业，内衣大小的picker

-(void)createUserInfoPicker{
    
//    actionSheet = [[UIActionSheet alloc]initWithTitle:@"\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    mytoolbar = [[UIToolbar alloc]init];
    mytoolbar.frame = CGRectMake(0, ScreenHeight+20, 320, 40);
    mytoolbar.barStyle = UIBarStyleBlackOpaque;
    
    //lee999recode
    UIBarButtonItem *buttonForCancel=[[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStyleBordered target:self action:@selector(hiddenBarAndSheet)];
    buttonForCancel.tag=103;
    if (isIOS7up) {
        buttonForCancel.tintColor = [UIColor whiteColor];
    }
    UIBarButtonItem *buttonForFix=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    buttonForFix.width=210;
    //end
    
    UIBarButtonItem *okBbi = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(bbiClick)];
    if (isIOS7up) {
        okBbi.tintColor = [UIColor whiteColor];
    }

    [mytoolbar setItems:[NSArray arrayWithObjects:buttonForCancel,buttonForFix,okBbi, nil]];
    [self.view addSubview:mytoolbar];

    
    mypickerView = [[UIPickerView alloc]init];
    mypickerView.frame = CGRectMake(0, ScreenHeight, 320, 160);
    mypickerView.delegate = self;
    mypickerView.dataSource = self;
    [mypickerView setBackgroundColor:[UIColor whiteColor]];
    mypickerView.showsSelectionIndicator = YES;
    [self.view addSubview:mypickerView];
}

- (void)bbiClick
{
    UIButton * btn = (UIButton *)[self.view viewWithTag:currentData+23];
    //lee 150608
    if ([(NSArray*)[dataArray objectAtIndex:currentData isArray:nil] count] > 0 ) {
        
        [lastSelectArray replaceObjectAtIndex:currentData withObject:[NSString stringWithFormat:@"%ld",(long)[mypickerView selectedRowInComponent:0]]];
        
        [btn setTitle:[[dataArray objectAtIndex:currentData] objectAtIndex:[[lastSelectArray objectAtIndex:currentData] intValue]] forState:UIControlStateNormal];
    }
//    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    mypickerView.frame = CGRectMake(0, ScreenHeight, 320, 160);
    mytoolbar.frame = CGRectMake(0, ScreenHeight+20, 320, 40);

}

//lee999recode
-(void)hiddenBarAndSheet{
//    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    mypickerView.frame = CGRectMake(0, ScreenHeight, 320, 160);
    mytoolbar.frame = CGRectMake(0, ScreenHeight+20, 320, 40);
}


#pragma mark textField
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    mypickerView.frame = CGRectMake(0, ScreenHeight, 320, 160);
    mytoolbar.frame = CGRectMake(0, ScreenHeight+20, 320, 40);
    toolBarForPicker.frame = CGRectMake(0, ScreenHeight+20, 320, 44);
    pickerForSelectColor.frame = CGRectMake(0, ScreenHeight, 320, 216);

    
    
    //lee999 加了60，修改了适配的问题
    CGFloat hight = [scrollView viewWithTag:textField.tag - 1].frame.origin.y-216 +60;
    
    if (textField.tag == 38) {
        //填写姓名
//        [scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    } else if (textField.tag == 39) {
        //昵称
//        [scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    } else if (textField.tag == 40) {
        [self.view endEditing:YES];
//        [textField resignFirstResponder];
//        [self hiddenKeyBoard];
//        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
//        [scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
        
        //创建toolbar
        pickerForSelectColor.tag = textField.tag;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        toolBarForPicker.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
        pickerForSelectColor.frame = CGRectMake(0, ScreenHeight-216, 320, 216);
        [UIView commitAnimations];
  
    } else if (textField.tag == 41) {
        //手机号码
//        [scrollView setContentOffset:CGPointMake(0, hight) animated:YES];
    } else if (textField.tag == 42) {
        //邮寄地址
        [scrollView setContentOffset:CGPointMake(0, hight) animated:YES];
    } else if (textField.tag == 43) {
        //邮编
        [scrollView setContentOffset:CGPointMake(0, hight) animated:YES];
    } else if (textField.tag == 44) {
        //电子邮箱
        [scrollView setContentOffset:CGPointMake(0, hight) animated:YES];
    } else if (textField.tag > 100) {
        
        if (textField.tag<104) {
            if (textField.tag == 102) {
                [self.view endEditing:YES];
                
                
                pickerForSelectColor.tag = textField.tag;
                [textField resignFirstResponder];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.3];
                
                toolBarForPicker.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
                pickerForSelectColor.frame = CGRectMake(0, ScreenHeight-216, 320, 216);
                
                [UIView commitAnimations];
            }
            [scrollView setContentOffset:CGPointMake(0, mytableView.frame.origin.y -252 + (textField.tag - 99) * 60) animated:YES];

            lastOffset =  mytableView.frame.origin.y -252 + (textField.tag - 99) * 60;
            isCellOffset = YES;
        }else {
//            ModifyCell *cell2 = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//            cell2.delegate = self;
//            if (textField.tag == 106) {
//                
//                pickerForSelectColor.tag = textField.tag;
//                [textField resignFirstResponder];
//                [UIView beginAnimations:nil context:nil];
//                [UIView setAnimationDuration:0.3];
//                
//                toolBarForPicker.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
//                
//                pickerForSelectColor.frame = CGRectMake(0, ScreenHeight-216, 320, 216);
//                
//                [UIView commitAnimations];
//            }
//            [scrollView setContentOffset:CGPointMake(0, cell2.frame.origin.y + (textField.tag - 99) * 100) animated:YES];
//            lastOffset =  cell2.frame.origin.y + (textField.tag - 99) * 100;
//            isCellOffset = YES;
        }
    }
}


-(IBAction)endEdit:(id)sender{
    [self.view endEditing:YES];
}

-(IBAction)birthdayLabelBtnAciton:(id)sender{
    
    [self.view endEditing:YES];
    pickerForSelectColor.tag = 40;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    toolBarForPicker.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
    pickerForSelectColor.frame = CGRectMake(0, ScreenHeight-216, 320, 216);
    [UIView commitAnimations];
}


#pragma mark  隐藏键盘
-(void)hiddenKeyBoard{
    
    [nameLabel resignFirstResponder];
//    [birthdayLabel resignFirstResponder];
    [telephoneLabel resignFirstResponder];
    [nicknameTField resignFirstResponder];
    [addressTField resignFirstResponder];
    [postcodeTField resignFirstResponder];
    [emailTField resignFirstResponder];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -- UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - UIPickerView

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([dataArray respondsToSelector:@selector(objectAtIndex:)] && [dataArray count] > 0) {
        //lee999 150608
        return [(NSArray*)[dataArray objectAtIndex:currentData isArray:nil] count];
    }
    return 0;
}

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
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ModifyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell.delegate = self;
    if (!cell) {
        cell = [[ModifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    
    NSDictionary *dic = [tableViewDataArray objectAtIndex:indexPath.row];
    
    cell.headlineLabel.text = [NSString stringWithFormat:@"儿童信息%d",indexPath.row+1];
    cell.nameLabel.text = [dic objectForKey:@"name"];
    
    if ([[dic objectForKey:@"sex"] isEqualToString:@"f"]) {
        [cell btnClick:[cell viewWithTag:22]];
    }else {
        [cell btnClick:[cell viewWithTag:21]];
    }
    
//    cell.birthdayLabelBtn.text = [dic objectForKey:@"Birthday"];
    [cell.birthdayLabelBtn setTitle:[dic objectForKey:@"Birthday"] forState:UIControlStateNormal];

    cell.statureTfield.text = [dic objectForKey:@"height"];
    deleteRow = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cell.statureTfield.delegate = self;
    cell.nameLabel.delegate = self;
//    cell.birthdayLabel.delegate = self;
    cell.nameLabel.tag = 101+indexPath.row*4;
    cell.birthdayLabelBtn.tag = 102+indexPath.row*4;
    cell.statureTfield.tag = 103+indexPath.row*4;


    cell.tag = 100+indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.deleteChirder = ^(NSInteger index){
        children --;
        //只有一个，或者没有孩子的信息
        //        [tableViewDataArray removeObjectAtIndex:self.children-1];
        [addChildrenBtn setY:children * 260 + 660];
        [confirmBtn setY:addChildrenBtn.frame.origin.y + addChildrenBtn.frame.size.height];
        scrollView.contentSize = CGSizeMake(320, confirmBtn.frame.origin.y + confirmBtn.frame.size.height +30);
        
        [addChildrenBtn setHidden:NO];
        
        [tableView reloadData];
    };
    
    return cell;
}

- (void)deleteBtnClick
{
    [tableViewDataArray removeObjectAtIndex:deleteRow];
    [mytableView reloadData];
    
    [addChildrenBtn setY:children * 260 + 660];
    [mytableView setHeight:250 * tableViewDataArray.count];
    [confirmBtn setY:mytableView.frame.origin.y + mytableView.frame.size.height + 20];
    scrollView.contentSize = CGSizeMake(320, confirmBtn.frame.origin.y + confirmBtn.frame.size.height + 30);
}


-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self hiddenKeyBoard];
}


#pragma mark 所有but的事件
- (IBAction)btnClick:(id)sender {
    
    [self.view endEditing:YES];
    
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
    } else if (btn.tag >= 23 && btn.tag <= 27) {
        //  月收入  职业  内衣尺码  底裤尺码  成衣尺码
        currentData = btn.tag - 23;
//        [actionSheet showInView:scrollView];
        mytoolbar.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
        
        [mypickerView reloadAllComponents];
        [mypickerView selectRow:[[lastSelectArray objectAtIndex:currentData] intValue] inComponent:0 animated:NO];
        mypickerView.frame = CGRectMake(0, ScreenHeight-216, 320, 216);

        
    }else if (btn.tag == 28){ //提交按钮
        
        ModifyCell *cell = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.delegate = self;
        ModifyCell *cell2 = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.delegate = self;

        //lee999 增加判断，么有输入手机号的时候，提示输入手机号。
        if (telephoneLabel.text.length<1) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请您输入手机号码"];
            return;
        }//end
        
        if (![NSString isValidTelephoneNum2:telephoneLabel.text]) {
            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请输入正确的手机号码"];
            return;
        }
        
//        if (![NSString isValidateEmail:emailTField.text]) {
//            [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请输入正确的邮箱"];
//            return;
//        }
        
        //lee999增加邮编的判断
        if (postcodeTField.text.length != 0) {
            if (postcodeTField.text.length != 6) {
                [SBPublicAlert showAlertTitle:@"爱慕提示" Message:@"请输入正确的邮编"];
                return;
            }
        }
        NSString *strBirthday = birthdayLabelBtn.titleLabel.text;
        NSLog(@"----%@",strBirthday);
        
        
        [mainSer editUSerinfoBrasize:underwearBtn.titleLabel.text
                       andUnderpants:underpantsBtn.titleLabel.text
                        andClothsize:adultBtn.titleLabel.text
                         andRealname:nameLabel.text
                           andGender:gender
                         andNickname:nicknameTField.text
                         andBirthday:birthdayLabelBtn.titleLabel.text
                           andMobile:telephoneLabel.text
                          andAddress:addressTField.text
                            andEmail:emailTField.text
                       andProfession:professionBtn.titleLabel.text
                           andIncome:incomeBtn.titleLabel.text
                  andChild1_Birthday:cell.birthdayLabelBtn.titleLabel.text
                        andAk_Name_1:cell.nameLabel.text
                        andAk_Name_2:cell2.nameLabel.text
                         andAk_Sex_1:cell.gender
                         andAk_Sex_2:cell2.gender
                          andChild1H:cell.statureTfield.text
                          andChild2H:cell2.statureTfield.text
                          andZipcode:postcodeTField.text
                  andChild2_Birthday:cell2.birthdayLabelBtn.titleLabel.text];
        
        
        
        
        [SBPublicAlert showMBProgressHUD:@"正在提交···" andWhereView:self.view states:NO];
    
    }else if (btn.tag == 50) {
        children++;
        NSDictionary *dic = @{@"name":@"",@"sex":@"",@"Birthday":@"",@"height":@""};
        [tableViewDataArray addObject:dic];
        [mytableView reloadData];
        mytableView.height = children * 260;

        //两个孩子的信息都加上了~
        
        [addChildrenBtn setY:children * 270 + 640];
        [confirmBtn setY:addChildrenBtn.frame.origin.y + addChildrenBtn.frame.size.height];
        scrollView.contentSize = CGSizeMake(320, confirmBtn.frame.origin.y + confirmBtn.frame.size.height+ 60);
        
        if (children == 2) {
            addChildrenBtn.hidden = YES;
        }
    }
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aObject
{
    return [aObject isEqual:[NSNull null]]||aObject == nil ? @"" : aObject;
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
        case Http_INFO_Tag:
        {
            
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                infoModel = (InfoInfoModel *)model;
                
                [dataArray addObject:infoModel.marriageArr];
                [dataArray addObject:infoModel.position];
                [dataArray addObject:infoModel.brasizes];
                [dataArray addObject:infoModel.underpant];
                [dataArray addObject:infoModel.clothsizes];
                
                nameLabel.text = infoModel.realname;
                [birthdayLabelBtn setTitle:infoModel.birthday forState:UIControlStateNormal];
//                birthdayLabelBtn.titleLabel.text = infoModel.birthday;
                telephoneLabel.text = infoModel.mobile;
                emailTField.text = infoModel.email;
                addressTField.text = infoModel.address;
                nicknameTField.text = infoModel.nickname;
                postcodeTField.text = infoModel.zipcode;

                
                if ([infoModel.gender isEqualToString:@"f"]) {
                    [self btnClick:[scrollView viewWithTag:21]];
                }else {
                    [self btnClick:[scrollView viewWithTag:22]];

                }
                if (infoModel.akName1 == nil) {
                    infoModel.akName1 = @"";
                }
                if (infoModel.akSex1 == nil) {
                    infoModel.akSex1 = @"";
                }
                if (infoModel.childBirthday == nil) {
                    infoModel.childBirthday = @"";
                }
                if (infoModel.childHeight == nil) {
                    infoModel.childHeight = @"";
                }
                
                
                NSDictionary *dic1 = @{@"name":infoModel.akName1,@"sex":infoModel.akSex1,@"Birthday":infoModel.childBirthday,@"height":infoModel.childHeight};
                [tableViewDataArray replaceObjectAtIndex:0 withObject:dic1];
                
                if (infoModel.akName2 != nil &&![infoModel.akName2 isEqualToString:@""]) {
                    NSDictionary *dic2 = @{@"name": [self  objectOrNilForKey:infoModel.akName2],@"sex":[self  objectOrNilForKey:infoModel.akSex2],@"Birthday":[self  objectOrNilForKey:infoModel.child1Birthday],@"height":[self  objectOrNilForKey:infoModel.child2_height]};
                    children ++;
                    if (tableViewDataArray.count > 1) {
                        [tableViewDataArray replaceObjectAtIndex:1 withObject:dic2];
                    }else {
                        [tableViewDataArray addObject:dic2];

                    }
                    mytableView.height = children * 260;
                    //        UIButton * addBtn = (UIButton *)[self.view viewWithTag:50];
                    
                    [addChildrenBtn setY:children * 260 + 660 +10];
                    [confirmBtn setY:addChildrenBtn.frame.origin.y + addChildrenBtn.frame.size.height];
                    scrollView.contentSize = CGSizeMake(320, confirmBtn.frame.origin.y + confirmBtn.frame.size.height +30);
                    
                    [addChildrenBtn setHidden:YES];
                }
                
                
                
                [mytableView reloadData];
                
                if (!infoModel.income) {
                    [incomeBtn setTitle:@"请选择" forState:UIControlStateNormal];
                } else {
                    //                [lastSelectArray addObject:infoModel.income];
                    //                [lastSelectArray addObject:infoModel.profession];
                    //                [lastSelectArray addObject:infoModel.brasize];
                    //                [lastSelectArray addObject:infoModel.underpants];
                    //                [lastSelectArray addObject:infoModel.clothsize];
                    int i = 0;
                    for (NSString *temStr in infoModel.marriageArr) {
                        
                        if ([temStr isEqualToString: infoModel.income]) {
                           [lastSelectArray addObject:[NSString stringWithFormat:@"%d",i]];
                            break;
                        }
                        i++;
                        if (i >= infoModel.marriageArr.count) {
                            i = infoModel.marriageArr.count-1;
                        }
                    }
                    
                    [incomeBtn setTitle:[infoModel.marriageArr objectAtIndex:i] forState:UIControlStateNormal];
                }
                if (!infoModel.profession) {
                    [professionBtn setTitle:@"请选择" forState:UIControlStateNormal];
                } else {
                    int i = 0;
                    for (NSString *temStr in infoModel.position) {
                        
                        if ([temStr isEqualToString:infoModel.profession]) {
                            [lastSelectArray addObject:[NSString stringWithFormat:@"%d",i]];
                            break;
                        }
                        i++;
                        if (i >= infoModel.position.count) {
                            i = infoModel.position.count-1;
                        }
                    }
                    [professionBtn setTitle:[infoModel.position objectAtIndex:i] forState:UIControlStateNormal];
                }
                if (!infoModel.brasize) {
                    [underwearBtn setTitle:@"请选择" forState:UIControlStateNormal];
                } else {
                    int i = 0;
                    for (NSString *temStr in infoModel.brasizes) {
                        
                        if ([temStr isEqualToString:infoModel.brasize ]) {
                            [lastSelectArray addObject:[NSString stringWithFormat:@"%d",i]];
                            break;
                        }
                        i++;
                        
                        if (i >= infoModel.brasizes.count) {
                            i = infoModel.brasizes.count-1;
                        }
                    }
                    [underwearBtn setTitle:[infoModel.brasizes objectAtIndex:i] forState:UIControlStateNormal];
                }
                if (!infoModel.underpants) {
                    [underpantsBtn setTitle:@"请选择" forState:UIControlStateNormal];
                } else {
                    int i = 0;
                    for (NSString *temStr in infoModel.underpant) {
                        
                        if ([temStr isEqualToString:infoModel.underpants]) {
                            [lastSelectArray addObject:[NSString stringWithFormat:@"%d",i]];
                            break;
                        }
                        i++;
                        
                        if (i >= infoModel.underpant.count) {
                            i = infoModel.underpant.count-1;
                        }
                    }
                    [underpantsBtn setTitle:[infoModel.underpant objectAtIndex:i] forState:UIControlStateNormal];
                }
                if (!infoModel.clothsize) {
                    [adultBtn setTitle:@"请选择" forState:UIControlStateNormal];
                } else {
                    int i = 0;
                    for (NSString *temStr in infoModel.clothsizes) {
                        
                        if ([temStr isEqualToString:infoModel.clothsize]) {
                            [lastSelectArray addObject:[NSString stringWithFormat:@"%d",i]];
                            break;
                        }
                        i++;
                        if (i >= infoModel.clothsizes.count) {
                            i = infoModel.clothsizes.count-1;
                        }
                    }
                    [adultBtn setTitle:[infoModel.clothsizes objectAtIndex:i] forState:UIControlStateNormal];
                }
            }else {
                
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            
        }
            break;
        case Http_EditInfo_Tag:
        {
            if (!model.errorMessage) {
                
//                [SBPublicAlert showMBProgressHUD:[(ChengeMyInfo *)model res] andWhereView:self.view hiddenTime:1.];
//                [SBPublicAlert showMBProgressHUD:@"恭喜您，修改成功" andWhereView:self.view hiddenTime:0.6];
//                [self.navigationController popViewControllerAnimated:YES];
                
                UIAlertView *alertv = [[UIAlertView alloc]initWithTitle:@"爱慕提示" message:@"恭喜您修改成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                alertv.tag = 100098;
                [alertv show];
            
            }else{
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
            [SBPublicAlert hideMBprogressHUD:self.view];
            break;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100098) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)selectReceiveview:(NSInteger)index{

    switch (index) {
        case 1:
        {
        
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void)changeChildBirthday:(NSInteger)index{

    [self.view endEditing:YES];
    
    NSLog(@"index----%d",index);
    
    ModifyCell *cell2 = (ModifyCell *)[mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell2.delegate = self;
//    if (index== 106) {
    
        pickerForSelectColor.tag = index;

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        toolBarForPicker.frame = CGRectMake(0, ScreenHeight-216-44, 320, 44);
        
        pickerForSelectColor.frame = CGRectMake(0, ScreenHeight-216, 320, 216);
        
        [UIView commitAnimations];
//    }
    [scrollView setContentOffset:CGPointMake(0, cell2.frame.origin.y + (index - 99) * 100) animated:YES];
    lastOffset =  cell2.frame.origin.y + (index - 99) * 100;
    isCellOffset = YES;

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
