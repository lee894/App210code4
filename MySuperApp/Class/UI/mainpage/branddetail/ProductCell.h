//
//  ProductCell.h
//  MySuperApp
//
//  Created by LEE on 14-7-23.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductView;

@protocol ProductIdDelegate <NSObject>

- (void)getProductId:(NSInteger)tag;

@end

@interface ProductCell : UITableViewCell

@property (nonatomic ,retain) IBOutlet ProductView *productViewFirst;
@property (nonatomic, retain) IBOutlet ProductView *productViewSecond;
@property (nonatomic, retain) IBOutlet ProductView *productViewThird;
@property (nonatomic, assign) id<ProductIdDelegate>delegate;
@property (nonatomic, retain) NSString *idProduct;

- (void)setBackgroundImage:(NSInteger)indexRow withArray:(NSArray *)array;

- (IBAction)productId:(UIButton *)sender;//获得点击产品的ID

@end
