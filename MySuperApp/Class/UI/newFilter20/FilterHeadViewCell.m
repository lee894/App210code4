//
//  FilterHeadViewCell.m
//  paipaiiphone
//
//  Created by zhangwenguang on 15/3/25.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "FilterHeadViewCell.h"
#import "UIColorAdditions.h"

#define FONTCOLOR @"463417"

@implementation FilterHeadViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSectionName:(NSString *)sectionName
{
    _sectionName = sectionName;
    _sectionNameLabel.text = sectionName;
}

-(void)setRightName:(NSString *)rightName
{
    _rightName = rightName;
    _rightLabel.text = rightName;
}

- (void)setOpen:(BOOL)open animation:(BOOL)anim
{
    _open = open;
    if (anim)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            if (_open)
            {
                CGAffineTransform newTransform = CGAffineTransformMakeRotation(-M_PI);//M_PI_2
                _stateView.transform = newTransform;
            }
            else
            {
                CGAffineTransform newTransform = CGAffineTransformIdentity;
                _stateView.transform = newTransform;
            }
        }];
    }
    else
    {
        if (!CGAffineTransformIsIdentity(_stateView.transform))
        {
            CGAffineTransform newTransform = CGAffineTransformIdentity;
            _stateView.transform = newTransform;
        }
    }
}

- (void)setOpen:(BOOL)theOpen
{
    _open = theOpen;
    if (_open)
    {
        NSString *imageStr = @"category_down.png";
        _stateView.image = [UIImage imageNamed:imageStr];
    }
    else
    {
        NSString *imageStr = @"category_down.png";
        _stateView.image = [UIImage imageNamed:imageStr];
        
    }
}

- (id)initWithFrame:(CGRect)frame isShowArrow:(BOOL)show
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.userInteractionEnabled = YES;
        
        if(show){
            
            CGRect rect = CGRectMake(frame.size.width - 50, 0, 50, frame.size.height);
            _tapView = [[UIView alloc] initWithFrame:rect];
            _tapView.backgroundColor = [UIColor clearColor];
            [self addSubview:_tapView];
            

            NSString *imageStr = @"category_down.png";
            rect = CGRectMake(frame.size.width - 30, (frame.size.height - 15.0) / 2.0, 18.0 * 0.65, 9.5 * 0.65);
            UIImageView *stateView = [[UIImageView alloc]initWithFrame:rect];
            _stateView = stateView;

            // 24 *14 ---12 * 7 --- 6 * 3.5  18 *10.5
            //19 *28 old
            _stateView.backgroundColor = [UIColor clearColor];
            _stateView.image = [UIImage imageNamed:imageStr];
            _stateView.userInteractionEnabled = YES;
            [self addSubview:_stateView];

        }
        
        UILabel *sectionNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (frame.size.height - 30.0) / 2.0, 230.0, 30.0)];
        _sectionNameLabel = sectionNameLabel;

        _sectionNameLabel.font = [UIFont systemFontOfSize:15.0];
        _sectionNameLabel.textColor = [UIColor colorWithHexString:FONTCOLOR];
        _sectionNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_sectionNameLabel];
        self.layer.borderWidth = .5;
        self.layer.borderColor = [UIColor colorWithHexString:@"E7E4DE"].CGColor;

        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 30 - 60, (frame.size.height - 30.0) / 2.0,50,30.0)];
        _rightLabel = rightLabel;
        _rightLabel.font = [UIFont systemFontOfSize:13.0];
        _rightLabel.textColor = [UIColor colorWithHexString:@"D2C9B7"];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment = NSTextAlignmentRight;

        [self addSubview:_rightLabel];
    }
    return self;
}



@end
