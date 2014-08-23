//
//  KPVideoThumbnail.h
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface KPVideoThumbnail : NSObject

@property (nonatomic, strong) NSString *originURL;
@property (nonatomic) CGSize imageSize;

+ (KPVideoThumbnail *)thumbnailWithOriginURL:(NSString *)url size:(CGSize)size;

@end
