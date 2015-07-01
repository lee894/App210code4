//
//  NewFilter20ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/20.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewFilter20ViewController.h"
#import "ProductlistViewController.h"
#import "BrandsItems.h"
#import "MyButton.h"

#define filterCellNum 3 //每行数量
#define filterSelectCellNum 4 //每行数量

#define filterSp 10 //间隔 上线下左右都保持10

#define filterbtnH  35  //按钮高度

#define filterSelectbtnH  30  //按钮高度

#define filterlittleSurebtnH   60  //每个子项的确认重置，按钮的高度

#define UnopenCellHight  60   //默认未展开时候的表格高度


@interface NewFilter20ViewController ()
{

    UITableView *myTableV;
    
    
    int totalSelectHeight ;// select过的总高度
    
//    UIView *headerSelectV;  //头部按钮群  已选中的标签

    NSMutableDictionary *filterdatadic;  //已选中的信息 存储到字典里面  key 是type  v是value
    
    NSMutableDictionary *namedatadic;  //选中的名称   存储到字典里面  key 是type  v是中文名称

    NSMutableArray *selectDataArr;  //这个仅用于存储选中过的 key  以便于跟上面两个对应上
    
    //NSMutableArray *allSelectDataArr;  //所有选中的数据
}
@end

@implementation NewFilter20ViewController
@synthesize arrfilter;
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"筛选"];
    

    [self createBackBtnWithType:0];
    [self creatTableView];
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    totalSelectHeight = 0;

    filterdatadic = [[NSMutableDictionary alloc] initWithCapacity:0];
    selectDataArr = [[NSMutableArray alloc] initWithCapacity:0];
    namedatadic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if (self.arrSelectfilter && [self.arrSelectfilter respondsToSelector:@selector(objectAtIndex:)] && [self.arrSelectfilter count]> 0) {
        
        for (int i = 0; i<[self.arrSelectfilter count]; i++) {
            id dic = [self.arrSelectfilter objectAtIndex:i isArray:nil];
         
            if ([dic respondsToSelector:@selector(objectForKey:)]) {
                //NSString *name = [dic objectForKey:@"name" isDictionary:nil];  //分类的名称
                NSString *type = [dic objectForKey:@"type" isDictionary:nil];
                NSString *namevalue = [dic objectForKey:@"namevalue" isDictionary:nil];
                NSString *value = [dic objectForKey:@"value" isDictionary:nil];

                [filterdatadic setObject:value forKey:type];
                [namedatadic setObject:namevalue forKey:type];
                [selectDataArr addObject:type];
            }
        }
    }
}

