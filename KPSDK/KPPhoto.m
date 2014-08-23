//
//  KPPhoto.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPPhoto.h"
#import "KPDefines.h"

@implementation KPPhoto

+ (NSString *)kpClassName
{
    return @"Photo";
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary
{
    if ( ! dictionary) {
        return nil;
    }
    
    KPPhoto *photo = [KPPhoto new];
    
    photo.title = dictionary[@"title"];
    photo.originURL = dictionary[@"link"];
    photo.primary = [dictionary[@"isprimary"] boolValue];
    photo.latitude = [dictionary[@"location"][@"latitude"] doubleValue];
    photo.latitude = [dictionary[@"location"][@"longitude"] doubleValue];
    
    NSDictionary *images = dictionary[@"images"];
    
    photo.images = @{kKPPhotoSizeSmall:images[kKPPhotoSizeSmall],
                     kKPPhotoSizeSmallSquqre:images[kKPPhotoSizeSmallSquqre],
                     kKPPhotoSizeLargeSquare:images[kKPPhotoSizeLargeSquare],
                     kKPPhotoSizeThumbnail:images[kKPPhotoSizeThumbnail],
                     kKPPhotoSizeMedium:images[kKPPhotoSizeMedium],
                     kKPPhotoSizeLarge:images[kKPPhotoSizeLarge],
                     kKPPhotoSizeOriginal:images[kKPPhotoSizeOriginal],};
    
    photo.takenAt = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[dictionary[@"date_taken"] doubleValue]];
    photo.uploadedAt = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[dictionary[@"date_upload"] doubleValue]];
    
    return photo;
}

@end
