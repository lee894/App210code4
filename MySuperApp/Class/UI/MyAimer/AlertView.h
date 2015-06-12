//
//  AlertView.h
//  MySuperApp
//
//  Created by bonan on 14-9-16.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertViewDelegate <NSObject>

@optional
- (void)alertViewWithStates:(BOOL)states;

@end

@interface AlertView : UIView

@property (nonatomic, assign) id<AlertViewDelegate> delegate;

@end
