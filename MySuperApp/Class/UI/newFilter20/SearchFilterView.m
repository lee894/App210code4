////
////  SearchFilterView.m
////  paipaiiphone
////
////  Created by zhangwenguang on 15/3/24.
////  Copyright (c) 2015年 lee. All rights reserved.
////
//
//#import "SearchFilterView.h"
//#import "Util.h"
//
//#import "PPSearchFilterPropertyCell.h"
//
//#import "PPSearchFilterCell.h"
//#import "PPRecvProv.h"
//
//#import "FilterHeadViewCell.h"
//#import <objc/runtime.h>
//
//#import "FilterButton.h"
//
//#define kClusterTitleH 21.0
//#define kClusterCellH 44.0
//
//#define kClusterButtonTag 3333
//
////static void * MyButtonKey = (void *)@"MyButtonKey";
////static void * MyButtonType = (void *)@"MyButtonType";
//
//
//typedef enum
//{
//    ActivitySectionOptions = 100,
//    ClassifySectionOptions = 101,//根据所给data展示
//    PriceSectionOptions    = 102,
//    AreaSectionOptions     = 103,
//    PropertySectionOptions = 104, //根据所给data展示
//    
//}FilterSectionOptions;
//
//
//typedef enum
//{
//    ActivityFilterButtonType = 200, //活动cell上的按钮
//    ClassifyFilterButtonType = 201, //品类cell上的按钮
//    AreaFilterButtonType     = 202, //地域cell上的按钮
//    ProPertyFilterButtonType = 203  //商品属性cell上的按钮
//    
//}FilterButtonType;
//
//@implementation NewPropertyItem
//
//
//@end
//
//@interface SearchFilterView ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
//{
//    //本地数据
//    NSMutableArray *activityArray;
//    NSMutableArray *areaArray;
//    NSMutableArray *provincesArray;
//    NSMutableArray *sectionTitleArray;
//
//}
//
//@property (nonatomic,assign) CGRect theRect;
//@property (nonatomic,retain) UITableView *tableView;
//
//
//@property (nonatomic,retain) NSMutableArray *classifyData;
//@property (nonatomic,retain) NSMutableArray *propertyData;
//
//@property (nonatomic,retain) NSString *lowPrice;
//@property (nonatomic,retain) NSString *topPrice;
//
//@end
//
//@implementation SearchFilterView
//
////重置、确定2个按钮的action
//- (void)buttonTouchAction:(id)sender{
//    UIButton *btn = (UIButton *)sender;
//    
//    switch (btn.tag) {
//        case 101://重置
//            [self reSetFilterViewDatawithParams:nil];
//            break;
//        case 102://确定
//        {
//            if (_delegate && [_delegate respondsToSelector:@selector(searchByFilter:)]) {
//                [_delegate searchByFilter:self.searchCondition];
//            }
//        }
//            break;
//        default:
//            break;
//    }
//}
//
////cell上的各种cell的 action
////change  Search Condition here
//- (void)cellButtonTouchAction:(id)sender{
//    FilterButton *btn = (FilterButton *)sender;
//
//    btn.selected = !btn.selected;
//
//    int arrayIndex = btn.tag - kClusterButtonTag;
//
//
////    NSString *value = btn.key; //objc_getAssociatedObject(self, MyButtonKey);///  参数path
//    NSString *bType = btn.type; //objc_getAssociatedObject(self, MyButtonType);
//    
//    switch ([bType intValue]) {
//        case ActivityFilterButtonType:
//        {
//            PPPropertyItem *item = (PPPropertyItem *)[activityArray objectAtIndex:arrayIndex isArray:nil];
//            item.isSelected = btn.selected;
//            if (arrayIndex == 0) {//运费险
//                [self.searchCondition setReightInsurance:(btn.selected)?1:0];
//            }
//            if (arrayIndex == 1) {//包邮
//                [self.searchCondition setFreeMail:(btn.selected)?YES:NO];
//            }
//            if (arrayIndex == 2) {//货到付款
//                [self.searchCondition  setSupportCod:(btn.selected)?YES:NO];
//            }
//            if (arrayIndex == 3) {//二手
//                [self.searchCondition setDegree:(btn.selected)?2:0];
//            }
//        }
//            break;
//        case ClassifyFilterButtonType:
//        {
//            PPPropertyItem *aimItem = nil;
//            for (PPPropertyItem *item in _classifyData) {
//                item.isSelected = NO;
//                if ([btn.titleLabel.text isEqualToString:item.clusterName]) {
//                    item.isSelected = btn.selected;
//                    aimItem = item;
//                }
//            }
//
//            NSIndexPath *headPath = [NSIndexPath indexPathForRow:1 inSection:1];//商品类目的cell
//            NSArray *aimPair = [NSArray array];
//
//            if (btn.selected) {
//                FilterHeadViewCell *headCell = (FilterHeadViewCell *)[self.tableView cellForRowAtIndexPath:headPath];
//                for (UIView *view in headCell.contentView.subviews) {
//                    if ([view isKindOfClass:[UIButton class]]) {
//                        UIButton *bn = (UIButton *) view;
//                        bn.selected = NO;
//                        bn.layer.borderColor = [UIColor colorWithHexString:@"E7E4DE"].CGColor;//灰色
//                        bn.titleLabel.textColor = [UIColor colorWithHexString:@"D2C9B7"];
//                        [bn setTintColor:[UIColor colorWithHexString:@"D2C9B7"]];
//                    }
//                }
//                btn.selected = YES;
//                NSArray *list = [aimItem.path componentsSeparatedByString:@"-"];
//                for (NSString *strPair in list)
//                {
//                    NSArray *pair = [strPair componentsSeparatedByString:@","];
//                    if (pair.count != 2)
//                    {
//                        continue;
//                    }else{
//                        aimPair = pair;
//                    }
//                }
//            }else{
//
//                NSArray *list = [aimItem.path componentsSeparatedByString:@"-"];
//                for (NSString *strPair in list)
//                {
//                    NSArray *pair = [strPair componentsSeparatedByString:@","];
//                    if (pair.count != 2)
//                    {
//                        continue;
//                    }else{
//                        aimPair = pair;
//                        [self.searchCondition removePathByAttrId:[pair objectAtIndex:0] clusterId:[pair objectAtIndex:1]];
//                    }
//                }
//
//            }
//            if (btn.selected) {
//                [self.searchCondition addPathByAttrId:[aimPair objectAtIndex:0] clusterId:[aimPair objectAtIndex:1]];
//            }else{
//                [self.searchCondition removePathByAttrId:[aimPair  objectAtIndex:0] clusterId:[aimPair objectAtIndex:1]];
//            }
//        }
//            break;
//        case AreaFilterButtonType:
//        {
//            NSString *title = btn.titleLabel.text;
//            for (PPPropertyItem *item in areaArray) {
//                item.isSelected = NO;
//                if ([title isEqualToString:item.clusterName]) {
//                    item.isSelected = btn.selected;
//                }
//            }
//            for (PPPropertyItem *item in provincesArray) {
//                item.isSelected = NO;
//                if ([title isEqualToString:item.clusterName]) {
//                    item.isSelected = btn.selected;
//                }
//            }
//
//            BOOL isSelected = btn.isSelected;
//
//            if (isSelected) {
//                [self.searchCondition setShopAddr:title];
//            }else{
//                [self.searchCondition setShopAddr:@""];
//            }
//
//            NSIndexPath *headPath1 = [NSIndexPath indexPathForRow:2 inSection:3];//地区
//            NSIndexPath *headPath2 = [NSIndexPath indexPathForRow:4 inSection:3];//省会
//
//            [self.tableView reloadRowsAtIndexPaths:@[headPath1,headPath2] withRowAnimation:UITableViewRowAnimationNone];
//
//            btn.selected = isSelected;
//
//        }
//            break;
//        case ProPertyFilterButtonType:
//        {
//            
//            UITableViewCell *cell = nil;
//            if ([btn.superview.superview isKindOfClass:[UITableViewCell class]]) {
//                cell = (UITableViewCell *)btn.superview.superview;
//            }else if([btn.superview.superview.superview isKindOfClass:[UITableViewCell class]]){///IOS7
//                cell = (UITableViewCell *)btn.superview.superview.superview;
//            }
//
//            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];//点击的时候，这个cell肯定是可见的
//
//            BOOL isSelected = btn.isSelected;
//
//            for (UIView *view in btn.superview.subviews) {
//                if ([view isKindOfClass:[UIButton class]]) {
//                    UIButton *bn = (UIButton *) view;
//                    bn.selected = NO;
//                    bn.layer.borderColor = [UIColor colorWithHexString:@"E7E4DE"].CGColor;//灰色
//                    bn.titleLabel.textColor = [UIColor colorWithHexString:@"D2C9B7"];
//                }
//            }
//            btn.selected = isSelected;
//            NewPropertyItem *newItem = (NewPropertyItem *)[_propertyData objectAtIndex:indexPath.row - 1 isArray:nil];
//            for (PPPropertyItem *item  in newItem.subItemArray) {
//                item.isSelected = NO;
//            }
//
//            PPPropertyItem *item = [newItem.subItemArray objectAtIndex:arrayIndex isArray:nil];
//            item.isSelected = btn.selected;
//
//            NSArray *aimPair = [NSArray array];
//            if (isSelected) {
//                NSArray *list = [item.path componentsSeparatedByString:@"-"];
//                for (NSString *strPair in list)
//                {
//                    NSArray *pair = [strPair componentsSeparatedByString:@","];
//                    if (pair.count != 2)
//                    {
//                        continue;
//                    }else{
//                        aimPair = pair;
//                    }
//                }
//
//            }else{
//                NSArray *list = [item.path componentsSeparatedByString:@"-"];
//                for (NSString *strPair in list)
//                {
//                    NSArray *pair = [strPair componentsSeparatedByString:@","];
//                    if (pair.count != 2)
//                    {
//                        continue;
//                    }else{
//                        aimPair = pair;
//                    }
//                }
//            }
//            if (isSelected) {
//                    [self.searchCondition addPathByAttrId:[aimPair objectAtIndex:0] clusterId:[aimPair objectAtIndex:1]];
//            }else{
//                    [self.searchCondition addPathByAttrId:[aimPair objectAtIndex:0] clusterId:[aimPair objectAtIndex:1]];
//            }
//        }
//            break;
//        default:
//            break;
//    }
//
//    if (btn.selected) {
//        btn.layer.borderColor = [UIColor colorWithHexString:@"F5303A"].CGColor;//红色
//        btn.titleLabel.textColor = [UIColor colorWithHexString:@"F5303A"];///IOS7 无效
//        [btn setTintColor:[UIColor colorWithHexString:@"F5303A"]];////IOS7 有效
//    }else{
//        btn.layer.borderColor = [UIColor colorWithHexString:@"E7E4DE"].CGColor;//灰色
//        btn.titleLabel.textColor = [UIColor colorWithHexString:@"D2C9B7"];
//        [btn setTintColor:[UIColor colorWithHexString:@"D2C9B7"]];
//    }
//
//}
//
//- (void)bViewTapAction:(id)sender{
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(cancleFilter)]) {
//        [_delegate cancleFilter];
//    }
//}
//
//- (void)createBottomBtnView{
//    
//    CGRect rect = CGRectMake(0, self.height - 49 - 40, self.width * .5, 49);
//    UIColor *textColor = [UIColor whiteColor];
//    UIColor *bgColor = [UIColor blackColor];
//    UIFont *font = [UIFont systemFontOfSize:15.0];
//    [Common showInView:self buttonType:UIButtonTypeCustom rect:rect title:@"重置" textColor:textColor textFont:font titleEdgeInsets:UIEdgeInsetsZero imageName:@"" imageEdgeInsets:UIEdgeInsetsZero tag:101 addTarget:self action:@selector(buttonTouchAction:) bgColor:bgColor bgImageName:@""];
//    
//    rect = CGRectMake(self.width * .5, self.height - 49 - 40, self.width * .5, 49);
//    bgColor = [UIColor colorWithHexString:@"#f82c33"];
//    [Common showInView:self buttonType:UIButtonTypeCustom rect:rect title:@"确定" textColor:textColor textFont:font titleEdgeInsets:UIEdgeInsetsZero imageName:@"" imageEdgeInsets:UIEdgeInsetsZero tag:102 addTarget:self action:@selector(buttonTouchAction:) bgColor:bgColor bgImageName:@""];
//    
//    rect = CGRectMake(0, self.height - 40, self.width, 40);
//    UIView *bView = [[UIView alloc] initWithFrame:rect];
//    bView.backgroundColor = [UIColor blackColor];
//    bView.alpha = .7;
//    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bViewTapAction:)];
//    tapGesture.numberOfTapsRequired = 1;
//    [bView addGestureRecognizer:tapGesture];
//    [self addSubview:bView];
//    
//}
//
//- (void)createTableView{
//    
//    CGRect rect = CGRectMake(0, 0, self.width, self.height - 49 - 40);
//    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.bounces = YES;//NO;
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        self.tableView.separatorInset = UIEdgeInsetsZero;
//        self.tableView.separatorColor = [UIColor colorWithHexString:@"e7e4de"];
//    }
//
//    UIView *lineView = [[UIView alloc] init];
//    lineView.frame = CGRectZero;
//    self.tableView.tableFooterView = lineView;
//    self.tableView.contentInset  = UIEdgeInsetsMake(0, 0, 0, 0);
//
//    [self addSubview:self.tableView];
//
//    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
//                                          initWithTarget:self
//                                          action:@selector(dismissKeyBoardTap:)];
//    [self.tableView addGestureRecognizer:tapGesture];
//
//}
//
//- (void)dismissKeyBoardTap:(UITapGestureRecognizer*)theTap
//{
//    [self endEditing:YES];
//
//}
//
//
//- (void)createCustomView{
//    
//    [self createBottomBtnView];
//    [self createTableView];
//}
//
//#pragma mark  将数据转换成筛选页面的数据源
//
//- (void)handleClusterOfSearchResult
//{
//    if (_searchResult == nil)
//    {
//        return;
//    }
//    
//    NSInteger dataType = PPFilterDataTypeNone;
//    // 添加分类类目
//    
//    if (_classifyData == nil) {
//        NSMutableArray *data = [[NSMutableArray alloc] init];
//        self.classifyData = data;
//    }else{
//        [_classifyData removeAllObjects];
//    }
//    
//
//    for (PPCluster *cluster in _searchResult.clusters)
//    {
//        PPPropertyItem *propertyItem = [[PPPropertyItem alloc] init];
//        propertyItem.clusterId = cluster.clusterId;
//        propertyItem.clusterCount = cluster.clusterCount;
//        propertyItem.clusterName = cluster.clusterName;
//        propertyItem.path = cluster.path;
//        
//        propertyItem.dataType = dataType;
//        propertyItem.isSelected = NO;
//        [_classifyData addObject:propertyItem];
//    }
//}
//
//- (void)handlePropertyOfSearchResult
//{
//    if (_searchResult == nil)
//    {
//        return;
//    }
//    
//    if (_propertyData == nil) {
//        NSMutableArray *data = [[NSMutableArray alloc] init];
//        self.propertyData = data;
//    }else{
//        [_propertyData removeAllObjects];
//    }
//
//    NSInteger propertyCount = [_searchResult.properties count];
//
//    for (NSInteger i = 0; i < propertyCount; i++)
//    {
//        PPProperty *property = [_searchResult.properties objectAtIndex:i];
//        NewPropertyItem *item = [[NewPropertyItem alloc] init];
//        item.pName = property.name;
//        item.subItemArray = property.options;
//
//        for (PPPropertyItem *tt in item.subItemArray) {
//            tt.isSelected = NO;
//        }
//        item.isTopCell = YES;
//        item.state = stateClosed;
//
//        [_propertyData addObject:item];
//    }
//
//}
//
//
//- (void)convertSearchResultToFilterData
//{
//    if (_searchResult == nil)
//    {
//        return;
//    }
//
//    // 处理类目数据源
//    [self handleClusterOfSearchResult];
//    
//    // 处理属性数据源
//    [self handlePropertyOfSearchResult];
//}
//
//// 设置筛选结果
//- (void)setTheSearchResult:(PPSearchResult *)searchResult
//{
//    _searchResult = searchResult;
//    
//    [self convertSearchResultToFilterData];;
//
//}
//
//- (void)initData{
//    
//    
////    PPPropertyItem *item; //标记 button  是否被选中
////        NewPropertyItem   //标记 cell  是否被展开
//
//    sectionTitleArray = [[NSMutableArray alloc] init];
//    NSArray *array0 = @[@"选择优惠活动",@"商品类目",@"价格区间（元）",@"发货地区",@"属性"];
//    for (int i = 0; i < array0.count; i ++) {
//        
//        NewPropertyItem *item = [[NewPropertyItem alloc] init];
//        item.pName = [array0 objectAtIndex:i];
//        item.state = stateOpened;
//        if (i == 1 || i == 3) {
//            item.state = stateClosed;
//        }
//        [sectionTitleArray addObject:item];
//    }
//
//    activityArray = [[NSMutableArray alloc] init];
//    //优惠活动
//    NSArray *array1 = @[@"运费险",@"包邮",@"货到付款",@"二手"];
//    for (int i = 0; i < array1.count; i ++) {
//
//        PPPropertyItem *item = [[PPPropertyItem alloc] init];
//        item.clusterName = [array1 objectAtIndex:i];
//        item.isSelected = NO;
//
//        [activityArray addObject:item];
//    }
//    
//    areaArray = [[NSMutableArray alloc] init];
//    //所在位置的直辖市等地区
//    NSArray *array2 = @[@"北京",@"上海",@"广州",@"深圳",@"江浙沪",@"珠三角",@"港澳台",@"海外"];
//    
//    for (int i = 0; i < array2.count; i ++) {
//        
//        PPPropertyItem *item = [[PPPropertyItem alloc] init];
//        item.clusterName = [array2 objectAtIndex:i];
//        item.isSelected = NO;
//        
//        [areaArray addObject:item];
//    }
//
//    NSArray *array3 = @[@"安徽",@"重庆",@"福建",@"广东",@"广西",@"贵州",@"甘肃",@"河北",@"河南",@"黑龙江",@"湖南",@"湖北",@"海南",@"江苏",@"吉林",@"江西",@"辽宁",@"内蒙",@"宁夏",@"青海",@"山西",@"山东",@"四川",@"陕西",@"天津",@"新疆",@"西藏",@"云南",@"浙江"];
//    provincesArray = [[NSMutableArray alloc] init];
//
//    for (int i = 0; i < array3.count; i ++) {
//        
//        PPPropertyItem *item = [[PPPropertyItem alloc] init];
//        item.clusterName = [array3 objectAtIndex:i];
//        item.isSelected = NO;
//        
//        [provincesArray addObject:item];
//    }
//
//    self.lowPrice = @"";
//    self.topPrice = @"";
//
//    [self setTheSearchResult:self.searchResult];
//}
//
//- (instancetype)initWithFrame:(CGRect) frame withParams:(NSDictionary *)dict{
//    
//    self = [super initWithFrame:frame];
//    if (self) {
//        //
//        self.backgroundColor = [UIColor clearColor];
//        self.theRect = self.bounds;
//        PPSearchResult *result = [dict objectForKey:@"PPSearchResult"];
//        self.searchResult = result; // readOnly
//        PPSearchCondition *condition = [dict objectForKey:@"PPSearchCondition"];
//        self.searchCondition = condition;
//
//        [self initData];
//        [self createCustomView];
//    }
//    return self;
//}
//
//
//-(void)setHidden:(BOOL)hidden{
//    [super setHidden:hidden];
//    if (hidden == YES) {
//        [self endEditing:YES];
//    }
//}
//
////重置所选筛选条件
//- (void)reSetFilterViewDatawithParams:(NSDictionary *)dict{
//    if (dict) {
//        PPSearchResult *result = [dict objectForKey:@"PPSearchResult"];
//        self.searchResult = result; // readOnly
//        PPSearchCondition *condition = [dict objectForKey:@"PPSearchCondition"];
//        self.searchCondition = condition;
//    }
//
//    [self.searchCondition  clearFilters];
//    self.lowPrice = @"";
//    self.topPrice = @"";
//
//    [self setTheSearchResult:self.searchResult];
//
//    [self initData];
//
//    [self.tableView reloadData];
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop
//                                  animated:YES];
//}
//
//#pragma mark  filterHeader Methods
//- (void)closeCellAtIndex:(NSIndexPath *)path
//{
//    NewPropertyItem *item = [_propertyData objectAtIndex:path.row - 1 isArray:nil];
//    item.state = stateClosed;
//
//    
//    // 要插入的行
//    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
//    
//    [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:path.row + 1  inSection:path.section]];
//    
//    [_propertyData removeObjectAtIndex:path.row];
//
//    [self.tableView beginUpdates];
//
//    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView endUpdates];
//
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:path.row - 1 inSection:path.section];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop
//                                  animated:YES];
//}
//
//- (void)openCellAtIndex:(NSIndexPath *)path
//{
//    NewPropertyItem *item = [_propertyData objectAtIndex:path.row - 1 isArray:nil];
//
//    item.state = stateOpened;
//
//    // 要插入的行
//    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
//    
//    [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:path.row + 1 inSection:path.section]];//操作cell是 row + 1
//    NewPropertyItem *addItem = [[NewPropertyItem alloc] init];
//    addItem.subItemArray = item.subItemArray;
//    addItem.isTopCell = NO;
//    addItem.state = stateClosed;
//
//
//    [_propertyData insertObject:addItem atIndex:path.row ];
//
//    [self.tableView beginUpdates];
//
//    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView endUpdates];
//    
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:path.row inSection:path.section];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop
//                                              animated:YES];
//
//}
//
//- (void)filterHeaderTap:(UITapGestureRecognizer*)theTap
//{
//    [self endEditing:YES];
//    
//    
//    FilterHeadViewCell *headerView = (FilterHeadViewCell *)theTap.view.superview;
// 
//    if (!headerView) {
//        return;
//    }
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:headerView];
//
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:[NSNumber numberWithInteger:ActivitySectionOptions]];
//    
//    if (_classifyData.count) {
//        [array addObject:[NSNumber numberWithInteger:ClassifySectionOptions]];
//    }
//    [array addObject:[NSNumber numberWithInteger:PriceSectionOptions]];
//    [array addObject:[NSNumber numberWithInteger:AreaSectionOptions]];
//    if (_propertyData.count) {
//        [array addObject:[NSNumber numberWithInteger:PropertySectionOptions]];
//    }
//    
//    NSInteger rowOption = [[array objectAtIndex:indexPath.section isArray:nil] integerValue];
//
//
//    // 取得section
//    NSInteger section = indexPath.section;
//    if (rowOption == ClassifySectionOptions) {//商品类目---刷新cell
//
//        NewPropertyItem *item = (NewPropertyItem *)[sectionTitleArray objectAtIndex:section];
//        BOOL toOpen = YES;
//        if (item.state == stateOpened) {
//            toOpen = NO;
//            item.state = stateClosed;
//        }else{
//            item.state = stateOpened;
//        }
//
//        [headerView setOpen:toOpen animation:YES];
//
//        [self.tableView beginUpdates];
//        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:1];
//
//        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView endUpdates];
//
//    }
//    if (rowOption == AreaSectionOptions) {//发货地区---插入4个cell
//        
//        NewPropertyItem *item = (NewPropertyItem *)[sectionTitleArray objectAtIndex:section];
//        BOOL toOpen = YES;
//        if (item.state == stateOpened) {
//            toOpen = NO;
//            item.state = stateClosed;
//        }else{
//            item.state = stateOpened;
//        }
//
//        [headerView setOpen:toOpen animation:YES];
//
//        
//        if (toOpen) {
//            [self.tableView beginUpdates];
//            NSIndexPath *path1 = [NSIndexPath indexPathForRow:1 inSection:3];
//            NSIndexPath *path2 = [NSIndexPath indexPathForRow:2 inSection:3];
//            NSIndexPath *path3 = [NSIndexPath indexPathForRow:3 inSection:3];
//            NSIndexPath *path4 = [NSIndexPath indexPathForRow:4 inSection:3];
//            [self.tableView insertRowsAtIndexPaths:@[path1,path2,path3,path4] withRowAnimation:UITableViewRowAnimationNone];
//            [self.tableView endUpdates];
//        }else{
//            [self.tableView beginUpdates];
//            NSIndexPath *path1 = [NSIndexPath indexPathForRow:1 inSection:3];
//            NSIndexPath *path2 = [NSIndexPath indexPathForRow:2 inSection:3];
//            NSIndexPath *path3 = [NSIndexPath indexPathForRow:3 inSection:3];
//            NSIndexPath *path4 = [NSIndexPath indexPathForRow:4 inSection:3];
//            [self.tableView deleteRowsAtIndexPaths:@[path1,path2,path3,path4] withRowAnimation:UITableViewRowAnimationNone];
//            [self.tableView endUpdates];
//        }
//
//    }
//
//    if (rowOption == PropertySectionOptions) {//展开某个属性 在下面添加一个cell
//
//        NewPropertyItem *item = (NewPropertyItem *)[_propertyData objectAtIndex:indexPath.row - 1];
//        BOOL toOpen = YES;
//        if (item.state == stateOpened) {
//            toOpen = NO;
//        }
//
//        [headerView setOpen:toOpen animation:YES];
//        
//        if (toOpen)
//        {
//            [self openCellAtIndex:indexPath];
//        }
//        else
//        {
//            [self closeCellAtIndex:indexPath];
//        }
//
//
//    }
//
//}
//
//- (FilterHeadViewCell *)loadParentsCellOfIndexPath:(NSIndexPath *)indexPath
//{
//    CGRect rect = CGRectMake(0, 0, self.tableView.width, 44);
//    BOOL isAddGesture = YES;
//
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:[NSNumber numberWithInteger:ActivitySectionOptions]];
//    
//    if (_classifyData.count) {
//        [array addObject:[NSNumber numberWithInteger:ClassifySectionOptions]];
//    }
//    [array addObject:[NSNumber numberWithInteger:PriceSectionOptions]];
//    [array addObject:[NSNumber numberWithInteger:AreaSectionOptions]];
//    if (_propertyData.count) {
//        [array addObject:[NSNumber numberWithInteger:PropertySectionOptions]];
//    }
//    
//    NSInteger rowOption = [[array objectAtIndex:indexPath.section isArray:nil] integerValue];
//    NSString *rightName = @"";
//    NewPropertyItem *nItem = (NewPropertyItem *)[sectionTitleArray objectAtIndex:indexPath.section isArray:nil];
//    NSString *sectionName = nItem.pName;
//    BOOL isOPen = NO;
//
//
//    if (rowOption == ActivitySectionOptions) {
//        isAddGesture = NO;
//    }else if (rowOption == ClassifySectionOptions){
//        if (_classifyData.count == 0) {
//            isAddGesture = NO;
//        }else{
//            if (nItem.state == stateOpened) isOPen = YES;
//        }
//    }else if (rowOption == AreaSectionOptions){
//        switch (indexPath.row) {
//            case 0:
//            {
//                if (nItem.state == stateOpened) isOPen = YES;
//            }
//                break;
//            case 1:
//            {
//                FilterHeadViewCell *cell = [[FilterHeadViewCell alloc] initWithFrame:rect isShowArrow:NO];
//                cell.sectionName = @"区域";
//                cell.backgroundColor = [UIColor whiteColor];
//                return cell;
//            }
//                break;
//            case 3:
//            {
//                FilterHeadViewCell *cell = [[FilterHeadViewCell alloc] initWithFrame:rect isShowArrow:NO];
//                cell.sectionName = @"省份";
//                cell.backgroundColor = [UIColor whiteColor];
//                return cell;
//            }
//                break;
//            default:
//                break;
//        }
//    }else if (rowOption == PropertySectionOptions){
//
//            if (indexPath.row == 0) {
//                isAddGesture = NO;
//            }else{
//                rightName = @"全部";
//                isAddGesture = YES;
//                NewPropertyItem *item = [_propertyData objectAtIndex:indexPath.row - 1 isArray:nil];
//                if (!item.subItemArray.count) {
//                    isAddGesture = NO;
//                }else{
//                    sectionName = item.pName;
//                }
//                if (item.state == stateOpened) {
//                    isOPen = YES;
//                }
//            }
//    }
//
//    FilterHeadViewCell *cell = [[FilterHeadViewCell alloc] initWithFrame:rect isShowArrow:isAddGesture];
//
//    cell.sectionName = sectionName;
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.rightName = rightName;
//
//    
//    if (isAddGesture && isOPen) {
//        [cell setOpen:isOPen animation:YES];
//    }
//
//    if (isAddGesture) {
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
//                                              initWithTarget:self
//                                              action:@selector(filterHeaderTap:)];
////        [cell addGestureRecognizer:tapGesture];
//        [cell.tapView addGestureRecognizer:tapGesture];
//        if (rowOption == PropertySectionOptions)
//            [cell.tapView setFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
//    }
//    return cell;
//}
//
////创建cell上的btn
//- (UIButton *)getCellButton:(NSString *)title type:(FilterButtonType)bType withKey:(NSString *)key{
//    
//    UIColor *color = [UIColor colorWithHexString:@"D2C9B7"];
//    UIColor *bgColor = [UIColor colorWithHexString:@"FAFBF5"];
//    
//    CGRect rect = CGRectZero;
//    UIFont *font = [UIFont systemFontOfSize:11.0];
//
////    UIButton *button1 = [Common showInView:nil buttonType:UIButtonTypeCustom rect:rect title:title textColor:color textFont:font titleEdgeInsets:UIEdgeInsetsZero imageName:@"" imageEdgeInsets:UIEdgeInsetsZero tag:20000 addTarget:self action:@selector(cellButtonTouchAction:) bgColor:bgColor bgImageName:@""];
//    FilterButton *btn = [FilterButton buttonWithType:UIButtonTypeCustom];
//
//
//    btn.frame = rect;
//    [btn addTarget:self action:@selector(cellButtonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setBackgroundColor:bgColor];
//
//    
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitle:title forState:UIControlStateSelected];
//    [btn setTitleColor:color forState:UIControlStateNormal];
//    [btn setTitleColor:color forState:UIControlStateSelected];
//
//    btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    btn.titleLabel.numberOfLines = 1;
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
//    btn.titleLabel.font = font;
//    
//    btn.layer.borderColor = [UIColor colorWithHexString:@"E7E4DE"].CGColor;
//    btn.layer.borderWidth = 1.0;
//    btn.layer.cornerRadius = 5;
//    btn.layer.masksToBounds = YES;
//    
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//
//    NSString *bTypeStr = [NSString stringWithFormat:@"%d",(int)bType];
////    objc_setAssociatedObject(self, MyButtonType, bTypeStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
////    objc_setAssociatedObject(self, MyButtonKey, key, OBJC_ASSOCIATION_COPY_NONATOMIC);
///////   objc_setAssociatedObject  用的时候出现问题。。。。 搞了2、3个小时，太坑爹了！！！
//    btn.type = bTypeStr;
//    btn.key = key;
//
//    return btn;
//}
//
//- (UITableViewCell *)loadButtonsCellOfIndexPath:(NSIndexPath *)indexPath{
//    
//    NSUInteger row = [indexPath row];
//    NSUInteger section = [indexPath section];
//
//    NSString *identifier = @"ButtonTypeCell";
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//    cell.accessoryType = UITableViewCellSeparatorStyleNone;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    
//    [Util removeAllSubview:cell.contentView];
////    [Util removeAllSubview:cell];
//
//    NSArray *dataArr = nil;
//    FilterButtonType bType = ActivityFilterButtonType;
//    
//
//    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:[NSNumber numberWithInteger:ActivitySectionOptions]];
//    
//    if (_classifyData.count) {
//        [array addObject:[NSNumber numberWithInteger:ClassifySectionOptions]];
//    }
//    [array addObject:[NSNumber numberWithInteger:PriceSectionOptions]];
//    [array addObject:[NSNumber numberWithInteger:AreaSectionOptions]];
//    
//    if (_propertyData.count) {
//        [array addObject:[NSNumber numberWithInteger:PropertySectionOptions]];
//    }
//    
//    NSInteger rowOption = [[array objectAtIndex:section] integerValue];
//    if (rowOption == ActivitySectionOptions) {
//        bType = ActivityFilterButtonType;
//        dataArr = activityArray;
//        
//    }else if (rowOption == ClassifySectionOptions){
//
//            bType = ClassifyFilterButtonType;
//            int  length = (_classifyData.count > 3)?4:_classifyData.count;
//            
//            NewPropertyItem *item = (NewPropertyItem *)[sectionTitleArray objectAtIndex:indexPath.section isArray:nil];
//            
//            if (item.state == stateOpened) {
//                if (_classifyData.count > 11)length = 12;
//            }
//            
//            NSRange range = NSMakeRange(0,length);
//            dataArr = [_classifyData subarrayWithRange:range];
//        
//    }else if (rowOption == AreaSectionOptions){
//            bType = AreaFilterButtonType;
//            if (row == 2){
//                dataArr = areaArray;
//            }
//            if (row == 4) {
//                dataArr = provincesArray;
//            }
//    }else if (rowOption == PropertySectionOptions){
//            bType = ProPertyFilterButtonType;
//            NewPropertyItem *item = (NewPropertyItem *)[_propertyData objectAtIndex:row - 1 isArray:nil];
//            int  length = item.subItemArray.count;//(item.subItemArray.count > 9)?10:item.subItemArray.count;
//            NSRange range = NSMakeRange(0,length);
//            dataArr = [item.subItemArray subarrayWithRange:range];
//    }
// 
//    CGFloat padding_x = 10.0;
//    CGFloat padding_y = 15.0;
//    CGFloat width = (self.width - 5 * padding_x) * .25;
//    
//    CGFloat height = width / 3.35;//这里的3.35是根据ui上面的比例得来
//    
//    NSString *title = @"...";
//    NSString *key = @"";
//    BOOL isSelected = NO;
//
//    for (int i = 0; i < dataArr.count; i++) {
//        CGRect rect = CGRectMake(padding_x + (width + padding_x) * (i%4), padding_y + (height + padding_y) * (i/4), width, height);
//
//        switch (bType) {
//            case ActivityFilterButtonType:
//            {
//                PPPropertyItem *item = (PPPropertyItem *)[dataArr objectAtIndex:i isArray:nil];
//                title = item.clusterName;
//                isSelected = item.isSelected;
//                key = @"";
//            }
//                break;
//            case ClassifyFilterButtonType:
//            {
//                PPPropertyItem *propertyItem = (PPPropertyItem *)[dataArr objectAtIndex:i isArray:nil];
//                title = propertyItem.clusterName;
//                key = propertyItem.path;
//                isSelected = propertyItem.isSelected;
//            }
//                break;
//             case AreaFilterButtonType:
//            {
//                PPPropertyItem *areaItem = (PPPropertyItem *)[dataArr objectAtIndex:i isArray:nil];
//                title = areaItem.clusterName;
//                key = @"";
//                isSelected = areaItem.isSelected;
//            }
//                break;
//            case ProPertyFilterButtonType:
//            {
//                PPPropertyItem *pItem = (PPPropertyItem *)[dataArr objectAtIndex:i isArray:nil];
//                title = pItem.clusterName;
//                key = pItem.path;
//                isSelected = pItem.isSelected;
//            }
//
//            default:
//                break;
//        }
//        
//        
//        UIButton *button = [self getCellButton:title type:bType withKey:key];
//        button.frame = rect;
//        button.selected = isSelected;
//        if (button.selected) {
//            button.layer.borderColor = [UIColor colorWithHexString:@"F5303A"].CGColor;//红色
//            button.titleLabel.textColor = [UIColor colorWithHexString:@"F5303A"];
//            [button setTintColor:[UIColor colorWithHexString:@"F5303A"]];////IOS7 有效
//        }
//        button.tag = i + kClusterButtonTag;
//
//        [cell.contentView addSubview:button];
//
//    }
//    
//    
//    
//    return cell;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:[NSNumber numberWithInteger:ActivitySectionOptions]];
//    
//    if (_classifyData.count) {
//        [array addObject:[NSNumber numberWithInteger:ClassifySectionOptions]];
//    }
//    [array addObject:[NSNumber numberWithInteger:PriceSectionOptions]];
//    [array addObject:[NSNumber numberWithInteger:AreaSectionOptions]];
//    if (_propertyData.count) {
//        [array addObject:[NSNumber numberWithInteger:PropertySectionOptions]];
//    }
//
//    return array.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    int num = 1;
//
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:[NSNumber numberWithInteger:ActivitySectionOptions]];
//    
//    if (_classifyData.count) {
//        [array addObject:[NSNumber numberWithInteger:ClassifySectionOptions]];
//    }
//    [array addObject:[NSNumber numberWithInteger:PriceSectionOptions]];
//    [array addObject:[NSNumber numberWithInteger:AreaSectionOptions]];
//
//    if (_propertyData.count) {
//        [array addObject:[NSNumber numberWithInteger:PropertySectionOptions]];
//    }
//
//    NSInteger rowOption = [[array objectAtIndex:section] integerValue];
//    if (rowOption == ActivitySectionOptions) {
//        num = 2;
//
//    }else if (rowOption == ClassifySectionOptions){
//        if (_classifyData.count) {
//            num = 2;
//        }
//    }else if (rowOption == AreaSectionOptions){
//        
//        NewPropertyItem *item = (NewPropertyItem *)[sectionTitleArray objectAtIndex:section isArray:nil];
//        
//        if (item.state == stateOpened) {
//            num = 5;
//        }else{
//            num = 1;
//        }
//
//    }else if (rowOption == PropertySectionOptions){
//        if (_propertyData.count) {
//            num += _propertyData.count;
//        }
//    }else if (rowOption == PriceSectionOptions){
//        num = 1;
//    }
//    
//    
//    return num;
//    
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView loadPriceCellOfIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *cellIdentifier = @"PriceCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        UITextField *leftField = [[UITextField alloc] init];
//        leftField.text = @"";
//        leftField.textColor = [UIColor colorWithHexString:@"7F735B"];
////        leftField.borderStyle = UITextBorderStyleLine;
//        leftField.layer.borderColor = [UIColor colorWithHexString:@"E7E4DE"].CGColor;
//        leftField.layer.borderWidth = 1.0;
//        leftField.keyboardType = UIKeyboardTypeNumberPad;
//        leftField.textAlignment = NSTextAlignmentCenter;
//        leftField.delegate = self;
//        leftField.tag = 888;
//
//        UITextField *rightField = [[UITextField alloc] init];
//        rightField.text = @"";
//        rightField.textColor = [UIColor colorWithHexString:@"7F735B"];
//        //        leftField.borderStyle = UITextBorderStyleLine;
//        rightField.layer.borderColor = [UIColor colorWithHexString:@"E7E4DE"].CGColor;
//        rightField.layer.borderWidth = 1.0;
//        rightField.keyboardType = UIKeyboardTypeNumberPad;
//        rightField.textAlignment = NSTextAlignmentCenter;
//        rightField.delegate = self;
//        rightField.tag = 999;
//
//        CGRect rect = CGRectMake(120, 15, 85, 30);
//        rect = PPRect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
//        leftField.frame = rect;
//        rect = CGRectMake(225, 15, 85, 30);
//        rect = PPRect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
//        rightField.frame = rect;
//
//        [cell.contentView addSubview:leftField];
//        [cell.contentView addSubview:rightField];
//        
//        rect = PPRect(212, 29, 8, 1);
//        UIView *lineView = [[UIView alloc] initWithFrame:rect];
//        lineView.backgroundColor = [UIColor colorWithHexString:@"463417"];
//        [cell.contentView addSubview:lineView];
//        
//        UILabel *sectionNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (60 - 30.0) / 2.0, 230.0, 30.0)];
//        sectionNameLabel.font = [UIFont systemFontOfSize:15.0];
//        sectionNameLabel.textColor = [UIColor colorWithHexString:@"463417"];
//        sectionNameLabel.backgroundColor = [UIColor clearColor];
////        NewPropertyItem *nItem = (NewPropertyItem *)[sectionTitleArray objectAtIndex:indexPath.section isArray:nil];
//        sectionNameLabel.text  = @"价格区间（元）";//nItem.pName;
//        [cell.contentView addSubview:sectionNameLabel];
//
//    }
//    
//    UITextField *left = (UITextField *)[cell.contentView viewWithTag:888];
//    UITextField *right = (UITextField *)[cell.contentView viewWithTag:999];
//
//    left.text = self.lowPrice;
//    right.text = self.topPrice;
//
//    return cell;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    int section = indexPath.section;
//    int row     = indexPath.row;
// 
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:[NSNumber numberWithInteger:ActivitySectionOptions]];
//    
//    if (_classifyData.count) {
//        [array addObject:[NSNumber numberWithInteger:ClassifySectionOptions]];
//    }
//    [array addObject:[NSNumber numberWithInteger:PriceSectionOptions]];
//    [array addObject:[NSNumber numberWithInteger:AreaSectionOptions]];
//
//    if (_propertyData.count) {
//        [array addObject:[NSNumber numberWithInteger:PropertySectionOptions]];
//    }
//    
//    NSInteger rowOption = [[array objectAtIndex:section] integerValue];
//    
//    if (rowOption == PriceSectionOptions){
//        
//        UITableViewCell *cell = [self tableView:tableView loadPriceCellOfIndexPath:indexPath];
//        
//        return cell;
//    }
//
//    if (row == 0) {//标题所在的cell
//        FilterHeadViewCell *cell = [self loadParentsCellOfIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//    }
//
//    if (rowOption == ActivitySectionOptions) {
//
//        if (row == 1) {
//            UITableViewCell *cell = [self loadButtonsCellOfIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//
//    }else if (rowOption == ClassifySectionOptions){
//        if (row == 1) {
//            UITableViewCell *cell = [self loadButtonsCellOfIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//        
//    }else if (rowOption == AreaSectionOptions){
//
//        switch (row) {
//            case 1:
//            {
//                FilterHeadViewCell *cell = [self loadParentsCellOfIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                return cell;
//            }
//                break;
//            case 2:
//            {
//                UITableViewCell *cell = [self loadButtonsCellOfIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                return cell;
//            }
//                break;
//            case 3:
//            {
//                FilterHeadViewCell *cell = [self loadParentsCellOfIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                return cell;
//            }
//                break;
//            case 4:
//            {
//                UITableViewCell *cell = [self loadButtonsCellOfIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                return cell;
//            }
//                break;
//            default:
//                break;
//        }
//
//    }
////    else if (rowOption == PropertySectionOptions)
////    {
//        FilterHeadViewCell *cell = nil;
//        NewPropertyItem *item = [_propertyData objectAtIndex:row - 1 isArray:nil];
//        if (item.isTopCell) {
//            cell = [self  loadParentsCellOfIndexPath:indexPath];
//        }else{
//            UITableViewCell *cell = [self loadButtonsCellOfIndexPath:indexPath];
//            return cell;
//        }
//            return cell;
////    }
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    CGFloat height = 44;
//
//    int section = indexPath.section;
//    int row     = indexPath.row;
//
//    
//    CGFloat padding_x = 10.0;
//    CGFloat padding_y = 15.0;
//    CGFloat width = (self.width - 5 * padding_x) * .25;
//    
//    CGFloat h = width / 3.35;//20.0;
//    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:[NSNumber numberWithInteger:ActivitySectionOptions]];
//    
//    if (_classifyData.count) {
//        [array addObject:[NSNumber numberWithInteger:ClassifySectionOptions]];
//    }
//    [array addObject:[NSNumber numberWithInteger:PriceSectionOptions]];
//    [array addObject:[NSNumber numberWithInteger:AreaSectionOptions]];
//
//    if (_propertyData.count) {
//        [array addObject:[NSNumber numberWithInteger:PropertySectionOptions]];
//    }
//    
//    NSInteger rowOption = [[array objectAtIndex:section] integerValue];
//
//    if (rowOption == PriceSectionOptions) {
//        height = 60;
//        return height;
//    }
//    
//    if (indexPath.row == 0) {
//        return height;
//    }
//
//
//    if (rowOption == ActivitySectionOptions) {
//        if (row == 1) height = 50.0;
//    }else if (rowOption == ClassifySectionOptions){
//
//        if (row == 1) {
//            if (_classifyData.count) {
//                height = 50.0;
//            }
//            NewPropertyItem *item = (NewPropertyItem *)[sectionTitleArray objectAtIndex:section isArray:nil];
//            if (item.state == stateClosed){
//                height = 50.0;// 默认开始只展示一行
//            }else{
//                int count = 1;//展示的行数
//                int length = (_classifyData.count > 3)?4:_classifyData.count;
//                if (_classifyData.count > 11)length = 12;
//                int rowCount = length % 4;
//                if (rowCount == 0) {
//                    count = length / 4;
//                }else{
//                    count = 1 + length / 4;
//                }
//
//                height = (padding_y + h) * count + padding_y;
//            }
//        }
//
//    }else if (rowOption == AreaSectionOptions){
//        if (row == 1 || row == 3) {
//            height = 44.0;
//        }else if (row == 2){
//            int count = 2;
//            height = (padding_y + h) * count + padding_y;
//            
//        }else if(row == 4){
//            int count = 1;//展示的行数
//            count = 1 + provincesArray.count / 4;
//            height = (padding_y + h) * count + padding_y;
//        }
//    }else if (rowOption == PropertySectionOptions){
//
//        if (row == 0) {
//            height = 44.0;
//        }else{
//            NewPropertyItem  *item = (NewPropertyItem *)[_propertyData objectAtIndex:row - 1 isArray:nil];
//            if (!item.isTopCell) {
//                int count = 1;//展示的行数
//                int length = item.subItemArray.count;//(item.subItemArray.count > 9)?10:item.subItemArray.count;
////                count = 1 + length / 4;
//                int rowCount = length % 4;
//                if (rowCount == 0) {
//                    count = length / 4;
//                }else{
//                    count = 1 + length / 4;
//                }
//
//                height = (padding_y + h) * count + padding_y;
//                
//            }else{
//                height = 44.0;
//            }
//        }
//
//    }
//    
//    
//    
//    return height;
//
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.1;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 0)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10.0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 10)];
//    view.backgroundColor = [UIColor colorWithHexString:@"F9F9F4"];
//    return view;
//}
//
//
//-(void)viewDidLayoutSubviews
//{
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
//}
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}
//
//#pragma mark  textFieldDelegate Method--
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop
//                                  animated:YES];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//
//    if (textField.tag == 888) {
//        self.lowPrice  = textField.text;
//    }else if (textField.tag == 999){
//        self.topPrice = textField.text;
//    }
//    NSInteger low = [self.lowPrice integerValue];
//    NSInteger top = [self.topPrice integerValue];
//
////    long maxTop = 2 ^ 31 - 1;
////    if (low > maxTop) {
////        low = maxTop;
////        self.lowPrice = [NSString stringWithFormat:@"%ld",maxTop];
////    }
////    if (top > maxTop) {
////        top = maxTop;
////        self.topPrice = [NSString stringWithFormat:@"%ld",maxTop];
////    }
//
//    NSInteger temp = 0;
//    if (top == 0) {
//        top = NSIntegerMax;
//    }
//
//    if (low > top) {
//        temp = top;
//        top = low;
//        low = temp;
//    }
//    [self.searchCondition setBeginPrice:low];
//    [self.searchCondition setEndPrice:top];
//
//}
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//        int alength = [string length];
//        for (int i = 0; i < alength; i++) {
//            char achar = [string characterAtIndex:i];
//            
//            if((achar < 47) || (achar > 58)){
//                [Common showErrorWithText:@"请您输入数字" duration:1.8];
//                return NO;
//            }
//
//        }
//
//    
//    if (textField.tag == 888) {
//        self.lowPrice  = textField.text;
//    }else if (textField.tag == 999){
//        self.topPrice = textField.text;
//    }
//    return YES;
//}
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//@end
