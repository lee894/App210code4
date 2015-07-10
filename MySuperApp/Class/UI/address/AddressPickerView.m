//
//  AddressPickerView.m
//  MySuperApp
//
//  Created by LEE on 14-4-2.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "AddressPickerView.h"
#import "YKGetAddressInfo.h"
#import "UIView+ChangeFrame.h"

@implementation AddressPickerView
@synthesize pickerAddress;
@synthesize areaProvinceId,areacityId,areaAreaId;
@synthesize delegate;
@synthesize areaProvince,areacity,areaArea;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    pickerData =  [[YKGetAddressInfo sharedManager] getCityList];
	NSDictionary* dic = (NSDictionary*)[pickerData objectAtIndex:0];
	NSString* pid = [dic objectForKey:@"cityId"];
    pickerData2 = [[YKGetAddressInfo sharedManager] getTownList:pid];
	
	NSDictionary* dic1 = (NSDictionary*)[pickerData2 objectAtIndex:0];
	NSString* pid1 = [dic1 objectForKey:@"cityId"];
    pickerData3 = [[YKGetAddressInfo sharedManager] getTownList:pid1];

}

#pragma mark -- 按钮事件
- (IBAction)confirmOrCancel:(UIButton *)sender//确认or取消
{
    
    if (sender.tag == 202) {
        NSInteger row1 = [self.pickerAddress selectedRowInComponent:0];
        self.areaProvince = [[pickerData objectAtIndex:row1] objectForKey:@"cityName"];
        self.areaProvinceId = [[pickerData objectAtIndex:row1] objectForKey:@"cityId"];
        
        NSInteger row2 = [self.pickerAddress selectedRowInComponent:1];
        areacity = [[pickerData2 objectAtIndex:row2] objectForKey:@"cityName"];
        areacityId = [[pickerData2 objectAtIndex:row2] objectForKey:@"cityId"];
        
        NSInteger row3 = [self.pickerAddress selectedRowInComponent:2];
        self.areaArea = [[pickerData3 objectAtIndex:row3] objectForKey:@"cityName"];
        self.areaAreaId = [[pickerData3 objectAtIndex:row3] objectForKey:@"cityId"];
        
        [delegate pickCountty:self];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self setOrigin:CGPointMake(0, self.superview.frame.size.height)];
    } completion:^(BOOL finish){
        [self removeFromSuperview];
    }];

}

#pragma mark - pickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSInteger row=0;
	switch (component) {
		case 0:
			row=[pickerData count];
			break;
		case 1:
			row=[pickerData2 count];
			break;
		case 2:
			row=[pickerData3 count];
			break;
		default:
			break;
	}
	return row;
	
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component reusingView:(UIView *)view{
	UILabel *content = [[UILabel alloc] init];
	content.textAlignment = UITextAlignmentCenter;
	content.backgroundColor = [UIColor clearColor];
	content.frame = CGRectMake(0,0,70,20);
	content.font = [UIFont systemFontOfSize:13];
	switch (component) {
		case 0:
			content.text = [[pickerData objectAtIndex:row] objectForKey:@"cityName"];
			break;
		case 1:
			content.text = [[pickerData2 objectAtIndex:row] objectForKey:@"cityName"];
			break;
		case 2:
			content.text = [[pickerData3 objectAtIndex:row] objectForKey:@"cityName"];
			break;
		default:
			break;
	}
	
	return content;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	switch (component) {
		case 0:{
			NSString *proid = [[pickerData objectAtIndex:row] objectForKey:@"cityId"];
			pickerData2 = [[YKGetAddressInfo sharedManager] getTownList:proid];
			NSString *cityid = [[pickerData2 objectAtIndex:0] objectForKey:@"cityId"];
			pickerData3 = [[YKGetAddressInfo sharedManager] getTownList:cityid];
			[pickerView reloadComponent:1];
			[pickerView selectRow:0 inComponent:1 animated:YES];
			[pickerView reloadComponent:2];
			[pickerView selectRow:0 inComponent:2 animated:YES];
			break;
		}
		case 1:{
			NSString *cityid = [[pickerData2 objectAtIndex:row] objectForKey:@"cityId"];
			pickerData3 = [[YKGetAddressInfo sharedManager] getTownList:cityid];
			[pickerView reloadComponent:2];
			[pickerView selectRow:0 inComponent:2 animated:YES];
			break;
		}
		case 2:
			break;
		default:
			break;
	}
}


@end
