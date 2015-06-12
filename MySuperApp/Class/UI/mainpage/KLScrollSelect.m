//
//  KLViewController.m
//  KLScrollSelectViewController
//
//  Created by Kieran Lafferty on 2013-04-02.
//  Copyright (c) 2014 KieranLafferty. All rights reserved.
//

#import "KLScrollSelect.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CATransform3D.h>
#import <objc/runtime.h>
#import "MYMacro.h"

#define pixelPerTime 0.5
#define LabelPixelPerTime 0.03
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#define TRANSLATED_INDEX_PATH( __INDEXPATH__, __TOTALROWS__ ) [self translatedIndexPath:__INDEXPATH__ forTotalRows:__TOTALROWS__]
#define ROUND_NEAREST_HALF(__NUM__)
@implementation KLScrollSelectViewController
@synthesize scrollSelect;
- (void)dealloc
{
    [scrollSelect release];
    [super dealloc];
}
-(void) viewDidLoad {
    [super viewDidLoad];
    
    self.scrollSelect = [[[KLScrollSelect alloc] initWithFrame: self.view.bounds] autorelease];
    [self.scrollSelect setDataSource: self];
    [self.scrollSelect setDelegate: self];
    [self.view addSubview:self.scrollSelect];
}
- (NSInteger)scrollSelect:(KLScrollSelect *)scrollSelect numberOfRowsInColumnAtIndex:(NSInteger)index {
    return 0;
}
- (UITableViewCell*) scrollSelect:(KLScrollSelect*) scrollSelect cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
@end



//分类
@interface KLScrollSelect()
-(void) populateColumns;
-(NSIndexPath*) translatedIndexPath: (NSIndexPath*) indexPath forTotalRows:(NSInteger) totalRows;
-(NSInteger) indexOfColumn:(KLScrollingColumn*) column;
-(void) startScrollingDriver:(BOOL)isNorm;
-(void) stopScrollingDriver;
-(NSArray*) columnsWithoutColumn:(KLScrollingColumn*) column;

@property (nonatomic) BOOL shouldResumeAnimating;
@property (nonatomic,retain) NSArray* passengers;//除了driver以外的tableview
@property (nonatomic,retain) KLScrollingColumn* driver;
@property (nonatomic,retain) KLScrollingColumn* smallestColumn;//最少行
@property (nonatomic, retain) NSTimer* animationTimer;//定时器

-(BOOL) animating;
@end




@implementation KLScrollSelect
@synthesize lastConSize;
@synthesize isNormal;
@synthesize columns;
@synthesize dataSource;
@synthesize delegate;
- (void)dealloc
{
    [columns release];
    self.delegate=nil;
    self.dataSource=nil;
    self.passengers=nil;
    self.driver=nil;
    self.smallestColumn=nil;
    [self.animationTimer invalidate];
    self.animationTimer=nil;
    [super dealloc];
}
-(BOOL) animating {
    return  (BOOL)self.animationTimer;
}
-(NSArray*) passengers {
    return [self columnsWithoutColumn: self.driver];
}
-(NSArray*) columnsWithoutColumn:(KLScrollingColumn*) column {
    return [self.columns filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return evaluatedObject != column;
    }]];
}
//生成视图的时候调用重新布局，刷新子视图
-(void) layoutSubviews {
    [super layoutSubviews];
    [self populateColumns];
    isNormal=YES;
    [self startScrollingDriver:NO];
    
}

