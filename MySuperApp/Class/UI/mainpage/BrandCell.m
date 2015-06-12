//
//  BrandCell.m
//  MySuperApp
//
//  Created by malan on 14-3-23.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "BrandCell.h"
#import "BrandListViewController.h"


@implementation BrandCell
@synthesize buttonFirst;
@synthesize buttonSecond;
@synthesize buttonThird;

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


- (void)setBackgroundImage:(NSInteger)indexpathRow withArray:(BrandsModel *)array //设置背景图片
{
   int num = ceilf(array.brandsWall.count /BrandCellNum) ;
   
    BrandsWall *pic = (BrandsWall *)[array.brandsWall objectAtIndex:indexpathRow*BrandCellNum];

    [self.buttonFirst setBackgroundImageFromUrl:YES withUrl:pic.pic];
    
   if (indexpathRow == num - 1) {
       if (array.brandsWall.count % BrandCellNum == 1) {
           self.buttonSecond.hidden = YES;
           self.buttonThird.hidden =YES;
       }else if (array.brandsWall.count % BrandCellNum == 2){
           self.buttonThird.hidden =YES;
        [self.buttonSecond setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[array.brandsWall objectAtIndex:indexpathRow * BrandCellNum + 1]]] forState:UIControlStateNormal];
       }
   }else{
       BrandsWall *pic1 = (BrandsWall *)[array.brandsWall objectAtIndex:indexpathRow*BrandCellNum + 1];
       BrandsWall *pic2 = (BrandsWall *)[array.brandsWall objectAtIndex:indexpathRow*BrandCellNum + 2];

       [self.buttonSecond setBackgroundImageFromUrl:YES withUrl:pic1.pic];
       [self.buttonThird setBackgroundImageFromUrl:YES withUrl:pic2.pic];
   }
       self.buttonFirst.tag = indexpathRow * BrandCellNum + 10;
       self.buttonSecond.tag = indexpathRow * BrandCellNum + 11;
       self.buttonThird.tag = indexpathRow * BrandCellNum + 12;
 
}
    


@end
