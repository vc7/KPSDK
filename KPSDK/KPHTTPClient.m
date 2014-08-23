//
//  KPHTTPClient.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPHTTPClient.h"
#import "KPDefines.h"

@implementation KPHTTPClient {
    NSString *apiKey;
}

#pragma mark - Client Lifecycle

+ (KPHTTPClient *)sharedClient
{
    static KPHTTPClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    
    return sharedClient;
}

+ (NSString *)apiVersion
{
    return kKPAPIVersion;
}

- (void)setAPIKey:(NSString *)theAPIKey
{
    apiKey = theAPIKey;
}

- (NSString *)getAPIKey
{
    return apiKey;
}

- (instancetype)init
{
    NSURL *baseURL = nil;
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSString *version = [[self class] apiVersion];
    
    
    baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@/", kKPAPIScheme, kKPAPIHost, version]];
    
    self = [super initWithBaseURL:baseURL sessionConfiguration:sessionConfiguration];
    if (self) {
        // By Default, response serializer is set to JSON, no need to setup here
    }
    return self;
}

@end
