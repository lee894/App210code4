//
//  NewBrandDetail20ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/4/24.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "NewBrandDetail20ViewController.h"
#import "UIViewController+MaryPopin.h"
#import "PlayNDropViewController.h"
#import "WeiBoViewController.h"
#import "ProductContentViewController.h"
#import "NewBrandDetailInfo.h"
#import "NewBrandDetailParser.h"
#import "NewTrendViewController.h"
#import "ProductlistViewController.h"

@interface NewBrandDetail20ViewController ()
{
    MainpageServ *mainSev;
    NewBrandDetailInfo *_detailinfo;
    

    UIView *bannerView;

    
    int brandID;
    
    __weak IBOutlet UrlImageButton *fashionBtn;
    __weak IBOutlet UrlImageButton *goodListBtn;
    
    
    __weak IBOutlet UIScrollView *myScrollV;
    
    __weak IBOutlet UIButton *brandStoryBtn;
    __weak IBOutlet UIButton *lookWeiboBtn;
    
    __weak IBOutlet UILabel *weiboNameLab;
    
    NSMutableArray *arrayFull;
    NSMutableArray *arrayPhote;
    NSMutableArray *arrayBrand1;
    
    NSArray *arrayStory;//品牌故事数组
    NSArray *arrayweiboText;//关注微博的文字
    NSArray *arrayWeiboLink;//微博链接
    
}
@end

@implementation NewBrandDetail20ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.title = self.brandname;
    [self createBackBtnWithType:0];
    
    brandID = 0;
    
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [mainSev getBrandDetail20:self.brandname];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

    
    [self hiddenFooterwithAnimated:YES];
    
    [myScrollV setFrame:self.view.frame];
    myScrollV.delegate = self;
    [myScrollV setContentSize:CGSizeMake(0, 650)];
    [myScrollV setHidden:YES];
    
    [self initbasedata];
}


#pragma mark-- service
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    _detailinfo = [[NewBrandDetailParser alloc] parseBrandDetailInfo:amodel];
    
    [self createBannerView];
    [myScrollV addSubview:bannerView];
    
    
    brandID = [_detailinfo.atype intValue];
    
    NSString *imga = [NSString stringWithFormat:@"brand_%@_s.png",_detailinfo.atype];
    [brandStoryBtn setImage:[UIImage imageNamed:imga] forState:UIControlStateNormal];
    
    //设置标题
    [self setTitle: _detailinfo.alias];
    
    [weiboNameLab setText:[NSString stringWithFormat:@"关注%@",_detailinfo.alias]];

    
    if ([[arrayWeiboLink objectAtIndex:brandID] description].length > 1) {
        [lookWeiboBtn setImage:[UIImage imageNamed:@"px_xl_.png"] forState:UIControlStateNormal];
    }else{
        [lookWeiboBtn setImage:[UIImage imageNamed:@"px_xl_no.png"] forState:UIControlStateNormal];
        lookWeiboBtn.enabled = YES;
    }
    
    [fashionBtn setImageFromUrl:NO withUrl:_detailinfo.brand_trend.pic];
    [goodListBtn setImageFromUrl:NO withUrl:_detailinfo.brand_zixun.pic];
    
    [myScrollV setHidden:NO];
    
    [SBPublicAlert hideMBprogressHUD:self.view];
}



#pragma mark--- banner
-(void)createBannerView{

    //banner---------------
    if (!bannerView) {
        bannerView = [[UIView alloc] initWithFrame:CGRectMake(14, 85, ScreenWidth-28, 220)];
    }
    for (UIView *view in bannerView.subviews) {
        [view removeFromSuperview];
    }
    int length = _detailinfo.home_banner.count;
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
    if (length > 1)
    {
        NewhomeNormalData *bannerModel = [_detailinfo.home_banner objectAtIndex:length-1 isArray:nil];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:bannerModel.title image:bannerModel.pic tag:length-1];
        [itemArray addObject:item];
    }
    for (int i = 0; i < length; i++)
    {
        NewhomeNormalData *bannerModel = [_detailinfo.home_banner objectAtIndex:i isArray:nil];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:bannerModel.title image:bannerModel.pic tag:i+132];
        [itemArray addObject:item];
        
    }
    //添加第一张图 用于循环
    if (length >1)
    {
        NewhomeNormalData *bannerModel = [_detailinfo.home_banner  objectAtIndex:0 isArray:nil];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithTitle:bannerModel.title image:bannerModel.pic tag:132];
        [itemArray addObject:item];
    }
    
    SGFocusImageFrame *banner = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 28,bannerView.frame.size.height) delegate:self imageItems:itemArray isAuto:YES];
    [bannerView addSubview:banner];

    [myScrollV addSubview:bannerView];
    
}



