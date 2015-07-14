//
//  SearchpageViewController.m
//  aimerOnline
//
//  Created by lee on 14-3-3.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "SearchpageViewController.h"
#import "SearchCell.h"
#import "ProductlistViewController.h"

@interface SearchpageViewController ()
{
    BOOL isSerch;
    BOOL ishot;
    
    __weak IBOutlet UIButton *hotSearchbtn;
    __weak IBOutlet UIButton *recentlySearchBtn;
    
}
@end

@implementation SearchpageViewController

- (NSString *)tabImageName
{
	return @"tab02_icon_search";
}
- (NSString *)tabTitle
{
	return @"搜索";
}

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
    self.title = @"搜索";
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    [self createBackBtnWithType:0];
    
    
//    if (isIOS7up) {
//        [myallView setFrame:CGRectMake(0, 60, 320, self.view.frame.size.height-60)];
//        [tableViewConetnt setFrame:CGRectMake(0, -25, 320, self.view.frame.size.height-30)];
//    }
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    
    UIImageView *searchBgImag = [[UIImageView alloc] initWithFrame:CGRectMake(45, 8, 225, 33)];
    [searchBgImag setImage:[UIImage imageNamed:@"search_bg"]];
    searchBgImag.userInteractionEnabled = YES ;
    UIImageView *bgIM = [[UIImageView alloc] initWithFrame:CGRectMake(6, 9 , 15, 15)];
    [bgIM setImage:[UIImage imageNamed:@"search_bg_icon"]];
    [searchBgImag addSubview:bgIM];

    serchField = [[UITextField alloc] initWithFrame:CGRectMake(20, 6 , 210, 22)];
    serchField.placeholder = @"请输入宝贝关键词";
    serchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    serchField.returnKeyType = UIReturnKeySearch;
    serchField.delegate = self;
    [searchBgImag addSubview:serchField];
    self.navigationItem.titleView = searchBgImag;

    //创建右边按钮
    [self createRightBtn];
    [self.navbtnRight setTitle:@"搜索" forState:UIControlStateNormal];
    [self.navbtnRight setTitle:@"搜索" forState:UIControlStateHighlighted];
    [self.navbtnRight setFrame:CGRectMake(262, 7, 46, 32)];
    
    //第一次进来  加载数据
    UIButton *tmpBut = (UIButton *)[viewBut viewWithTag:100];
    [self seacheHotAndZuijingButActionChicked:tmpBut];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

}


- (void)rightButAction {
    [serchField resignFirstResponder];
    if (serchField.text.length > 0) {
        [self writeToFileDoument:serchField.text];
        isSerch  = YES;
        [self sendRequest];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    isSerch = NO;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1004", @"PageID",nil];
    [TalkingData trackEvent:@"4" label:@"商品搜索" parameters:dic];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1004", @"PageID",nil];
    [TalkingData trackEvent:@"5" label:@"商品搜索" parameters:dic];
    
}

- (NSString *)DoumentPath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:@"search.plist"];
}

//把最近搜索的数据写入本地
- (void)writeToFileDoument:(NSString *)serchStr {
    NSMutableArray *arr = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self DoumentPath]]) {
        arr = [NSMutableArray arrayWithContentsOfFile:[self DoumentPath]];
    }else {
        arr = [[NSMutableArray alloc] init];
    }
    if (arr.count >= 11) {
        [arr insertObject:serchStr atIndex:0];
        [arr removeObjectAtIndex:11];
    }else {
        if (![arr containsObject:serchStr]) {
            [arr insertObject:serchStr atIndex:0];
        }
    }
    [arr writeToFile:[self DoumentPath] atomically:YES];
}

//热门搜索的两个按钮事件 根据tag 100 和 101
- (IBAction)seacheHotAndZuijingButActionChicked:(UIButton *)sender  {
    
    isSerch = NO;
    
    [serchField resignFirstResponder];
    
    rightJianImage.hidden = YES;
    leftJianImage.hidden = YES;
    
    UIButton *tempButhot = (UIButton *)[viewBut viewWithTag:100];
    UIButton *tempBut = (UIButton *)[viewBut viewWithTag:101];
    tempButhot.selected = NO;
    tempBut.selected = NO;
    
    UIImage *butImage = nil;
    UIImage *butImageH = nil;
    switch (sender.tag) {
        case 100: //热门搜索
        {
            ishot = YES;
            [self sendRequest];
            
            butImage = [UIImage imageNamed:@"search_icon_refresh.png"];
            butImageH = [UIImage imageNamed:@"search_icon_refresh_press.png"];
            rightJianImage.hidden = NO;
            
            tempButhot.selected = YES;
            
            [DplusMobClick track:@"首页/搜索" property:@{@"搜索方式":@"热门搜索"}];

        }
            break;
        case 101: //最近搜索
        {
            ishot = NO;
            
            arrSearch = [NSArray arrayWithContentsOfFile:[self DoumentPath]];
            
            butImage = [UIImage imageNamed:@"search_icon_delete.png"];
            butImageH = [UIImage imageNamed:@"search_icon_delete_press.png"];
            leftJianImage.hidden = NO;
            tempBut.selected = YES;
            [tableViewConetnt reloadData];
            
            [DplusMobClick track:@"首页/搜索" property:@{@"搜索方式":@"最近搜索"}];

        }
            break;
        default:
            break;
    }
    [refreshBut setImage:butImage forState:UIControlStateNormal];
    [refreshBut setImage:butImageH forState:UIControlStateHighlighted];
}

