//
//  MyFavAll20ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/21.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyFavAll20ViewController.h"
#import "MyFavViewController.h"
#import "FavStoreViewController.h"
#import "FavMaginzeViewController.h"


@interface MyFavAll20ViewController ()
{
    UITableView *myTableV;
}
@end

@implementation MyFavAll20ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"我的收藏"];
    
    [self createBackBtnWithType:0];
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    [self creatTableView];
    
}


//创建表格
-(void)creatTableView{
    
    myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)
                                            style:UITableViewStylePlain];
    myTableV.delegate = self;
    myTableV.dataSource = self;
    [self.view addSubview:myTableV];
    [myTableV setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
    
}



#pragma mark-- tableView

// row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    UIView *spV = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, ScreenWidth, 0.5)];
    [spV setBackgroundColor:[UIColor colorWithHexString:@"#d0d0d0"]];
    [cell addSubview:spV];
    
    switch ([indexPath row]) {
        case 0:
        {
            UIView *spV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
            [spV setBackgroundColor:[UIColor colorWithHexString:@"#d0d0d0"]];
            [cell addSubview:spV];
            
            cell.textLabel.text = @"我收藏的商品";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"我收藏的专辑";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"我收藏的门店";
        }
            break;
        default:
            break;
    }
    [cell.textLabel setTextColor:[UIColor colorWithHexString:@"#444444"]];
    
    // Configure the cell.
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    switch ([indexPath row]) {
        case 0:
        {
            //@"我收藏的商品"
            //我的收藏
            NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"UserName",nil];
            [TalkingData trackEvent:@"5010" label:@"收藏" parameters:dic1];
            
            MyFavViewController *tempCollect = [[MyFavViewController alloc] initWithNibName:@"MyFavViewController" bundle:nil];
            [self.navigationController pushViewController:tempCollect animated:YES];
            
            
        }
            break;
        case 1:
        {
            //@"我收藏的专辑"
            
            FavMaginzeViewController *tempCollect = [[FavMaginzeViewController alloc] init];
            [self.navigationController pushViewController:tempCollect animated:YES];
        }
            break;
        case 2:
        {
            //@"我收藏的店铺"
            
            
            FavStoreViewController *tempCollect = [[FavStoreViewController alloc] init];
            [self.navigationController pushViewController:tempCollect animated:YES];
            
        }
            break;
        default:
            break;
    }

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