//创建表格
-(void)creatTableView{
    
    int btnHight = 80;

    myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- 50 - btnHight)
                                            style:UITableViewStylePlain];
    myTableV.delegate = self;
    myTableV.dataSource = self;
    [self.view addSubview:myTableV];
    [myTableV setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
    
    
    //底部按钮  防止重置  和  确认按钮
    UIView *footV = [[UIView alloc] initWithFrame:CGRectMake(0, myTableV.frame.size.height, ScreenWidth, btnHight)];
    [footV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:footV];
    
    UIImage *imagv = [UIImage imageNamed:@"del_c_btn_normal.png"];
    
    
    MyButton *resetbtn = [MyButton buttonWithType:UIButtonTypeCustom];
    [resetbtn setFrame:CGRectMake(55,7,imagv.size.width, imagv.size.height)];
    [resetbtn setBackgroundImage:[UIImage imageNamed:@"del_c_btn_normal.png"] forState:UIControlStateNormal];
    [resetbtn setBackgroundImage:[UIImage imageNamed:@"del_c_btn_hover.png"] forState:UIControlStateHighlighted];
    [resetbtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetbtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    resetbtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    resetbtn.titleLabel.font = [UIFont systemFontOfSize:LabBigSize];
    [resetbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    resetbtn.tag = 1110;
    [footV addSubview:resetbtn];
    
    
    MyButton *okbtn = [MyButton buttonWithType:UIButtonTypeCustom];
    [okbtn setFrame:CGRectMake( ScreenWidth - imagv.size.width - 55, 7 ,imagv.size.width, imagv.size.height)];
    [okbtn setBackgroundImage:[UIImage imageNamed:@"del_btn_normal.png"] forState:UIControlStateNormal];
    [okbtn setBackgroundImage:[UIImage imageNamed:@"del_btn_hover.png"] forState:UIControlStateHighlighted];
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    okbtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    okbtn.titleLabel.font = [UIFont systemFontOfSize:LabBigSize];
    [okbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    okbtn.tag = 1111;

    [footV addSubview:okbtn];
}

#pragma mark--- 选中的按钮区域
-(UIView *)createHeadV:(NSArray*)subSortArray
//---------V3
{
    
    //filterSelectbtnH  按钮高度
    //filterSp 按钮分割线
    
    UIFont *font = [UIFont systemFontOfSize:LablitileSmallSize];
    //CGSize titleSize = [@"123123" sizeWithFont:font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    int lineNum = 0; //列数
    int pointX = 0;  //x的位置
    int pointY = 0;  //y的位置
    
    
    NSMutableArray *marrkey = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *marrname = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (self.arrSelectfilter && [self.arrSelectfilter respondsToSelector:@selector(objectAtIndex:)] && [self.arrSelectfilter count]> 0) {
        
        for (int i = 0; i<[self.arrSelectfilter count]; i++) {
            id dic = [self.arrSelectfilter objectAtIndex:i isArray:nil];
            
            if ([dic respondsToSelector:@selector(objectForKey:)]) {
                NSString *type = [dic objectForKey:@"type" isDictionary:nil];
                NSString *namevalue = [dic objectForKey:@"namevalue" isDictionary:nil];
                
                [marrkey addObject:type];
                [marrname addObject:namevalue];
            }
        }
    }
    
    if ([marrkey count]> 0) {
        lineNum = 1;
    }
    
    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    [bgv setBackgroundColor:[UIColor clearColor]];
    
    for (int i= 0; i<[marrkey count]; i++) {
        
        
        NSString *key = [marrkey objectAtIndex:i isArray:nil];
        NSString *name = [marrname objectAtIndex:i isArray:nil];
        
        
        NSString *str = [NSString stringWithFormat:@" %@  x ",name];
        
        
//        int tempLabW = [str sizeWithFont:font].width;
//        if (tempLabW > 110) {
//            tempLabW = 110;
//        }
        
        int tempLabW = (ScreenWidth-5*filterSp)/4;
        
        if (i == 0) {
            pointX = filterSp;
            pointY = filterSp;
        }else
        {
            //>0
//            if (pointX + tempLabW + filterSp <ScreenWidth) {
            //修改ip6p 上不能显示全部的bug
            if (pointX + tempLabW <ScreenWidth) {

                //如果当前的X 加上 当前的宽度 < 300的时候，不分行
                
                //pointX = pointX;
                //pointY = filterSp;
                
            }else{
                //如果当前的X 加上 当前的宽度 > 300的时候，换一行
                pointX = filterSp;
                pointY = filterSp + (lineNum)*(filterSelectbtnH + filterSp);
                lineNum ++;
            }
        }
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(pointX, pointY, tempLabW, 30)];
        lab.lineBreakMode = UILineBreakModeMiddleTruncation;
        [lab setBackgroundColor:[UIColor colorWithHexString:@"F3F1F1"]];
        [lab setTextColor:[UIColor colorWithHexString:@"c8002c"]];
        lab.layer.borderColor = [UIColor colorWithHexString:@"888888"].CGColor;
        lab.layer.masksToBounds = YES;
        [lab setTextAlignment:NSTextAlignmentCenter];
        lab.font = font;
        lab.text = str;
        lab.tag = i;
        [bgv addSubview:lab];
        
        MyButton* bgv2 = [MyButton buttonWithType:UIButtonTypeCustom];
        [bgv2 setFrame:CGRectMake(pointX, pointY, tempLabW, 30)];
        [bgv2 setBackgroundColor:[UIColor clearColor]];
        bgv2.btntype = key;
        [bgv2 addTarget:self action:@selector(removeSelectCararyAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgv addSubview:bgv2];
        
        
        totalSelectHeight = pointY + 40;
        
        [bgv setFrame:CGRectMake(0, 0, ScreenWidth,totalSelectHeight)];
        [bgv setBackgroundColor:[UIColor clearColor]];
        
        //延长当前的X
        pointX = pointX + filterSp + tempLabW;
    }
    
    
    
    //    int H = filterSp + (30 +filterSp)* lineNum;
    //    [bgv setFrame:CGRectMake(0, 0, ScreenWidth, H)];
    
    
    return bgv;
    
}
//---------V2
//{
//    
//    //filterSelectbtnH  按钮高度
//    //filterSp 按钮分割线
//    
//    UIFont *font = [UIFont systemFontOfSize:LablitileSmallSize];
//    //CGSize titleSize = [@"123123" sizeWithFont:font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
//    
//    int lineNum = 0; //列数
//    int pointX = 0;  //x的位置
//    int pointY = 0;  //y的位置
//    
//    
//    NSMutableArray *marrkey = [[NSMutableArray alloc] initWithCapacity:0];
//    NSMutableArray *marrname = [[NSMutableArray alloc] initWithCapacity:0];
//
//    if (self.arrSelectfilter && [self.arrSelectfilter respondsToSelector:@selector(objectAtIndex:)] && [self.arrSelectfilter count]> 0) {
//        
//        for (int i = 0; i<[self.arrSelectfilter count]; i++) {
//            id dic = [self.arrSelectfilter objectAtIndex:i isArray:nil];
//            
//            if ([dic respondsToSelector:@selector(objectForKey:)]) {
//                NSString *type = [dic objectForKey:@"type" isDictionary:nil];
//                NSString *namevalue = [dic objectForKey:@"namevalue" isDictionary:nil];
//                
//                [marrkey addObject:type];
//                [marrname addObject:namevalue];
//            }
//        }
//    }
//    
//    if ([marrkey count]> 0) {
//        lineNum = 1;
//    }
//    
//    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//    [bgv setBackgroundColor:[UIColor clearColor]];
//    
//    for (int i= 0; i<[marrkey count]; i++) {
//        
//        
//        NSString *key = [marrkey objectAtIndex:i isArray:nil];
//        NSString *name = [marrname objectAtIndex:i isArray:nil];
//        
//        
//        NSString *str = [NSString stringWithFormat:@" %@  x ",name];
//        
//        
//        int tempLabW = [str sizeWithFont:font].width;
//                if (tempLabW > 110) {
//                    tempLabW = 110;
//                }
//        
//        
////        int tempLabW = (ScreenWidth -5*filterSp)/4;//[str sizeWithFont:font].width;
//        
//
//        
//        
//        if (i == 0) {
//            pointX = filterSp;
//            pointY = filterSp;
//        }else
//        {
//            //>0
//            if (pointX + tempLabW + filterSp <ScreenWidth - 2*filterSp) {
//                //如果当前的X 加上 当前的宽度 < 300的时候，不分行
//                
//                //pointX = pointX;
//                //pointY = filterSp;
//                
//            }else{
//                //如果当前的X 加上 当前的宽度 > 300的时候，换一行
//                pointX = filterSp;
//                pointY = filterSp + (lineNum)*(filterSelectbtnH + filterSp);
//                lineNum ++;
//            }
//        }
//        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(pointX, pointY, tempLabW, 30)];
//        lab.lineBreakMode = UILineBreakModeMiddleTruncation;
//        [lab setBackgroundColor:[UIColor colorWithHexString:@"F3F1F1"]];
//        [lab setTextColor:[UIColor colorWithHexString:@"c8002c"]];
//        lab.layer.borderColor = [UIColor colorWithHexString:@"888888"].CGColor;
//        lab.layer.masksToBounds = YES;
//        lab.font = font;
//        lab.text = str;
//        lab.tag = i;
//        [bgv addSubview:lab];
//        
//        MyButton* bgv2 = [MyButton buttonWithType:UIButtonTypeCustom];
//        [bgv2 setFrame:CGRectMake(pointX, pointY, tempLabW, 30)];
//        [bgv2 setBackgroundColor:[UIColor clearColor]];
//        bgv2.btntype = key;
//        [bgv2 addTarget:self action:@selector(removeSelectCararyAction:) forControlEvents:UIControlEventTouchUpInside];
//        [bgv addSubview:bgv2];
//        
//        
//        totalSelectHeight = pointY + 40;
//        
//        [bgv setFrame:CGRectMake(0, 0, ScreenWidth,totalSelectHeight)];
//        [bgv setBackgroundColor:[UIColor clearColor]];
//        
//        //延长当前的X
//        pointX = pointX + filterSp + tempLabW;
//    }
//    
//    
//    
////    int H = filterSp + (30 +filterSp)* lineNum;
////    [bgv setFrame:CGRectMake(0, 0, ScreenWidth, H)];
//    
//    
//    return bgv;
//    
//}
//---------V1
//{
//    
//    //filterSelectbtnH  按钮高度
//    //filterSp 按钮分割线
//    
//    UIFont *font = [UIFont systemFontOfSize:LablitileSmallSize];
//    //CGSize titleSize = [@"123123" sizeWithFont:font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
//    
//    int lineNum = 0; //列数
//    int pointX = 0;  //x的位置
//    int pointY = 0;  //y的位置
//
//    if ([subSortArray count]> 0) {
//        lineNum = 1;
//    }
//    
//    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//    [bgv setBackgroundColor:[UIColor clearColor]];
//    
//    for (int i= 0; i<[subSortArray count]; i++) {
//        
//        
//        NSString *key = [subSortArray objectAtIndex:i isArray:nil];
//        NSString *name = [namedatadic objectForKey:key isDictionary:nil];
//        
//        //test
//        //    subSortArray = [NSArray arrayWithObjects:@"啊SD卡还是简单会卡机",@"哈市的",@"阿卡刷卡机",@"卡说的框架啊好SD卡哈数据库的贺卡说的框架阿斯达",@"阿斯",@"阿斯达好卡哈萨克记得哈刷卡机兑换卡说的框架阿斯达",@"切吻合口寄回去我",@"哈哈",@"啊是等哈可接受的",@"卡号是",@"阿斯达好卡萨丁",@"啥都好卡", nil];
//        //NSString *name = [subSortArray objectAtIndex:i isArray:nil];
//        
//        
//        NSString *str = [NSString stringWithFormat:@" %@  x ",name];
//        
//        int tempLabW = [str sizeWithFont:font].width;
//        NSLog(@"---%d",tempLabW);
//        
//        if (tempLabW > 130) {
//            tempLabW = 120;
//        }
//        
//        
//        if (i == 0) {
//            pointX = filterSp;
//            pointY = filterSp;
//        }else
//        {
//            //>0
//            if (pointX + tempLabW + filterSp <ScreenWidth - 2*filterSp) {
//                //如果当前的X 加上 当前的宽度 < 300的时候，不分行
//                
//                //pointX = pointX;
//                //pointY = filterSp;
//
//            }else{
//                //如果当前的X 加上 当前的宽度 > 300的时候，换一行
//                pointX = filterSp;
//                pointY = filterSp + (lineNum)*(filterSelectbtnH + filterSp);
//                lineNum ++;
//            }
//        }
//        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(pointX, pointY, tempLabW, 30)];
//        lab.lineBreakMode = UILineBreakModeMiddleTruncation;
//        [lab setBackgroundColor:[UIColor colorWithHexString:@"F3F1F1"]];
//        [lab setTextColor:[UIColor colorWithHexString:@"c8002c"]];
//        lab.layer.borderColor = [UIColor colorWithHexString:@"888888"].CGColor;
//        lab.layer.masksToBounds = YES;
//        lab.font = font;
//        lab.text = str;
//        lab.tag = i;
//        [bgv addSubview:lab];
//        
//        MyButton* bgv2 = [MyButton buttonWithType:UIButtonTypeCustom];//[[UIButton alloc] initWithFrame:CGRectMake(pointX, pointY, tempLabW, 30)];
//        [bgv2 setFrame:CGRectMake(pointX, pointY, tempLabW, 30)];
//        [bgv2 setBackgroundColor:[UIColor clearColor]];
//        bgv2.btntype = key;
//        [bgv2 addTarget:self action:@selector(removeSelectCararyAction:) forControlEvents:UIControlEventTouchUpInside];
//        [bgv addSubview:bgv2];
//        
//        
//        totalHeight = pointY + 40;
//        
//        [bgv setFrame:CGRectMake(0, 0, ScreenWidth,totalHeight)];
//        
//        [bgv setBackgroundColor:[UIColor clearColor]];
//        
//        //延长当前的X
//        pointX = pointX + filterSp + tempLabW;
//    }
//    return bgv;
//}


-(void)removeSelectCararyAction:(MyButton*)btn{
    // 参数和属性之间用  ,   相同属性用 - 分割。  不同属性用  /  分割   c,123-321/b,123-122
//    NSString *strprama = [filterdatadic objectForKey:btn.btntype isDictionary:nil];
    NSString *strprama = @"";
    for (int i = 0; i<[self.arrSelectfilter count]; i++) {
        id dic = [self.arrSelectfilter objectAtIndex:i isArray:nil];
        
        if ([dic respondsToSelector:@selector(objectForKey:)]) {

            NSString *atype = [dic objectForKey:@"type" isDictionary:nil];
            if ([atype isEqualToString:btn.btntype]) {
                strprama = [dic objectForKey:@"params" isDictionary:nil];
            }
        }
    }
    
    self.params = [NSString stringWithFormat:@"%@",strprama];
    
    [filterdatadic removeObjectForKey:btn.btntype];
    [namedatadic removeObjectForKey:btn.btntype];

    
    BOOL isIn = NO;
    for (NSString *str in selectDataArr) {
        if ([str isEqualToString:btn.btntype]) {
            isIn = YES;
            break;
        }
    }
    if (isIn) {
        [selectDataArr removeObject:btn.btntype];
    }
    
    [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:self.key andPage:self.strcurrentpage andPer_page:self.strperpage];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

//    [self MakeSureAndRequestData];
}



#pragma mark -- net request delegate
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
        case Http_Productlist_Tag:
        {
            if (!model.errorMessage) {
                
                productListModel = (BrandsProductListModel *)model;
                [arrfilter removeAllObjects];
                arrfilter = [NSMutableArray arrayWithArray:productListModel.productlistFilter];
                [myTableV reloadData];
                
                if (productListModel.productlist_select_filter && [productListModel.productlist_select_filter respondsToSelector:@selector(objectAtIndex:)] && [productListModel.productlist_select_filter count]> 0) {
                    
                    
                    [self.arrSelectfilter removeAllObjects];
                    [self.arrSelectfilter addObjectsFromArray:productListModel.productlist_select_filter];
                    
                    [filterdatadic removeAllObjects];
                    [namedatadic removeAllObjects];
                    [selectDataArr removeAllObjects];
                    
                    for (int i = 0; i<[productListModel.productlist_select_filter count]; i++) {
                        id dic = [productListModel.productlist_select_filter objectAtIndex:i isArray:nil];
                        
                        if ([dic respondsToSelector:@selector(objectForKey:)]) {
                            //NSString *name = [dic objectForKey:@"name" isDictionary:nil];  //分类的名称
                            NSString *type = [dic objectForKey:@"type" isDictionary:nil];
                            NSString *namevalue = [dic objectForKey:@"namevalue" isDictionary:nil];
                            NSString *value = [dic objectForKey:@"value" isDictionary:nil];
                            
                            [filterdatadic setObject:value forKey:type];
                            [namedatadic setObject:namevalue forKey:type];
                            [selectDataArr addObject:type];
                        }
                    }
                }else{
                    [self.arrSelectfilter removeAllObjects];
                    [filterdatadic removeAllObjects];
                    [namedatadic removeAllObjects];
                    [selectDataArr removeAllObjects];
                }
            }
            [SBPublicAlert hideMBprogressHUD:self.view];
            
        }
            break;
        case Http_SuitList_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
            return;
        }
            break;
        case 10086:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            return;
        }
            break;
        case 100861:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
        }
        default:
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            break;
    }
}




