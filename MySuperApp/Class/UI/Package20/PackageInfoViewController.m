//
//  PackageInfoViewController.m
//  MyAimerApp
//
//  Created by 蒋博男 on 15-6-10.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "PackageInfoParser.h"
#import "ProductDetailViewController.h"
#import "PackageInfoViewController.h"

@interface PackageInfoViewController ()
{
    MainpageServ* mainSev;
    UIView* vGoods;
    
    UIPickerView *pickerForSelectColor;//颜色下拉列表
    UIToolbar *toolBarForPicker;//picker上的toolbar
    
    UIPickerView *pickerForSelectSize;//尺寸下来列表
    UIToolbar *toolBarForSizePicker;//尺寸picker的toolbar
    
    //数据源
    NSMutableArray *colorsForProduct;//颜色数据源
    NSMutableArray *buttonsForSize;//尺码数据源
    
    NSInteger currentProduct;//因为不同颜色对应不同的商品 换颜色也换currentproduct id
    NSInteger currentColor;//滚动picker时给这b赋值
    NSInteger currentSize;
    ProductProductDetailModel *productModel;
}
@property (nonatomic, retain) PackageInfo* pInfo;
@property (nonatomic, retain) UIScrollView* svPackage;
@property(nonatomic, copy)	NSString *selectedSize;//记录选择的尺码
@property (nonatomic, retain) NSArray *arrTemSize;
@property(nonatomic,retain) NSMutableString *str_append;
@end

