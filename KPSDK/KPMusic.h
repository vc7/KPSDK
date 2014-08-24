//
//  KPMusic.h
//  KPSDK
//
//  Created by vincent on 2014/08/24.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "KPObject.h"

@class KPMusicPlaylist;

@interface KPMusic : KPObject

@property (nonatomic, strong) KPMusicPlaylist *playlist;

@property (nonatomic, strong) NSString *soundcloudId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *group;
@property (nonatomic, strong) NSString *originURL;
@property (nonatomic, strong) NSString *lyric;
@property (nonatomic, strong) NSString *creative;

@property (nonatomic) NSInteger voteCount;

@end
