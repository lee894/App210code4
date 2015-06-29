//
//  ManageGiftInfoParser.h
//  MyAimerApp
//
//  Created by 蒋博男 on 15/6/29.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "YKBaseEntity.h"
#import "BaseParser.h"

@interface ProductBanner : YKBaseEntity
-(NSString*)pbid;
-(NSString*)pic;
@end

@interface SpecValues : YKBaseEntity
-(NSString*)svid;
-(NSString*)spec_id;
-(NSString*)spec_value;
-(NSString*)spec_alias;
-(NSString*)imgurl;
@end

@interface AddressInfo : YKBaseEntity
-(NSString*)address_id;
-(NSString*)user_name;
-(NSString*)province;
-(NSString*)city;
-(NSString*)county;
-(NSString*)address;
-(NSString*)mobile;
-(NSString*)phone;
@end

@interface GiftProductItemInfo : YKBaseEntity
-(NSString*)pid;
-(NSString*)count;
-(YKBaseEntity*)_spec_value_ids;
@end

@interface GiftProductInfo : YKBaseEntity
-(NSArray*)products;
-(NSArray*)specs;
-(NSArray*)spec_values;
-(YKBaseEntity*)propos;
-(NSArray*)product_banner;
-(NSString*)product_name;
-(NSString*)price;
-(NSString*)mkt_price;
-(GiftProductItemInfo*)currentProduct;
-(void)setCurrentProduct:(GiftProductItemInfo*)gpii;
@end

@interface ManageGiftInfo : YKBaseEntity
-(NSString*)response;
-(AddressInfo*)address;
-(NSArray*)productlist;
@end

@interface ManageGiftInfoParser : BaseParser
-(ManageGiftInfo*)ParseManageGiftInfo:(NSDictionary*)dic;
@end