@implementation PackageInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [self.view addSubview:self.svPackage];
    [self.view addConstraints:[self viewConstraints]];
    [mainSev getPackageInfoWithPid:self.pid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)serviceStarted:(ServiceType)aHandle
{
    
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel
{
    _pInfo = [[[PackageInfoParser alloc] init] parsePackageInfo:amodel];
    self.title = _pInfo.packageinfo.name;
    for (NSInteger i = 0; i < ((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods.count; ++i) {
        PackageGoodsInfo* pgi = [((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods objectAtIndex:i];
        UIView* vUnit = [[UIView alloc] initWithFrame:CGRectMake(15 + (i % 2) * (lee1fitAllScreen(140) + 10), (i / 2) * (lee1fitAllScreen((180 + 105))), lee1fitAllScreen(140), lee1fitAllScreen((180 + 105)))];
        UrlImageView* uiv = [[UrlImageView alloc] initWithFrame:CGRectMake(0, 15, lee1fitAllScreen(140), lee1fitAllScreen(180))];
        [uiv setImageWithURL:[NSURL URLWithString:pgi.image_url] placeholderImage:nil];
        [vUnit addSubview:uiv];
        
        UILabel* lblName = [[UILabel alloc] init];
        [lblName setFont:[UIFont systemFontOfSize:11]];
        [lblName setNumberOfLines:2];
        [lblName setText:pgi.name];
        [lblName setTextColor:[UIColor colorWithHexString:@"#333333"]];
        [lblName setLineBreakMode:NSLineBreakByTruncatingTail];
        NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
        [mps setLineBreakMode:NSLineBreakByCharWrapping];
        CGRect rcName = [lblName.text boundingRectWithSize:CGSizeMake(vUnit.frame.size.width - 20, 36) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSParagraphStyleAttributeName : mps, NSFontAttributeName : lblName.font} context:nil];
        [lblName setFrame:CGRectMake(10, uiv.frame.size.height + uiv.frame.origin.y + 12, rcName.size.width, rcName.size.height)];
        [vUnit addSubview:lblName];
        
        UILabel* lblPrice = [[UILabel alloc] init];
        [lblPrice setFont:[UIFont systemFontOfSize:11]];
        [lblPrice setText:[NSString stringWithFormat:@"￥%@", pgi.price]];
        [lblPrice setTextColor:[UIColor colorWithHexString:@"#c8002c"]];
        CGRect rcPrice = [lblName.text boundingRectWithSize:CGSizeMake(vUnit.frame.size.width - 20, 36) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : lblPrice.font} context:nil];
        [lblPrice setFrame:CGRectMake(lblName.frame.origin.x, vUnit.frame.size.height - 15 - rcPrice.size.height, rcPrice.size.width, rcPrice.size.height)];
        [vUnit addSubview:lblPrice];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, vUnit.frame.size.width, vUnit.frame.size.height)];
        [btn addTarget:self action:@selector(selectGoods:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        [vUnit addSubview:btn];
        
        [self.svPackage addSubview:vUnit];
        
        if (i % 2 == 1) {
            UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(15, vUnit.frame.origin.y + vUnit.frame.size.height, [UIScreen mainScreen].bounds.size.width - 30, 0.5)];
            [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d1d1d1"]];
            [self.svPackage addSubview:lblSep];
        }
    }
    NSInteger total = ((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods.count;
    [_svPackage setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, lee1fitAllScreen(285) * (total % 2 > 0 ? (total / 2 + 1) : (total / 2)))];
}

-(void)serviceFailed:(ServiceType)aHandle
{
    
}

-(void)selectGoods:(UIButton*)sender
{
    NSInteger index = sender.tag;
    PackageGoodsInfo* pgi = [((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods objectAtIndex:index];
    vGoods = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [vGoods setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    UIView* vBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lee1fitAllScreen(270), lee1fitAllScreen(212))];
    [vBG setBackgroundColor:[UIColor colorWithHexString:@"#eaeaea"]];
    [vBG setAlpha:0.8];
    [vBG.layer setCornerRadius:5];
    [vBG setCenter:vGoods.center];
    
    UrlImageView* uiv = [[UrlImageView alloc] initWithFrame:CGRectMake(15, 15, lee1fitAllScreen(97), lee1fitAllScreen(125))];
    [uiv setImageWithURL:[NSURL URLWithString:pgi.image_url] placeholderImage:nil];
    [vBG addSubview:uiv];
    
    UILabel* lblName = [[UILabel alloc] init];
    [lblName setFont:[UIFont systemFontOfSize:12]];
    [lblName setNumberOfLines:2];
    [lblName setText:pgi.name];
    [lblName setTextColor:[UIColor colorWithHexString:@"#333333"]];
    [lblName setLineBreakMode:NSLineBreakByTruncatingTail];
    NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
    [mps setLineBreakMode:NSLineBreakByCharWrapping];
    CGRect rcName = [lblName.text boundingRectWithSize:CGSizeMake(vBG.frame.size.width - 40 - uiv.frame.size.width - uiv.frame.origin.x, 36) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSParagraphStyleAttributeName : mps, NSFontAttributeName : lblName.font} context:nil];
    [lblName setFrame:CGRectMake(uiv.frame.size.width + uiv.frame.origin.x + 20, uiv.frame.origin.y, rcName.size.width, rcName.size.height)];
    [vBG addSubview:lblName];
    
    UILabel* lblColor = [[UILabel alloc] init];
    [lblColor setFont:[UIFont systemFontOfSize:12]];
    [lblColor setText:@"颜色："];
    [lblColor setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [lblColor setFrame:CGRectMake(lblName.frame.origin.x, 76, 100, 12)];
    [vBG addSubview:lblColor];
    
    UIButton* btnColor = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnColor setFrame:CGRectMake(uiv.frame.origin.x + uiv.frame.size.width + 62.5, 68, lee1fitAllScreen(80), lee1fitAllScreen(30))];
    [btnColor addTarget:self action:@selector(ShowColorView:) forControlEvents:UIControlEventTouchUpInside];
    [btnColor setTitleColor:[UIColor colorWithHexString:@"181818"] forState:UIControlStateNormal];
    [btnColor.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnColor setTitle:@"橘色" forState:UIControlStateNormal];
    [btnColor setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [btnColor setBackgroundImage:[UIImage imageNamed:@"lp_option"] forState:UIControlStateNormal];
    [vBG addSubview:btnColor];
    
    UILabel* lblSize = [[UILabel alloc] init];
    [lblSize setFont:[UIFont systemFontOfSize:12]];
    [lblSize setText:@"尺码："];
    [lblSize setTextColor:[UIColor colorWithHexString:@"#666666"]];
    [lblSize setFrame:CGRectMake(lblName.frame.origin.x, 122, 100, 12)];
    [vBG addSubview:lblSize];
    
    UILabel* lblSep = [[UILabel alloc] initWithFrame:CGRectMake(0, uiv.frame.origin.y + uiv.frame.size.height + 11, vBG.frame.size.width, 0.5)];
    [lblSep setBackgroundColor:[UIColor colorWithHexString:@"#d1d1d1"]];
    [vBG addSubview:lblSep];
    
    UIButton* btnToDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnToDetail setBackgroundImage:[UIImage imageNamed:@"lp_btn_normal"] forState:UIControlStateNormal];
    [btnToDetail setBackgroundImage:[UIImage imageNamed:@"lp_btn_hover"] forState:UIControlStateSelected];
    [btnToDetail setTitle:@"单独购买" forState:UIControlStateNormal];
    [btnToDetail setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btnToDetail.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btnToDetail addTarget:self action:@selector(toDetail:) forControlEvents:UIControlEventTouchUpInside];
    [btnToDetail setTag:index];
    [btnToDetail setFrame:CGRectMake(20, 7.5 + lblSep.frame.origin.y + lblSep.frame.size.height, lee1fitAllScreen(105), lee1fitAllScreen(44))];
    [vBG addSubview:btnToDetail];
    
    UIButton* btnAddToPackage = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddToPackage setBackgroundImage:[UIImage imageNamed:@"lp_btn_normal"] forState:UIControlStateNormal];
    [btnAddToPackage setBackgroundImage:[UIImage imageNamed:@"lp_btn_hover"] forState:UIControlStateSelected];
    [btnAddToPackage setTitle:@"加入礼包" forState:UIControlStateNormal];
    [btnAddToPackage setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btnAddToPackage.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btnAddToPackage addTarget:self action:@selector(addToPackage:) forControlEvents:UIControlEventTouchUpInside];
    [btnAddToPackage setTag:index];
    [btnAddToPackage setFrame:CGRectMake(btnToDetail.frame.size.width + btnToDetail.frame.origin.x   + 20, 7.5 + lblSep.frame.origin.y + lblSep.frame.size.height, lee1fitAllScreen(105), lee1fitAllScreen(44))];
    [vBG addSubview:btnAddToPackage];
    
    [vGoods addSubview:vBG];
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window addSubview:vGoods];
}

-(void)toDetail:(UIButton*)sender
{
    NSInteger index = sender.tag;
    [vGoods removeFromSuperview];
    PackageGoodsInfo* pgi = [((PackageGroupInfo*)[_pInfo.packageinfo.groups firstObject]).goods objectAtIndex:index];
    ProductDetailViewController* detail = [[ProductDetailViewController alloc] init];
    detail.thisProductId = pgi.gid;
    detail.ThisPorductName = pgi.name;
    detail.isPush = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)addToPackage:(UIButton*)sender
{
    
}

-(void)ShowColorView:(UIButton*)sender
{
    
}

-(NSArray*)viewConstraints
{
    NSDictionary *views = @{@"svPackage" : self.svPackage};
    NSDictionary *metrics = @{@"barHeight" : [NSNumber numberWithFloat:lee1fitAllScreen(59)]};
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[svPackage]-(barHeight)-|" options:0 metrics:metrics views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[svPackage]|" options:0 metrics:metrics views:views]];
    return constraints;
}