#pragma mark--- Aciton
-(void)btnAction:(id)sender
{
    MyButton*btn = (MyButton*)sender;
    //小按钮------------
    if (btn.tag == 1108)
    {
        //重置一小部分
        [filterdatadic removeObjectForKey:btn.addstring];
        [namedatadic removeObjectForKey:btn.addstring];

        BOOL isIn = NO;
        for (NSString *str in selectDataArr) {
            if ([str isEqualToString:btn.addstring]) {
                isIn = YES;
                break;
            }
        }
        if (isIn) {
            [selectDataArr removeObject:btn.addstring];
        }
        
        [myTableV reloadData];
    }else if (btn.tag == 1109)
    {
        //只确认一部分  小确定。   请求接口 然后刷新界面
        
        [self MakeSureAndRequestData];
        
    }
    
    //大按钮------------
    if (btn.tag == 1110) {
        //全部重置
        [filterdatadic removeAllObjects];

        //重置的话  全部清空
        self.params = @"";
        [self MakeSureAndRequestData];

        [myTableV reloadData];
        
    }else if (btn.tag == 1111){
        //确定
        if (self.delegate && [self.delegate respondsToSelector:@selector(sureFilter:)]) {
            
            NSArray *keyarr = [filterdatadic allKeys];
            if ([keyarr count] > 0) {
                
                //数据请求-----------
                // 参数和属性之间用  ,   相同属性用 - 分割。  不同属性用  /  分割
                NSMutableArray *marrY = [[NSMutableArray alloc] initWithCapacity:2];
                for (NSString* str in keyarr) {
                    NSString *svalue = [filterdatadic objectForKey:str isDictionary:nil];
                    svalue = [NSString stringWithFormat:@"%@,%@",str,svalue];
                    [marrY addObject:svalue];
                }
                NSString *data = [marrY componentsJoinedByString:@"/"];
                NSLog(@"最终选中的：----%@",data);
                
                [self.delegate sureFilter:data];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [LCommentAlertView showMessage:@"您还未选择筛选条件" target:nil];
                return;
            }
            
        }
    }
    
    
    NSLog(@"拼接的字符串2222----%@",filterdatadic);
    
}


