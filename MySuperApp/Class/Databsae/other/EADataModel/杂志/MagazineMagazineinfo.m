//
//  MagazineMagazineinfo.m
//
//  Created by malan  on 14-4-20
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MagazineMagazineinfo.h"


@interface MagazineMagazineinfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MagazineMagazineinfo

@synthesize synopsisText = _synopsisText;
@synthesize titleText = _titleText;
@synthesize simgPath = _simgPath;
@synthesize mainText = _mainText;
@synthesize imgPath = _imgPath;
@synthesize shareUrl=_shareUrl;

+ (MagazineMagazineinfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    MagazineMagazineinfo *instance = [[MagazineMagazineinfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.synopsisText = [self objectOrNilForKey:@"synopsis_text" fromDictionary:dict];
            self.titleText = [self objectOrNilForKey:@"title_text" fromDictionary:dict];
            self.simgPath = [self objectOrNilForKey:@"simg_path" fromDictionary:dict];
            self.mainText = [self objectOrNilForKey:@"main_text" fromDictionary:dict];
            self.imgPath = [self objectOrNilForKey:@"img_path" fromDictionary:dict];
        self.shareUrl = [self objectOrNilForKey:@"share_url" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.synopsisText forKey:@"synopsis_text"];
    [mutableDict setValue:self.titleText forKey:@"title_text"];
    [mutableDict setValue:self.simgPath forKey:@"simg_path"];
    [mutableDict setValue:self.mainText forKey:@"main_text"];
    [mutableDict setValue:self.imgPath forKey:@"img_path"];
    [mutableDict setValue:self.shareUrl forKey:@"share_url"];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.synopsisText = [aDecoder decodeObjectForKey:@"synopsisText"];
    self.titleText = [aDecoder decodeObjectForKey:@"titleText"];
    self.simgPath = [aDecoder decodeObjectForKey:@"simgPath"];
    self.mainText = [aDecoder decodeObjectForKey:@"mainText"];
    self.imgPath = [aDecoder decodeObjectForKey:@"imgPath"];
    self.shareUrl = [aDecoder decodeObjectForKey:@"share_url"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_synopsisText forKey:@"synopsisText"];
    [aCoder encodeObject:_titleText forKey:@"titleText"];
    [aCoder encodeObject:_simgPath forKey:@"simgPath"];
    [aCoder encodeObject:_mainText forKey:@"mainText"];
    [aCoder encodeObject:_imgPath forKey:@"imgPath"];
    [aCoder encodeObject:_shareUrl forKey:@"share_url"];
}

@end
