//
//  YKPayMethod.m
//  YKProduct
//
//  Created by user on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YKPayMethod.h"

@interface YKPayMethod ()

- (void)backToPrev:(id)sender;

@end

@implementation YKPayMethod

@synthesize m_StrSelectIndex;
@synthesize m_sourcePage;
@synthesize m_payMethod;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)initPayMethod:(NSMutableArray*)data
{
    self.m_payMethod = [[NSMutableArray alloc] initWithCapacity:2];
    
    //支付方式
    for (NSDictionary * aD in data) {
        NSDictionary * a = [[NSDictionary alloc] initWithDictionary:aD];
        [self.m_payMethod addObject:a];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"支付方式";
    [self createBackBtnWithType:0];

    
    m_UISelectTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20) style:UITableViewStyleGrouped];
    m_UISelectTable.delegate   = self;
    m_UISelectTable.dataSource = self;
    [m_UISelectTable setBackgroundColor:[UIColor clearColor]];
    m_UISelectTable.backgroundView = nil;
    [self.view addSubview:m_UISelectTable];
}

#pragma mark -
#pragma mark clickEvent

- (void)backToPrev:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 60)];
//    [headV setBackgroundColor:[UIColor colorWithHexString:@"faf8f5"]];
//    
//    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, ScreenWidth - 40, 40)];
//    [titleLab setNumberOfLines:2];
//    [titleLab setTextAlignment:NSTextAlignmentCenter];
//    titleLab.font = [UIFont systemFontOfSize:LabMidSize];
//    [titleLab setTextColor:[UIColor colorWithHexString:@"#7f735a"]];
//    [titleLab setText:@"选择拍照商品的类别，搜索更精准，请拍摄商品完整正面照"];
//    
//    [headV addSubview:titleLab];
//    
//    return headV;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSelectFreePostCard) {
        [SBPublicAlert showMBProgressHUD:@"您已选包邮卡，不能使用货到付款" andWhereView:self.view hiddenTime:AlertShowTime];
        return;
    }
    
    
    
    NSInteger nIndex = 0;
    for (NSDictionary * a in m_payMethod) {
        if (nIndex == [indexPath row]) {
            NSInteger  abc = [[a objectForKey:@"id"] intValue];
            NSString * selectIndex = [[NSString alloc] initWithFormat:@"%ld", (long)abc];
            
            
            if (abc == 4) {
                if (![WXApi isWXAppInstalled]) {
                    [LCommentAlertView showMessage:@"您还未安装微信，请换其他支付方式" target:nil];
                    return;
                }
            }
            
            
            m_sourcePage.selectIndex = nIndex;
            m_sourcePage.m_strPayMethod = selectIndex;
        }
        nIndex++;
    }
        
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    //返回上一级页面
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)
{
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_payMethod count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CustomCellIdentifier = @"payMethodTableView";
    UITableViewCell * tablecell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (tablecell) {
        
    } else {
        tablecell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
        [tablecell setAccessoryType:UITableViewCellAccessoryNone];
        tablecell.backgroundColor = [UIColor clearColor];
        //添加数据
        NSMutableString * strIndex;
        NSDictionary *a = [m_payMethod objectAtIndex:indexPath.row];
                strIndex = [[NSMutableString alloc] initWithFormat:@"%@", [a objectForKey:@"id"]];
//                tablecell.textLabel.text = [a objectForKey:@"desc"];
                tablecell.selectionStyle = UITableViewCellSelectionStyleNone;
                [tablecell setAccessoryType:UITableViewCellAccessoryNone];
                //勾选
                if (self.m_pay_id != nil) {
                    if ([self.m_pay_id isEqualToString:strIndex]) {
                        [tablecell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    }
            }
        UIImage *img = [UIImage imageNamed:@"zf_cxk_.png"];
        UIImageView* imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, img.size.width, img.size.height)];
        [tablecell addSubview:imageV];
        
        UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 17, 200, 30)];
        [nameLab setText:[a objectForKey:@"desc"]];
        [tablecell addSubview:nameLab];
    
        switch ([strIndex intValue]) {
            case 0:
            {
                //货到付款
                [imageV setImage:[UIImage imageNamed:@"zf_hdfk_.png"]];
            }
                break;
                
            case 1:
            {
                //支付宝
                [imageV setImage:[UIImage imageNamed:@"zf_zfb_.png"]];
            }
                break;
                
            case 2:
            {
                //[imageV setImage:[UIImage imageNamed:@"zf_zfb_.png"]];
            }
                break;
                
            case 3:
            {
                //银联支付
                [imageV setImage:[UIImage imageNamed:@"zf_cxk_.png"]];
            }
                break;
                
            case 4:
            {
                //微信
                [imageV setImage:[UIImage imageNamed:@"zf_wx_.png"]];
            }
                break;
                
            default:
                break;
        }
    }
    
    return tablecell;
}

@end
