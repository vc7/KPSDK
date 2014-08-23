//
//  KPHTTPClient.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPHTTPClient.h"
#import "KPDefines.h"

#import "KPCategory.h"
#import "KPArticle.h"

NSString * const kKPRequestParameterAccessToken = @"accessToken";
NSString * const kKPRequestParameterPage = @"page";
NSString * const kKPRequestParameterPageSize = @"page_size";

NSString * const kKPRequestPathCategory = @"category";
NSString * const kKPRequestPathAlbums = @"albums";
NSString * const kKPRequestPathVideos = @"videos";

@interface KPHTTPClient ()

@property (nonatomic, strong) NSDictionary *baseParameter;

@end

@implementation KPHTTPClient {
    NSString *apiKey;
    NSDictionary *baseParameter;
}

@synthesize baseParameter;

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

- (void)setAPIKey:(NSString *)newAPIKey
{
    if ( ! [apiKey isEqualToString:newAPIKey]) {
        
        apiKey = newAPIKey;
        
        baseParameter = @{ kKPRequestParameterAccessToken:apiKey };
    }
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

#pragma mark - GET Request

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if ( ! [self getAPIKey]) {
        
        @throw([NSException exceptionWithName:@"kKPAPIKeyNotSetException" reason:@"API key is not been set" userInfo:nil]);
    }
    
    NSMutableDictionary *completeParameter = [NSMutableDictionary dictionaryWithDictionary:self.baseParameter];
    
    if (parameters && [parameters isKindOfClass:[NSDictionary class]]) {
        
        [completeParameter addEntriesFromDictionary:parameters];
    }
    
    return [super GET:URLString parameters:completeParameter success:success failure:failure];
}

#pragma mark - Category

- (void)getCategoriesWithSuccess:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self GET:kKPRequestPathCategory parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject) {
            
            NSArray *data = responseObject[@"data"];
            __block NSMutableArray *categoryArray = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dataDictionary, NSUInteger idx, BOOL *stop) {
                KPCategory *category = [KPCategory objectWithDictionary:dataDictionary];
                
                [categoryArray addObject:category];
                
            }];
            
            success(task, categoryArray);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

#pragma mark - Article List

- (void)getArticlesByCategoryId:(NSString *)objectId page:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    if ( ! objectId) {
        @throw([NSException exceptionWithName:@"kKPRequestCategoryIdNotSetException" reason:@"category id shoud be set for this request." userInfo:nil]);
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (page > 0) {
        [parameters setObject:@(page) forKey:kKPRequestParameterPage];
    }
    
    if (pageSize > 0 && pageSize <= 500) {
        [parameters setObject:@(pageSize) forKey:kKPRequestParameterPage];
    } else if (pageSize <= 0) {
        [parameters setObject:@(100) forKey:kKPRequestParameterPage];
    } else {
        [parameters setObject:@(500) forKey:kKPRequestParameterPage];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kKPRequestPathCategory, objectId];
    
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject) {
            
            NSArray *data = responseObject[@"data"];
            __block NSMutableArray *articlesArray = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dataDictionary, NSUInteger idx, BOOL *stop) {
                KPArticle *article = [KPArticle objectWithDictionary:dataDictionary];
                
                [articlesArray addObject:article];
                
            }];
            
            success(task, articlesArray);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}
- (void)getArticlesByCategoryId:(NSString *)objectId page:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getArticlesByCategoryId:objectId page:page pageSize:100 success:success failure:failure];
}
- (void)getArticlesByCategoryId:(NSString *)objectId pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getArticlesByCategoryId:objectId page:0 pageSize:pageSize success:success failure:failure];
}
- (void)getArticlesByCategoryId:(NSString *)objectId success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getArticlesByCategoryId:objectId page:0 pageSize:100 success:success failure:failure];
}
@end
