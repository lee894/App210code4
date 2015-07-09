//
//  QrcodeView.m
//  MySuperApp
//
//  Created by lee on 14-5-13.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "QrcodeView.h"
#import "MYCommentAlertView.h"
#import "AppDelegate.h"

@implementation QrcodeView
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)btnqrcodeclose:(id)sender {
    
    [delegate hiddenView];
    
    CGRect oldViewR = self.frame;
    oldViewR.origin.y = 1136/2;
    [UIView animateWithDuration:0.5 animations:^{
        [self setFrame:oldViewR];
    }];
    
}

- (IBAction)btnqrcodesave:(id)sender {
    
    [MYCommentAlertView showMessage:@"二维码已经保存到相册" target:nil];
    
    UIGraphicsBeginImageContext(self.bounds.size);     //currentView 当前的view
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
}
@end
