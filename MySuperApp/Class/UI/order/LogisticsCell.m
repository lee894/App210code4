//
//  LogisticsCell.m
//  爱慕商场
//
//  Created by LEE on 14-8-5.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "LogisticsCell.h"

@implementation LogisticsCell
@synthesize imageBackground,labelAddr,labelTime;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

- (void)setBackgroundImageWithRow:(NSInteger)Row withCount:(NSInteger)count//设置cell的背景图片
{
    if (count == 1) {
//        self.imageBackground.image = [UIImage imageNamed:@"list02_bg.png"];
        //lee给view设置为圆角，不再使用图片了。 -140512
//        [SingletonState setViewRadioSider:self.imageBackground];
        
    }else if(count == 2){
        switch (Row) {
            case 0:
                self.imageBackground.image = [UIImage imageNamed:@"list02_bg_01.png"];//IMAGE(@"list02_bg_01", @"png");
                break;
            case 1:
                self.imageBackground.image = [UIImage imageNamed:@"list02_bg_03.png"];//IMAGE(@"list02_bg_03", @"png");
                break;
            default:
                break;
        }
    }else{
            if (Row == 0) {
                self.imageBackground.image = [UIImage imageNamed:@"list02_bg_01.png"];//IMAGE(@"list02_bg_01", @"png");
            }else if (Row < count-1){
                
                self.imageBackground.image = [UIImage imageNamed:@"list02_bg_02.png"];//IMAGE(@"list02_bg_02", @"png");
            
            }else{
                
                self.imageBackground.image = [UIImage imageNamed:@"list02_bg_03.png"];//IMAGE(@"list02_bg_03", @"png");
            
            }
        }
    }

@end