#pragma mark--- Action

- (IBAction)brandStoryAction:(id)sender {
    
    
    PlayNDropViewController *popin = [[PlayNDropViewController alloc] init];
    popin.view.bounds = CGRectMake(20, 0, ScreenWidth -40, 310);
    popin.view.backgroundColor = [UIColor whiteColor];
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleSnap];
    //[popin setPopinOptions:BKTPopinDisableAutoDismiss];
    BKTBlurParameters *blurParameters = [[BKTBlurParameters alloc] init];
    //blurParameters.alpha = 0.5;
    blurParameters.tintColor = [UIColor colorWithWhite:0 alpha:0.5];
    blurParameters.radius = 0.3;
    [popin setBlurParameters:blurParameters];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    //popin.presentingController = self;
    
    CGFloat width = CGRectGetWidth(popin.view.frame);
    CGFloat height = CGRectGetHeight(popin.view.frame);
    
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 4, 260, 30)];
    [titleLab setNumberOfLines:2];
    [titleLab setTextAlignment:NSTextAlignmentCenter];
    titleLab.font = [UIFont systemFontOfSize:LabMidSize];
    [titleLab setTextColor:[UIColor colorWithHexString:@"#FF2A1A"]];
    [popin.view addSubview:titleLab];
    [titleLab setText:@"品牌故事"];
    
    UITextView *textContent = [[UITextView alloc] initWithFrame:CGRectMake(30, 30, width -30, height - 40)];
    textContent.text = [arrayStory objectAtIndex:brandID isArray:nil];
    textContent.font = [UIFont systemFontOfSize:LabSmallSize];
    [textContent setBackgroundColor:[UIColor whiteColor]];
    textContent.editable  = NO;
    [popin.view addSubview:textContent];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textContent.attributedText = [[NSAttributedString alloc] initWithString:[arrayStory objectAtIndex:brandID] attributes:attributes];
    
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *unSelectedImg = [UIImage imageNamed:@"closeBtn.png"];
    UIImage *selectedImg = [UIImage imageNamed:@"closeBtn.png"];
    [photoBtn setBackgroundImage:unSelectedImg forState:UIControlStateNormal];
    [photoBtn setBackgroundImage:selectedImg forState:UIControlStateHighlighted];
    [photoBtn addTarget:self action:@selector(closePresentView) forControlEvents:UIControlEventTouchUpInside];
    photoBtn.frame = CGRectMake(270, 10, 20, 20);
    [popin.view addSubview:photoBtn];
    
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}




-(void) closePresentView{
    [self dismissCurrentPopinControllerAnimated:YES];
}

- (IBAction)weiBoAction:(id)sender {
    
    
    if ([[arrayWeiboLink objectAtIndex:brandID] description].length > 1) {

    WeiBoViewController *tempWeibo = [[WeiBoViewController alloc] initWithNibName:@"WeiBoViewController" bundle:nil];
    tempWeibo.weiboUrl = [arrayWeiboLink objectAtIndex:brandID isArray:nil];
    [self.navigationController pushViewController:tempWeibo animated:YES];
        
    }
}



//潮流新品
- (IBAction)fashionGoods:(id)sender {
    
//    BrandsWall *wallArray = [arraywall objectAtIndex:brandID];
    NewTrendViewController *tempVCon = [[NewTrendViewController alloc] initWithNibName:@"NewTrendViewController" bundle:nil];
    tempVCon.brandName = _detailinfo.brand_trend.brand_name;//wallArray.name;
    tempVCon.arrayImg = arrayPhote;
    tempVCon.index = [_detailinfo.atype intValue];//0;//brandID;//pageControl.currentPage;
    [self.navigationController pushViewController:tempVCon animated:YES];
    
}

