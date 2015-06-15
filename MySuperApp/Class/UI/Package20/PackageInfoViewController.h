//
//  PackageInfoViewController.h
//  MyAimerApp
//
//  Created by 蒋博男 on 15-6-10.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "LBaseViewController.h"

@interface PackageInfoViewController : LBaseViewController <ServiceDelegate, UIScrollViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, retain) NSString* pid;
@end
