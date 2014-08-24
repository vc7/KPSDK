//
//  KPMusicPlaylist.m
//  KPSDK
//
//  Created by vincent on 2014/08/24.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "KPMusicPlaylist.h"

@implementation KPMusicPlaylist

+ (NSString *)kpClassName
{
    return @"Playlist";
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary
{
    if ( ! dictionary) {
        return nil;
    }
    
    KPMusicPlaylist *playlist = [KPMusicPlaylist new];
    
    playlist.objectId = dictionary[@"id"];
    playlist.name = dictionary[@"name"];
    playlist.musicCount = [dictionary[@"count"] integerValue];
    
    return playlist;
}

@end
