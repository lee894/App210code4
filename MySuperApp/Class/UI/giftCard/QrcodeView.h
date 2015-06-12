//
//  QrcodeView.h
//  MySuperApp
//
//  Created by lee on 14-5-13.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QrcodeViewDelegate <NSObject>

-(void)hiddenView;

@end


@interface QrcodeView : UIView

{
}

@property (retain, nonatomic) IBOutlet UILabel *qrcodeNum;
@property (retain, nonatomic) IBOutlet UIImageView *qrcodeimg;
@property (retain, nonatomic) IBOutlet UILabel *qrcodetitle;
@property (retain, nonatomic) IBOutlet UILabel *qrcodetime;
@property (retain, nonatomic) IBOutlet UILabel *qrcodedesc;


@property (nonatomic, assign) id <QrcodeViewDelegate>delegate;


- (IBAction)btnqrcodeclose:(id)sender;
- (IBAction)btnqrcodesave:(id)sender;

@end
