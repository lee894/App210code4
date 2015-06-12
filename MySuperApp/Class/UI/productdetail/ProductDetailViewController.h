//
//  ProductDetailViewController.h
//  MySuperApp
//
//  Created by lee on 14-4-2.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "LBaseViewController.h"
#import "SinaClass.h"
#import "MyPageControl.h"
#import "UrlImageView.h"

@interface UIViewForRecursively : UIView {
}
@property(nonatomic,assign)    UIScrollView *scroll;
@end

@interface ProductDetailViewController : LBaseViewController<ServiceDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,sinaLoginDelegate>
{

    
    NSInteger scrollNum;
    NSInteger _currentPage;
    
    //UI
    UITableView *detailTab;//大表
    UIViewForRecursively *headerView;
    MyPageControl *pgControlForScroll;
    UITextField *buttonForNum;
    
    UIPickerView *pickerForSelectNumber;
    UIToolbar *toolBarForNumber;
    
    
    UIPickerView *pickerForSelectColor;//颜色下拉列表
    UIToolbar *toolBarForPicker;//picker上的toolbar
    
    UIPickerView *pickerForSelectSize;//尺寸下来列表
    UIToolbar *toolBarForSizePicker;//尺寸picker的toolbar
    
    
    //数据源
	NSMutableArray *colorsForProduct;//颜色数据源
    NSMutableArray *buttonsForSize;//尺码数据源
    NSMutableArray *numberProduct;//物品数量的数据源
    
    int currentProduct;//因为不同颜色对应不同的商品 换颜色也换currentproduct id
    int currentColor;//滚动picker时给这b赋值
    int didSelectColor;
    int currentSize;
    int currentNumber; //商品的数量
    int didSelectNumber;
    int recordNUM;
    
    
    
    BOOL isRePostWeibo;
    BOOL isPushShareWeiboAnimatied;
    
    UIButton *addButfav;
    
    UILabel *label_size;
//    ProductDetailController *detial;
    YKBannerShowInProductdetail *bannerShow;
    YKProductdetailList *detailList;
    BOOL isAddFav;
    BOOL hasSuit;   //是否有套装
    
    
    ProductProductDetailModel *productModel;

}


@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, assign) BOOL isHome;

@property (nonatomic, assign) BOOL isFromMyAimer;
@property (nonatomic, assign) BOOL isFromCar;

@property (nonatomic, assign) BOOL isHiddenBar; //是否隐藏bar

@property(nonatomic, retain)	NSMutableString *multiDescStr;
@property(nonatomic, copy)	NSString *num;//记录输入的数量
@property(nonatomic, copy)	NSString *selectedSize;//记录选择的尺码
@property(nonatomic, copy)  NSString *thisProductId;//拼接此商品的url
@property(nonatomic, retain) UIButton *buttonForSelect;//颜色按钮
@property(nonatomic,retain) UIButton *buttonForSize;//尺码数据源
@property(nonatomic,retain) NSMutableString *str_append;
@property(nonatomic,retain) NSString *product_id;
@property(nonatomic,assign) int leftNUM;
@property(nonatomic,assign) int buttonView_height;
@property(nonatomic,retain) NSString *ThisPorductName;
@property(nonatomic,retain) NSString *source_id;
@property(nonatomic, retain) UIView *shareView;//弹出分享的视图
@property (nonatomic, assign) BOOL isShop;



//@property(nonatomic, strong)UIPickerView *pickerForSelectNumber;
//@property(nonatomic, strong)UIToolbar *toolBarForNumber;
//
//
//@property(nonatomic, strong)UIPickerView *pickerForSelectColor;//颜色下拉列表
//@property(nonatomic, strong)UIToolbar *toolBarForPicker;//picker上的toolbar
//
//@property(nonatomic, strong)UIPickerView *pickerForSelectSize;//尺寸下来列表
//@property(nonatomic, strong)UIToolbar *toolBarForSizePicker;//尺寸picker的toolbar


@property (nonatomic, retain) NSArray *arrTemSize;

//- (IBAction)productShare:(UIButton *)sender;//分享
//- (IBAction)cancel:(id)sender;

@end



