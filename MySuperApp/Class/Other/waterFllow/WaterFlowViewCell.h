//
//  WaterFlowViewCell.h
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-11.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IndexPath;
@interface WaterFlowViewCell : UIView
{
    NSInteger _columnCount; //列数
    IndexPath *_indexPath; //位置
    NSString *_strReuseIndentifier; //重用标识

}
@property (nonatomic,assign) NSInteger columnCount; 
@property (nonatomic, retain) IndexPath *indexPath;
@property (nonatomic, retain) NSString *strReuseIndentifier;

-(id)initWithIdentifier:(NSString *)indentifier;
-(void)relayoutViews;

@end

@interface IndexPath : NSObject
{
    NSInteger _row;       //行号
    NSInteger _column;    //列号
}
@property(nonatomic,assign) NSInteger row;
@property(nonatomic,assign) NSInteger column;

+(IndexPath *)initWithRow:(int)indexRow withColumn:(int)indexColumn;

@end