

#import <UIKit/UIKit.h>
#import "CouponsListTableViewController.h"

//结算中心  选择优惠券

@protocol SelectCouponDelegate <NSObject>

@required
- (void) SelectCouponIndex:(NSInteger)index withslelectTag:(NSInteger)tag withCodeValue:(NSString*)value;

@end



@interface SelectCouponTableViewController :LBaseViewController <UITableViewDelegate,UITableViewDataSource,ServiceDelegate,UIAlertViewDelegate,UIScrollViewDelegate,BlockAlertViewDelegate,UITextFieldDelegate>
{
    UILabel *_labelInfo;
    NSInteger totalCount;
    NSInteger current;
    MainpageServ *mainSer;//兑换用
    
    
    UITextField *nametextfield;
}

@property (nonatomic, assign) NSInteger selectType; //1 优惠券  2电子券  3 包邮卡

@property (assign, nonatomic) id<SelectCouponDelegate> delegate;

@property (retain, nonatomic) NSArray *contentArr;
@property (nonatomic, retain) NSString *phoneNum;
@property (nonatomic, retain) UITableView *mytableView;
@property (nonatomic, assign) ECouponListType clType;
//单元格上按钮的点击事件
- (void)btnClicked:(UIButton *)btn onCell:(UITableViewCell *)cell;

@end

