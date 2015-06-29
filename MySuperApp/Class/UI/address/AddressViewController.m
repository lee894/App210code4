//
//  AddressViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-1.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressCell.h"
#import "AddAddressViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

@synthesize isCar;
@synthesize chectOutViewC;

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
    
    self.title = @"收货地址";
    [self createBackBtnWithType:0];
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    mainSer = [[MainpageServ alloc] init];
    mainSer.delegate = self;
    
    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"新增地址" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"新增地址" forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(242, 7, 66, 32)];
    
    
    isDelAddress = NO;
    
    
    UIView *tempFoot = [[[NSBundle mainBundle] loadNibNamed:@"FootView" owner:self options:nil] lastObject];
    [tableList setAllowsSelectionDuringEditing:YES];
    tableList.tableFooterView = tempFoot;
    
    [tableList setFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self getTablelistData];

}

-(void)getTablelistData{
    [mainSer getAddersslist];
    [buttonEdit setHidden:YES];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark -- 按钮事件

- (IBAction)editAddress:(id)sender//编辑地址
{
    if ([buttonEdit.titleLabel.text isEqualToString:@"编辑地址"]) {
        
        [buttonEdit setTitle:@"完成" forState:UIControlStateNormal];
        [buttonEdit setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [tableList setEditing:YES];
        
        [tableList reloadData];
        
    }else if ([buttonEdit.titleLabel.text isEqualToString:@"完成"]){
        
        [buttonEdit setTitle:@"编辑地址" forState:UIControlStateNormal];
        [buttonEdit setTitle:@"编辑地址" forState:UIControlStateHighlighted];
        [tableList setEditing:NO];
        [tableList reloadData];
    }
}

- (void)rightButAction//新增地址
{
    AddAddressViewController *tempAddAddress = [[AddAddressViewController alloc] initWithNibName:@"AddAddressViewController" bundle:nil];
    tempAddAddress.addOrEdit = YES;
    tempAddAddress.isFromcheck = self.isCar;
    [self.navigationController pushViewController:tempAddAddress animated:YES];
}

#pragma mark -- Netrequest delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_Addresslist_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                addresslistModel = (AddressAddressLIstModel *)model;
                
                CGRect oldF = buttonEdit.frame;
                oldF.origin.x = (ScreenWidth-oldF.size.width)/2;
                [buttonEdit setFrame:oldF];
                
                [buttonEdit setHidden:NO];
                
                //lee999 修复bug 如果没有地址的时候
                if (addresslistModel.addresslist.count < 1) {
                    tableList.hidden = YES;
                    [buttonEdit setHidden:YES];
                    noaddrssslab.hidden = NO;
                    if(chectOutViewC)
                    {
                        chectOutViewC.straddressID = @"";
                    }
                }else{
                    tableList.hidden = NO;
                    noaddrssslab.hidden = YES;
                }
                
                tableList.delegate = self;
                tableList.dataSource = self;
                
                [tableList reloadData];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            break;
        case Http_AddressDel_Tag:
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
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
    
    //lee999 修改bug
    if (isDelAddress) {
        isDelAddress = NO;
        [self getTablelistData];
    }
}

#pragma mark -- 删除地址数据请求
- (void)requestDeleteAddr:(AddressAddresslist *)addrList
{
    [mainSer getAddressdel:addrList.addresslistIdentifier];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
    isDelAddress = YES;
}

#pragma mark -- UITableView delegate and datesource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return addresslistModel.addresslist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    AddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (addressCell == nil) {
        addressCell = [[[NSBundle mainBundle] loadNibNamed:@"AddressCell" owner:self options:nil] lastObject];
    }
    
    AddressAddresslist *addressList = [addresslistModel.addresslist objectAtIndex:indexPath.row];
    
    if ([self.PublicStringAddressId isEqualToString:addressList.addresslistIdentifier]&&!tableView.editing) {
        addressCell.imageCheck.hidden = NO;
        
        CGRect oldf = addressCell.imageCheck.frame;
        oldf.origin.x = ScreenWidth-50;
        [addressCell.imageCheck setFrame:oldf];
        
    }else {
        addressCell.imageCheck.hidden = YES;
    }
    
    [addressCell setContentWithArray:addressList];
    
    addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return addressCell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self requestDeleteAddr:[addresslistModel.addresslist objectAtIndex:indexPath.row]];
    [addresslistModel.addresslist removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isCar&&!tableList.editing) {
        
        AddressAddresslist* addressItem = (AddressAddresslist*)[addresslistModel.addresslist objectAtIndex:indexPath.row];
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        AddressCell *tempCell = (AddressCell *)[tableView cellForRowAtIndexPath:path];
        tempCell.imageCheck.hidden = NO;
        self.chectOutViewC.addressItem_ben = addressItem;
        //lee999recode
        self.chectOutViewC.straddressID = addressItem.addresslistIdentifier;
        //end
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        if (tableList.editing) {
            AddAddressViewController *tempEditAddress = [[AddAddressViewController alloc] initWithNibName:@"AddAddressViewController" bundle:nil];
            tempEditAddress.addOrEdit = NO;
            tempEditAddress.isFromcheck = self.isCar;
            tempEditAddress.addressList = [addresslistModel.addresslist objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:tempEditAddress animated:YES];
        }
 
    }
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