-(UIScrollView *)svPackage
{
    if (_svPackage) {
        return _svPackage;
    }
    _svPackage = [[UIScrollView alloc] init];
    [_svPackage setDelegate:self];
    [_svPackage setShowsVerticalScrollIndicator:NO];
    [_svPackage setTranslatesAutoresizingMaskIntoConstraints:NO];
    return _svPackage;
}

-(void)createtoolbarandpicker{
    //toolbar上地按钮
    UIBarButtonItem *buttonForCancel_Number=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel_Number.tintColor = [UIColor whiteColor];
    }
    buttonForCancel_Number.tag=101;
    UIBarButtonItem *buttonForFix_Number=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix_Number.width=225;
    UIBarButtonItem *buttonForDone_Number=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForDone_Number.tintColor = [UIColor whiteColor];
    }
    buttonForDone_Number.tag=102+10;
    
    //创建picker
    //    颜色的pickeView
    pickerForSelectColor=[[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, 320, 216)];
    [pickerForSelectColor setDelegate:self];
    [pickerForSelectColor setDataSource:self];
    pickerForSelectColor.showsSelectionIndicator=YES;
    //    [self.view addSubview:pickerForSelectColor];
    [[MyAppDelegate window] addSubview:pickerForSelectColor];
    //    尺寸的Pickview
    pickerForSelectSize=[[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, 320, 216)];
    [pickerForSelectSize setDelegate:self];
    [pickerForSelectSize setDataSource:self];
    pickerForSelectSize.showsSelectionIndicator=YES;
    //    [self.view addSubview:pickerForSelectSize];
    [[MyAppDelegate window] addSubview:pickerForSelectSize];
    
    //创建toolbar
    toolBarForPicker=[[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight+20, 320, 44)];
    toolBarForPicker.hidden = YES;
    toolBarForPicker.barStyle=UIBarStyleBlackTranslucent;
    //    [self.view addSubview:toolBarForPicker];
    [[MyAppDelegate window] addSubview:toolBarForPicker];
    toolBarForSizePicker=[[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight+20, 320, 44)];
    toolBarForSizePicker.barStyle=UIBarStyleBlackTranslucent;
    //    [self.view addSubview:toolBarForSizePicker];
    [[MyAppDelegate window] addSubview:toolBarForSizePicker];
    
    //toolbar上地按钮
    UIBarButtonItem *buttonForCancel=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel.tintColor = [UIColor whiteColor];
    }
    buttonForCancel.tag=101;
    UIBarButtonItem *buttonForFix=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix.width=225;
    UIBarButtonItem *buttonForDone=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForDone.tintColor = [UIColor whiteColor];
    }
    buttonForDone.tag=102;
    [toolBarForPicker setItems:[NSArray arrayWithObjects:buttonForCancel,buttonForFix,buttonForDone,nil]];
    
    
    UIBarButtonItem *buttonForCancel_size=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForCancel_size.tintColor = [UIColor whiteColor];
    }
    buttonForCancel_size.tag=101+100;
    UIBarButtonItem *buttonForFix_size=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(BarButtonClick:)];
    buttonForFix_size.width=220;
    UIBarButtonItem *buttonForDone_size=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(BarButtonClick:)];
    if (isIOS7up) {
        buttonForDone_size.tintColor = [UIColor whiteColor];
    }
    buttonForDone_size.tag=102+100;
    [toolBarForSizePicker setItems:[NSArray arrayWithObjects:buttonForCancel_size,buttonForFix_size,buttonForDone_size,nil]];
    
    pickerForSelectColor.backgroundColor = [UIColor whiteColor];
    pickerForSelectSize.backgroundColor = [UIColor whiteColor];
    
}

