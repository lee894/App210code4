//
//  NewSortViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/15.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewSortViewController.h"
#import "MYMacro.h"
#import "MyButton.h"
#import <QuartzCore/QuartzCore.h>
#import "ProductlistViewController.h"


@interface NewSortViewController ()
{
    
    MainpageServ *mainSev;
    NewSortInfo *_sortinfo;
    
    UITableView *myTableV;
}
@end

@implementation NewSortViewController

- (id)init{
    self = [super init];
    if (self)
        self.title = @"分类";
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"商品分类"];
    
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [mainSev getSort20data];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

    [self creatTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self NewSHowTableBarwithAnimated:YES];
    
    [DplusMobClick track:@"分类"];

}

//创建表格
-(void)creatTableView{
    
    myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- 113)
                                            style:UITableViewStylePlain];
    myTableV.delegate = self;
    myTableV.dataSource = self;
    [self.view addSubview:myTableV];
    [myTableV setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];

    
    //添加下拉刷新
    [myTableV addHeaderWithTarget:self action:@selector(headerRereshing)];
}

-(void)headerRereshing{
    [mainSev getSort20data];
}




#pragma mark-- service
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    [myTableV headerEndRefreshing];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    
    [myTableV headerEndRefreshing];
    
    _sortinfo = [[NewSortParser alloc] parseNewHomeInfo:amodel];
    
    [myTableV reloadData];
    
    [SBPublicAlert hideMBprogressHUD:self.view];

}




#pragma mark-- tableView

// Section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

// row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Section的 head高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    [bgv setBackgroundColor:[UIColor colorWithHexString:@"f4f4f4"]];

    UIImage*img = [UIImage imageNamed:@"list_title_to.jpg"];
    UIImageView*imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, img.size.width, img.size.height)];
    [imageV setImage:img];
    [bgv addSubview:imageV];
    
    
    UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(15 + 10, 8, 200, 20)];
    [namelab setNumberOfLines:1];
    [namelab setTextAlignment:NSTextAlignmentLeft];
    namelab.font = [UIFont systemFontOfSize:LabMidSize];
    [namelab setTextColor:[UIColor colorWithHexString:@"#8e8e8e"]];
    [bgv addSubview:namelab];
    
    switch (section) {
        case 0:
            namelab.text = @"女士";
            break;
            
        case 1:
            namelab.text = @"男士";
            break;
            
        case 2:
            namelab.text = @"女童";
            break;
            
        case 3:
            namelab.text = @"男童";
            break;
            
        default:
            break;
    }
    
    
    return bgv;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

// row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch ([indexPath section ]) {
        case 0:
            return ((ScreenWidth/4) * 1.25)* ([_sortinfo.woman count]%4 == 0? [_sortinfo.woman count]/4 :[_sortinfo.woman count]/4+1);
            break;
            
        case 1:
            return ((ScreenWidth/4) * 1.25)* ([_sortinfo.man count]%4 == 0? [_sortinfo.woman count]/4 :[_sortinfo.woman count]/4+1);
            break;
            
        case 2:
            return ((ScreenWidth/4) * 1.25) * ([_sortinfo.girl count]%4 == 0? [_sortinfo.woman count]/4 :[_sortinfo.woman count]/4+1);
            break;
            
        case 3:
            return ((ScreenWidth/4) * 1.25)* ([_sortinfo.boy count]%4 == 0? [_sortinfo.woman count]/4 :[_sortinfo.woman count]/4+1);
            break;
            
        default:
        {
            return 0;
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:showUserInfoCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    switch ([indexPath section]) {
        case 0:
        {
        //女士
            [cell addSubview:[self createCellView:_sortinfo.woman]];
        
        }
            break;
            
        case 1:
        {
            //男士
            [cell addSubview:[self createCellView:_sortinfo.man]];

        }
            break;
            
        case 2:
        {
            //女孩
            [cell addSubview:[self createCellView:_sortinfo.girl]];
            
        }
            break;
            
        case 3:
        {
            //男孩
            [cell addSubview:[self createCellView:_sortinfo.boy]];
  
        }
            break;
    
        default:
            break;
    }
    
    // Configure the cell.
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

-(UIView *)createCellView:(NSArray*)subSortArray{
    
    //行数
    NSInteger subSortbtnNum = ([subSortArray count]%4 == 0? [subSortArray count]/4 :[subSortArray count]/4+1);
    
    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, subSortbtnNum*100)];
    [bgv setBackgroundColor:[UIColor clearColor]];
    

    for (int i = 0; i<subSortbtnNum; i++) {
        
        NSInteger jcount = ([subSortArray count]-4*i)>4?4:([subSortArray count]-4*i);
        
        for (int j = 0; j<jcount; j++) {
            //80  100
            UIView *sortV = [[UIView alloc] initWithFrame:CGRectMake(j*(ScreenWidth/4), i*(ScreenWidth/4 * 1.25), ScreenWidth/4, (ScreenWidth/4) * 1.25)];
            sortV.layer.borderWidth = 0.5;
            sortV.layer.borderColor = [[UIColor colorWithHexString:@"e2e2e2"] CGColor];
            sortV.tag = j + i*4;
            
            
            int index = j + i*4;
            NewSortData *item = (NewSortData*)[subSortArray objectAtIndex:index isArray:nil];

            UrlImageView *buynowV = [[UrlImageView alloc] initWithFrame:CGRectMake(15,15,(ScreenWidth/4)-30, (ScreenWidth/4)-30)];
            [buynowV setImageFromUrl:NO withUrl:item.pic];
            [sortV addSubview:buynowV];
            
            UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + (ScreenWidth/4)-30 + 4, (ScreenWidth/4), 20)];
            [namelab setNumberOfLines:1];
            [namelab setTextAlignment:NSTextAlignmentCenter];
            namelab.text = item.alias;
            namelab.font = [UIFont systemFontOfSize:LabSmallSize];
            [namelab setTextColor:[UIColor colorWithHexString:@"#444444"]];
            [sortV addSubview:namelab];
            
            [bgv addSubview:sortV];

            
            MyButton *sortbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [sortbtn setFrame:CGRectMake(j*(80), i*(100), 80, 100)];
            [sortbtn addTarget:self action:@selector(subSortBtnclick:) forControlEvents:UIControlEventTouchUpInside];
            sortbtn.addstring = item.params;
            sortbtn.addtitle = item.alias;
            [bgv addSubview:sortbtn];
        }
    }
    return bgv;
}

-(void)subSortBtnclick:(id)sender{

    MyButton *btn = (MyButton*)sender;
    
    ProductlistViewController *hotVC = [[ProductlistViewController alloc] initWithNibName:@"ProductlistViewController" bundle:nil];
    hotVC.titleName = btn.addtitle;
    [SingletonState sharedStateInstance].productlistType = 3;
    hotVC.isShop = YES;
    hotVC.params = btn.addstring;
    hotVC.isSearch = YES;
    [self.navigationController pushViewController:hotVC animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
