//
//  KPHTTPClient.h
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "AFNetworking.h"

typedef void (^KPHTTPClientSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void (^KPHTTPClientFailure)(NSURLSessionDataTask *task, NSError *error);

@interface KPHTTPClient : AFHTTPSessionManager

#pragma mark - Client Lifecycle

+ (KPHTTPClient *)sharedClient;
+ (NSString *)apiVersion;

- (void)setAPIKey:(NSString *)apiKey;
- (NSString *)getAPIKey;

#pragma mark - Category

/*!
 Get category list
 @param success success callback, will return the operation and category array for response object if has any.
 @param failur failure callback, will return the operation and the error if has any.
 */
- (void)getCategoriesWithSuccess:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;

#pragma mark - Article List

/*!
 Get article list by category id
 
 @param objectId as NSString, the id of category.
 @param page as NSUInteger, default is 0.
 @param pageSize as NSUInteger, default is 100, max is 500, giving 0 to got default 100 records.
 @param success success callback, will return the operation and category array for response object if has any.
 @param failur failure callback, will return the operation and the error if has any.
 */
- (void)getArticlesByCategoryId:(NSString *)objectId page:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getArticlesByCategoryId:(NSString *)objectId page:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getArticlesByCategoryId:(NSString *)objectId pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getArticlesByCategoryId:(NSString *)objectId success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
@end