- (void)hiddle {
    toolBarForSizePicker.hidden = YES;
    toolBarForPicker.hidden = YES;
}

-(void)hiddenBar{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    pickerForSelectColor.frame=CGRectMake(0, ScreenHeight, 320, 216);
    toolBarForPicker.frame=CGRectMake(0, ScreenHeight+20, 320, 44)
    ;
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    pickerForSelectSize.frame=CGRectMake(0, ScreenHeight, 320, 216);
    toolBarForSizePicker.frame=CGRectMake(0, ScreenHeight+20, 320, 44)
    ;
    [UIView setAnimationDidStopSelector:@selector(hiddle)];
    [UIView commitAnimations];
}

- (int)indexOfSize:(NSString *)size
{
    int index = 0;
    for (int i=0; i<self.arrTemSize.count; i++) {
        if ([[[self.arrTemSize objectAtIndex:i]objectForKey:@"spec_alias"] isEqualToString:self.selectedSize]) {
            index = i;
        }
    }
    return index;
}

-(void)BarButtonClick:(UIBarButtonItem *)barButton{
    
    
    [self hiddenBar];
    
    
    if(barButton.tag==102)
    {
        
    }
    else if(barButton.tag==102+100)
    {
        
    }
}


#pragma mark picker delegate&dataSource
//====================================================
// 函数名称: picker delegate&dataSource
// 函数功能: picker的协议方法
//====================================================
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==pickerForSelectColor) {
        return [productModel.colorlist count];
    }else if (pickerView == pickerForSelectSize) {
        return [self.arrTemSize count];
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 44) ];
    NSString *pickerText=@"";
    UrlImageView *image=[[UrlImageView alloc]init];
    if (pickerView==pickerForSelectColor) {
        pickerText= [[productModel.colorlist objectAtIndex:row] Spec_alias];
        [image setImageWithURL:[NSURL URLWithString:[[productModel.colorlist objectAtIndex:row] ImageUrl]]];
        titleLabel.textAlignment = UITextAlignmentLeft;
    }
    else if (pickerView==pickerForSelectSize){
        
        titleLabel.textAlignment = UITextAlignmentCenter;
        
        pickerText= [[self.arrTemSize objectAtIndex:row] objectForKey:@"spec_alias"];
        
    }
    titleLabel.text = pickerText;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [ UIFont boldSystemFontOfSize:18];;
    titleLabel.opaque = NO;
    
    image.frame=CGRectMake(180, 4, 50, 36);
    UIView *view_image=[[UIView alloc]init];
    view_image.frame=CGRectMake(0, 0, 320, 44);
    [view_image addSubview:image];
    [view_image addSubview:titleLabel];
    return view_image;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView==pickerForSelectColor) {
        currentColor = row;
    }else if (pickerView == pickerForSelectSize) {
        currentSize = row;
    }
}

@end
