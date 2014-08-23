//
//  KPDefines.h
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - API

extern NSString *const kKPAPIScheme;    //! @constant protocol of KPAPI
extern NSString *const kKPAPIHost;      //! @constant host of KPAPI
extern NSString *const kKPAPIVersion;   //! @constant default version of KPAPI

#pragma mark - Photo Key Names

extern NSString *const kKPPhotoSizeSmall;
extern NSString *const kKPPhotoSizeSmallSquqre;
extern NSString *const kKPPhotoSizeLargeSquare;
extern NSString *const kKPPhotoSizeThumbnail;
extern NSString *const kKPPhotoSizeMedium;
extern NSString *const kKPPhotoSizeLarge;
extern NSString *const kKPPhotoSizeOriginal;

#pragma mark - Video Key Names

extern NSString *const kKPVideoThumbnailSizeDefault;
extern NSString *const kKPVideoThumbnailSizeMedium;
extern NSString *const kKPVideoThumbnailSizeHigh;
extern NSString *const kKPVideoThumbnailSizeStandard;
extern NSString *const kKPVideoThumbnailSizeMaxres;