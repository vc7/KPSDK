//
//  KPSDK.h
//  KPSDK
//
//  Created by vincent on 2014/08/22.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KPDefines.h"

#import "KPHTTPClient.h"

#import "KPObject.h"
#import "KPCategory.h"
#import "KPArticle.h"
#import "KPAlbum.h"
#import "KPPhoto.h"
#import "KPPlaylist.h"
#import "KPVideo.h"
#import "KPVideoThumbnail.h"
#import "KPMusicPlaylist.h"
#import "KPMusic.h"

@interface KPSDK : NSObject

#pragma - KPAPI

/** @name Connection with KPAPI */

/*!
 [Required!] Set the API Key of your appilcation.
 @param apiKey The API Key given by http://unlimited.kptaipei.tw/
 */
+ (void)setAPIKey:(NSString *)apiKey;
/*!
 get current API Key
 */
+ (NSString *)getAPIKey;

@end