//
//  KPVideoThumbnail.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPVideoThumbnail.h"

@implementation KPVideoThumbnail

+ (KPVideoThumbnail *)thumbnailWithOriginURL:(NSString *)url size:(CGSize)size
{
    KPVideoThumbnail *thumbnail = [KPVideoThumbnail new];
    
    thumbnail.originURL = url;
    thumbnail.imageSize = size;
    
    return thumbnail;
}

@end
