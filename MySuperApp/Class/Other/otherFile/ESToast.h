//
//  ESToast.h
//  ThriftShop
//
//  Created by qz on 15/6/20.
//  Copyright (c) 2015年 蒋博男. All rights reserved.


@interface ESToast : UIView
{
    UIView *_tosView;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

+ (void)showDelayToastWithText:(NSString*)text;
+ (void)showToastWithText:(NSString*)text closeAfterDelay:(NSTimeInterval)delay;

@end
