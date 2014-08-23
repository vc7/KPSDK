//
//  KPAlbum.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPAlbum.h"

@implementation KPAlbum

+ (NSString *)kpClassName
{
    return @"Album";
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary
{
    if ( ! dictionary) {
        return nil;
    }
    
    KPAlbum *album = [KPAlbum new];
    
    album.objectId = dictionary[@"id"];
    album.description = dictionary[@"discription"];
    album.originURL = dictionary[@"link"];
    
    album.photoCount = [dictionary[@"photos"] integerValue];
    album.videoCount = [dictionary[@"videos"] integerValue];
    
    album.createdAt = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[dictionary[@"date_create"] doubleValue]];
    album.updatedAt = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[dictionary[@"date_update"] doubleValue]];
    
    return album;
}

@end