-(void) populateColumns {
    
    //lee999适配IOS8
    NSLog(@"self.columns======%d",[self.columns count]);
    if (isIOS8up && [self.columns count]>0) {
        return;
    }
    //end
    
    //列数
    NSInteger numberOfColumns = [self numberOfColumnsInScrollSelect:self];
    //创建放tableview的数组
    NSMutableArray* columArr = [[[NSMutableArray alloc] initWithCapacity:numberOfColumns] autorelease];

    for (NSInteger count = 0; count < numberOfColumns;  count++) {//numberOfColumns
        //Make the frame the entire height and the width the width of the superview divided by number of columns
        CGRect columnFrame = CGRectMake(0, 0,HEIGHT,WIDTH);//480,480);//480//columnWidth * count-10//columnWidth
        KLScrollingColumn* column1 = [[KLScrollingColumn alloc] initWithFrame:columnFrame style:UITableViewStylePlain];
        //         NSLog(@"表格前：%@",column1);
        //        NSLog(@"%f---%f",column1.center.x,column1.center.y);
        
        column1.transform=CGAffineTransformMakeRotation(-M_PI/2);
        //        NSLog(@"表格后：%@",column1);
        //        NSLog(@"%f---%f",column1.center.x,column1.center.y);
        column1.frame=CGRectMake(0, 0,HEIGHT,WIDTH);
        //        NSLog(@"表格最后：%@",column1);
        //        NSLog(@"%f---%f",column1.center.x,column1.center.y);
        column1.backgroundColor=[UIColor clearColor];
        
        [column1 setDataSource:self];
        [column1 setRowHeight: [self scrollSelect:self heightForColumnAtIndex:count]];
        [column1 setSeparatorStyle: UITableViewCellSeparatorStyleNone];
        //[column1 setBackgroundColor:[UIColor blackColor]];
        [column1 setColumnDelegate:self];
        [column1 setScrollRate: [self.dataSource scrollRateForColumnAtIndex: count]];
        [column1 setOffsetDelta:[self.dataSource offsetDeltaForColumnAtIndex:count]];
        [column1 setDelegate:self];
        [columArr addObject: column1];
        [column1 release];
        
        if (![[self subviews] containsObject: column1]) {
            [self addSubview:column1];
        }
    }
    self.columns = columArr;
    NSInteger smallestCount = -1;
    //所有tableview中行数最少的cell个数
    for (KLScrollingColumn* column in self.columns) {
        NSInteger currentNumRows =  [self tableView:column numberOfRowsInSection:0];
        if (smallestCount < 0 || currentNumRows < smallestCount) {
            smallestCount = currentNumRows;
            //获取所有tableview行数最小值
            self.smallestColumn = column;
        }
    }
    
}
#pragma mark - Driver & Passenger animation implementation
-(void) startScrollingDriver:(BOOL)isNorm {
    
    self.driver =[self.columns lastObject]; //self.columns[0];//所有的滚动列的数组
    for(KLScrollingColumn*colum in self.columns)
    {
        [colum startScrollingDriver:isNorm];
    }
    
}

- (void)stopScrollingDriver {
    for(KLScrollingColumn*colum in self.columns)
    {
        [colum stopScrollingDriver];
    }
}

#pragma mark - UIScrollViewDelegate implementation
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //Stop animating driver
    
    [self setDriver: (KLScrollingColumn*) scrollView];
    lastConSize=scrollView.contentOffset.y;
    [self stopScrollingDriver];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //Start animating driver
    // NSLog(@"滚动结束");
    if(scrollView.contentOffset.y<lastConSize)
    {
        isNormal=YES;
        [self startScrollingDriver:NO];
        NSLog(@" 向左滑");
    }
    else
    {
        isNormal=NO;
        [self startScrollingDriver:YES];
        NSLog(@" 向右滑");
    }
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // NSLog(@"拖拽结束");
    if (!decelerate) {
        if(scrollView.contentOffset.y<lastConSize)
        {
            isNormal=NO;
            [self startScrollingDriver:NO];
            // NSLog(@" 向左滑");
        }
        else
        {
            isNormal=YES;
            [self startScrollingDriver:YES];
            // NSLog(@" 向右滑");
        }
    }
}