-(void)MakeSureAndRequestData{
    
    NSArray *keyarr = [filterdatadic allKeys];
    if ([keyarr count] > 0) {
    
        //数据请求-----------
        // 参数和属性之间用  ,   相同属性用 - 分割。  不同属性用  /  分割
        NSMutableArray *marrY = [[NSMutableArray alloc] initWithCapacity:2];
        for (NSString* str in keyarr) {
            NSString *svalue = [filterdatadic objectForKey:str isDictionary:nil];
            svalue = [NSString stringWithFormat:@"%@,%@",str,svalue];
            [marrY addObject:svalue];
        }
        NSString *data = [marrY componentsJoinedByString:@"/"];
        NSLog(@"小确定选中的：----%@",data);
        
        [mainSev getProductlist:data andOrder:self.orderStr andKeyword:self.key andPage:self.strcurrentpage andPer_page:self.strperpage];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

    }else{
    //如果没有数据的话，就直接传 之前的params
        [mainSev getProductlist:self.params andOrder:self.orderStr andKeyword:self.key andPage:self.strcurrentpage andPer_page:self.strperpage];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    }
}



#pragma mark-- tableView

// Section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrfilter count] + 1;
}

// row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Section的 head高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 38;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.1)];
        return v;
    }
    
    //正常的cell
    NSInteger normalindex = section -1;
    

    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 38)];
    [bgv setBackgroundColor:[UIColor colorWithHexString:@"ffffff"]];

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
    
    BrandsProductlistFilter *info = [arrfilter objectAtIndex:normalindex isArray:nil];
    namelab.text = info.title;
    
    //CGSize titleSize = [info.title sizeWithFont:namelab.font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    
    UILabel *namelab2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-100, 8, 50, 20)];
    [namelab2 setNumberOfLines:1];
    [namelab2 setTextAlignment:NSTextAlignmentRight];
    namelab2.font = [UIFont systemFontOfSize:LabSmallSize];
    [namelab2 setTextColor:[UIColor colorWithHexString:@"#B5B5B5"]];
    [bgv addSubview:namelab2];
    
    
    if (![info.type isEqualToString:@"t"]) {
        [namelab2 setText:@"可多选"];
    }else{
        [namelab2 setText:@"单选"];
    }
    
    MyButton *resetbtn = [MyButton buttonWithType:UIButtonTypeCustom];
    [resetbtn setFrame:CGRectMake(80, 0, ScreenWidth -80, 38)];
    [resetbtn setBackgroundColor:[UIColor clearColor]];
    resetbtn.titleLabel.font = [UIFont systemFontOfSize:LabSmallSize];
    resetbtn.isOpenCell = info.isOpenCell;
    [resetbtn addTarget:self action:@selector(openCellAction:) forControlEvents:UIControlEventTouchUpInside];
    resetbtn.index = normalindex;
    [bgv addSubview:resetbtn];
    
    
    UIImage *image = [UIImage imageNamed:@"zz_arrow.png"];//[UIImage imageNamed:@"arrow_right.png"];
    UIImageView *imageArrowV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-30, 10, image.size.width * 2/3, image.size.height *2/3)];
    [imageArrowV setImage:image];
    [imageArrowV setBackgroundColor:[UIColor clearColor]];
    [bgv addSubview:imageArrowV];
    
    if (info.isOpenCell == NO) {
        //展开的
        imageArrowV.transform = CGAffineTransformMakeRotation(0);
    }else{
        imageArrowV.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
    
    return bgv;
}


