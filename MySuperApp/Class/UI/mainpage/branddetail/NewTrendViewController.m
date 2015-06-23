//
//  NewTrendViewController.m
//  MySuperApp
//
//  Created by LEE on 14-7-24.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "NewTrendViewController.h"
#import "NewBigViewController.h"
#import "ProductDetailViewController.h"
#import "ImageViewCell.h"

//潮流新品
//#define TableViewOneWidth (320/5.0*2.0)
//#define TableViewTowWidth (320/5.0*3.0)

#define TableViewOneWidth (320/6.0*3.0)
#define TableViewTowWidth (320/6.0*3.0)

#define objectwidth 150

@interface NewTrendViewController ()

@end

@implementation NewTrendViewController
@synthesize brandName;
@synthesize arrayImg;
@synthesize index;
@synthesize imgBackground;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayFirst = [[NSMutableArray alloc] init];
    arraySecond = [[NSMutableArray alloc] init];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 1; i<= 13; i++) {
        if (i >= 10) {//@"brand_%@_s.png"
            [arr addObject:[NSString stringWithFormat:@"brand_%d_pic_02.png",i]];
        }else {
            [arr addObject:[NSString stringWithFormat:@"brand_0%d_pic_02.png",i]];
        }
    }
    arrIcon = arr;
    
    self.title = @"潮流新品";
    
    
    MainpageServ *mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [mainSev getBrandtrend:self.brandName];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
    
    waterFlow = [[WaterFlowView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth,NowViewsHight + 20)];
//    waterFlow = [[WaterFlowView alloc] initWithFrame:self.view.frame];
    waterFlow.waterFlowViewDelegate = self;
    waterFlow.waterFlowViewDatasource = self;
    waterFlow.backgroundColor = [UIColor clearColor];
    [self.view addSubview:waterFlow];
    [self.view setBackgroundColor:[UIColor colorWithHexString:tableViewBGC]];
    
    waterFlow.showsVerticalScrollIndicator = FALSE;
    waterFlow.showsHorizontalScrollIndicator = FALSE;

    [self createBackBtnWithType:0];
}

#pragma mark -- NetRequestDelegate
#pragma mark--sever
-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_Brandtrend_Tag:
        {
            chaoliuModel = (ChaoliuChaoliuxinpinModel *)model;
            
            for (int i = 0; i < chaoliuModel.chaoliuxinpinInfo.count+1; i++) {
                ChaoliuChaoliuxinpinInfo *object = nil;
                if (i==0) {
                    object = [[ChaoliuChaoliuxinpinInfo alloc] init];
                    
                    object.width = [NSString stringWithFormat:@"%f",TableViewOneWidth];
                    object.height = [NSString stringWithFormat:@"%f",30.0];
                    
                    NSString *str = [arrIcon objectAtIndex:self.index-1 isArray:nil];//[NSString stringWithFormat:@"fashion_brand_logo_%d.png",self.index];//[[NSBundle mainBundle] pathForResource:[arrIcon objectAtIndex:index] ofType:@"png"];
                    
                    object.imgPath = str;
                }else {
                    object = [chaoliuModel.chaoliuxinpinInfo objectAtIndex:i-1 isArray:nil];
                }
                if (_firstHeight <= _secondHeight ) {
                    _firstHeight += [object.height floatValue] / ([object.width floatValue] / (float)TableViewOneWidth);
                    [arrayFirst addObject:object];
                } else {
                    _secondHeight += [object.height floatValue] / ([object.width floatValue] / (float)TableViewTowWidth);
                    [arraySecond addObject:object];
                }
            }
            
            [waterFlow reloadData];
        }
            break;
        case 10086:
            [SBPublicAlert showMBProgressHUD:@"请求错误···" andWhereView:self.view hiddenTime:0.6];
            break;
        default:
            break;
    }
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceStarted:(ServiceType)aHandle{
}

#pragma mark WaterFlowViewDataSource
- (NSInteger)numberOfColumsInWaterFlowView:(WaterFlowView *)waterFlowView{
    
    return 2;
}

