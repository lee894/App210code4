//
//  KLViewController.h
//  KLScrollSelectViewController
//
//  Created by Kieran Lafferty on 2013-04-02.
//  Copyright (c) 2014 KieranLafferty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

#define kDefaultCellImageEdgeInset UIEdgeInsetsMake(5, 5, 5, 5)
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@class KLScrollSelectViewController, KLScrollingColumn, KLScrollSelect;
//自定义tableview的委托方法
@protocol KLScrollingColumnDelegate <NSObject>
@optional
- (void) willUpdateContentOffsetForColumn: (KLScrollingColumn*) column;
- (void) didUpdateContentOffsetForColumn: (KLScrollingColumn*) column;
@end
@protocol KLScrollSelectDelegate <NSObject>
@optional
- (void)scrollSelect:(KLScrollSelect *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath;
@end
//自定义tableview的数据源方法
@protocol KLScrollSelectDataSource <NSObject>
@required
//单元格数
- (NSInteger)scrollSelect:(KLScrollSelect *)scrollSelect numberOfRowsInColumnAtIndex:(NSInteger)index;
- (UITableViewCell*) scrollSelect:(KLScrollSelect*) scrollSelect cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (CGFloat) scrollSelect: (KLScrollSelect*) scrollSelect heightForColumnAtIndex: (NSInteger) index;
- (CGFloat) scrollRateForColumnAtIndex: (NSInteger) index;
- (CGFloat)offsetDeltaForColumnAtIndex: (NSInteger) index;
//section数
- (NSInteger)scrollSelect:(KLScrollSelect *)scrollSelect numberOfSectionsInColumnAtIndex:(NSInteger)index;
// Default is 1 if not implemented
//tableview个数
- (NSInteger)numberOfColumnsInScrollSelect:(KLScrollSelectViewController *)scrollSelect;
@end


//控件基类，实现tableview的数据源和委托，实现scroll列的委托
@interface KLScrollSelect : UIView <UITableViewDelegate, UITableViewDataSource, KLScrollingColumnDelegate>
@property (nonatomic, retain) NSArray* columns;
@property (nonatomic, assign)  id<KLScrollSelectDataSource> dataSource;
@property (nonatomic, assign)  id<KLScrollSelectDelegate> delegate;
@property (nonatomic, assign) float lastConSize;
@property (nonatomic, assign) BOOL isNormal;
- (NSInteger)scrollSelect:(KLScrollSelect *)scrollSelect numberOfRowsInColumnAtIndex:(NSInteger)index;
- (NSInteger)scrollSelect:(KLScrollSelect *)scrollSelect numberOfSectionsInColumnAtIndex:(NSInteger)index;
- (CGFloat) scrollSelect: (KLScrollSelect*) scrollSelect heightForColumnAtIndex: (NSInteger) index;

//Actions
- (UITableViewCell*) cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfColumnsInScrollSelect:(KLScrollSelect *)scrollSelect;
- (CGFloat) scrollRateForColumnAtIndex: (NSInteger) index;

- (KLScrollingColumn*) columnAtIndex:(NSInteger) index;
@end


//自定义的可自动移动的tableview子类，实现scrollview的委托tableview 的委托
@interface KLScrollingColumn : UITableView <UIScrollViewDelegate, UITableViewDelegate>
@property (nonatomic, assign) id<KLScrollingColumnDelegate> columnDelegate;
@property (nonatomic) CGFloat offsetDelta;//滚动幅度，每次滚动的像素
@property (nonatomic) CGFloat scrollRate;//滚动频率，每秒滚动次数
@property (nonatomic) CGFloat offsetAccumulator;
@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic) CGFloat animationDuration;

- (void)resetContentOffsetIfNeeded;//重新设置偏移量
-(void) startScrollingDriver:(BOOL)isNorm ;
- (void)stopScrollingDriver;
-(BOOL) animating;
@end


//自定义带图像cell
@interface KLImageCell : UITableViewCell
@property (nonatomic, retain) UrlImageView* image;
@property (nonatomic, retain) UILabel* label;
@property (nonatomic, retain) UILabel *labelMain;
@property (nonatomic,assign) KLScrollingColumn *superTable;
@property (nonatomic, retain) UIButton *btnVideo;
@end


//NSIndexPath分类
@interface NSIndexPath (Column)
+ (NSIndexPath *)indexPathForRow:(NSInteger) row
                       inSection:(NSInteger) section
                        inColumn:(NSInteger) column;

@property(nonatomic, readonly) NSInteger column;
@end


//使用改自定义空间的控制器
@interface KLScrollSelectViewController : UIViewController <KLScrollSelectDataSource, KLScrollSelectDelegate>
@property (nonatomic, retain) KLScrollSelect* scrollSelect;
@end

