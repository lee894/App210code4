//
//  YKShoseGiftViewController.m
//  YKProduct
//
//  Created by caiting on 11-12-13.
//  Copyright 2011 yek. All rights reserved.
//

#import "YKChoseGiftViewController.h"
#import "UrlImageView.h"
#import "YKGiftItem.h"
#import "YKSpecitem.h"
#import "YKItem.h"
#import "GifesCell.h"

#define ColorNum 10000
#define ChimaNum 20000

#define pickViewhight 270

@implementation YKChoseGiftViewController


-(void)popBackAnimate:(UIButton *)sender{
    [self cancelAction];
    
	[self.navigationController popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    
    self.title = @"赠品";
    [self createBackBtnWithType:0];
    
    [self NewHiddenTableBarwithAnimated:YES];

    currentColor = 0;
    currentSize = 0;
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    [mainSev getSelectgifts];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];
    
	buttonArray=[[NSMutableArray alloc] init];
	spseidArray = [[NSMutableArray alloc] init];
    resultsArray = [[NSMutableArray alloc] init];
    
    
    //lee999recode
    if (isIOS7up) {
        barbtnCancel.tintColor = [UIColor whiteColor];
        barBtnOK.tintColor = [UIColor whiteColor];
    }
    //end
    
    //创建数量PickeView
    picker.frame = CGRectMake(0, 42, 320, 216);
    [picker setDelegate:self];
    [picker setDataSource:self];
    picker.showsSelectionIndicator=YES;
    [popView setFrame:CGRectMake(0, ScreenHeight+20, 320, 258)];
    [popView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:popView];
    
    giftTab.backgroundColor=[UIColor clearColor];
    giftTab.showsVerticalScrollIndicator=NO;
	[giftTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
}

#pragma mark 赠品加入购物车

-(void)addCarAction:(id)sender{
    
    UIButton *button=(UIButton*)sender;
    NSMutableDictionary *dic = [resultsArray objectAtIndex:button.tag-100 isArray:nil];
    NSArray *giftsarray = [dic objectForKey:@"gifts"];
    
    NSInteger index = button.tag-100;
    if ([_muArrSelectGift count] != 0) {
        index -= [_muArrSelectGift count];
    }
    NSArray *array = [spseidArray objectAtIndex:index isArray:nil];
    
    NSMutableArray *itemIDArray = [NSMutableArray array];
    YKItem* item = nil;
    int i = 0;
    for (; i < [array count]; i++) {
        
        YKGiftItem* gift = (YKGiftItem*)[giftsarray objectAtIndex:i isArray:nil];
        NSDictionary *dic = [array objectAtIndex:i isArray:nil];
        NSString *isselect = [dic objectForKey:@"isSelect"];
        NSString *colorStr = [dic objectForKey:@"color"];
        NSString *sizeStr = [dic objectForKey:@"size"];
        
        if ([isselect isEqualToString:@"1"] && colorStr.length != 0 && sizeStr.length != 0) {//可以加入购物车
            for (int i = 0; i < [gift.idArray count]; i ++) {
                item = (YKItem*)[gift.idArray objectAtIndex:i isArray:nil];
                if ([item.color isEqualToString:colorStr] && [item.size isEqualToString:sizeStr]) {
                    NSString *tmpStr = [NSString stringWithFormat:@"%@:%@:gift:%@",item.productid,@"1",gift.promotion_id];
                    [itemIDArray addObject:tmpStr];
                    break;
                }
            }
        } else {
        }
    }
    
    NSMutableString *tmpStr = [NSMutableString string];
    
    
    
    if ([itemIDArray count] > 0) {
        [tmpStr appendFormat:@"%@",[itemIDArray objectAtIndex:0 isArray:nil]];
        for (int i = 1; i < [itemIDArray count]; i++) {
            [tmpStr appendFormat:@"|%@",[itemIDArray objectAtIndex:i isArray:nil]];
        }
        
        NSDictionary *dic1  = [NSDictionary dictionaryWithObjectsAndKeys:item.productid, @"GoodsID",item.name, @"GoodsName",@"gift", @"SelectType",tmpStr, @"SKU",[NSNumber numberWithShort:1],@"Number",nil];
        [TalkingData trackEvent:@"1007" label:@"加入购物车(赠品)" parameters:dic1];
 
        
        [mainSev getCar_add:tmpStr];
        [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

    } else {//没有选择赠品
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"爱慕提示" message:@"请勾选赠品" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    
    return;
}

#pragma mark-- 选择赠品的尺码颜色
-(void)pickAction:(id)send{
    giftTab.userInteractionEnabled = NO;
    
	UIButton* button = (UIButton*)send;
	tagnumber = button.tag;
	[picker reloadAllComponents];
    [picker selectRow:0 inComponent:0 animated:NO];
	[UIView beginAnimations:@"aaa" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[popView setFrame:CGRectMake(0, ScreenHeight-pickViewhight, 320, 258)];//258
	[UIView commitAnimations];
}
-(IBAction)cancelAction{
	[UIView beginAnimations:@"Animations" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[popView setFrame:CGRectMake(0, ScreenHeight+20, 320, 258)];
	[UIView commitAnimations];
    giftTab.userInteractionEnabled = YES;

}
-(IBAction)ensureAction{
    
	[UIView beginAnimations:@"Animations" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[popView setFrame:CGRectMake(0, ScreenHeight+20, 320, 258)];
	[UIView commitAnimations];
    giftTab.userInteractionEnabled = YES;

	
	NSInteger row = [picker selectedRowInComponent:0];
    
    if (tagnumber > ChimaNum) {
        
        NSInteger section = (tagnumber - ChimaNum) / 100 - 1;
        
        NSInteger index = (tagnumber - ChimaNum) % 100;
        NSMutableDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
        NSArray *giftsarray = [dic objectForKey:@"gifts"];
        YKGiftItem* item = (YKGiftItem*)[giftsarray objectAtIndex:index isArray:nil];
        
		NSDictionary * specitem = nil;
        
        for (int j = 0; j<item.sizeArray.count; j++) {
            if ([[[[item.sizeArray objectAtIndex:j isArray:nil] allKeys] lastObject] isEqualToString:[[item.colorArray objectAtIndex:currentColor] productid]]) {
                
                NSArray *arr = [[item.sizeArray objectAtIndex:j isArray:nil]objectForKey:[[item.colorArray objectAtIndex:currentColor isArray:nil] productid]];
                specitem = [arr objectAtIndex:row];
            }
        }

        currentSize = row;
        
        NSInteger sectionSpseid = section;
        if ([_muArrSelectGift count] != 0) {
            sectionSpseid -= [_muArrSelectGift count];
        }
        
        NSMutableDictionary *tmpDic = [[spseidArray objectAtIndex:sectionSpseid isArray:nil] objectAtIndex:index isArray:nil];
        [tmpDic setObject:[specitem objectForKey:@"id"] forKey:@"size"];
        
        GifesCell *cell = (GifesCell *)[giftTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
        [cell.chimaBtn setTitle:[specitem objectForKey:@"spec_alias"] forState:UIControlStateNormal];

        item.sizeNameStr = [specitem objectForKey:@"spec_alias"];
        
	}else if (tagnumber < ChimaNum && tagnumber > ColorNum) {//颜色
        
        NSInteger section = (tagnumber - ColorNum) / 100 - 1;
        NSInteger index = (tagnumber - ColorNum) % 100;
        NSMutableDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
        NSArray *giftsarray = [dic objectForKey:@"gifts"];
        YKGiftItem* item = (YKGiftItem*)[giftsarray objectAtIndex:index isArray:nil];
        
		YKSpecitem* specitem = (YKSpecitem*)[item.colorArray objectAtIndex:row isArray:nil];
        currentColor = row;
        
        //更换了颜色 对应的PIckview 要刷新数据
        currentSize = 0;

        [picker reloadAllComponents];

        NSInteger sectionSpaseid = section;
        if ([_muArrSelectGift count] != 0) {
            sectionSpaseid -= [_muArrSelectGift count];
        }
        
        //获取这个颜色id对应的尺码的id的第一个元素
        NSDictionary *sizeDic = nil;
        for (int j = 0; j<item.sizeArray.count; j++) {
            if ([[[[item.sizeArray objectAtIndex:j isArray:nil] allKeys] lastObject] isEqualToString:[[item.colorArray objectAtIndex:currentColor] productid]]) {
                
                NSArray *arr = [[item.sizeArray objectAtIndex:j isArray:nil]objectForKey:[[item.colorArray objectAtIndex:currentColor isArray:nil]productid] isDictionary:nil];
                sizeDic = [arr objectAtIndex:0 isArray:nil];
            }
        }
        
        NSMutableDictionary *tmpDic = [[spseidArray objectAtIndex:sectionSpaseid isArray:nil] objectAtIndex:index isArray:nil];
        [tmpDic setObject:specitem.productid forKey:@"color"];
        //修改尺寸
        [tmpDic setObject:[sizeDic objectForKey:@"id"] forKey:@"size"];
        
        GifesCell *cell = (GifesCell *)[giftTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
        [cell.colorBtn setTitle:[NSString stringWithFormat:@"  %@  ",specitem.spec_alias] forState:UIControlStateNormal];
        
        [cell.chimaBtn setTitle:[sizeDic objectForKey:@"spec_alias"] forState:UIControlStateNormal];
        
        item.colorNameStr = specitem.spec_alias;
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 0) {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;

    switch (model.requestTag) {
        case Http_Selectgifts_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                SelectGifesModel *giftsModel = (SelectGifesModel *)model;
                selectGiftsModel = giftsModel;
                //赠品
                
                for (int i = 0; i < [giftsModel.gifts count]; i++) {
                    NSArray *tmpGiftArray = [giftsModel.gifts objectAtIndex:i isArray:nil];
                    NSInteger count = tmpGiftArray.count;
                    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionary];
                    [tmpDic setObject:@"1" forKey:@"isopen"];
                    [tmpDic setObject:@"1" forKey:@"ismeet"];
                    [tmpDic setObject:[tmpGiftArray objectAtIndex:count - 2 isArray:nil] forKey:@"promotion_name"];
                    [tmpDic setObject:[tmpGiftArray objectAtIndex:count - 1 isArray:nil] forKey:@"actionname"];
                    
                    [resultsArray addObject:tmpDic];

                    NSMutableArray *mutArrayGifts = [NSMutableArray array];
                    NSMutableArray* array = [[NSMutableArray alloc] init];
                    for (int j = 0; j < count - 2; j++) {
                        NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
                        
                        YKGiftItem *giftItem  = [tmpGiftArray objectAtIndex:j isArray:nil];
                        [mutArrayGifts addObject:giftItem];
                        //取颜色
                        YKSpecitem *specitem = [giftItem.colorArray objectAtIndex:0 isArray:nil];
                        giftItem.colorNameStr = specitem.spec_alias;
                        //取大小
                        NSDictionary *dic = [giftItem.sizeArray objectAtIndex:0 isArray:nil];
                        NSString *key = [[dic allKeys] objectAtIndex:0 isArray:nil];
                        NSArray *arr = [dic objectForKey:key];
                        NSDictionary *dicSize = [arr objectAtIndex:0 isArray:nil];
                        giftItem.sizeNameStr = [dicSize objectForKey:@"spec_value" isDictionary:nil];
                        
                        [muDic setObject:specitem.productid forKey:@"color"];
                        [muDic setObject:[dicSize objectForKey:@"id" isDictionary:nil] forKey:@"size"];

                        [array addObject:muDic];
                    }
                    [tmpDic setObject:mutArrayGifts forKey:@"gifts"];

                    [spseidArray addObject:array];
                }
                
                NSMutableArray *muArr = [NSMutableArray array];
                
                //不符合要求的赠品
                for (int i = 0; i < [giftsModel.nogifts count]; i++) {
                    NogiftsModel *nogiftsModel = [giftsModel.nogifts objectAtIndex:i isArray:nil];
                    if (nogiftsModel.isSelect) {
                        continue;
                    }
                    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionary];
                    [tmpDic setObject:@"0" forKey:@"isopen"];
                    [tmpDic setObject:@"0" forKey:@"ismeet"];
                    [tmpDic setObject:nogiftsModel.promotion_name forKey:@"promotion_name"];
                    [tmpDic setObject:nogiftsModel.actionname forKey:@"actionname"];
                    [tmpDic setObject:[NSArray array] forKey:@"gifts"];
                    [resultsArray addObject:tmpDic];
                }
                
                //说明已经选择赠品
                int k = 0;
                for (int i = 0; i < [giftsModel.nogifts count]; i++) {
                    NogiftsModel *nogiftsModel = [giftsModel.nogifts objectAtIndex:i isArray:nil];
                    
                    if (nogiftsModel.isSelect) {
                        NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
                        [muDic setObject:[NSNumber numberWithBool:YES] forKey:@"isSelect"];
                        [muDic setObject:nogiftsModel.nogiftsItemArr forKey:@"gifts"];
                        [muDic setObject:nogiftsModel.promotion_name forKey:@"promotion_name"];
                        [muDic setObject:nogiftsModel.actionname forKey:@"actionname"];
                        [muDic setObject:@"1" forKey:@"isopen"];
                        [muDic setObject:@"0" forKey:@"ismeet"];
                        [muDic setObject:nogiftsModel.strSelect forKey:@"select"];
                        [resultsArray insertObject:muDic atIndex:k];
                        k++;
                        [muArr addObject:nogiftsModel];
                    }
                }
                if (!_muArrSelectGift) {//存放所有已选得数组
                    _muArrSelectGift = [[NSMutableArray alloc] initWithArray:muArr];
                }
                
                [giftTab reloadData];
                
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
        case Http_Car_add_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
        case 10086:
        {
            [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
        }
            break;
            
        default:
            [SBPublicAlert hideMBprogressHUD:self.view];

            break;
    }

}

#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (tagnumber > ChimaNum) {
        
		NSInteger section = (tagnumber - ChimaNum) / 100 - 1;
        NSInteger index = (tagnumber - ChimaNum) % 100;
        NSDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
        NSArray *array = [dic objectForKey:@"gifts"];
        YKGiftItem* item = (YKGiftItem*)[array objectAtIndex:index isArray:nil];
        for (int j = 0; j<item.sizeArray.count; j++) {
            if ([[[[item.sizeArray objectAtIndex:j] allKeys] lastObject] isEqualToString:[[item.colorArray objectAtIndex:currentColor] productid]]) {
                
                NSArray *arr = [[item.sizeArray objectAtIndex:j isArray:nil]objectForKey:[[item.colorArray objectAtIndex:currentColor isArray:nil]productid]];
             
            return  [arr count];//[sizeArr count];
                
                
            }
        }
	}else if (tagnumber < ChimaNum && tagnumber > ColorNum) {
        NSInteger section = (tagnumber - ColorNum) / 100 - 1;
        NSInteger index = (tagnumber - ColorNum) % 100;
        NSDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
        NSArray *array = [dic objectForKey:@"gifts" isDictionary:nil];
        YKGiftItem* item = (YKGiftItem*)[array objectAtIndex:index isArray:nil];
        
		return [item.colorArray count];
	}

	return 0;
}

//设置picker内容区域的大小
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return 240.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	
	return 50;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 200, 35)];
    titleLabel.textAlignment = UITextAlignmentCenter;

	NSString *pickerText = @"";
	NSString *url = @"";
	if (tagnumber > ChimaNum) {
        
        NSInteger section = (tagnumber - ChimaNum) / 100 - 1;
        NSInteger index = (tagnumber - ChimaNum) % 100;
        NSDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
        NSArray *array = [dic objectForKey:@"gifts"];
        YKGiftItem* item = (YKGiftItem*)[array objectAtIndex:index isArray:nil];
        
        for (int j = 0; j<item.sizeArray.count; j++) {
            if ([[[[item.sizeArray objectAtIndex:j isArray:nil] allKeys] lastObject] isEqualToString:[[item.colorArray objectAtIndex:currentColor isArray:nil] productid]]) {
                
                NSArray *arr = [[item.sizeArray objectAtIndex:j isArray:nil]objectForKey:[[item.colorArray objectAtIndex:currentColor isArray:nil]productid]];
                NSDictionary * specitem = [arr objectAtIndex:row isArray:nil];
                
                pickerText = [specitem objectForKey:@"spec_alias"];
                url = [specitem objectForKey:@"imgurl"];
            }
        }
	}else if (tagnumber < ChimaNum && tagnumber > ColorNum) {
        NSInteger section = (tagnumber - ColorNum) / 100 - 1;
        NSInteger index = (tagnumber - ColorNum) % 100;
        NSDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
        NSArray *array = [dic objectForKey:@"gifts"];
        YKGiftItem* item = (YKGiftItem*)[array objectAtIndex:index isArray:nil];
		YKSpecitem* specitem = (YKSpecitem*)[item.colorArray objectAtIndex:row isArray:nil];
		pickerText = specitem.spec_alias;
		url = specitem.imgurl;
	}
     titleLabel.text = pickerText;
     titleLabel.backgroundColor = [UIColor clearColor];
     titleLabel.font = [UIFont boldSystemFontOfSize:18];
     if (tagnumber > ChimaNum) {
         
     }else if (tagnumber < ChimaNum && tagnumber > ColorNum) {
          UrlImageView* shoppingImg = [[UrlImageView alloc] init];
          [shoppingImg setImageFromUrl:YES withUrl:url];
          shoppingImg.frame = CGRectMake(160, 5, 30, 30);
          [titleLabel addSubview:shoppingImg];
     }
   return titleLabel; 
    
}

#pragma mark ===UITableViewDelegate ========

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [resultsArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
    NSArray *array = [dic objectForKey:@"gifts"];
    
    NSInteger isMeet = [[dic objectForKey:@"ismeet"] integerValue];
    if (isMeet == 1) {
        return [array count];
    }
    if ([array count] == 0) {
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [resultsArray objectAtIndex:indexPath.section isArray:nil];
    NSArray *array = [dic objectForKey:@"gifts"];
    
    BOOL states = [[dic objectForKey:@"isSelect"] boolValue];
    
    NSInteger isMeet = [[dic objectForKey:@"ismeet"] integerValue];
    if (isMeet == 1) {//满足条件
        
        static NSString *CellIdentifier = @"GifesCell";

        GifesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GifesCell" owner:self options:nil] objectAtIndex:0 isArray:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.tag = [indexPath section];
        
        
        cell.colorBtn.tag = 10000 + 100 * (indexPath.section +1) + indexPath.row;
        [cell.colorBtn addTarget:self action:@selector(pickAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.colorBtn setTitleColor:[UIColor colorWithHexString:@"0x666666"] forState:UIControlStateNormal];
        
        cell.chimaBtn.tag = 20000 + 100 * (indexPath.section +1) + indexPath.row;
        [cell.chimaBtn addTarget:self action:@selector(pickAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.chimaBtn setTitleColor:[UIColor colorWithHexString:@"0x666666"] forState:UIControlStateNormal];

        
        YKGiftItem* item = (YKGiftItem*)[array objectAtIndex:indexPath.row isArray:nil];

        cell.titleLabel.text = item.productname;
        [cell.picImgView setImageWithURL:[NSURL URLWithString:item.imageurl] placeholderImage:nil];
        //lee999
        cell.selectBtn.tag = [indexPath section];
        [cell.selectBtn setSelected:item.isSelect];
        
        NSString *chimaStr = item.sizeNameStr;
        NSString *colorStr = item.colorNameStr;

        if (chimaStr.length == 0) {
            [cell.chimaBtn setTitle:@"请选择" forState:UIControlStateNormal];
        } else {
            [cell.chimaBtn setTitle:chimaStr forState:UIControlStateNormal];
        }
        //选择颜色
        if (colorStr.length == 0) {
            [cell.colorBtn setTitle:@"请选择" forState:UIControlStateNormal];
        } else {
            [cell.colorBtn setTitle:[NSString stringWithFormat:@"  %@  ",colorStr] forState:UIControlStateNormal];
        }
        [cell.chimaBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 55, 6, 5)];
        [cell.colorBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 55, 6, 5)];
        [cell.chimaBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -28, 0, 0)];
        [cell.colorBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -28, 0, 0)];

        
        UIButton *addCartButton = (UIButton *)[cell viewWithTag:100+indexPath.section];

        UILabel *label = (UILabel *)[cell viewWithTag:1101];
       
        if (indexPath.row == [array count]-1) {
            
            if (!label) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(0, 142, 320, 22)];
                label.text = @"赠品如不加入购物车内将视为放弃领取活动赠品";
                label.tag = 1101;
                label.font = [UIFont systemFontOfSize:14];
                label.backgroundColor = [UIColor clearColor];
                [label setTextColor:RGBACOLOR(190, 0, 38, 1)];
                label.textAlignment = UITextAlignmentCenter;
                [cell addSubview:label];
            }
            [label setHidden:NO];
            
            addCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [cell addSubview:addCartButton];
            addCartButton.tag = 100+indexPath.section;
            
            addCartButton.frame = CGRectMake(50, label.frame.origin.y + label.frame.size.height, 220, 35);
            addCartButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            
            if ([item.colorArray count]==0) {
                [addCartButton setTitle:@"已售完" forState:UIControlStateNormal];
                [addCartButton setEnabled:NO];
            }else{
                [addCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
                [addCartButton setEnabled:YES];
            }
            [addCartButton addTarget:self action:@selector(addCarAction:) forControlEvents:UIControlEventTouchUpInside];
            [addCartButton setBackgroundImage:[UIImage imageNamed:@"big_btn_r_normal.png"] forState:UIControlStateNormal];
            [addCartButton setBackgroundImage:[UIImage imageNamed:@"big_btn_r_hover.png"] forState:UIControlStateHighlighted];
            [addCartButton setHidden:NO];
        } else {
            if (addCartButton) {
                [addCartButton setHidden:YES];
            }
            if (label) {
                [label setHidden:YES];
            }
        }
        
        return cell;
    } else {//不满足
        static NSString *CellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        UIView *view = [cell viewWithTag:120];
        if (view) {
            [view removeFromSuperview];
        }
        
        PicsView *picsView = [[PicsView alloc] initWithDatas:array andDic:dic];
        picsView.tag = 120;
        [cell addSubview:picsView];
        picsView.delegate = self;
        picsView.frame = CGRectMake(0, 0, ScreenWidth, [PicsView heightForDatas:array type:states]);
        return cell;
    }
        return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [resultsArray objectAtIndex:indexPath.section isArray:nil];
    NSArray *array = [dic objectForKey:@"gifts"];
    BOOL states = [[dic objectForKey:@"isSelect"] boolValue];
    NSInteger isMeet = [[dic objectForKey:@"ismeet"] integerValue];
    if (isMeet == 1) {//已满足
        if (indexPath.row == [array count]-1) {
            return 145 + 60;
        }
    } else {
        NSDictionary *dic = [resultsArray objectAtIndex:indexPath.section isArray:nil];
        NSArray *array = [dic objectForKey:@"gifts"];
        return [PicsView heightForDatas:array type:states];
    }
    
	return 145;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
      NSDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
    BOOL states = [[dic objectForKey:@"isopen"] boolValue];
    ButtonInSection *titleForTb = [[ButtonInSection alloc]initWithFrame:CGRectMake(0, 0, 320, 44)
            title:dic
          section:section
           opened: states
         delegate:self];
    return titleForTb;
}


#pragma mark ButtonInSeactionDelegate
-(void)sectionHeaderView:(ButtonInSection*)sectionHeaderView sectionClosed:(NSInteger)section
{
    NSMutableDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
    [dic setObject:@"0" forKey:@"isopen"];
    
    NSArray *array = [dic objectForKey:@"gifts"];
    NSMutableArray *indexPathArray = [NSMutableArray array];
    NSInteger isMeet = [[dic objectForKey:@"ismeet"] integerValue];
    if (isMeet == 1) {
        for (int i = 0; i < [array count]; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [indexPathArray addObject:indexPath];
        }
    } else {
        for (int i = 0; i < 1; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [indexPathArray addObject:indexPath];
        }
    }
    
    [dic setObject:[NSArray array] forKey:@"gifts"];
    [giftTab deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];

}

-(void)sectionHeaderView:(ButtonInSection*)sectionHeaderView sectionOpened:(NSInteger)section
{
    NSMutableDictionary *dic = [resultsArray objectAtIndex:section isArray:nil];
    [dic setObject:@"1" forKey:@"isopen"];
    
    BOOL isSelect = [[dic objectForKey:@"isSelect"] boolValue];
    
    NSInteger isMeet = [[dic objectForKey:@"ismeet"] integerValue];
    NSMutableArray *indexPathArray = [NSMutableArray array];

    if (isMeet == 1) {//gifts   满足条件
        NSInteger indexInt = section;
        if ([_muArrSelectGift count] != 0) {
            indexInt -= [_muArrSelectGift count];
        }
        
        NSMutableArray *ykgiftsArray = [NSMutableArray arrayWithArray:[selectGiftsModel.gifts objectAtIndex:indexInt isArray:nil]];
        [ykgiftsArray removeLastObject];
        [ykgiftsArray removeLastObject];
        
        [dic setObject:ykgiftsArray forKey:@"gifts"];
        for (int i = 0; i < [ykgiftsArray count]; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [indexPathArray addObject:indexPath];
        }

    } else if (isSelect) {//已添加到购物车
        NogiftsModel *nogiftsModel = [_muArrSelectGift objectAtIndex:section isArray:nil];
        NSMutableArray *nogiftsArray = [NSMutableArray arrayWithArray:nogiftsModel.nogiftsItemArr];
        [dic setObject:nogiftsArray forKey:@"gifts"];
        for (int i = 0; i < 1; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [indexPathArray addObject:indexPath];
        }
        
    } else {//nogifts   不满足条件
        NSInteger index = section - [selectGiftsModel.gifts count];
        NogiftsModel *nogiftsModel = [selectGiftsModel.nogifts objectAtIndex:index isArray:nil];
        NSMutableArray *nogiftsArray = [NSMutableArray arrayWithArray:nogiftsModel.nogiftsItemArr];
        [dic setObject:nogiftsArray forKey:@"gifts"];

        for (int i = 0; i < 1; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [indexPathArray addObject:indexPath];
        }
    }
    [giftTab insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark PicsViewDelegate
- (void)didSelectItemAtIndex:(NogiftsItem *)nogifts{
}
- (void)giftsCellWithStates:(BOOL)states indexPath:(NSInteger)index{
    
    NSDictionary *dic = [resultsArray objectAtIndex:index isArray:nil];
    NSArray *array = [dic objectForKey:@"gifts"];
    
    if ([array count] != 0){
        YKGiftItem* item = (YKGiftItem*)[array objectAtIndex:0 isArray:nil];
        item.isSelect = states;
    }
    
    NSInteger section = index;
    if ([_muArrSelectGift count] != 0) {
        section -= [_muArrSelectGift count];
    }else{
        section = 0;
    }
    
    NSLog(@"index是：%ld-----section是：%ld",(long)index,(long)section);
    
    //lee 防止崩溃 增加判断
    //lee999 150608
    if ([spseidArray count] > index ||
        [(NSArray*)[spseidArray objectAtIndex:index isArray:nil] count]> section) {
        NSMutableDictionary *tmpDic = [[spseidArray objectAtIndex:index isArray:nil] objectAtIndex:section isArray:nil];
        [tmpDic setObject:[NSString stringWithFormat:@"%d",states] forKey:@"isSelect"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end