- (void)sendRequest {
    
    if (isSerch) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:serchField.text, @"Keywords",@"userSearch", @"SearchType",nil];        
        [TalkingData trackEvent:@"1004" label:@"商品搜索" parameters:dic];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"search" forKey:@"From"];
        ProductlistViewController *hotVC = [[ProductlistViewController alloc] init];
        [SingletonState sharedStateInstance].productlistType = 4;
        hotVC.key = serchField.text;
        hotVC.isSearch = YES;
        hotVC.isHiddenFilerbtn = NO;
        hotVC.isFromSearchPage = YES;
        [self.navigationController pushViewController:hotVC animated:YES];
        
        
        
    }else {
        [mainSev getSearch];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    }
}

//刷新按钮事件
- (IBAction)refreshButtonActionChicked:(id)sender {
    if (ishot) { //热门列表的刷新
        isSerch = NO;
        [self sendRequest];
        
        [DplusMobClick track:@"搜索页面/刷新按钮"];

    }else { //最近列表的刷新
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:[self DoumentPath] error:nil];
        arrSearch = nil;
        [tableViewConetnt reloadData];
        
        [DplusMobClick track:@"搜索页面/清空按钮"];

    }
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
        case Http_Search_Tag:
        {
            searchModel = (SearchSearchHotModel *)model;
            arrSearch = [(SearchSearchHotModel *)model keyword];
            [tableViewConetnt reloadData];
            
        }
            break;
        default:
            break;
    }
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    
}


- (void)popBackAnimate:(UIButton *)sender{
    
    [serchField resignFirstResponder];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (serchField.text.length > 0) {
        [self writeToFileDoument:serchField.text];
        isSerch  = YES;
        [self sendRequest];
    }
    [serchField resignFirstResponder];
    
    
    return YES;
}


#pragma mark ===TableViewDeledage

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (ishot) {
        NSArray *keyArr = [[[arrSearch objectAtIndex:0] dic] allKeys];
        
        return keyArr.count;
    }else {
        return arrSearch.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    
    static NSString *CellIdentifier=@"MyCostomsCell";
    
    SearchCell *cell=[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:nil options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (ishot) {
        if(row < 3) {
            [cell.iconImageView setImage:[UIImage imageNamed:@"number_bg_red.png"]];
            [cell.iconLabel setTextColor:[UIColor colorWithHexString:@"#c8002e"]];
        }else {
            [cell.iconImageView setImage:[UIImage imageNamed:@"number_bg_black.png"]];
            [cell.iconLabel setTextColor:[UIColor blackColor]];
        }
        
        cell.iconLabel.text = [NSString stringWithFormat:@"%d",row+1];
        
        cell.contentLable.text = [[(SearchKeyword *)[arrSearch objectAtIndex:0] dic] objectForKey:cell.iconLabel.text];
    }else {
        
        [cell.iconImageView setImage:[UIImage imageNamed:@"icon_history.png"]];
        [cell.iconLabel setTextColor:[UIColor blackColor]];
        
        cell.iconLabel.text = nil;
        
        cell.contentLable.text = [arrSearch objectAtIndex:row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SearchCell *cell = (SearchCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:cell.contentLable.text, @"Keywords",@"Search", @"SearchType",nil];
    [TalkingData trackEvent:@"1004" label:@"商品搜索" parameters:dic];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"search" forKey:@"From"];
    
    ProductlistViewController *hotVC = [[ProductlistViewController alloc] init];
    [SingletonState sharedStateInstance].productlistType = 4;
    hotVC.key = cell.contentLable.text;
    hotVC.isSearch = YES;
    hotVC.isHiddenFilerbtn = NO;
    hotVC.isFromSearchPage = YES;
    [self.navigationController pushViewController:hotVC animated:YES];
    
    if (ishot) {
        [DplusMobClick track:@"热门搜索点击" property:@{@"标签名称":cell.contentLable.text}];
    }else{
        [DplusMobClick track:@"最近搜索" property:@{@"标签名称":cell.contentLable.text}];
    }


}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [serchField resignFirstResponder];
    
}

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
//- (NSUInteger)supportedInterfaceOrientations
//{
//	return UIInterfaceOrientationMaskPortrait;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//	return UIInterfaceOrientationPortrait;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
