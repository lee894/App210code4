//
//  YKChannelViewController.h
//  YKProduct
//
//  Created by k ye on 11-12-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CannelCategires.h"
#import "LBaseViewController.h"

@class YKChannelViewController;
@interface YKChannelViewController : LBaseViewController<UITableViewDelegate,UITableViewDataSource,ServiceDelegate>{
     UITableView *tableview_channel;
     NSString *ThisChannelID;
     BOOL isSub;
     NSDictionary *dic_sub;
     YKChannelViewController *channelview;
     NSString *title_Name;

    MainpageServ *mainSev;
    
    CannelCategires *cannelCategiresModel;
    CannelCannelHomeModel *cannelModel;
    
//    UrlImageView *imageView_back;
}

@property(nonatomic,retain)NSDictionary *dic_sub;

@property(nonatomic,retain)NSString *ThisChannelID;

@property(nonatomic,assign)BOOL isSub;
@property(nonatomic,retain)NSString *title_Name;
@property(nonatomic, assign) BOOL isHome;

-(void)setIsSub:(BOOL)isSub;

@end
