//
//  BrandMessageCell.m
//  MySuperApp
//
//  Created by LEE on 14-7-25.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "BrandMessageCell.h"

@implementation BrandMessageCell
@synthesize buttonVodie,imageViewShop,labelDescription;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addData:(ZixunZixunInfo *)data withRow:(NSInteger)row //添加数据
{
    self.buttonVodie.hidden = YES;
    self.buttonVodie.tag = row;
    NSURL *url = [NSURL URLWithString:data.imgPath];
    [self.imageViewShop setImageWithURL:url placeholderImage:[UIImage imageNamed:@"pic_default_brand_news.png"]];
//    [self.imageViewShop setImageFromUrl:YES withUrl:data.imgPath];
    
    if ([data.type integerValue] == 7) {
        self.buttonVodie.hidden = NO;
    }
    
    self.labelDescription.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    self.mainTititleLabel.text = data.mainTitle;
    
    //    - (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
    //- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes context:(NSStringDrawingContext *)context NS_AVAILABLE_IOS(7_0);
    //NS_DEPRECATED_IOS(2_0, 7_0, "Use -boundingRectWithSize:options:attributes:context:"); // NSTextAlignment is not needed to determine size
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
//    CGRect size2 = [data.nexttitle boundingRectWithSize:CGSizeMake(250, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    CGSize size = [data.nexttitle sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(250, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.labelDescription.frame = CGRectMake(6, 155, 187, size.height);
    self.labelDescription.text = data.nexttitle;
}

@end
