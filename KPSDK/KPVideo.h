//
//  KPVideo.h
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPObject.h"

@class KPPlaylist;

@interface KPVideo : KPObject

@property (nonatomic, strong) KPPlaylist *playlist;

@property (nonatomic, strong) NSString *sysId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDictionary *thumbnails;
@property (nonatomic, strong) NSString *originURL;
@property (nonatomic, strong) NSDate *publishedAt;

@end
