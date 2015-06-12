//
//  YKPayMethod.h
//  YKProduct
//
//  Created by user on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBaseViewController.h"
#import "CheckOutViewController.h"

@interface YKPayMethod : LBaseViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView * m_UISelectTable;

    NSMutableArray * m_payMethod;
}

@property (nonatomic, assign) NSString * m_StrSelectIndex;
@property (nonatomic, assign) CheckOutViewController * m_sourcePage;
@property (nonatomic, retain) NSMutableArray * m_payMethod;


@property(nonatomic, retain) NSString *m_pay_id;

- (void)initPayMethod:(NSMutableArray*)data;

@end