- (NSInteger)numberOfAllWaterFlowView:(WaterFlowView *)waterFlowView  numberOfRowsInColumn:(NSInteger)colunm{
    
    switch (colunm) {
        case 0:
        {
            return arrayFirst.count;
        }
            break;
        case 1:
        {
            return arraySecond.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

- (UIView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(IndexPath *)indexPath{
    
    ImageViewCell *view = [[ImageViewCell alloc] initWithIdentifier:nil];
    
    if ([indexPath row]== 0 && [indexPath column] == 0) {
        view.imageView.alpha = 1.0;
    }
    
    return view;
}


-(void)waterFlowView:(WaterFlowView *)waterFlowView  relayoutCellSubview:(UIView *)view withIndexPath:(IndexPath *)indexPath{
    
    //arrIndex是某个数据在总数组中的索引
    
    switch (indexPath.column) {
        case 0:
        {
            int arrIndex = indexPath.row;
            
            if (arrIndex < arrayFirst.count){
                
                // 0是默认的 品牌图片
                if (arrIndex == 0) {
                    ChaoliuChaoliuxinpinInfo *object = [arrayFirst objectAtIndex:arrIndex];
                    
                    ImageViewCell *imageViewCell = (ImageViewCell *)view;
                    imageViewCell.indexPath = indexPath;
                    imageViewCell.columnCount = waterFlowView.columnCount;
                    [imageViewCell relayoutViews];
                    
                    UIImage *image = [UIImage imageNamed:object.imgPath];
                    
                    [(ImageViewCell *)view setImage:image];
                    
                }else {
                    ChaoliuChaoliuxinpinInfo *object = [arrayFirst objectAtIndex:arrIndex];
                    
                    ImageViewCell *imageViewCell = (ImageViewCell *)view;
                    imageViewCell.indexPath = indexPath;
                    imageViewCell.columnCount = waterFlowView.columnCount;
                    [imageViewCell relayoutViews];
                    [(ImageViewCell *)view setImageWithURL:object.imgPath];
                }
            }
        }
            break;
        case 1:
        {
            int arrIndex = indexPath.row-1 <0?0:indexPath.row;
            NSLog(@"2  %d", arrIndex);
            
            if (arrIndex < arraySecond.count){
                ChaoliuChaoliuxinpinInfo *object = [arraySecond objectAtIndex:arrIndex];
                
                ImageViewCell *imageViewCell = (ImageViewCell *)view;
                imageViewCell.indexPath = indexPath;
                imageViewCell.columnCount = waterFlowView.columnCount;
                [imageViewCell relayoutViews];
                [(ImageViewCell *)view setImageWithURL:object.imgPath];
            }
        }
            break;
        default:
            break;
    }
}


#pragma mark WaterFlowViewDelegate
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(IndexPath *)indexPath{
    
    switch (indexPath.column) {
        case 0:
        {
            if (indexPath.row == 0) {
                return 80;
            }
            
            ChaoliuChaoliuxinpinInfo * object = [arrayFirst objectAtIndex:indexPath.row];
            return [object.height floatValue] / ([object.width floatValue] / (float)TableViewOneWidth);
        }
            break;
        case 1:
        {
            ChaoliuChaoliuxinpinInfo * object = [arraySecond objectAtIndex:indexPath.row];
            return [object.height floatValue] / ([object.width floatValue] / (float)TableViewTowWidth);
        }
            break;
        default:
            break;
    }
    return 0;
}


- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(IndexPath *)indexPath{
    
    
    NewBigViewController *newBigImageVC = [[NewBigViewController alloc] init];
    
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return;
        }
        ChaoliuChaoliuxinpinInfo *object = [arrayFirst objectAtIndex:indexPath.row];
        newBigImageVC.productID = object.productId;
        newBigImageVC.imagePath = object.imgPath;
    }else {
        ChaoliuChaoliuxinpinInfo *object = [arraySecond objectAtIndex:indexPath.row];
        newBigImageVC.productID = object.productId;
        newBigImageVC.imagePath = object.imgPath;
    }
    [self.navigationController pushViewController:newBigImageVC animated:YES];
    
    
//    ProductDetailViewController* detail = [[ProductDetailViewController alloc] init];
////    detail.thisProductId = self.productID;
//    NewBigViewController *newBigImageVC = [[NewBigViewController alloc] init];
//
//    if (indexPath.column == 0) {
//        if (indexPath.row == 0) {
//            return;
//        }
//        ChaoliuChaoliuxinpinInfo *object = [arrayFirst objectAtIndex:indexPath.row];
////        newBigImageVC.productID = object.productId;
////        newBigImageVC.imagePath = object.imgPath;
//        detail.thisProductId = object.productId;
//
//    }else {
//        ChaoliuChaoliuxinpinInfo *object = [arraySecond objectAtIndex:indexPath.row];
////        newBigImageVC.productID = object.productId;
////        newBigImageVC.imagePath = object.imgPath;
//        
//        detail.thisProductId = object.productId;
//    }
////    [self.navigationController pushViewController:newBigImageVC animated:YES];
//    [self.navigationController pushViewController:detail animated:YES];

}


//    将UIImage缩放到指定大小尺寸：
//- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    // 返回新的改变大小后的图片
//    return scaledImage;
//}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
