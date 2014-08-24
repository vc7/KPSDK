//
//  KPPhoto.h
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPObject.h"

@class KPAlbum;

@interface KPPhoto : KPObject

// @property (nonatomic, strong) KPAlbum *album;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *originURL;
@property (nonatomic, strong) NSDictionary *images;
@property (nonatomic, getter = isPrimary) BOOL primary;
@property (nonatomic) double latitude;
@property (nonatomic) double longiture;

@property (nonatomic, strong) NSDate *takenAt;
@property (nonatomic, strong) NSDate *uploadedAt;

@end
