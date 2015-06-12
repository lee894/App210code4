//
//  YKOrderPostscriptView.h
//  YKProduct
//
//  Created by caiting on 11-12-26.
//  Copyright 2011 yek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckOutViewController.h"
@interface YKOrderPostscriptView : LBaseViewController <UITextViewDelegate>{
	UITextView* postText;

}
@property (nonatomic, retain) NSString *postStr;
@property(nonatomic,retain) CheckOutViewController* checkOut;

@end
