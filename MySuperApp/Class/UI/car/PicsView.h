//
//  PicsView.h
//  ThreePicViewTry
//
//  Created by user on 13-10-11.
//  Copyright (c) 2014年 eastedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NogiftsItem.h"

@protocol PicsViewDelegate <NSObject>

- (void)didSelectItemAtIndex:(NogiftsItem *)nogifts;

@end

@interface PicsView : UIView
{
    UILabel *_labelTitle;
}
@property (nonatomic, assign) id <PicsViewDelegate> delegate;
@property (nonatomic, retain) NSArray *array;

+ (CGFloat)heightForDatas:(NSArray *)datas type:(NSInteger)theType;

- (id)initWithDatas:(NSArray *)datas andDic:(NSDictionary *)theDic;

@end
