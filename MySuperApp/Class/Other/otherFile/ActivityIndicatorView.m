//
//  ActivityIndicatorView.m
//  letao
//
//  Created by lee on 11-8-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityIndicatorView.h"
#import "SingletonState.h"


#pragma mark loading animation

@implementation UIView(add_loading_animation)


-(void) startLoadingAnimation{
//	SingletonState* mySingle = [SingletonState sharedStateInstance];
	self.userInteractionEnabled = NO;
//    mySingle.loadingBG.center = self.center;
//    mySingle.activityView.center = self.center;
//    [self addSubview:mySingle.loadingBG];
//	[self addSubview:mySingle.activityView];
//	[mySingle.activityView startAnimating];
//    
    //设置网络标示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(void) stopLoadingAnimation{
	self.userInteractionEnabled = YES;
	
//	[activityView stopAnimating];
//	[[SingletonState sharedStateInstance].activityView removeFromSuperview];
//    [[SingletonState sharedStateInstance].loadingBG removeFromSuperview];
//    
    //设置网络标示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
}

@end
