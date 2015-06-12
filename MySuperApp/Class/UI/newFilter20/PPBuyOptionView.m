////
////  PPBuyOptionView.m
////  qqbuy
////
////  Created by Henry Tse on 13-8-8.
////  Copyright (c) 2013年 tencent. All rights reserved.
////
//
//#import "PPBuyOptionView.h"
////#import "SVProgressHUD.h"
//
////#import "PPProductDetailInfo.h"
//#import "Util.h"
////#import "ImgUtil.h"
////#import "PPStockCountCalculator.h"
////#import "PPVipPriceCalculator.h"
//
//
//@interface PPBuyOptionView ()<UIScrollViewDelegate>
//
//@property (nonatomic, retain) UIScrollView *scrollView;
//
//@property (nonatomic, retain) NSMutableDictionary *attributesButtonMap;
//@property (nonatomic, retain) NSMutableDictionary *attrMap;
//@property (nonatomic, retain) NSMutableArray *attrOrder;
//@property (nonatomic, retain) NSMutableDictionary *currentSalesAttrStates;
//@property (nonatomic, assign) CGFloat totalHeight;
//@property (nonatomic, assign) long minStockPrice;
//@property (nonatomic, assign) long maxStockPrice;
//@property (nonatomic, assign) long minActivityPrice;
//@property (nonatomic, assign) long maxActivityPrice;
//
//@end
//
//@implementation PPBuyOptionView
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    
//    if (self)
//    {
//        
//    }
//    
//    return self;
//}
//
////- (void)dealloc
////{
////    [_spu release];
////    [_selectedAttrOrders release];
////    [_regionId release];
////    [_regionName release];
////    [_selectedRegionLabel release];
////    
////    _numberTextField.delegate = nil;
////    [_numberTextField release];
////    [_shipInfoLabel release];
////    [_currentStock release];
////    
////    _scrollView.delegate = nil;
////    [_scrollView release];
////    
////    [_attributesButtonMap release];
////    [_attrMap release];
////    [_attrOrder release];
////    [_currentSalesAttrStates release];
////    [_priceLabel release];
////    [_stockCountLabel release];
////    
////    [super dealloc];
////}
//
//- (void)drawRect:(CGRect)rect
//{
//    for (UIView *sub in self.subviews) {
//        [sub removeFromSuperview];
//    }
//    
//    if (!self.currentSalesAttrStates)
//    {
//        _currentSalesAttrStates = [[NSMutableDictionary alloc] init];
//    }
//    
//
//    [self drawSalesAttribute:CGPointMake(0, 0)];
//}
//
//- (void)drawUI
//{
//    _totalHeight = 100;
//    
//    [self drawSalesAttribute:CGPointMake(0, 100 + 10)];
//    
//    UILabel *numberTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _totalHeight + 10, 45, 20)];
//    [numberTitleLabel setBackgroundColor:[UIColor clearColor]];
//    [numberTitleLabel setTextColor:[UIColor blackColor]];
//    [numberTitleLabel setTextAlignment:NSTextAlignmentLeft];
//    [numberTitleLabel setFont:[UIFont systemFontOfSize:15.0]];
//    [numberTitleLabel setText:@"数量:"];
//    [self addSubview:numberTitleLabel];
//    
////    [self drawNumberView:CGPointMake(78, numberTitleLabel.frame.origin.y)];
//    
//    UILabel *priceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberTitleLabel.frame.origin.x, numberTitleLabel.frame.size.height + numberTitleLabel.frame.origin.y + 18, numberTitleLabel.frame.size.width, numberTitleLabel.frame.size.height)];
//    [priceTitleLabel setBackgroundColor:[UIColor clearColor]];
//    [priceTitleLabel setTextColor:[UIColor blackColor]];
//    [priceTitleLabel setTextAlignment:NSTextAlignmentLeft];
//    [priceTitleLabel setFont:[UIFont systemFontOfSize:15.0]];
//    [priceTitleLabel setText:@"单价:"];
//    [self addSubview:priceTitleLabel];
//    
////    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, priceTitleLabel.frame.origin.y, 200, 20)];
////    [_priceLabel setBackgroundColor:[UIColor clearColor]];
////    [_priceLabel setTextColor:[UIColor redColor]];
////    [_priceLabel setTextAlignment:UITextAlignmentLeft];
////    [_priceLabel setFont:[UIFont systemFontOfSize:15.0]];
//    NSString *price = nil;
//    if (_currentStock == nil)
//    {
//        if (_spu.activityPrice == 0)
//        {
//            price = _minStockPrice == _maxStockPrice ? [NSString stringWithFormat:@"￥%@", [Util fen2yuan:_minStockPrice]] : [NSString stringWithFormat:@"￥%@ - ￥%@", [Util fen2yuan:_minStockPrice], [Util fen2yuan:_maxStockPrice]];
//        }
//        else
//        {
//            price = _minActivityPrice == _maxActivityPrice ? [NSString stringWithFormat:@"￥%@", [Util fen2yuan:_minActivityPrice]] : [NSString stringWithFormat:@"￥%@ - ￥%@", [Util fen2yuan:_minActivityPrice], [Util fen2yuan:_maxActivityPrice]];
//        }
//    }
//    else
//    {
//        price = [NSString stringWithFormat:@"￥%@", [Util fen2yuan:[self minPrice]]];
//    }
//    [_priceLabel setText:price];
//    [self addSubview:_priceLabel];
//    
//    _totalHeight = priceTitleLabel.frame.size.height + priceTitleLabel.frame.origin.y + 10;
//    
////    [sourceLocationTitleLabel release];
////    [sourceLocationLabel release];
////    [deliveryTitleLabel release];
////    [selectRegionButton release];
////    [numberTitleLabel release];
////    [priceTitleLabel release];
//}
//
//- (void)drawSalesAttribute:(CGPoint)originPoint
//{
//    [self extractAttributeMap];
//    
////    NSInteger spaceAndBtnHeigth = 45;
////    NSInteger rowIndex = 0;
//    float totalHeight = 20;
//    UIScrollView *view = [[UIScrollView alloc] init];
//    [view setTag:723897923];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    [view setShowsVerticalScrollIndicator:NO];
//    NSMutableArray* arrNeedSelectButton = [[NSMutableArray alloc] initWithCapacity:1];
//    // 放btn的map
//    if (_attributesButtonMap == nil)
//    {
//        self.attributesButtonMap = [[NSMutableDictionary alloc] initWithCapacity:2];
//    }
//    
//    if (self.attrMap)
//    {
//        // 遍历所有key
//        for (NSString *key in self.attrOrder)
//        {
//            //显示key的label
//            UILabel *keyLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, totalHeight, 300, 12)];
//            keyLbl.font = [UIFont systemFontOfSize:11.0];
//            keyLbl.textColor = [UIColor colorWithHexString:@"#7f735a"];
//            keyLbl.text = [NSString stringWithFormat:@"请选择%@:", key];
//            keyLbl.backgroundColor = [UIColor clearColor];
//            [view addSubview:keyLbl];
//            
//            totalHeight += 21.5;
//            //根据key得到对应的value组,生成button
////            NSArray *attrValueArray = [_attrMap objectForKey:key];
//            NSMutableArray *attrBtnArray = [[NSMutableArray alloc] initWithCapacity:3];
//            NSInteger coloum = 0;                           //用来标记当前行的个数
//            NSInteger longColoum = 0;
//            BOOL hasLongAttr = NO;
//            NSArray* attrValueArray = [[_attrMap objectForKey:key] sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id obj1, id obj2) {
////                return [((NSString*)obj1) sizeWithFont:[UIFont systemFontOfSize:11]].width > [((NSString*)obj2) sizeWithFont:[UIFont systemFontOfSize:11]].width;
//                //chark fixed, 2015/02/27
//
//                return [Common sizeForString:((NSString*)obj1) withFont:[UIFont systemFontOfSize:11]].width > [Common sizeForString:((NSString*)obj2) withFont:[UIFont systemFontOfSize:11]].width;
//
//            }];
//            for (int i = 0; i < [attrValueArray count]; i++)
//            {
//                NSString *attr = [attrValueArray objectAtIndex:i];
//                UIFont *titleFont = [UIFont systemFontOfSize:14];
//                UIButton *attrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                
//                // 一行显示不下
//                //chark fixed, 2015/02/27
////                if ([attr sizeWithFont:titleFont].width > [Common sizeForString:@"国国国国" withFont:titleFont].width)
//                if ([Common sizeForString:attr withFont:titleFont].width > [Common sizeForString:@"国国国国" withFont:titleFont].width)
//
//                {
//                    // 设置numOfRow=4 使得下一行换行 套装
//                    hasLongAttr = YES;
//                    coloum = 4;
//                    ++longColoum;
//                    // 如果不是第一个，就增加一行
//                    //chark fixed, 2015/02/27
////                    if ([attr sizeWithFont:titleFont].width > [@"国国国国国国国国" sizeWithFont:titleFont].width)
//                    if ([Common sizeForString:attr withFont:titleFont].width > [Common sizeForString:@"国国国国国国国国" withFont:titleFont].width)
//
//                    {
//                        longColoum = 0;
//                        attrBtn.frame = CGRectMake(20, totalHeight, 180, 30);
//                    }else
//                    {
//                        if (longColoum == 1) {
//                            attrBtn.frame = CGRectMake(20, totalHeight, 135, 30);
//                        }else
//                        {
//                            attrBtn.frame = CGRectMake(20 + 145, totalHeight, 135, 30);
//                            longColoum = 0;
//                        }
//                    }
//                    if (longColoum == 0)
//                    {
//                        //                        rowIndex++;
//                        totalHeight += 40;
//                    }else
//                    {
//                        if (i + 1 < [attrValueArray count]) {
////                            if ([[attrValueArray objectAtIndex:i + 1] sizeWithFont:titleFont].width > [@"国国国国国国国国" sizeWithFont:titleFont].width)
//                            if ([Common sizeForString:[attrValueArray objectAtIndex:i + 1] withFont:titleFont].width > [Common sizeForString:@"国国国国国国国国" withFont:titleFont].width)
//
//                            {
//                                totalHeight += 40;
//                            }
//                        }
//
//                    }
//                }
//                // 增加行数
//                else if (coloum == 4 && i != 0)
//                {
////                    rowIndex++;
//                    totalHeight += 40;
//                    coloum = 0;
//                    attrBtn.frame = CGRectMake(20 + coloum * 72.5, totalHeight, 62.5, 30);
//                    coloum++;
//                }
//                // 正常的三个一行
//                else
//                {
//                    attrBtn.frame = CGRectMake(20 + coloum * 72.5, totalHeight, 62.5, 30);
//                    coloum++;
//                    if (i + 1 < [attrValueArray count]) {
////                        if ([[attrValueArray objectAtIndex:i + 1] sizeWithFont:titleFont].width > [@"国国国国" sizeWithFont:titleFont].width)
//                        if ([Common sizeForString:[attrValueArray objectAtIndex:i + 1] withFont:titleFont].width > [Common sizeForString:@"国国国国" withFont:titleFont].width)
//
//                        {
//                            totalHeight += 40;
//                        }
//                    }
//                }
//                
//                // 每个attr一个按钮
////                [self setBtnUnSelected:attrBtn];
//                [attrBtn setSelected:NO];
//                [attrBtn addTarget:self action:@selector(onAttrBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//                [attrBtn setTitle:attr forState:UIControlStateNormal];
//                [attrBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//                [attrBtn setTitleColor:HEXCOLOR(0x463417) forState:UIControlStateNormal];
//                attrBtn.titleLabel.font = [UIFont systemFontOfSize:11.0];
//                [attrBtn setBackgroundImage:[[UIImage imageNamed:@"salesattrNormal"] stretchableImageWithLeftCapWidth:5 topCapHeight:20] forState:UIControlStateNormal];
//                [attrBtn setBackgroundImage:[[UIImage imageNamed:@"salesattrSelected"] stretchableImageWithLeftCapWidth:5 topCapHeight:20] forState:UIControlStateSelected];
//                [attrBtn setBackgroundImage:[[UIImage imageNamed:@"salesattrSelected"] stretchableImageWithLeftCapWidth:5 topCapHeight:20] forState:UIControlStateHighlighted];
//                int nStockCount = 0;
//                for (PPProductDetailItemStockBo* stockBO in _spu.itemStockBo) {
//                    if (stockBO) {
//                        if ([stockBO.stockAttr rangeOfString:[NSString stringWithFormat:@"%@:%@", key, attr]].location != NSNotFound) {
//                            nStockCount += stockBO.stockCount;
//                        }
//                    }
//                }
//                if (nStockCount == 0) {
//                    [attrBtn setEnabled:NO];
//                    [attrBtn setTitleColor:HEXCOLOR(0xe7e4de) forState:UIControlStateNormal];
//                    attrBtn.tag = 92653;
//                }
//                
//                //假如是已经选中的话，就点亮，默认为不点亮
//                for (int keyIndex = 0; keyIndex < [[self.currentSalesAttrStates allKeys] count]; keyIndex++)
//                {
//                    id pressedButton = [self.currentSalesAttrStates objectForKey:[self.attrOrder objectAtIndex:keyIndex]];
//                    if (pressedButton != [NSNull null] && [((UIButton *)pressedButton).titleLabel.text isEqualToString:attr])
//                    {
////                        [self setBtnSelected:attrBtn];
//                        [attrBtn setSelected:YES];
//                    }
//                }
//                
//                [view addSubview:attrBtn];
//                // btn放入列表里面
//                [attrBtnArray addObject:attrBtn];
//            }
//            
//            //假如attrBtn只有一个,就默认选中 new feature
//            if ([attrBtnArray count] == 1)
//            {
//                UIButton *defaultButton = (UIButton *)[attrBtnArray objectAtIndex:0];
////                [self setBtnSelected:defaultButton];
//                [arrNeedSelectButton addObject:defaultButton];
//                
//            }
//            
//            // 放入map里
//            [_attributesButtonMap setValue:attrBtnArray forKey:key];
////            rowIndex++;
//            if (longColoum == 0 && hasLongAttr) {
//                totalHeight -= 30;
//            }
//            totalHeight += 50;
//        }
//    }
//    //根据当前选中的属性值，更新选中对应的btn以及商品属性值，
//    //假如是第一次进入页面，就默认选中广东
//    //从其它页面进来传入相应的商品属性
//    //    [self setCurrentStockPoWith:_stockAttrInDeal];
//    
//    view.frame = CGRectMake(originPoint.x, originPoint.y, 320, totalHeight > 268.5 ? 268.5 : totalHeight);
//    view.contentSize = CGSizeMake(320, totalHeight + 10);
//    
//    _totalHeight += view.contentSize.height;
//    [self addSubview:view];
//    
//    for (UIButton* btn in arrNeedSelectButton) {
//        [self onAttrBtnClick:btn];
//    }
//    if (totalHeight > 50) {
//        if (self.titleLabel) {
//            if ([self validateSelectionCompletion].length > 0) {
//                [self.titleLabel setText:[NSString stringWithFormat:@"请选择%@", [self validateSelectionCompletion]]];
//                [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#d2c9b6"]];
//            }else
//            {
//                [self.titleLabel setText:[NSString stringWithFormat:@"已选择%@", [self completedSelection]]];
//                [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#463417"]];
//            }
//        }
//    }
//}
//
////- (void)drawNumberView:(CGPoint)originPoint
////{
////    UIButton *minusButton = [[UIButton alloc] initWithFrame:CGRectMake(originPoint.x, originPoint.y, 31, 26)];
////    [minusButton setBackgroundColor:[UIColor clearColor]];
////    [minusButton setImage:[UIImage imageNamed:@"minusbutton"] forState:UIControlStateNormal];
////    [minusButton setImage:[UIImage imageNamed:@"minusbutton"] forState:UIControlStateHighlighted];
////    [minusButton setTag:1];
////    [minusButton addTarget:self action:@selector(numberButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
////    [self addSubview:minusButton];
////    
////    _numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(minusButton.frame.origin.x + minusButton.frame.size.width, originPoint.y, 50, 26)];
////    [_numberTextField setDelegate:_delegate];
////    [_numberTextField setBackground:[UIImage imageNamed:@"salesattrnormal"]];
////    [_numberTextField setTextColor:[UIColor blackColor]];
////    [_numberTextField setTextAlignment:UITextAlignmentCenter];
////    [_numberTextField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
////    [_numberTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
////    [_numberTextField setFont:[UIFont systemFontOfSize:14.0]];
////    [_numberTextField setText:[NSString stringWithFormat:@"%d", self.buyCount]];
////    [_numberTextField setKeyboardType:UIKeyboardTypeNumberPad];
////    [_numberTextField setReturnKeyType:UIReturnKeyDone];
////    [self addSubview:_numberTextField];
////    
////    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(_numberTextField.frame.origin.x + _numberTextField.frame.size.width, originPoint.y, 31, 26)];
////    [addButton setBackgroundColor:[UIColor clearColor]];
////    [addButton setImage:[UIImage imageNamed:@"addbutton"] forState:UIControlStateNormal];
////    [addButton setImage:[UIImage imageNamed:@"addbutton"] forState:UIControlStateHighlighted];
////    [addButton setTag:2];
////    [addButton addTarget:self action:@selector(numberButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
////    [self addSubview:addButton];
////    
////    _stockCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(addButton.frame.origin.x + addButton.frame.size.width + 10, addButton.frame.origin.y, 100, addButton.frame.size.height)];
////    [_stockCountLabel setBackgroundColor:[UIColor clearColor]];
////    [_stockCountLabel setTextColor:[UIColor blackColor]];
////    [_stockCountLabel setTextAlignment:UITextAlignmentLeft];
////    [_stockCountLabel setFont:[UIFont systemFontOfSize:12.0f]];
//////    [_stockCountLabel setText:[NSString stringWithFormat:@"剩余%d件", [[PPStockCountCalculator sharedCalculator] remainingCount:_selectedAttrOrders inSpu:_spu]]];
////    CGSize textSize = [_stockCountLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(200, addButton.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
////    [_stockCountLabel setFrame:CGRectMake(_stockCountLabel.frame.origin.x, _stockCountLabel.frame.origin.y, textSize.width, _stockCountLabel.frame.size.height)];
////    [self addSubview:_stockCountLabel];
////    
////    if (_spu.buyLimit > 0)
////    {
////        UILabel *buyLimitLabel = [[UILabel alloc] initWithFrame:CGRectMake(_stockCountLabel.frame.origin.x + _stockCountLabel.frame.size.width + 5, _stockCountLabel.frame.origin.y, 100, addButton.frame.size.height)];
////        [buyLimitLabel setBackgroundColor:[UIColor clearColor]];
////        [buyLimitLabel setTextColor:[UIColor redColor]];
////        [buyLimitLabel setTextAlignment:UITextAlignmentLeft];
////        [buyLimitLabel setFont:[UIFont systemFontOfSize:12.0f]];
////        [buyLimitLabel setText:[NSString stringWithFormat:@"限购%d件", _spu.buyLimit]];
////        [self addSubview:buyLimitLabel];
////    }
////}
//
//#pragma mark - Other
//
//- (NSString *)getFromSite:(NSString *)cityId provinceId:(NSString *)provinceId
//{
//    if (!self.spu)
//    {
//        return nil;
//    }
//    
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *regionPath = [bundle pathForResource:@"region" ofType:@"txt"];
//    NSDictionary *regionDict = [[NSDictionary alloc] initWithContentsOfFile:regionPath];
//    NSArray *provIdArray = [regionDict objectForKey:@"provinces"];
//    
//    BOOL found = NO;
//    NSMutableString *sourcePathString = [NSMutableString string];
//    NSString *provincName = nil;
//    NSString *cityName = nil;
//    for (NSDictionary *provinceDic in provIdArray)
//    {
//        NSArray *cities = [provinceDic objectForKey:@"citys"];
//        for (NSDictionary *cityDic in cities)
//        {
//            NSArray *areas = [cityDic objectForKey:@"areas"];
//            for (NSDictionary *area in areas)
//            {
//                if ([[area objectForKey:@"areaId"] isEqualToString:cityId])
//                {
//                    cityName = [cityDic objectForKey:@"cityName"];
//                    provincName = [provinceDic objectForKey:@"provName"];
//                    found = YES;
//                }
//            }
//            
//            if ([[cityDic objectForKey:@"cityId"] isEqualToString:cityId])
//            {
//                cityName = [cityDic objectForKey:@"cityName"];
//                provincName = [provinceDic objectForKey:@"provName"];
//                found = YES;
//            }
//        }
//        
//        if ([[provinceDic objectForKey:@"provId"] isEqualToString:cityId])
//        {
//            provincName = [provinceDic objectForKey:@"provName"];
//            found = YES;
//        }
//        
//        if (found)
//        {
//            break;
//        }
//    }
//    
//    if (found)
//    {
//        if (cityName == nil || [cityName hasPrefix:provincName])
//        {
//            [sourcePathString appendString:provincName];
//        }
//        else
//        {
//            [sourcePathString appendFormat:@"%@ %@", provincName, cityName];
//        }
//    }
//    else
//    {
//        [sourcePathString appendString:@"卖家未填写"];
//    }
//    return sourcePathString;
//}
//
//- (void)extractAttributeMap
//{
//    NSMutableDictionary *attrDic = [[NSMutableDictionary alloc] init];
//    NSMutableArray *attOrder = [[NSMutableArray alloc] init];
//    BOOL isNoAttr = YES;
//    
//    _minStockPrice = LONG_MAX;
//    _maxStockPrice = 0;
//    
//    _minActivityPrice = LONG_MAX;
//    _maxActivityPrice = 0;
//    
//    for (PPProductDetailItemStockBo *stock in self.spu.itemStockBo)
////    for (PPStockPo *stock in [self.spu stockList])
//    {
//        //假如stockAttr为空字符串，则表示没有销售属性，无需生成对应按钮
//        if (![stock.stockAttr isEqualToString:@""])
//        {
//            _minStockPrice = _minStockPrice > stock.stockPrice ? stock.resultPrice : _minStockPrice;
//            _maxStockPrice = _maxStockPrice < stock.resultPrice ? stock.resultPrice : _maxStockPrice;
//            _minActivityPrice = _minActivityPrice > stock.activityPrice ? stock.activityPrice : _minActivityPrice;
//            _maxActivityPrice = _maxActivityPrice < stock.activityPrice ? stock.activityPrice : _maxActivityPrice;
//            
//            //提取销售属性的键值
//            isNoAttr = NO;
//            NSArray *attrArray = [[stock stockAttr] componentsSeparatedByString:@"|"];
//            for (NSString *attrString in attrArray)
//            {
//                
//                NSArray *attrPair = [attrString componentsSeparatedByString:@":"];
//                NSString *key = [attrPair objectAtIndex:0];
//                NSString *value = [attrPair objectAtIndex:1];
//                
//                //记录stockAttr的key的顺序，方便之后对照
//                if (![attOrder containsObject:key])
//                {
//                    [attOrder addObject:key];
//                    //初始化整个字典，里面还没包含任何button
//                    [self.currentSalesAttrStates setObject:[NSNull null] forKey:key];
//                }
//                
//                if (![[attrDic allKeys] containsObject:key])
//                {
//                    NSMutableArray *valueArray = [[NSMutableArray alloc] init];
//                    [valueArray addObject:value];
//                    [attrDic setObject:valueArray forKey:key];
//                }
//                else
//                {
//                    NSMutableArray *valueArray = [attrDic objectForKey:key];
//                    if (![valueArray containsObject:value])
//                    {
//                        [valueArray addObject:value];
//                    }
//                }
//            }
//        }
//        else
//        {
//            _minStockPrice = _minStockPrice > stock.resultPrice ? stock.resultPrice : _minStockPrice;
//            _maxStockPrice = _maxStockPrice < stock.resultPrice ? stock.resultPrice : _maxStockPrice;
//            _minActivityPrice = _minActivityPrice > stock.activityPrice ? stock.activityPrice : _minActivityPrice;
//            _maxActivityPrice = _maxActivityPrice < stock.activityPrice ? stock.activityPrice : _maxActivityPrice;
//        }
//    }
//    
//    if (!isNoAttr)
//    {
//        [self setAttrMap:attrDic];
//        [self setAttrOrder:attOrder];
////        [[PPStockCountCalculator sharedCalculator] setAttrOrder:attOrder];
////        [[PPVipPriceCalculator sharedCalculator] setAttrOrder:attOrder];
//    }
//    
//    //没有销售属性的话（stockAttr为空）
//    if ([self.spu.itemStockBo count] == 1)
//    {
//        //        [self setCurrentStockPo:[self.spu.stockList objectAtIndex:0]];
//    }
//}
//
//- (void)setBtnSelected:(UIButton *)button
//{
////    UIImage *bakImage = [UIImage imageNamed:@"addcarbtn2"];
////    CGSize size = bakImage.size;
////    CGFloat topCapHeight = size.height / 2;
////    CGFloat leftCapWidth = size.width / 2;
////    [button setBackgroundImage:[bakImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight] forState:UIControlStateNormal];
////    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    button.selected = YES;
//}
//
//- (void)setBtnUnSelected:(UIButton *)button
//{
////    UIImage *bakImg = [UIImage imageNamed:@"salesattrnormal"];
////    CGSize size = bakImg.size;
////    CGFloat topCapHeight = size.height / 2;
////    CGFloat leftCapWidth = size.width / 2;
////    [button setBackgroundImage:[bakImg stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight] forState:UIControlStateNormal];
////    [button setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
//    button.selected = NO;
//}
//
//- (void)onAttrBtnClick:(id) sender
//{
//    [self refreshAttrBtns:sender];
//    [self changeStockCountAndPriceAccordingSelectedAttr];
//    [self changeStockPoAccordingToSelectedStock];
//    
//    NSUInteger remainingStockCount = [[PPStockCountCalculator sharedCalculator] remainingCount:_selectedAttrOrders inSpu:_spu];
//    NSString* strStockCount = [NSString stringWithFormat:@"库存%d件", remainingStockCount];
////chark fixed, 2015/02/27
////    CGSize szStockCount = [strStockCount sizeWithFont:_stockCountLabel.font];
//    CGSize szStockCount = [Common sizeForString:strStockCount withFont:_stockCountLabel.font];
//
//    [_stockCountLabel setText:strStockCount];
//    CGRect rectStockCount = _stockCountLabel.frame;
//    rectStockCount.origin.x = self.frame.size.width - 20 - szStockCount.width;
//    [_stockCountLabel setFrame:rectStockCount];
//    
//    if (_numberTextField != nil && [_numberTextField.text longLongValue] == 0 && remainingStockCount != 0)
//    {
//        [SVProgressHUD showWithStatus:@"商品数量低于最小数量"];
//        [SVProgressHUD dismissWithStatus:@"商品数量低于最小数量" image:nil afterDelay:2];
//        [_numberTextField setText:@"1"];
//        self.buyCount = 1;
//    }
//    if (remainingStockCount != 0) {
//        if ([_numberTextField.text longLongValue] > remainingStockCount)
//        {
//            if (_spu.buyLimit > 0)
//            {
//                if ([_numberTextField.text longLongValue] > _spu.buyLimit)
//                {
//                    if (remainingStockCount < _spu.buyLimit)
//                    {
//                        [SVProgressHUD showWithStatus:@"商品数量超出最大范围"];
//                        [SVProgressHUD dismissWithStatus:@"商品数量超出最大范围" image:nil afterDelay:2];
//                        self.buyCount = remainingStockCount;
//                    }
//                    else
//                    {
//                        [SVProgressHUD showWithStatus:@"商品数量超出最大范围"];
//                        [SVProgressHUD dismissWithStatus:@"商品数量超出最大范围" image:nil afterDelay:2];
//                        self.buyCount = _spu.buyLimit;
//                    }
//                }
//                else
//                {
//                    [SVProgressHUD showWithStatus:@"商品数量超出最大范围"];
//                    [SVProgressHUD dismissWithStatus:@"商品数量超出最大范围" image:nil afterDelay:2];
//                    self.buyCount = remainingStockCount;
//                }
//            }
//            else
//            {
//                [SVProgressHUD showWithStatus:@"商品数量超出最大范围"];
//                [SVProgressHUD dismissWithStatus:@"商品数量超出最大范围" image:nil afterDelay:2];
//                self.buyCount = remainingStockCount;
//            }
//        }
//        else
//        {
//            if (_spu.buyLimit > 0)
//            {
//                if ([_numberTextField.text longLongValue] > _spu.buyLimit)
//                {
//                    [SVProgressHUD showWithStatus:@"商品数量超出最大范围"];
//                    [SVProgressHUD dismissWithStatus:@"商品数量超出最大范围" image:nil afterDelay:2];
//                    self.buyCount = _spu.buyLimit;
//                }
//                else
//                {
//                    self.buyCount = (NSUInteger)[_numberTextField.text longLongValue];
//                }
//            }
//            else
//            {
//                self.buyCount = (NSUInteger)[_numberTextField.text longLongValue];
//            }
//        }
//
//    }
//    else
//    {
//        self.buyCount = 1;
//    }
//    [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAdd.jpg"] forState:UIControlStateNormal];
//    [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAdd.jpg"] forState:UIControlStateHighlighted];
////    if (_delegate && [_delegate respondsToSelector:@selector(drawShipFeeForSelection:)])
////    {
////        [_delegate drawShipFeeForSelection:self.regionName];
////    }
////    
//////    [[PPVipPriceCalculator sharedCalculator] minVipPrices:_selectedAttrOrders inSpu:_spu];
////    if (_delegate && [_delegate respondsToSelector:@selector(didtapAttributeButtonToTriggerReload)])
////    {
////        [_delegate didtapAttributeButtonToTriggerReload];
////    }
//    do {
//        if (_spu.itemState!= IN_BIN)
//        {
//            //dis
//            if (self.finishBtn) {
//                [self.addBtn setEnabled:NO];
//                [self.subBtn setEnabled:NO];
//                [self.finishBtn setEnabled:NO];
////                [self.finishBtn setFrame:CGRectMake(0, 0, 320, 49)];
//            }
//            if (self.ivZeroStock) {
//                [self.addBtn setEnabled:NO];
//                [self.subBtn setEnabled:NO];
//                [self.ivZeroStock setHidden:NO];
//            }
//            break;
//        }
//        if ([self validateSelectionCompletion].length > 0) {
//            break;
//        }
//        if ([[PPStockCountCalculator sharedCalculator] remainingCount:self.selectedAttrOrders inSpu:_spu] == 0)
//        {
//            //dis
//            if (self.finishBtn) {
//                [self.addBtn setEnabled:NO];
//                [self.subBtn setEnabled:NO];
//                [self.finishBtn setEnabled:NO];
////                [self.finishBtn setFrame:CGRectMake(0, 0, 320, 49)];
//            }
//            if (self.ivZeroStock) {
//                [self.addBtn setEnabled:NO];
//                [self.subBtn setEnabled:NO];
//                [self.ivZeroStock setHidden:NO];
//            }
//            break;
//        }
//        else
//        {
//            //en
//            if (self.finishBtn) {
//                [self.addBtn setEnabled:YES];
//                [self.subBtn setEnabled:YES];
//                [self.finishBtn setEnabled:YES];
////                [self.finishBtn setFrame:CGRectMake(80, 0, 160, 49)];
//            }
//            if (self.ivZeroStock) {
//                [self.addBtn setEnabled:YES];
//                [self.subBtn setEnabled:YES];
//                [self.ivZeroStock setHidden:YES];
//            }
//            break;
//        }
//    } while (0);
//    [_numberTextField setText:[NSString stringWithFormat:@"%d", self.buyCount]];
//    if (self.titleLabel) {
//        if ([self validateSelectionCompletion].length > 0) {
//            [self.titleLabel setText:[NSString stringWithFormat:@"请选择%@", [self validateSelectionCompletion]]];
//            [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#d2c9b6"]];
//        }else
//        {
//            [self.titleLabel setText:[NSString stringWithFormat:@"已选择%@", [self completedSelection]]];
//            [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#463417"]];
//            [self.ivItemPic setImageFromUrl:NO withUrl:self.currentStock.colorPicUrl];
//        }
//    }
//}
//
//-(void)refreshAttrBtns:(id)sender
//{
//    if (!self.attrMap)
//    {
//        return;
//    }
//    
//    UIButton *senderButton = (UIButton *)sender;
//    NSArray *attrInBtnArray = nil;
//    NSString *currentAttrName = nil;
//    int btnListIndex = -1;
//    for (int i = 0; i < [[self.attributesButtonMap allKeys] count]; i++)
//    {
//        NSArray *btnArray = [self.attributesButtonMap objectForKey:[self.attrOrder objectAtIndex:i]];
//        for (int j = 0; j < [btnArray count]; j++)
//        {
//            UIButton *btn = [btnArray objectAtIndex:j];
//            if ([btn.titleLabel.text isEqualToString:senderButton.titleLabel.text])
//            {
//                btnListIndex = i;
//                attrInBtnArray = btnArray;
//                currentAttrName = [self.attrOrder objectAtIndex:i];
//                break;
//            }
//        }
//    }
//    //找出点击的button所在的button数组，把该数组的button全部unselected，
//    if (senderButton.selected)
//    {
////        [self setBtnUnSelected:senderButton];
//        [senderButton setSelected:NO];
//        if (currentAttrName != nil)
//        {
//            [self.currentSalesAttrStates setObject:[NSNull null] forKey:currentAttrName];
//        }
//    }
//    else
//    {
////        [self setBtnSelected:senderButton];
//        [senderButton setSelected:YES];
//        if (currentAttrName != nil)
//        {
//            [self.currentSalesAttrStates setObject:senderButton forKey:currentAttrName];
//        }
//    }
//    
//    
//    for (int j = 0; j < [attrInBtnArray count]; j++)
//    {
//        UIButton *btnInArray = (UIButton *)[attrInBtnArray objectAtIndex:j];
//        if (btnInArray != senderButton)
//        {
////            [self setBtnUnSelected:btnInArray];
//            [btnInArray setSelected:NO];
//        }
//    }
//    if ([[self.attributesButtonMap allKeys] count] < 2) {
//        return;
//    }
//    
//    NSString* otherAttrName = [self.attrOrder objectAtIndex:btnListIndex == 0 ? 1 : 0];
//    //取另一组btn 用来铲除没有库存的选项
//    BOOL b1 = [self.currentSalesAttrStates objectForKey:currentAttrName] == senderButton;
////    BOOL b2 = [self.currentSalesAttrStates objectForKey:otherAttrName] == [NSNull null];
//    BOOL b3 = (senderButton.selected == NO);
//    if (btnListIndex != -1 && b1 && (senderButton.selected == YES)) {
//        
//        NSArray *otherBtnArray = [self.attributesButtonMap objectForKey:otherAttrName];
//        for (UIButton* btn in otherBtnArray) {
//            NSString* attr1 = [NSString stringWithFormat:@"%@:%@|%@:%@", currentAttrName, senderButton.titleLabel.text, otherAttrName, btn.titleLabel.text];
//            NSString* attr2 = [NSString stringWithFormat:@"%@:%@|%@:%@", otherAttrName, btn.titleLabel.text, currentAttrName, senderButton.titleLabel.text];
//            for (PPProductDetailItemStockBo* pdisb in self.spu.itemStockBo) {
//                if ([pdisb.stockAttr isEqualToString:attr1]) {
//                    if (pdisb.stockCount == 0) {
//                        [btn setEnabled:NO];
//                        [btn setTitleColor:[UIColor colorWithHexString:@"#e7e4de"] forState:UIControlStateNormal];
//                    }else
//                    {
//                        [btn setEnabled:YES];
//                        [btn setTitleColor:HEXCOLOR(0x463417) forState:UIControlStateNormal];
//                    }
//                    break;
//                }
//                else if([pdisb.stockAttr isEqualToString:attr2])
//                {
//                    if (pdisb.stockCount == 0) {
//                        [btn setEnabled:NO];
//                        [btn setTitleColor:[UIColor colorWithHexString:@"#e7e4de"] forState:UIControlStateNormal];
//                    }else
//                    {
//                        [btn setEnabled:YES];
//                        [btn setTitleColor:HEXCOLOR(0x463417) forState:UIControlStateNormal];
//                    }
//                    break;
//                }
//            }
//        }
//    }
//    else if (btnListIndex != -1 && [self.currentSalesAttrStates objectForKey:currentAttrName] == [NSNull null] && b3)
//    {
//        NSArray *otherBtnArray = [self.attributesButtonMap objectForKey:otherAttrName];
//        for (UIButton* btn in otherBtnArray) {
//            if (btn.tag != 92653) {
//                [btn setEnabled:YES];
//                [btn setTitleColor:HEXCOLOR(0x463417) forState:UIControlStateNormal];
//            }
//            
//        }
//    }
//}
//
//- (void)changeStockCountAndPriceAccordingSelectedAttr
//{
//    if (!self.attrMap)
//    {
//        return;
//    }
//    
//    //用于存储选中的属性
//    if (_selectedAttrOrders == nil)
//    {
//        _selectedAttrOrders = [[NSMutableArray alloc] initWithCapacity:[self.attrOrder count]];
//    }
//    [_selectedAttrOrders removeAllObjects];
//    for (int i = 0; i < [self.attrOrder count]; i++)
//    {
//        [_selectedAttrOrders addObject:[NSNull null]];
//    }
//    
//    int attrCount = 0;
//    
//    for (int i = 0; i < [self.attrOrder count]; i++)
//    {
//        NSArray *btnArray = [self.attributesButtonMap objectForKey:[self.attrOrder objectAtIndex:i isArray:nil]];
//        
//        for (int j = 0; j < [btnArray count]; j++)
//        {
//            UIButton *button = (UIButton *)[btnArray objectAtIndex:j isArray:nil];
//            if (button.selected)
//            {
//                NSMutableString *selectedAttrString = [[NSMutableString alloc] initWithCapacity:0];
//                [selectedAttrString appendString:[self.attrOrder objectAtIndex:i isArray:nil]];
//                [selectedAttrString appendString:@":"];
//                [selectedAttrString appendString:button.titleLabel.text];
//                
//                [_selectedAttrOrders replaceObjectAtIndex:i withObject:selectedAttrString];
//                attrCount++;
//                
//            }
//        }
//    }
//    
//    //计算区间价
//    _minStockPrice = LONG_MAX;
//    _maxStockPrice = 0;
//    _minActivityPrice = LONG_MAX;
//    _maxActivityPrice = 0;
//    
//    for (int i = 0; i < [self.spu.itemStockBo count]; i++)
//    {
////        PPStockPo *stock = (PPStockPo *)[self.spu.stockList objectAtIndex:i];
//        PPProductDetailItemStockBo *stock = (PPProductDetailItemStockBo *)[self.spu.itemStockBo objectAtIndex:i];
//        NSArray *kvPairArray = [stock.stockAttr componentsSeparatedByString:@"|"];
//        
//        //比对所选的属性，是不是某个stock的子集，计算库存和区间价
//        int matchCount = 0;
//        for (int i = 0; i < [kvPairArray count]; i++)
//        {
//            if ([_selectedAttrOrders objectAtIndex:i] != [NSNull null])
//            {
//                NSString *selectedString = [_selectedAttrOrders objectAtIndex:i];
//                NSString *kvString = [kvPairArray objectAtIndex:i];
//                
//                if ([selectedString isEqualToString:kvString])
//                {
//                    matchCount++;
//                }
//            }
//        }
//        if (matchCount == attrCount)
//        {
//            _minStockPrice = _minStockPrice > stock.resultPrice ? stock.resultPrice : _minStockPrice;
//            _maxStockPrice = _maxStockPrice < stock.resultPrice ? stock.resultPrice : _maxStockPrice;
//            _minActivityPrice = _minActivityPrice > stock.activityPrice ? stock.activityPrice : _minActivityPrice;
//            _maxActivityPrice = _maxActivityPrice < stock.activityPrice ? stock.activityPrice : _maxActivityPrice;
//        }
//    }
//}
//
//-(void)changeStockPoAccordingToSelectedStock
//{
//    //假如没有销售属性，没必要改变选中状态，直接返回
//    if (!self.attrMap)
//    {
//        return;
//    }
//    
//    
//    NSMutableString *stockAttrString = [[NSMutableString alloc] init];
//    
//    //遍历所有key，已经选择的button，形成stockAttr
//    for (int i = 0; i < [self.attrOrder count]; i++)
//    {
//        //根据销售属性的键，找到对应的按钮数组
//        NSArray *btnArray = [self.attributesButtonMap objectForKey:[self.attrOrder objectAtIndex:i]];
//        
//        //遍历该按钮数组的所有按钮，根据选中状态取回对应销售属性键的值，形成键值对字符串,
//        for (int j = 0; j < [btnArray count]; j++)
//        {
//            UIButton *button = (UIButton *)[btnArray objectAtIndex:j];
//            if (button.selected)
//            {
//                [stockAttrString appendString:[self.attrOrder objectAtIndex:i]];
//                [stockAttrString appendString:@":"];
//                [stockAttrString appendString:button.titleLabel.text];
//            }
//        }
//        
//        if (i != [self.attrOrder count] - 1)
//        {
//            [stockAttrString appendString:@"|"];
//        }
//    }
//    BOOL hasStockPo = NO;
//    //遍历取回的商品信息，根据上面代码段生成的stockAttr与请求回来的json数据的stockAttr进行对比，找到对应的StockPo
//    for (int i = 0; i < [self.spu.itemStockBo count]; i++)
//    {
//        PPProductDetailItemStockBo *stockPo = (PPProductDetailItemStockBo *)[self.spu.itemStockBo objectAtIndex:i];
////        PPStockPo *stockPo = (PPStockPo *)[self.spu.stockList objectAtIndex:i];
//        PPPrint(@"%@", stockPo.stockAttr);
//        if ([stockAttrString isEqualToString:stockPo.stockAttr])
//        {
//            //设置为当前选中的Stock
//            [self setCurrentStock:stockPo];
//            hasStockPo = YES;
//            
//            [_priceLabel setText:[NSString stringWithFormat:@"￥%@", [Util fen2yuan:[self minPrice]]]];
//        }
//    }
////    PPPrint(@"the stock string is %@, the stock price is %d", stockAttrString, _currentStock.stockPrice);
//    if (!hasStockPo)
//    {
//        [self setCurrentStock:nil];
//        NSString *price = nil;
////        if (_spu.activityPrice == 0)
//        {
//            price = _minStockPrice == _maxStockPrice ? [NSString stringWithFormat:@"￥%@", [Util fen2yuan:_minStockPrice]] : [NSString stringWithFormat:@"￥%@ - ￥%@", [Util fen2yuan:_minStockPrice], [Util fen2yuan:_maxStockPrice]];
//        }
////        else
////        {
////            price = _minActivityPrice == _maxActivityPrice ? [NSString stringWithFormat:@"￥%@", [Util fen2yuan:_minActivityPrice]] : [NSString stringWithFormat:@"￥%@ - ￥%@", [Util fen2yuan:_minActivityPrice], [Util fen2yuan:_maxActivityPrice]];
////        }
//        [_priceLabel setText:price];
//    }
//    
//}
//
//- (NSString *)getRegionName:(NSString *) regionId;
//{
//    NSString *areaRegionId = [NSString stringWithFormat:@"%@%@", [regionId substringToIndex:2], @"0000"];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"RegionInfo" ofType:@"plist"];
//    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
//    NSArray *regions = [dict objectForKey:@"Region"];
//    for (NSArray *area in regions) {
//        for (id item in area) {
//            if ([item isKindOfClass:[NSDictionary class]])
//            {
//                if ([[[item allValues] objectAtIndex:0] isEqual:areaRegionId]) {
//                    return [[item allKeys] objectAtIndex:0];
//                }
//            }
//        }
//    }
//    return nil;
//}
//
//-(NSString *) completedSelection
//{
//    NSMutableString *selectedAttrString = [NSMutableString string];
//    for (int i = 0; i < [self.attrOrder count]; i++)
//    {
//        NSArray *btnArray = [self.attributesButtonMap objectForKey:[self.attrOrder objectAtIndex:i]];
//        for (UIButton *button in btnArray)
//        {
//            if (button.selected)
//            {
//                [selectedAttrString appendString:button.currentTitle];
//                [selectedAttrString appendString:@" "];
//                break;
//            }
//        }
//    }
//    
//    [selectedAttrString replaceCharactersInRange:NSMakeRange([selectedAttrString length] - 1, 1) withString:@""];
//    
//    return selectedAttrString;
//}
//
//-(NSString *)validateSelectionCompletion
//{
//    NSMutableArray *selectedAttrIndex = [NSMutableArray array];
//    [selectedAttrIndex removeAllObjects];
//    
//    for (int i = 0; i < [self.attrOrder count]; i++)
//    {
//        NSArray *btnArray = [self.attributesButtonMap objectForKey:[self.attrOrder objectAtIndex:i]];
//        for (UIButton *button in btnArray)
//        {
//            if (button.selected)
//            {
//                [selectedAttrIndex addObject:[NSNumber numberWithInt:i]];
//                break;
//            }
//        }
//    }
//    
//    NSMutableString *notSelectedAttrString = [NSMutableString string];
//    if ([selectedAttrIndex count] != [self.attrOrder count])
//    {
//        for (int i = 0; i < [self.attrOrder count]; i++)
//        {
//            BOOL isSelected = NO;
//            for (NSNumber *number in selectedAttrIndex)
//            {
//                if ([number intValue] == i)
//                {
//                    isSelected = YES;
//                    break;
//                }
//            }
//            
//            if (!isSelected)
//            {
//                [notSelectedAttrString appendString:[self.attrOrder objectAtIndex:i]];
//                [notSelectedAttrString appendString:@","];
//                
//            }
//        }
//        [notSelectedAttrString replaceCharactersInRange:NSMakeRange([notSelectedAttrString length] - 1, 1) withString:@""];
//    }
//    
//    return notSelectedAttrString;
//}
//
//#pragma mark - Button Action
//
//- (void)selectRegion
//{
////    if (_delegate && [_delegate respondsToSelector:@selector(didTapSelectRegionButton)])
////    {
////        [_delegate didTapSelectRegionButton];
////    }
//}
//
//- (void)numberButtonPressed:(id)sender
//{
//    //1是减
//    UIButton *button = (UIButton *)sender;
//    
//    if (button.tag == 1)
//    {
//        if (self.buyCount > 1)
//        {
//            [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAdd.jpg"] forState:UIControlStateNormal];
//            [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAdd.jpg"] forState:UIControlStateHighlighted];
//            self.buyCount--;
//        }
//        if (self.buyCount == 1) {
//            [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDelGray.jpg"] forState:UIControlStateNormal];
//            [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDelGray.jpg"] forState:UIControlStateHighlighted];
//        }
//    }
//    else
//    {
//        UIImage* img = [sender imageForState:UIControlStateNormal];
//        NSData* imgData = UIImagePNGRepresentation(img);
//        NSData* picData = UIImagePNGRepresentation([UIImage imageNamed:@"btnDetailAddGray.jpg"]);
//        if ([[imgData description] isEqualToString:[picData description]]) {
//            return;
//        }
//        if (self.currentStock == nil)
//        {
//            if (_spu.buyLimit > 0)
//            {
//                if (self.buyCount < _spu.buyLimit)
//                {
//                    [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDel.jpg"] forState:UIControlStateNormal];
//                    [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDel.jpg"] forState:UIControlStateHighlighted];
//                    self.buyCount++;
//                }
//                else
//                {
//                    [SVProgressHUD showWithStatus:@"商品数量超出限购数量"];
//                    [SVProgressHUD dismissWithStatus:@"商品数量超出限购数量" image:nil afterDelay:2];
//                    [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAddGray.jpg"] forState:UIControlStateNormal];
//                    [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAddGray.jpg"] forState:UIControlStateHighlighted];
//                }
//            }
//            else
//            {
//                [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDel.jpg"] forState:UIControlStateNormal];
//                [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDel.jpg"] forState:UIControlStateHighlighted];
//                self.buyCount++;
//            }
//        }
//        else
//        {
//            if (self.buyCount < self.currentStock.stockCount)
//            {
//                if (_spu.buyLimit > 0)
//                {
//                    if (self.buyCount < _spu.buyLimit)
//                    {
//                        [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDel.jpg"] forState:UIControlStateNormal];
//                        [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDel.jpg"] forState:UIControlStateHighlighted];
//                        self.buyCount++;
//                    }
//                    else
//                    {
//                        [SVProgressHUD showWithStatus:@"商品数量超出限购数量"];
//                        [SVProgressHUD dismissWithStatus:@"商品数量超出限购数量" image:nil afterDelay:2];
//                        [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAddGray.jpg"] forState:UIControlStateNormal];
//                        [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAddGray.jpg"] forState:UIControlStateHighlighted];
//                    }
//                }
//                else
//                {
//                    [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDel.jpg"] forState:UIControlStateNormal];
//                    [self.subBtn setImage:[UIImage imageNamed:@"btnDetailDel.jpg"] forState:UIControlStateHighlighted];
//                    self.buyCount++;
//                }
//            }
//            else
//            {
//                [SVProgressHUD showWithStatus:@"商品数量超过最大库存"];
//                [SVProgressHUD dismissWithStatus:@"商品数量超过最大库存" image:nil afterDelay:2];
//                [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAddGray.jpg"] forState:UIControlStateNormal];
//                [self.addBtn setImage:[UIImage imageNamed:@"btnDetailAddGray.jpg"] forState:UIControlStateHighlighted];
//            }
//        }
//    }
//    [_numberTextField setText:[NSString stringWithFormat:@"%d", self.buyCount]];
////    if (_delegate && [_delegate respondsToSelector:@selector(drawShipFeeForSelection:)])
////    {
////        [_delegate drawShipFeeForSelection:self.regionName];
////    }
//}
//
//+ (CGFloat)getOptionViewHeight:(PPProductDetailBO *)spu
////+ (CGFloat)getOptionViewHeight:(PPSpuPo *)spu
//{
//    PPBuyOptionView *buyOptionView = [[PPBuyOptionView alloc] init];
//    [buyOptionView setSpu:spu];
////    [buyOptionView drawUI];
//    [buyOptionView drawSalesAttribute:CGPointMake(0, 0)];
//    
//    CGFloat totalHeight = buyOptionView.totalHeight;
//    
//    return totalHeight;
//}
//
//- (NSInteger)minPrice
//{
//    NSInteger miniumPrice = 0;
//    
//    if (_currentStock != nil)
//    {
//        miniumPrice = _currentStock.resultPrice;
//    }
//    else
//    {
//        miniumPrice = _spu.resultPrice * 100;
//    }
//    
//    return miniumPrice;
//}
//
//@end