// Section的 foot高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.1)];
    return v;
}

// row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    // section == 0 是已选中的那一列
    if ([indexPath section] == 0) {
        
        if ([selectDataArr count] == 0) {
            return 0;
        }
        
        //lee999 设置高度，现在改为动态的
        return totalSelectHeight;
        
//        int subSortbtnNum = ([selectDataArr count]%filterSelectCellNum == 0? [selectDataArr count]/filterSelectCellNum :[selectDataArr count]/filterSelectCellNum+1);
//        int H = (filterSelectbtnH+filterSp)*subSortbtnNum + 10;
//        return H;
    }
    
    
    //剩余的是待选区域
//    int H = UnopenCellHight;
//    return H;
    
    //正常的cell
    NSInteger normalindex = [indexPath section] -1;
    
    BrandsProductlistFilter *info = [arrfilter objectAtIndex:normalindex isArray:nil];
    
    if (info.isOpenCell == NO) {
        return filterSp + (filterbtnH +filterSp);
    }
    
    
    if (![info.type isEqualToString:@"t"]) {
        return filterSp + (filterbtnH +filterSp)* ([info.items count]%filterCellNum == 0? [info.items count]/filterCellNum :[info.items count]/filterCellNum+1) + filterlittleSurebtnH;
    }else{
        
        //l类型不显示  确认和重置按钮
        return filterSp + (filterbtnH +filterSp)* ([info.items count]%filterCellNum == 0? [info.items count]/filterCellNum :[info.items count]/filterCellNum+1);
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:[NSString stringWithFormat:@"index%ld",(long)[indexPath row]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    
    if ([indexPath section] == 0) {
     
        NSArray *arr = [filterdatadic allKeys];
        if ([arr respondsToSelector:@selector(objectAtIndex:)] &&
            [arr count] > 0) {
            [cell.contentView addSubview:[self createHeadV:arr]];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        
    }else{
    //正常的cell
    NSInteger normalindex = [indexPath section] -1;
    
    BrandsProductlistFilter *info = [arrfilter objectAtIndex:normalindex isArray:nil];
        
        [cell.contentView addSubview:[self createCellView:info.items
                                                 withtype:info.type
                                               withtypeid:info.typeidd
                                                withgroup:info.group
                                                withtitle:info.title
                                               withIsOpen:info.isOpenCell
                                                withIndex:normalindex
                                                ]];
        
        //去掉类型的 确认 重置  按钮
        if ([info.type isEqualToString:@"t"] || info.isOpenCell == NO){

            
        }else{
            NSInteger Hight = filterSp + (filterbtnH +filterSp)* ([info.items count]%filterCellNum == 0? [info.items count]/filterCellNum :[info.items count]/filterCellNum+1) ;
            
            UIView *bgfootvLittle = [[UIView alloc] initWithFrame:CGRectMake(0, Hight, ScreenWidth, filterlittleSurebtnH)];
            [bgfootvLittle setBackgroundColor:[UIColor colorWithHexString:@"e6e6e6"]];
            
            UIImageView*imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 2, ScreenWidth - 30, 0.5)];
            [imageV setBackgroundColor:[UIColor colorWithHexString:@"#DADADA"]];
            [bgfootvLittle addSubview:imageV];
            
            
            UIImage *imagv = [UIImage imageNamed:@"del_c_btn_normal.png"];
            
            MyButton *resetbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [resetbtn setFrame:CGRectMake(85,17,imagv.size.width *0.7, imagv.size.height *0.9)];
            [resetbtn setBackgroundImage:[UIImage imageNamed:@"del_c_btn_normal.png"] forState:UIControlStateNormal];
            [resetbtn setBackgroundImage:[UIImage imageNamed:@"del_c_btn_hover.png"] forState:UIControlStateHighlighted];
            [resetbtn setTitle:@"取消" forState:UIControlStateNormal];
            [resetbtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
            resetbtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
            resetbtn.titleLabel.font = [UIFont systemFontOfSize:LabSmallSize];
            [resetbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            resetbtn.tag = 1108;
            resetbtn.addstring = info.type;
            [bgfootvLittle addSubview:resetbtn];
            
            
            MyButton *okbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [okbtn setFrame:CGRectMake( ScreenWidth - imagv.size.width *0.7 - 85, 17 ,imagv.size.width *0.7, imagv.size.height *0.9)];
            [okbtn setBackgroundImage:[UIImage imageNamed:@"del_btn_normal.png"] forState:UIControlStateNormal];
            [okbtn setBackgroundImage:[UIImage imageNamed:@"del_btn_hover.png"] forState:UIControlStateHighlighted];
            [okbtn setTitle:@"确定" forState:UIControlStateNormal];
            [okbtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
            okbtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
            okbtn.titleLabel.font = [UIFont systemFontOfSize:LabSmallSize];
            [okbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            okbtn.tag = 1109;
            [bgfootvLittle addSubview:okbtn];
            [cell addSubview:bgfootvLittle];
        }
        
    }
    
    // Configure the cell.
    cell.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    
    return cell;
}

-(UIView *)createCellView:(NSArray*)subSortArray withtype:(NSString *)atype withtypeid:(int)atypeid withgroup:(int)agroup withtitle:(NSString*)atitle withIsOpen:(BOOL)isOpen withIndex:(int)sectionindex{

    //行数
    NSInteger subSortbtnNum = ([subSortArray count]%filterCellNum == 0? [subSortArray count]/filterCellNum :[subSortArray count]/filterCellNum+1);
    
    //按钮宽度
    NSInteger filterbtnW = (ScreenWidth-40)/3;
    
    
    //view的高度
    NSInteger viewH = 60;//subSortbtnNum*(filterbtnH+ SplashViewCount);

    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, viewH)];
    [bgv setBackgroundColor:[UIColor clearColor]];


    for (int i = 0; i<subSortbtnNum; i++) {

        NSInteger jcount = ([subSortArray count] - filterCellNum*i) > filterCellNum ? filterCellNum : ([subSortArray count] - filterCellNum*i);
        
        for (int j = 0; j<jcount; j++) {
            
            int index = j + i*filterCellNum;
            
            if (isOpen == NO) {
                //如果是未展开的话 超过3个 跳出
                if (index > 2) {
                    break;
                }
            }
            
            BrandsItems *item = (BrandsItems*)[subSortArray objectAtIndex:index isArray:nil];

            MyButton *sortbtn = [MyButton buttonWithType:UIButtonTypeCustom];
            [sortbtn setFrame:CGRectMake(j*(filterbtnW +10) + filterSp, i*(filterbtnH +10)+10, filterbtnW, filterbtnH)];
            [sortbtn setBackgroundImage:[UIImage imageNamed:@"sx_laber_bg_normal.png"] forState:UIControlStateNormal];
            [sortbtn setBackgroundImage:[UIImage imageNamed:@"sx_laber_bg_select.png"] forState:UIControlStateSelected];
            [sortbtn setTitle:item.name forState:UIControlStateNormal];
            [sortbtn setTitle:item.name forState:UIControlStateSelected];
            [sortbtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
            [sortbtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateSelected];
            sortbtn.titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
            sortbtn.titleLabel.font = [UIFont systemFontOfSize:LabSmallSize];
            [sortbtn addTarget:self action:@selector(subSortBtnclick:) forControlEvents:UIControlEventTouchUpInside];
            sortbtn.isOpenCell = isOpen;
            sortbtn.index = sectionindex;
            
            sortbtn.tag = j + i*filterCellNum;

            
            /*
            "type":"b",
            "typeid":0,
            "group":1,   这个是递增的
            "title":"品牌",
             "items":[
                {
                "name":"1-99元",
                "value":1
                },
              ]
            */

            sortbtn.btntype = atype;   //分类
            sortbtn.btntypeid = [item.value intValue];  //vuale
            sortbtn.btntitle = atitle;    //分类名
            sortbtn.btnname = item.name;  //名称
            if (agroup>0) {
                sortbtn.btngroup = agroup -1;
            }
            
            
            //判断是否含有value，如果有的话 设为选中
            NSString *str = [filterdatadic objectForKey:atype isDictionary:nil];
            NSArray *arr = [str componentsSeparatedByString:@"-"];
            BOOL isSelect = NO;
            for (NSString *str in arr) {
                if ([str isEqualToString:item.value]) {
                    isSelect = YES;
                    break;
                }
            }
            if (isSelect) {
                [sortbtn setSelected:YES];
            }else{
                [sortbtn setSelected:NO];
            }
            
            
            [bgv addSubview:sortbtn];
        }
    }
    
    
    NSInteger H = 0;
    if (isOpen == NO) {
        H = filterSp + (filterbtnH +filterSp);
    }else{
        H = filterSp + (filterbtnH +filterSp)* subSortbtnNum;
    }
    
    [bgv setFrame:CGRectMake(0, 0, ScreenWidth, H)];
    
    return bgv;
}


-(void)openCellAction:(MyButton *)btn{

    //如果未展开的话，点击这一行进行展开操作~~~
    if (btn.isOpenCell == NO) {
        
        BrandsProductlistFilter *info = [arrfilter objectAtIndex:btn.index isArray:nil];
        info.isOpenCell = YES;
        [myTableV reloadData];
    }else{
        
        BrandsProductlistFilter *info = [arrfilter objectAtIndex:btn.index isArray:nil];
        info.isOpenCell = NO;
        [myTableV reloadData];
    
    }
    //end

}


-(void)subSortBtnclick:(id)sender{
    MyButton *btn = (MyButton*)sender;
    
    btn.selected = !btn.selected;
    
    /*
     "type":"b",
     "typeid":0,
     "group":1,   这个是递增的
     "title":"品牌",
     
     相同属性用 - 分割。  不同属性用  /  分割
     相同名字用、隔开
     */
    
    //如果未展开的话，点击这一行进行展开操作~~~
    if (btn.isOpenCell == NO) {
        
        BrandsProductlistFilter *info = [arrfilter objectAtIndex:btn.index isArray:nil];
        info.isOpenCell = YES;
        [myTableV reloadData];
    }
    //end
    
    if (btn.selected) {
        
        if ([[filterdatadic allKeys] count] == 0) {
            //第一次   没有这个属性
            NSString *v = [NSString stringWithFormat:@"%d",btn.btntypeid];
            [filterdatadic setObject:v forKey:btn.btntype];
            
            //lee987
            [namedatadic setObject:btn.btnname forKey:btn.btntype];

            //lee999 修改 类型只能单选。
            if ([btn.btntype isEqualToString:@"t"]) {
                [self MakeSureAndRequestData];
            }
            //end
            
            
        }
        else{
            BOOL isHasKey = NO;
            NSString *haskey = @"";
            
            //判断是否有这个key
            for (NSString *key in [filterdatadic allKeys]) {
                if ([key isEqualToString:btn.btntype]) {
                    //有这个属性key
                    isHasKey = YES;
                    haskey = key;
                    break;
                }
            }
            
            if (isHasKey) {
                
                //判断是否有这个Value
                //判断是否含有value，如果有的话 设为选中
                NSString *str = [filterdatadic objectForKey:haskey isDictionary:nil];
                NSArray *arr = [str componentsSeparatedByString:@"-"];
                BOOL isSelect = NO;
                for (NSString *str in arr) {
                    if ([str intValue] == btn.btntypeid) {
                        isSelect = YES;
                        break;
                    }
                }
                if (!isSelect) {
                    //如果没选中，再添加这个值
                    
                    NSString *v = [filterdatadic objectForKey:haskey];
                    v = [NSString stringWithFormat:@"%@-%d",v,btn.btntypeid];
                    [filterdatadic removeObjectForKey:haskey];
                    [filterdatadic setObject:v forKey:haskey];
                    
                    
                    //lee987
                    NSString *v1 = [namedatadic objectForKey:haskey];
                    v1 = [NSString stringWithFormat:@"%@、%@",v1,btn.btnname];
                    [namedatadic removeObjectForKey:haskey];
                    [namedatadic setObject:v1 forKey:haskey];
                    
                }
            
            }else{
                //第二次 没有这个属性
                NSString *v = [NSString stringWithFormat:@"%d",btn.btntypeid];
                [filterdatadic setObject:v forKey:btn.btntype];
                
                //lee987
                [namedatadic setObject:btn.btnname forKey:btn.btntype];
                
                
                
                //lee999 修改 类型只能单选。
                if ([btn.btntype isEqualToString:@"t"]) {
                    [self MakeSureAndRequestData];
                }
                //end
            }
        }
    }
    
    else{
    //移除 属性
        
        NSString *strV = [filterdatadic objectForKey:btn.btntype isDictionary:nil];
        if (strV.length>0) {
            NSArray *arr = [strV componentsSeparatedByString:@"-"];
            NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
            if ([arr count] > 0) {
                
                for (NSString *strr in arr) {
                    if ([strr intValue] == btn.btntypeid) {
                        [marr removeObject:strr];
                        
                        //如果为0的话，就移除这个key
                        if (marr.count == 0) {
                            [filterdatadic removeObjectForKey:btn.btntype];
                            
                            //lee987
                            [namedatadic removeObjectForKey:btn.btntype];
    
                            break;
                        }
                        
                        //拼接为一个字符串
                        NSString *lstr = [marr componentsJoinedByString:@"-"];
                        [filterdatadic setObject:lstr forKey:btn.btntype];
                        break;
                    }
                }
            }
        }
        
        //移除名字
        NSString *strV1 = [namedatadic objectForKey:btn.btntype isDictionary:nil];
        if (strV1.length>0) {
            NSArray *arr1 = [strV1 componentsSeparatedByString:@"、"];
            NSMutableArray *marr1 = [NSMutableArray arrayWithArray:arr1];
            if ([arr1 count] > 0) {
                
                for (NSString *strr1 in arr1) {
                    if ([strr1 isEqualToString:btn.btnname]) {
                        [marr1 removeObject:strr1];
                        
                        //如果为0的话，就移除这个key
                        if (marr1.count == 0) {
                            //lee987
                            [namedatadic removeObjectForKey:btn.btntype];
                            
                            break;
                        }
                        
                        //拼接为一个字符串
                        NSString *lstr1 = [marr1 componentsJoinedByString:@"、"];
                        [namedatadic setObject:lstr1 forKey:btn.btntype];
                        break;
                    }
                }
            }
        }//end 移除名字
    }
    
    //lee999 150505 修改bug
    //selectDataArr = [NSMutableArray arrayWithArray:[filterdatadic allKeys]];
    
    NSLog(@"拼接的字符串----%@",filterdatadic);
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




//    //行数
//    int subSortbtnNum = ([subSortArray count]%filterSelectCellNum == 0? [subSortArray count]/filterSelectCellNum :[subSortArray count]/filterSelectCellNum+1);
//
//    //按钮宽度
//    int filterbtnW = (ScreenWidth-(filterSelectCellNum*10 +10))/filterSelectCellNum;
//
////    UIView *bgv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, subSortbtnNum*(filterSelectbtnH+ filterSp) + 10)];
////    [bgv setBackgroundColor:[UIColor clearColor]];
//
//
//
//    for (int i = 0; i<subSortbtnNum; i++) {
//
//        int jcount = ([subSortArray count] - filterSelectCellNum*i) > filterSelectCellNum ? filterSelectCellNum : ([subSortArray count] - filterSelectCellNum*i);
//
//        for (int j = 0; j<jcount; j++) {
//
//            int index = j + i*filterSelectCellNum;
//
//
//            NSString *key = [subSortArray objectAtIndex:index isArray:nil];
//            NSString *name = [namedatadic objectForKey:key isDictionary:nil];
//
//
//            MyButton *sortbtn = [MyButton buttonWithType:UIButtonTypeCustom];
//            [sortbtn setFrame:CGRectMake(j*(filterbtnW +10) + filterSp, i*(filterSelectbtnH +10)+10, filterbtnW, filterSelectbtnH)];
//            [sortbtn setBackgroundImage:[UIImage imageNamed:@"sx_laber_bg_normal.png"] forState:UIControlStateNormal];
//            [sortbtn setBackgroundImage:[UIImage imageNamed:@"sx_laber_bg_select.png"] forState:UIControlStateSelected];
//
//            [sortbtn setTitle:[NSString stringWithFormat:@"%@ x",name] forState:UIControlStateNormal];
//            [sortbtn setTitle:[NSString stringWithFormat:@"%@ x",name] forState:UIControlStateSelected];
//            [sortbtn setTitleColor:[UIColor colorWithHexString:@"c8002c"] forState:UIControlStateNormal];
//            [sortbtn setTitleColor:[UIColor colorWithHexString:@"c8002c"] forState:UIControlStateSelected];
//            sortbtn.titleLabel.textColor = [UIColor colorWithHexString:@"c8002c"];
//            sortbtn.titleLabel.font = [UIFont systemFontOfSize:LablitileSmallSize];
//            [sortbtn addTarget:self action:@selector(removeSelectCararyAction:) forControlEvents:UIControlEventTouchUpInside];
//
//            sortbtn.btntype = key;
//
//            sortbtn.tag = index; //j + i*filterSelectCellNum;
//
//            [bgv addSubview:sortbtn];
//        }
//    }
//    return bgv;



//正常的cell
//    int normalindex = section -1;
//    UIView *bgfootvLittle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, filterlittleSurebtnH)];
//    [bgfootvLittle setBackgroundColor:[UIColor colorWithHexString:@"e6e6e6"]];
//
//    UIImageView*imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 2, ScreenWidth - 30, 0.5)];
//    [imageV setBackgroundColor:[UIColor colorWithHexString:@"#DADADA"]];
//    [bgfootvLittle addSubview:imageV];
//
//
//    BrandsProductlistFilter *info = [arrfilter objectAtIndex:normalindex isArray:nil];
//
//
//    UIImage *imagv = [UIImage imageNamed:@"del_c_btn_normal.png"];
//    MyButton *resetbtn = [MyButton buttonWithType:UIButtonTypeCustom];
//    [resetbtn setFrame:CGRectMake(85,17,imagv.size.width *0.7, imagv.size.height *0.9)];
//    [resetbtn setBackgroundImage:[UIImage imageNamed:@"del_c_btn_normal.png"] forState:UIControlStateNormal];
//    [resetbtn setBackgroundImage:[UIImage imageNamed:@"del_c_btn_hover.png"] forState:UIControlStateHighlighted];
//    [resetbtn setTitle:@"重置" forState:UIControlStateNormal];
//    [resetbtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
//    resetbtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
//    resetbtn.titleLabel.font = [UIFont systemFontOfSize:LabSmallSize];
//    [resetbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    resetbtn.tag = 1108;
//    resetbtn.addstring = info.type;
//    [bgfootvLittle addSubview:resetbtn];
//
//
//    MyButton *okbtn = [MyButton buttonWithType:UIButtonTypeCustom];
//    [okbtn setFrame:CGRectMake( ScreenWidth - imagv.size.width *0.7 - 85, 17 ,imagv.size.width *0.7, imagv.size.height *0.9)];
//    [okbtn setBackgroundImage:[UIImage imageNamed:@"del_btn_normal.png"] forState:UIControlStateNormal];
//    [okbtn setBackgroundImage:[UIImage imageNamed:@"del_btn_hover.png"] forState:UIControlStateHighlighted];
//    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
//    [okbtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
//    okbtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
//    okbtn.titleLabel.font = [UIFont systemFontOfSize:LabSmallSize];
//    [okbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    okbtn.tag = 1109;
//    [bgfootvLittle addSubview:okbtn];
//    return bgfootvLittle;

