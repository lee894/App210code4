////
////  SearchFilterView.h
////  paipaiiphone
////
////  Created by zhangwenguang on 15/3/24.
////  Copyright (c) 2015年 lee. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
////#import "PPSearchCondition.h"
//#import "PPSearchResult.h"
//
//
//#import "PPSearchConstants.h"
//#import "PPProperty.h"
//#import "PPPath.h"
//#import "PPCluster.h"
//
//#import "PPSearchUtil.h"
//
//
//@protocol FilterViewDelegate <NSObject>
//
//@required
///*
// 点击筛选view底部的半透明部分，则remove此view
// */
//- (void)cancleFilter;
///*
//点击“确定”去搜索
// */
//- (void)searchByFilter:(PPSearchCondition *)searchCondition;
//
//@end
//
//
//
///*
// cell (右边带箭头的)标志的状态,箭头的默认方向朝下为stateClosed
// */
//typedef enum
//{
//    stateClosed = 3, // 关闭
//    stateOpened = 4  // 展开
//
//}FilterCellState;
//
//
//@interface NewPropertyItem : NSObject
//
//@property (nonatomic,retain) NSString *pName;
//@property (nonatomic,retain) NSArray *subItemArray;
//@property (nonatomic,assign) NSInteger state;// FilterCellState  属性cell状态
//@property (nonatomic,assign) BOOL isTopCell;
//
//@end
//
//
//@interface SearchFilterView : UIView
//
//
//@property (nonatomic,assign) id<FilterViewDelegate>  delegate;
//@property (nonatomic,retain) PPSearchResult *searchResult;
//@property (nonatomic,retain) PPSearchCondition *searchCondition;
//
//
//- (instancetype)initWithFrame:(CGRect) frame withParams:(NSDictionary *)dict;
//- (void)reSetFilterViewDatawithParams:(NSDictionary *)dict; //刷新filteview
//
//
//@end
