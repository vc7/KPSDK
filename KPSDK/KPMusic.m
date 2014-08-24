//
//  KPMusic.m
//  KPSDK
//
//  Created by vincent on 2014/08/24.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "KPMusic.h"

@implementation KPMusic

+ (NSString *)kpClassName
{
    return @"Playlist";
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary
{
    if ( ! dictionary) {
        return nil;
    }
    
    KPMusic *music = [KPMusic new];
    
    music.objectId = dictionary[@"id"];
    music.soundcloudId = dictionary[@"soundcloudID"];
    music.name = dictionary[@"song_name"];
    music.group = dictionary[@"groupname"];
    music.originURL = dictionary[@"link"];
    music.lyric = dictionary[@"lyric"];
    music.voteCount = [dictionary[@"votes"] integerValue];
    
    return music;
}

@end
