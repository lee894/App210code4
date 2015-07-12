//
//  PPBuyCircleCommonCell.m
//  paipaiiphone
//
//  Created by JDMAC on 15-3-26.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "PPBuyCircleCommonCell.h"
#import "SingletonState.h"

@implementation PPBuyCircleCommonCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(UILabel *)showDesLab
//{
//    if (!_showDesLab) {
//        _showDesLab = [[UILabel alloc] init];
//        _showDesLab.font = [UIFont systemFontOfSize:12.0f];
//        _showDesLab.textColor = [UIColor colorWithHexString:@"ffffff"];
//    }
//    return _showDesLab;
//}
//
//
//-(UILabel *)showDesLab
//{
//    if (!_showDesLab) {
//        _showDesLab = [[UILabel alloc] init];
//        _showDesLab.font = [UIFont systemFontOfSize:12.0f];
//        _showDesLab.textColor = [UIColor colorWithHexString:@"ffffff"];
//    }
//    return _showDesLab;
//}
//
//-(UIView *)textBackGroundView
//{
//    if (!_textBackGroundView) {
//        _textBackGroundView = [[UIView alloc] init];
//        _textBackGroundView.backgroundColor= [UIColor colorWithHexString:@"000000"];
//        _textBackGroundView.alpha = 0.6;
//    }
//    return _textBackGroundView;
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.item) {
        
        
        
        
        [self.showtitleLab setText:self.item.title];
        [self.showtitleLab setTextColor:[UIColor blackColor]];
         
         [self.showDesLab setText:self.item.subtitle];
         [self.showDesLab setTextColor:[UIColor blackColor]];
        
        _textBackGroundView.backgroundColor= [UIColor colorWithHexString:@"ffffff"];
        _textBackGroundView.alpha = 0.6;
        
        
        
        if ([self.item.title description].length<1 || [self.item.subtitle description].length < 1) {
            _textBackGroundView.hidden = YES;
        }else{
            _textBackGroundView.hidden = NO;
        }
        
          [self.showImageV setImageFromUrl:YES withUrl:self.item.img_file_path];
        
    }
        /*
        self.showDesLab.numberOfLines = 0;
        
        self.textBackGroundView.hidden = YES;
        
        CGSize szItemPrice;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        NSMutableParagraphStyle* mps = [[NSMutableParagraphStyle alloc] init];
        mps.lineBreakMode = NSLineBreakByCharWrapping;
        szItemPrice = [self.item.subtitle boundingRectWithSize:CGSizeMake(280, MAXFLOAT)
                                                      options:  NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12], NSParagraphStyleAttributeName : mps}
                                                      context:nil].size;
#else
        szItemPrice = [self.item.nexttitle sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
#endif
        if (szItemPrice.height > 30) {
            szItemPrice.height = 30;
        }

        if (self.item.subtitle != nil)
        {
            if (self.item.subtitle.length > 0)
            {
                
                [self.textBackGroundView addSubview:self.showDesLab];
                [self.showDesLab setFrame:CGRectMake(10, 10, 280, szItemPrice.height)];

                self.textBackGroundView.hidden = NO;
                [self.textBackGroundView setFrame:CGRectMake(10, 200 + 60 -  self.showDesLab.frame.size.height - 20, 300, self.showDesLab.frame.size.height + 20)];
                [self.contentView addSubview:self.textBackGroundView];
            }
            else
            {
                [self.textBackGroundView setHidden:YES];
            }
        }
        else
        {
            [self.textBackGroundView setHidden:YES];
        }
        
        [self.showDesLab setText:self.item.subtitle];
        [self.showImageV setImageFromUrl:YES withUrl:self.item.img_file_path];
    }
         
         */
}

@end
