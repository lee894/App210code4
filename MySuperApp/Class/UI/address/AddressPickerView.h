//
//  AddressPickerView.h
//  MySuperApp
//
//  Created by LEE on 14-4-2.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressPickerView;
@protocol AreaPickerDelegate <NSObject>

- (void)pickCountty:(AddressPickerView *)addressdPicker;

@end


@interface AddressPickerView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray* pickerData;
    NSArray* pickerData2;
    NSArray* pickerData3;
}
@property (nonatomic, retain) IBOutlet UIPickerView *pickerAddress;

@property (nonatomic, assign) id <AreaPickerDelegate>delegate;

@property(nonatomic,retain) NSString *areaProvinceId;
@property(nonatomic,retain) NSString *areacityId;
@property(nonatomic,retain) NSString *areaAreaId;

@property(nonatomic,retain) NSString *areaProvince;
@property(nonatomic,retain) NSString *areacity;
@property(nonatomic,retain) NSString *areaArea;

- (IBAction)confirmOrCancel:(UIButton *)sender;//确认or取消

@end
