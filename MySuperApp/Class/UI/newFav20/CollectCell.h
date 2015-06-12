//
//  CollectCell.h
//  MySuperApp
//
//  Created by LEE on 14-7-31.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

@class CollectView;

@protocol CollectForkDelegate <NSObject>//删除收藏代理

- (void) forkWithTag:(NSInteger)tag withProductId:(NSString *)productId;

- (void)forkProductList:(NSString *)productId;
@end


@interface CollectCell : UITableViewCell

@property (nonatomic, assign) id<CollectForkDelegate>delegate;

@property (nonatomic, retain) IBOutlet CollectView *collectFirst;
@property (nonatomic, retain) IBOutlet CollectView *collectSecond;

@property (nonatomic, retain) NSString *idProduct;
@property (nonatomic, retain) NSString *idProduct2;
- (void)setbuttonCancel:(BOOL)bools;//视图上x按钮状态

- (void)setImageData:(NSInteger)row withArray:(NSMutableArray *)array;


- (IBAction)fork:(UIButton *)sender;//叉子按钮删除单个收藏

- (IBAction)productList:(id)sender;
@end