#pragma  UITableViewDataSource implementation
//Column data source implementation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger columnIndex = [self indexOfColumn: (KLScrollingColumn*)tableView];
    NSInteger numberOfRows = [self scrollSelect:self numberOfRowsInColumnAtIndex: columnIndex] * 3;
    return numberOfRows;
}

-(NSInteger) numberOfSectionsInTableView:(KLScrollingColumn *)tableView {
    return [self scrollSelect:self numberOfSectionsInColumnAtIndex:[self indexOfColumn: tableView]];
}
-(UITableViewCell*) tableView:(KLScrollingColumn *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger columnIndex = [self indexOfColumn:tableView];
    NSIndexPath* translatedIndex = TRANSLATED_INDEX_PATH(indexPath, [self scrollSelect:self
                                                           numberOfRowsInColumnAtIndex:columnIndex]);
    
    
    return [self cellForRowAtIndexPath: [NSIndexPath indexPathForRow: translatedIndex.row
                                                           inSection: translatedIndex.section
                                                            inColumn: columnIndex]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger columnIndex = [self indexOfColumn: (KLScrollingColumn*)tableView];
    NSIndexPath* translatedIndex = TRANSLATED_INDEX_PATH(indexPath, [self scrollSelect: self
                                                           numberOfRowsInColumnAtIndex: columnIndex]);
    if ([self.delegate respondsToSelector:@selector(scrollSelect:didSelectCellAtIndexPath:)]) {
        [self.delegate scrollSelect:self didSelectCellAtIndexPath:[NSIndexPath indexPathForRow: translatedIndex.row
                                                                                     inSection: translatedIndex.section
                                                                                      inColumn: columnIndex]];
    }
}

#pragma mark - Delegate Implementation
- (CGFloat) scrollSelect: (KLScrollSelect*) scrollSelect heightForColumnAtIndex: (NSInteger) index {
    if ([self.dataSource respondsToSelector:@selector(scrollSelect:heightForColumnAtIndex:)]) {
        return [self.dataSource scrollSelect:self heightForColumnAtIndex:index];
    }
    else return 150.0;
}
-(NSIndexPath*) translatedIndexPath: (NSIndexPath*) indexPath forTotalRows:(NSInteger) totalRows{
    return [NSIndexPath indexPathForRow: indexPath.row % totalRows
                              inSection: indexPath.section];
}

#pragma mark - Datasource Implementation
- (NSInteger)scrollSelect:(KLScrollSelect *)scrollSelect numberOfRowsInColumnAtIndex:(NSInteger)index {
    return [self.dataSource scrollSelect: self
             numberOfRowsInColumnAtIndex: index];
}
- (NSInteger)scrollSelect:(KLScrollSelect *)scrollSelect numberOfSectionsInColumnAtIndex:(NSInteger)index {
    if ([self.dataSource respondsToSelector:@selector(scrollSelect:numberOfSectionsInColumnAtIndex:)]) {
        return [self.dataSource scrollSelect:self numberOfSectionsInColumnAtIndex: index];
    }
    else return 1;
}

-(NSInteger) numberOfColumnsInScrollSelect:(KLScrollSelectViewController *)scrollSelect {
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInScrollSelect:)]) {
        return [self.dataSource numberOfColumnsInScrollSelect:scrollSelect];
    }
    else return 1;
}
- (UITableViewCell*) cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource scrollSelect:self cellForRowAtIndexPath:indexPath];
}
- (KLScrollingColumn*) columnAtIndex:(NSInteger) index {
    return [self.columns objectAtIndex:index];
}
- (CGFloat) scrollRateForColumnAtIndex: (NSInteger) index {
    if ([self.dataSource respondsToSelector:@selector(scrollRateForColumnAtIndex:)]) {
        return [self.dataSource scrollRateForColumnAtIndex:index];
    }
    else return 10.0;
}
- (CGFloat)offsetDeltaForColumnAtIndex: (NSInteger) index
{
    if ([self.dataSource respondsToSelector:@selector(offsetDeltaForColumnAtIndex:)]) {
        return [self.dataSource offsetDeltaForColumnAtIndex:index];
    }
    else return 10.0;
}
-(NSInteger) indexOfColumn:(KLScrollingColumn*) column {
    return [self.columns indexOfObject: column];
}
//将要更新某个tableview的contentoffset时执行
- (void) willUpdateContentOffsetForColumn: (KLScrollingColumn*) column {
    if (column == self.driver) {
    }
}
//更新内容的时候contentoffset时执行
- (void) didUpdateContentOffsetForColumn: (KLScrollingColumn*) column {
    if (column == self.driver) {
    }
}
@end

