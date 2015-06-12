////
////  PPBuyOptionView.h
////  qqbuy
////
////  Created by Henry Tse on 13-8-8.
////  Copyright (c) 2013年 tencent. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//#import "UrlImageView.h"
//
//@class PPProductDetailBO, PPProductDetailItemStockBo;
//@protocol PPBuyOptionViewDelegate;
//
//@interface PPBuyOptionView : UIView
//
////@property (nonatomic, retain) UIImage* finishImage;
//@property (nonatomic, assign) id<PPBuyOptionViewDelegate, UITextFieldDelegate> delegate;
//@property (nonatomic, retain) PPProductDetailBO *spu;
////@property (nonatomic, retain) PPSpuPo *spu;
//@property (nonatomic, retain) NSMutableArray *selectedAttrOrders;
//
//@property (nonatomic, retain) NSString *regionName;
//@property (nonatomic, retain) NSString *regionId;
//
//@property (nonatomic, retain) UILabel *selectedRegionLabel;
////@property (nonatomic, retain) UILabel *numberTextField;
//@property (nonatomic, retain) UITextField *numberTextField;
//@property (nonatomic, retain) UILabel *shipInfoLabel;
//@property (nonatomic, retain) UILabel *priceLabel;
//@property (nonatomic, assign) UILabel *titleLabel;
//@property (nonatomic, retain) UILabel *stockCountLabel;
//@property (nonatomic, retain) UIButton *addBtn;
//@property (nonatomic, retain) UIButton *subBtn;
////购买所需的必要信息
//@property (nonatomic, assign) NSUInteger buyCount;
//@property (nonatomic, retain) PPProductDetailItemStockBo *currentStock;
//@property (nonatomic, assign) UIButton* finishBtn;
//@property (nonatomic, assign) UIImageView* ivZeroStock;
//@property (nonatomic, assign) UrlImageView* ivItemPic;
////@property (nonatomic, retain) PPStockPo *currentStock;
//
//+ (CGFloat)getOptionViewHeight:(PPProductDetailBO *)spu;
////+ (CGFloat)getOptionViewHeight:(PPSpuPo *)spu;
//- (NSString *)validateSelectionCompletion;
//- (void)extractAttributeMap;
//-(void)numberButtonPressed:(UIButton*)sender;
//@end
////
////@protocol PPBuyOptionViewDelegate <NSObject>
////
////- (void)didTapSelectRegionButton;
////- (void)drawShipFeeForSelection:(NSString *)regionName;
////- (void)didtapAttributeButtonToTriggerReload;
////
////@end
