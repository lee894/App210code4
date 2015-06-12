//
//  CategoryView.h
//  Shop
//
//  Created by bonan on 13-8-27.
//  Copyright (c) 2014年 xiexianhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryViewDelegate <NSObject>

@optional
- (void)categoryWithID:(NSString *)theStrID title:(NSString *)strTitle;

@end

@interface CategoryView : UIView
{
    NSInteger type;
    id<CategoryViewDelegate> delegate;
}
@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, retain) NSDictionary *dicData;

//theType 1表示女士  2表示男士  3表示儿童中的女童  4表示儿童中的男童
- (id)initWithFrame:(CGRect)frame type:(NSInteger)theType delegate:(id<CategoryViewDelegate>)theDelegate;

- (void)loadViewWithDic:(NSDictionary *)theDic;

@end
