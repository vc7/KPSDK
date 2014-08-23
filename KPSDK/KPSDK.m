//
//  KPSDK.h
//  KPSDK
//
//  Created by vincent on 2014/08/22.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPSDK.h"

@implementation KPSDK

+ (void)setAPIKey:(NSString *)apiKey
{
    [[KPHTTPClient sharedClient] setAPIKey:apiKey];
}

+ (NSString *)getAPIKey
{
    return [[KPHTTPClient sharedClient] getAPIKey];
}

@end