//产品类目
- (IBAction)goodlistAction:(id)sender {

    ProductlistViewController *hotVC = [[ProductlistViewController alloc] init];
    [SingletonState sharedStateInstance].productlistType = 0;
    hotVC.titleName = _detailinfo.alias;
    hotVC.params = _detailinfo.brand_zixun.params;
    hotVC.isHiddenFilerbtn = NO;
    [self.navigationController pushViewController:hotVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initbasedata{
    arrayPhote = [NSMutableArray array];
    
    arrayBrand1 = [NSMutableArray array];
    for (int i = 1; i<=14; i++) {
        if (i >= 10) {
            [arrayBrand1 addObject:[NSString stringWithFormat:@"brand_%d_pic_02.png",i]];
        }else {
            [arrayBrand1 addObject:[NSString stringWithFormat:@"brand_0%d_pic_02.png",i]];
        }
    }
    /*
     1，爱慕
     2，爱慕先生
     3，爱慕儿童
     4，兰卡文
     5，BECHIC
     6，慕澜
     7，爱美丽
     8，心爱
     9，宝迪威德
     10，皇锦
     11，爱慕家居
     12，爱慕运动
     13，爱慕一家人
     14，爱慕定制
     */
    
    
    arrayFull = [NSMutableArray array];
    
    arrayStory = [NSArray arrayWithObjects:
                  @"",  //index 是从1开始的
                  
                  @"Aimer 爱慕，诞生于1993年中国北京。\n  22年来，她秉承“爱”与“美”的品牌理念，融科技于时尚，追求融合东西方文化的美学设计，为都市女性提供精致、时尚、优雅的产品和体验，展现万千姿彩的女性魅力，帮助女性做最好的自己、最美的自己。\n  今天的爱慕是中国原创内衣品牌的领导者，是中国女性喜爱的首选内衣品牌，是女性高级内衣服饰的代名词。",
                  
                  @"Aimer Men 爱慕先生，爱慕集团旗下高端男士内衣品牌，诞生于2005年。\n  爱慕先生致力于为都市精英男士提供舒适、时尚、高品质的内衣服饰。爱慕先生秉承品质、品位的设计理念，追求科技与时尚的融合，经典与创意的统一。\n  爱慕先生，品质内衣，品位生活。",
                  
                  @"Aimer kids，诞生于2009年，是爱慕集团旗下的儿童内衣品牌，专为0-16岁孩子提供专业、纯净、时尚的内衣和家居服饰。\n  Aimer kids，追求纯净自然的风格、天然环保的材质、时尚有趣的设计、安全细致的工艺。\n  Aimer kids，倡导健康内衣生活新理念，提供让家长放心、孩子乐享的好内衣。" ,
                  
                  @"LA CLOVER兰卡文，诞生于2004年，她是爱慕集团倾力打造的梦想之作。\n  她奢华、性感，她与众不同；她独具匠心的设计，考究的工艺，高级的面料，兼容的版型成就贴身艺术品。她致力于将意大利风情与东方美学完美的融合，表达成功女性神秘、优雅和高贵的气质。拥有了LA CLOVER，你就拥有了幸福。" ,
                  
                  @"BECHIC，爱慕集团旗下的高端时尚内衣会所，汇聚了来自法国、意大利等10余个国际顶级内衣、泳衣、家居服等品牌。\n  BECHIC，传播欧式时尚潮流文化，为追求国际生活品质的高端消费者提供一站式的购物享受。\n  BECHIC，中国消费者的“别致品位，国际格调",
                  
                  @"MODELAB慕澜，诞生于2010年，爱慕集团旗下专业美体内衣品牌，是集团专注内衣事业二十载的经典传承。慕澜，\n  依托爱慕独一无二的人体工学研究机构，坚持舒适、健康、时尚兼容的设计理念，为成熟女性消费者提供内衣美体解决方案。\n  慕澜，首创“软塑”美体新理念，致力于让顾客感知并享受身体变化的美好过程。慕澜，逆龄时光魅力永驻。",
                  
                  @"imi's 爱美丽，爱慕集团旗下最具活力的青春时尚品牌，诞生于2005年。\n  爱美丽是都市的、快乐的、活力的、青春的，她是一种永远年轻向上的精神。\n  爱美丽始终走在潮流前沿，追求简约、甜美、小性感的设计风格，提供多姿多彩、乐趣轻松的购物新体验。",
                  
                  @"Shine love 心爱，诞生于2010年，爱慕集团旗下网络专享品牌，是“创造美、传递爱”企业使命的网络无线延伸。\n  心爱，传播正能量的内衣服饰理念，快速提供充满魅力、性感、浪漫的内衣及时尚服饰。心爱，用心生活，用爱照亮人生。",
                  
                  @"BODY WILD宝迪威德，日本百年企业郡是株式会社旗下年轻男士内衣品牌，2011年联手爱慕集团进驻中国市场。\n  宝迪威德，提供多彩、科技、物超所值的产品，准确定位于年轻时尚的都市男性，个性鲜明的宝迪威德品牌必将使男士更加自信、现代，勇敢秀出属于自己的内衣风潮。",
                  
                  @"皇锦，源自中华文化五千年灵感。皇锦，\n  创立于1999年，致力于传承与复兴中国皇家丝绸文化，用最优良的材质和最精湛的手工艺，创造出经得起时间考验的具有卓越品质的完美产品。皇锦，饱含着中国五千年文化的积累，通过传承与创新，与时代对话，与未来接轨，这就是皇锦品牌的核心价值。皇锦，连接传统与现代、东方与西方、人与自然，是中国式优雅生活方式的诠释者、实践者与传播者。皇锦，皇家风范，锦绣相传。",
                  
                  @"Aimer home爱慕家居，爱慕品牌旗下高端时尚家居产品线。\n  爱慕家居，将精致的品质追求渗透到家居生活的每一个细节，是对时尚都市家庭生活的崭新诠释。",
                  
                  @"Aimer sports爱慕运动，爱慕集团旗下专业运动产品线。\n  Aimer sports为崇尚运动健康生活方式的你，提供时尚、专业的运动服饰及配件，让生活更美，更愉悦，更健康。",
                  
                  @"中文：爱慕一家人\n创立时间：2012\n定位：爱慕一家人是爱慕集团旗下内衣生活方式体验店，是适应购物中心业态和百货店经营购物中心化的全新渠道模式，提供全家人、一站式内衣服饰购物解决方案。\n爱慕一家人，营造家一样的愉悦、轻松、舒适的购物环境和氛围，致力于为顾客提供周到、专业、贴心的消费体验。\n爱慕一家人，爱慕消费者的温馨之家。",
                  
                  @"“爱慕定制”是爱慕独创的内衣定制技术，专业致力于女性内衣产品的个性化量身定制服务。\n利用专利测量技术确定位乳形态和体型特征，从数千版型中甄选出最适合的专属号型，并潜心研发乳腺术后女性内衣产品；秉承“健康、舒适、专业”的服务理念，让顾客在身心放松、愉悦的状态下尽情享受一对一的专业顾问式体验。",
                  
                  nil];
    
    arrayweiboText = [NSArray arrayWithObjects:
                      @"",  //index 是从1开始的
                      @"关注爱慕",
                      @"关注爱慕先生",
                      @"关注爱慕儿童",
                      @"关注兰卡文",
                      @"暂未开通",
                      @"关注慕澜",
                      @"关注爱美丽",
                      @"关注心爱",
                      @"关注宝迪威徳",
                      @"关注皇锦",
                      @"暂未开通",
                      @"暂未开通",
                      @"暂未开通",
                      @"暂未开通",

                      nil];
    
    arrayWeiboLink = [NSArray arrayWithObjects:
                      @"",  //index 是从1开始的
                      @"http://e.weibo.com/aimer",
                      @"http://e.weibo.com/bjaimermen",
                      @"http://e.weibo.com/aimerkidsonline",
                      @"http://e.weibo.com/laclovergroup",
                      @"",
                      @"http://e.weibo.com/MODELABBYAIMER",
                      @"http://e.weibo.com/imisgirl",
                      @"http://e.weibo.com/shinelovexinai",
                      @"http://weibo.com/u/2044976861",
                      @"http://e.weibo.com/homesilk",
                      @"",
                      @"",
                      @"",
                      @"",

                      nil];
    
    
    //爱慕定制   http://weibo.com/u/1828520181
}


#pragma mark---banner 事件
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(UITapGestureRecognizer*)item{
    
    NewhomeNormalData *bannerModel = (NewhomeNormalData *)[_detailinfo.home_banner objectAtIndex:[item.view tag]-132];
    
    //lee999埋点
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[bannerModel type_argu], @"TopicID", [bannerModel title], @"ActivityName",nil];
    [TalkingData trackEvent:@"1001" label:@"横屏首页轮播" parameters:dic];
    NSLog(@"banner跳转类型是：-----%d",[[bannerModel atype] intValue]);
    
    [self.navigationController pushViewController:[LBaseViewController bannerJumpTo:[[bannerModel atype] intValue]
                                                                       withtypeArgu:[bannerModel type_argu]
                                                                          withTitle:[bannerModel title]
                                                                         andIsRight:NO
                                                   ] animated:YES];
    
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
