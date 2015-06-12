//
//  ProductListCell.h
//  MySuperApp
//
//  Created by LEE on 14-4-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"
#import "UrlImageButton.h"


@interface CommonListCell : UITableViewCell<UITextViewDelegate>
{
    IBOutlet UIView *allcellBg;

}
@property (nonatomic, retain) IBOutlet UrlImageView *imageViewCommodity;
@property (nonatomic, retain) IBOutlet UILabel *labelIntroduce;
@property (nonatomic, retain) IBOutlet UILabel *labelColor;
@property (nonatomic, retain) IBOutlet UILabel *labelSize;
@property (weak, nonatomic) IBOutlet UIImageView *iconImagV;




@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn11;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn12;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn13;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn14;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn15;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn16;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn17;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn18;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn19;

@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn21;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn22;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn23;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn24;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn25;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn26;

@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn31;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn32;
@property (retain, nonatomic) IBOutlet UrlImageButton *urlbtn33;


@property (retain, nonatomic) IBOutlet UITextView *textcellAccess1;
@property (retain, nonatomic) IBOutlet UITextView *textcellAccess2;
@property (retain, nonatomic) IBOutlet UITextView *textcellAccess3;





@end
