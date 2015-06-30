//
//  YKProductsItem.m
//  YKProduct
//
//  Created by k ye on 11-12-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "YKProductsItem.h"

@implementation YKSuitListItem
@synthesize disountprice,price,save,number,suitid,suits;

//lee999 新增套装的积分
@synthesize suit_score;

-(id)init
{
    if (self = [super init]) {
        suits = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

@end


@implementation YKProductsItem

-(NSString *)goodsid{
    return [self attributeForKey:@"goods_id"];

}
-(void)setGoodsid:(NSString *)goodsid{
    [self setAttribute:goodsid forKey:@"goods_id"];

}

-(NSString*)ID{
     return [self attributeForKey:@"id"];
}
-(void)setID:(NSString*)aID{
     [self setAttribute:aID forKey:@"id"];
}
-(NSString*)Count{
     return [self attributeForKey:@"count"];
}
-(void)setCount:(NSString*)aCount{
     [self setAttribute:aCount forKey:@"count"];
}
-(NSDictionary*)Spec_value_id{
     return [self attributeForKey:@"_spec_value_ids"];
}
-(void)setSpec_value_id:(NSDictionary*)aSpec_value_id{
     [self setAttribute:aSpec_value_id forKey:@"_spec_value_ids"];
} 

//供套装使用
-(NSString*)product_id
{
    return [self attributeForKey:@"product_id"];
}
-(void)setProduct_id:(NSString*)aId
{
    [self setAttribute:aId forKey:@"product_id"];
}

-(NSString*)name
{
    return [self attributeForKey:@"name"];
}
-(void)setName:(NSString*)aName
{
    [self setAttribute:aName forKey:@"name"];
}

-(NSString*)pic
{
    return [self attributeForKey:@"pic"];
}
-(void)setPic:(NSString*)aPic
{
    [self setAttribute:aPic forKey:@"pic"];
}

-(float)mkt_price
{
    return [[self attributeForKey:@"mkt_price"] floatValue];
}
-(void)setMkt_price:(float)aPrice
{
    NSNumber *value = [NSNumber numberWithFloat:aPrice];
    [self setAttribute:value forKey:@"mkt_price"];
}

-(float)price
{
    return [[self attributeForKey:@"price"] floatValue];
}
-(void)setPrice:(float)aPrice
{
    NSNumber *value = [NSNumber numberWithFloat:aPrice];
    [self setAttribute:value forKey:@"price"];
}

-(NSString*)size
{
    return [self attributeForKey:@"size"];
}
-(void)setSize:(NSString*)aSize
{
    [self setAttribute:aSize forKey:@"size"];
}

-(NSString*)color
{
    return [self attributeForKey:@"color"];
}
-(void)setColor:(NSString*)aColor
{
    [self setAttribute:aColor forKey:@"color"];
}

-(NSString*)stock
{
    id value = [self attributeForKey:@"stock"];
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return value;
}

-(void)setStock:(NSString*)aStock
{
    [self setAttribute:aStock forKey:@"stock"];
}

-(NSString*)uk
{
    id value = [self attributeForKey:@"uk"];
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return value;
}

-(void)setUk:(NSString*)aUk
{
    [self setAttribute:aUk forKey:@"uk"];
}

-(BOOL)selected
{
    id value = [self attributeForKey:@"selected"];
    if ([value isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return [value boolValue];
}
-(void)setSelected:(BOOL)aSelected
{
    [self setAttribute:[NSNumber numberWithBool:aSelected] forKey:@"selected"];
}

@end
@implementation YKColor_Size
-(NSString*)ID{
     return [self attributeForKey:@"id"];
}
-(void)setID:(NSString*)aID{
     [self setAttribute:aID forKey:@"id"];
}
-(NSString*)Spec_type{
     return [self attributeForKey:@"spec_type"];
}
-(void)setSpec_type:(NSString*)aSpec_type{
     [self setAttribute:aSpec_type forKey:@"spec_type"];
}
-(NSString*)Type{
     return [self attributeForKey:@"type"];
}
-(void)setType:(NSString*)aType{
     [self setAttribute:aType forKey:@"type"];
}
-(NSString*)View_name{
     return [self attributeForKey:@"view_name"];
}
-(void)setView_name:(NSString*)aView_name{
     [self setAttribute:aView_name forKey:@"view_name"];
}

@end
@implementation YKBannerItem
-(NSString*)ID{
     return [self attributeForKey:@"id"];
}
-(void)setID:(NSString*)aID{
     [self setAttribute:aID forKey:@"id"];
}
-(NSString*)BannerPic{
     return [self attributeForKey:@"pic"];
}
-(void)setBannerPic:(NSString*)aBannerPic{
     [self setAttribute:aBannerPic forKey:@"pic"];
}

@end



//lee999 新增支付方式选择
@implementation YKAllowPayType

//-(NSString*)typeID{
//    return [self attributeForKey:@"id"];
//}
//-(void)settypeID:(NSString*)aID{
//    [self setAttribute:aID forKey:@"id"];
//}
//
//-(NSString*)typeDesc{
//    return [self attributeForKey:@"desc"];
//}
//-(void)settypeDesc:(NSString*)adesc{
//    [self setAttribute:adesc forKey:@"desc"];
//}

@synthesize paytypeDesc,payid;

@end
