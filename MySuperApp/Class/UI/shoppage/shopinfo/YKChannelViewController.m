//
//  YKChannelViewController.m
//  YKProduct
//
//  Created by k ye on 11-12-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "YKChannelViewController.h"
//#import "HotViewController.h"
#import "UIColorAdditions.h"
#import "ProductlistViewController.h"

#import "MyAimerViewController.h"
#import "MyAimerLoginViewController.h"

@implementation YKChannelViewController
@synthesize dic_sub;
@synthesize ThisChannelID;
@synthesize isSub;
@synthesize title_Name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.title = self.title_Name;
    
    [self createBackBtnWithType:0];
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;

     tableview_channel=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height-50) style:UITableViewStylePlain];
    
    //leerecode
    
    int tableH = self.view.frame.size.height;
    
    NSLog(@"tableH-----%d",tableH);
    
    //lee999recode
//    if (tableH < 500) {
//        [tableview_channel setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-100)];
//    }
    if ([[[UIDevice currentDevice] systemVersion] intValue]<7) {
        [tableview_channel setFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height-0)];
    }
    //end
    
     tableview_channel.backgroundColor=[UIColor clearColor];
     tableview_channel.showsVerticalScrollIndicator=NO;
     tableview_channel.delegate=self;
     tableview_channel.dataSource=self;
     tableview_channel.separatorStyle=UITableViewCellSeparatorStyleNone;
     [self.view addSubview:tableview_channel];
    
    
    [self NewHiddenTableBarwithAnimated:YES];
    
    
    //创建右边按钮
//    [self createRightBtn];
//    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_mine.png"] forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"" forState:UIControlStateNormal];
//    [self.navbtnRight setTitle:@"" forState:UIControlStateHighlighted];
//    [self.navbtnRight setBackgroundImage:[UIImage imageNamed:@"nav_icon_mine_press.png"] forState:UIControlStateHighlighted];
//    [self.navbtnRight setFrame:CGRectMake(0, 10, 25, 25)];
//    [self.navbtnRight addTarget:self action:@selector(gotoUserCenter) forControlEvents:UIControlEventTouchUpInside];
    
     if (isSub) {
          [tableview_channel reloadData];
     }else{
         [mainSev getChannelcate:self.ThisChannelID];
     }
}

//到用户中心  todo
-(void)gotoUserCenter{
    //切换到我的爱慕 来源于竖屏的商场~~
    [SingletonState sharedStateInstance].myaimerIsFrom = 2;
    [self changeToMyaimer];
}

-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:YES];
}


#pragma mark tableviewdelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return lee1fitAllScreen(48)+8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return [cannelCategiresModel.categoriesPictext count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return lee1fitAllScreen(208.00);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *identifier=@"identifier";
    
    
    NSInteger row = [indexPath row];
    
     UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    //lee999recode
//     if (cell==nil) {
          cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//     }
     for (UIView *view in cell.contentView.subviews) {
          [view removeFromSuperview];
     }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CannelCategoriesPictext *ca = [cannelCategiresModel.categoriesPictext objectAtIndex:row];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(23, 15, lee1fitAllScreen(300), 20)];
     label.textAlignment=UITextAlignmentLeft;
     label.font=[UIFont systemFontOfSize:14];
     label.textColor=[UIColor colorWithHexString:@"#4c4c4c"];
     label.backgroundColor=[UIColor clearColor];
     label.text=[ca title];
    
     UIImageView *imageview_arrow=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]];
     imageview_arrow.frame=CGRectMake(lee1fitAllScreen(290), 19, 7, 11);
    
     UIImageView *image_normal=[[UIImageView alloc]init];//WithImage:[UIImage imageNamed:@"list_one.png"]
    //lee给view设置为圆角，不再使用图片了。 -140512
    image_normal.frame= CGRectMake(10, 5, lee1fitAllScreen(300), cell.frame.size.height-4);
    [SingletonState setViewRadioSider:image_normal];
    
    [cell addSubview:image_normal];
     [cell addSubview:label];
    [cell addSubview:imageview_arrow];
    
     UILabel *label_selected=[[UILabel alloc]initWithFrame:CGRectMake(23, 13, lee1fitAllScreen(300), 20)];
     label_selected.textAlignment=UITextAlignmentLeft;
     label_selected.font=[UIFont systemFontOfSize:14];
     label_selected.textColor=[UIColor colorWithHexString:@"#ffffff"];
     label_selected.backgroundColor=[UIColor clearColor];
     label_selected.text=[ca title];
    
     return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view_header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, lee1fitAllScreen(208))];
    UrlImageView* imageView_back = [[UrlImageView alloc]init];
    CannelChannel *cannel = cannelModel.channel;
    [imageView_back setImageWithURL:[NSURL URLWithString:[cannel pic]] placeholderImage:nil];

    imageView_back.frame=CGRectMake(0, 0, ScreenWidth, lee1fitAllScreen(208));
    
    [view_header addSubview:imageView_back];
    view_header.backgroundColor=[UIColor clearColor];
    return view_header;
}



-(void)setIsSub:(BOOL)_isSub{
     isSub=_isSub;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     CannelCategoriesPictext *item=[cannelCategiresModel.categoriesPictext objectAtIndex:[indexPath row]];

     if ([item subCategories]&&![item isleafnode]) {
          channelview=[[YKChannelViewController alloc]init];
          channelview.title_Name= [item title];
          [channelview setIsSub:YES];
          channelview.dic_sub=[NSDictionary dictionaryWithObjectsAndKeys:[item subCategories], @"sub_categories", nil];
          [self.navigationController pushViewController:channelview animated:YES];
          
     }else{

         ProductlistViewController *productlist=[[ProductlistViewController alloc]init];
         [SingletonState sharedStateInstance].productlistType = 1;
         productlist.params = item.categoriesPictextIdentifier;
         productlist.titleName= [item title];
         productlist.isHiddenFilerbtn = YES;
         [self.navigationController pushViewController:productlist animated:YES];
     }
    UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
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
        case Http_Channelcate_Tag:
        {
            if (!model.errorMessage) {
                cannelModel = (CannelCannelHomeModel *)model;
                CannelChannel *cannel = [cannelModel channel];
                cannelCategiresModel = (CannelCategires *)[cannel categires];
                
                [tableview_channel reloadData];
            }else {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
        default:
            break;
    }
}

@end
