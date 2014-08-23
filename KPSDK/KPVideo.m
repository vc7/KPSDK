//
//  KPVideo.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPVideo.h"
#import "KPDefines.h"
#import "KPVideoThumbnail.h"

@implementation KPVideo

+ (NSString *)kpClassName
{
    return @"Playlist";
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary
{
    if ( ! dictionary) {
        return nil;
    }
    
    KPVideo *video = [KPVideo new];
    
    video.objectId = dictionary[@"id"];
    video.sysId = dictionary[@"sys_id"];
    video.title = dictionary[@"title"];
    video.description = dictionary[@"description"];
    video.originURL = dictionary[@"link"];
    
    NSDictionary *images = dictionary[@"thumbnails"];
    
    video.thumbnails = @{kKPVideoThumbnailSizeDefault:[KPVideoThumbnail thumbnailWithOriginURL:images[kKPVideoThumbnailSizeDefault][@"url"]
                                                                                          size:CGSizeMake([images[kKPVideoThumbnailSizeDefault][@"width"] floatValue],
                                                                                                          [images[kKPVideoThumbnailSizeDefault][@"height"] floatValue])],
                         kKPVideoThumbnailSizeMedium:[KPVideoThumbnail thumbnailWithOriginURL:images[kKPVideoThumbnailSizeMedium][@"url"]
                                                                                         size:CGSizeMake([images[kKPVideoThumbnailSizeMedium][@"width"] floatValue],
                                                                                                         [images[kKPVideoThumbnailSizeMedium][@"height"] floatValue])],
                         kKPVideoThumbnailSizeHigh:[KPVideoThumbnail thumbnailWithOriginURL:images[kKPVideoThumbnailSizeHigh][@"url"]
                                                                                       size:CGSizeMake([images[kKPVideoThumbnailSizeHigh][@"width"] floatValue],
                                                                                                       [images[kKPVideoThumbnailSizeHigh][@"height"] floatValue])],
                         kKPVideoThumbnailSizeStandard:[KPVideoThumbnail thumbnailWithOriginURL:images[kKPVideoThumbnailSizeStandard][@"url"]
                                                                                           size:CGSizeMake([images[kKPVideoThumbnailSizeStandard][@"width"] floatValue],
                                                                                                           [images[kKPVideoThumbnailSizeStandard][@"height"] floatValue])],
                         kKPVideoThumbnailSizeMaxres:[KPVideoThumbnail thumbnailWithOriginURL:images[kKPVideoThumbnailSizeMaxres][@"url"]
                                                                                         size:CGSizeMake([images[kKPVideoThumbnailSizeMaxres][@"width"] floatValue],
                                                                                                         [images[kKPVideoThumbnailSizeMaxres][@"height"] floatValue])]
                         };
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssSSS'Z'"];
    
    video.publishedAt = [dateFormatter dateFromString:dictionary[@"publishedAt"]];
    
    return video;
}

@end