//自定义tableview 分类
@interface KLScrollingColumn()
{
    int mTotalCellsVisible;
    BOOL isResettingContent;
    NSInteger _totalRows;
}
- (void) resetContentOffsetIfNeeded;
- (BOOL) didReachBottomBounds;
- (BOOL) didReachTopBounds;
@end

@implementation KLScrollingColumn
@synthesize columnDelegate;
@synthesize offsetAccumulator;
@synthesize offsetDelta;
@synthesize scrollRate;
@synthesize timer;
@synthesize animationDuration;

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    self.columnDelegate=nil;
    [super dealloc];
}
-(BOOL) animating {
    return  (BOOL)self.timer;
}
-(void) startScrollingDriver:(BOOL)isNorm {
    if (self.animating) {
        return;
    }
    self.animationDuration =0.5 / self.scrollRate;//0.5f//每秒多少像素
    self.timer = [NSTimer scheduledTimerWithTimeInterval: self.animationDuration
                                                  target:self
                                                selector:@selector(updateDriverOffset:)
                                                userInfo:[NSNumber numberWithBool:isNorm]
                                                 repeats:YES];
    [self.timer fire];
}
-(void) updateDriverOffset:(NSTimer*)isNorm{
    //    return;
    //CGFloat pointChange =self.offsetDelta;//0.5;// 0.5
    CGPoint newOffset = self.contentOffset;
    if(((KLScrollSelect*)self.columnDelegate).isNormal)
    {
        newOffset.y = newOffset.y + pixelPerTime;
        for (KLImageCell *cell in self.visibleCells) {
            CGRect rect=cell.label.frame;
            rect.origin.x+=LabelPixelPerTime;
            //            cell.label.frame=rect;
        }
    }
    else
    {
        newOffset.y = newOffset.y - pixelPerTime;
        for (KLImageCell *cell in self.visibleCells) {
            CGRect rect=cell.label.frame;
            rect.origin.x-=LabelPixelPerTime;
            //            cell.label.frame=rect;
        }
    }
    
    [self setContentOffset: newOffset];
    
}

- (void)stopScrollingDriver {
    if (!self.animating) {
        return;
    }
    [self.layer removeAllAnimations];
    [self.timer invalidate];
    self.timer = nil;
    
}

//判断是否滑到了顶端
- (BOOL) didReachTopBounds {
    return self.contentOffset.y <= 0.0;
}
//判断是否滑到了底端
- (BOOL) didReachBottomBounds {
    return self.contentOffset.y >= ( self.contentSize.height - self.bounds.size.height);
}
- (void)resetContentOffsetIfNeeded
{
    CGPoint contentOffset  = self.contentOffset;
    //check the top condition
    //check if the scroll view reached its top.. if so.. move it to center.. remember center is the start of the data repeating for 2nd time.
    if ([self didReachTopBounds] || [self didReachBottomBounds]) {
        isResettingContent = YES;
        if([self didReachTopBounds])
        {
            contentOffset.y = self.contentSize.height/3.0f;
            ((KLScrollSelect*)self.delegate).lastConSize=contentOffset.y;
        }
        
        else if([self didReachBottomBounds] )//scrollview content offset reached bottom minus the height of the tableview
            //this scenario is same as the data repeating for 2nd time minus the height of the table view
        {
            contentOffset.y = self.contentSize.height/3.0f - self.bounds.size.height;
            ((KLScrollSelect*)self.delegate).lastConSize=contentOffset.y;
        }
        
        [self setContentOffset: contentOffset];
        isResettingContent = NO;
    }
}

