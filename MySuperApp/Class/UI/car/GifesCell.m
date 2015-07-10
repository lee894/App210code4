//
//  GifesCell.m
//  MySuperApp
//
//  Created by bonan on 14-4-10.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "GifesCell.h"

@implementation GifesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)btnSelectClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    
//    NSLog(@"self.indexPath------%d----%d---%@---tag:%d",[self.indexPath section],[self.indexPath row],self.indexPath,sender.tag);

    
    if (self.delegate && [self.delegate respondsToSelector:@selector(giftsCellWithStates:indexPath:)]) {
        [self.delegate giftsCellWithStates:sender.selected indexPath:sender.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
