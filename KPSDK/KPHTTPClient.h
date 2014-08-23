//
//  KPHTTPClient.h
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "AFNetworking.h"

@interface KPHTTPClient : AFHTTPSessionManager

#pragma mark - Client Lifecycle

+ (KPHTTPClient *)sharedClient;
+ (NSString *)apiVersion;

- (void)setAPIKey:(NSString *)apiKey;
- (NSString *)getAPIKey;

@end