//The heart of this app.
//this function iterates through all visible cells and lay them in a circular shape
#pragma mark Layout

- (void)layoutSubviews
{
    //NSLog(@"tableView重新布局");
    [super layoutSubviews];
    //显示的总的cell个数
    mTotalCellsVisible = self.frame.size.height / self.rowHeight;
    [self resetContentOffsetIfNeeded];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    
    [super willMoveToWindow:newWindow];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
}

@end

@implementation KLImageCell
@synthesize superTable;
@synthesize image;
@synthesize label;
@synthesize labelMain;

- (void)dealloc
{
    [_btnVideo release];
    self.labelMain = nil;
    self.superTable=nil;
    self.image=nil;
    self.label=nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        if (self.image == nil) {
            self.backgroundColor = [UIColor clearColor];
            self.image=[[[UrlImageView alloc] initWithFrame:CGRectMake(0, 0,0,0)] autorelease];
            
            [self.image setClipsToBounds:NO];
            self.image.transform=CGAffineTransformMakeRotation(M_PI/2);
            CGRect rect=self.image.frame;
            rect.origin.x=80;
            rect.size.width=160;
            rect.size.height=245;
            rect.origin.y=50;
            self.image.frame=rect;
            
            [self addSubview: self.image];
            
            
            self.label = [[[UILabel alloc] initWithFrame: CGRectMake(0,130,250,20)] autorelease];//(0,0,280,320)
            
            [self.label setBackgroundColor:[UIColor clearColor]];
            [self.label setTextColor:[UIColor whiteColor]];
            [self.label setTextAlignment:NSTextAlignmentLeft];
            [self.label setFont:[UIFont systemFontOfSize: 19]];
            self.label.numberOfLines=0;
            [self.image addSubview:self.label];
            
            
            self.labelMain = [[[UILabel alloc] initWithFrame:CGRectMake(0, 164, 250, 40)]autorelease];
            [self.labelMain setBackgroundColor:[UIColor clearColor]];
            [self.labelMain setTextColor:[UIColor whiteColor]];
            [self.labelMain setTextAlignment:NSTextAlignmentLeft];
            [self.labelMain setFont:[UIFont systemFontOfSize:14.]];
            self.labelMain.numberOfLines = 0;
            [self.image addSubview:self.labelMain];
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"brand_news_icon_video.png"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(250/2 - 55/2, 80 - 55/2, 55, 55);
            [self.image addSubview:btn];
            self.btnVideo = btn;
        }
    }
    return self;
}




//生成视图的时候调用重新布局，刷新子视图
-(void) layoutSubviews {
    [super layoutSubviews];

    CGRect rect= self.label.frame;
    CGRect surRect=self.label.superview.frame;
    if(((KLScrollSelect*)(superTable.columnDelegate)).isNormal)
    {
        rect.origin.x=0;
    }
    else
    {
        rect.origin.x=surRect.size.height-rect.size.width;
    }
    //    self.label.frame=rect;
    
}

@end

NSString const *kColumnObjectKey = @"columnKey";

//分类实现
@implementation NSIndexPath (Column)

+ (NSIndexPath *)indexPathForRow:(NSInteger) row
                       inSection:(NSInteger) section
                        inColumn:(NSInteger) column {
    NSIndexPath* index = [NSIndexPath indexPathForRow:row inSection:section];
    objc_setAssociatedObject(index, &kColumnObjectKey, @(column), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return index;
}
-(NSInteger) column {
    id object = objc_getAssociatedObject(self, &kColumnObjectKey);
    return [object integerValue];
}

@end