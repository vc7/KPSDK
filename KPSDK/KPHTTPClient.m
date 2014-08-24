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
#import "KPAlbum.h"
#import "KPPhoto.h"
#import "KPPlaylist.h"
#import "KPVideo.h"
#import "KPMusicPlaylist.h"
#import "KPMusic.h"

NSString * const kKPRequestParameterAccessToken = @"accessToken";
NSString * const kKPRequestParameterPage = @"page";
NSString * const kKPRequestParameterPageSize = @"page_size";

NSString * const kKPRequestPathCategory = @"category";
NSString * const kKPRequestPathAlbums = @"albums";
NSString * const kKPRequestPathVideos = @"videos";
NSString * const kKPRequestPathMusics = @"musics";

NSInteger const kKPPageDefault = 0;
NSInteger const kKPPageSizeDefault = 100;
NSInteger const kKPPageSizeMax = 500;

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
        @throw([NSException exceptionWithName:@"kKPRequestCategoryIdNotSetException" reason:@"Category id should be set for this request." userInfo:nil]);
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (page > 0) {
        [parameters setObject:@(page) forKey:kKPRequestParameterPage];
    }
    
    if (pageSize > 0 && pageSize <= kKPPageSizeMax) {
        [parameters setObject:@(pageSize) forKey:kKPRequestParameterPageSize];
    } else if (pageSize <= 0) {
        [parameters setObject:@(kKPPageSizeDefault) forKey:kKPRequestParameterPageSize];
    } else {
        [parameters setObject:@(kKPPageSizeMax) forKey:kKPRequestParameterPageSize];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kKPRequestPathCategory, objectId];
    
    [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
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
    [self getArticlesByCategoryId:objectId page:page pageSize:kKPPageSizeDefault success:success failure:failure];
}
- (void)getArticlesByCategoryId:(NSString *)objectId pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getArticlesByCategoryId:objectId page:kKPPageDefault pageSize:pageSize success:success failure:failure];
}
- (void)getArticlesByCategoryId:(NSString *)objectId success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getArticlesByCategoryId:objectId page:kKPPageDefault pageSize:kKPPageSizeDefault success:success failure:failure];
}


#pragma mark - Album

- (void)getAlbumsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (page > kKPPageDefault) {
        [parameters setObject:@(page) forKey:kKPRequestParameterPage];
    }
    
    if (pageSize > 0 && pageSize <= kKPPageSizeMax) {
        [parameters setObject:@(pageSize) forKey:kKPRequestParameterPageSize];
    } else if (pageSize <= 0) {
        [parameters setObject:@(kKPPageSizeDefault) forKey:kKPRequestParameterPageSize];
    } else {
        [parameters setObject:@(kKPPageSizeMax) forKey:kKPRequestParameterPageSize];
    }
    
    [self GET:kKPRequestPathAlbums parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject) {
            
            NSArray *data = responseObject[@"data"];
            __block NSMutableArray *albumsArray = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dataDictionary, NSUInteger idx, BOOL *stop) {
                KPAlbum *album = [KPAlbum objectWithDictionary:dataDictionary];
                
                [albumsArray addObject:album];
                
            }];
            
            success(task, albumsArray);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}
- (void)getAlbumsWithPage:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getAlbumsWithPage:page pageSize:kKPPageSizeDefault success:success failure:failure];
}
- (void)getAlbumsWithPageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getAlbumsWithPage:kKPPageDefault pageSize:pageSize success:success failure:failure];
}
- (void)getAlbumsWithSuccess:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getAlbumsWithPage:kKPPageDefault pageSize:kKPPageSizeDefault success:success failure:failure];
}

#pragma mark - Photo List

- (void)getPhotosByAlbumId:(NSString *)objectId page:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    if ( ! objectId) {
        @throw([NSException exceptionWithName:@"kKPRequestAlbumIdNotSetException" reason:@"Album id should be set for this request." userInfo:nil]);
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (page > kKPPageDefault) {
        [parameters setObject:@(page) forKey:kKPRequestParameterPage];
    }
    
    if (pageSize > 0 && pageSize <= kKPPageSizeMax) {
        [parameters setObject:@(pageSize) forKey:kKPRequestParameterPageSize];
    } else if (pageSize <= 0) {
        [parameters setObject:@(kKPPageSizeDefault) forKey:kKPRequestParameterPageSize];
    } else {
        [parameters setObject:@(kKPPageSizeMax) forKey:kKPRequestParameterPageSize];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kKPRequestPathAlbums, objectId];
    
    [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject) {
            
            NSArray *data = responseObject[@"data"];
            __block NSMutableArray *photosArray = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dataDictionary, NSUInteger idx, BOOL *stop) {
                KPPhoto *photo = [KPPhoto objectWithDictionary:dataDictionary];
                
                [photosArray addObject:photo];
                
            }];
            
            success(task, photosArray);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}
- (void)getPhotosByAlbumId:(NSString *)objectId page:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getPhotosByAlbumId:objectId page:page pageSize:kKPPageSizeDefault success:success failure:failure];
}
- (void)getPhotosByAlbumId:(NSString *)objectId pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getPhotosByAlbumId:objectId page:kKPPageDefault pageSize:pageSize success:success failure:failure];
}
- (void)getPhotosByAlbumId:(NSString *)objectId success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getPhotosByAlbumId:objectId page:kKPPageDefault pageSize:kKPPageSizeDefault success:success failure:failure];
}

#pragma mark - Playlist

- (void)getPlaylistsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (page > kKPPageDefault) {
        [parameters setObject:@(page) forKey:kKPRequestParameterPage];
    }
    
    if (pageSize > 0 && pageSize <= kKPPageSizeMax) {
        [parameters setObject:@(pageSize) forKey:kKPRequestParameterPageSize];
    } else if (pageSize <= 0) {
        [parameters setObject:@(kKPPageSizeDefault) forKey:kKPRequestParameterPageSize];
    } else {
        [parameters setObject:@(kKPPageSizeMax) forKey:kKPRequestParameterPageSize];
    }
    
    [self GET:kKPRequestPathVideos parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject) {
            
            NSArray *data = responseObject[@"data"];
            __block NSMutableArray *playlistsArray = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dataDictionary, NSUInteger idx, BOOL *stop) {
                KPPlaylist *playlist = [KPPlaylist objectWithDictionary:dataDictionary];
                
                [playlistsArray addObject:playlist];
                
            }];
            
            success(task, playlistsArray);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}
- (void)getPlaylistsWithPage:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getPlaylistsWithPage:page pageSize:kKPPageSizeDefault success:success failure:failure];
}
- (void)getPlaylistsWithPageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getPlaylistsWithPage:kKPPageDefault pageSize:pageSize success:success failure:failure];
}
- (void)getPlaylistsWithSuccess:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getPlaylistsWithPage:kKPPageDefault pageSize:kKPPageSizeDefault success:success failure:failure];
}

#pragma mark - Video List

- (void)getVideosByPlaylistId:(NSString *)objectId page:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    if ( ! objectId) {
        @throw([NSException exceptionWithName:@"kKPRequestPlaylistIdNotSetException" reason:@"Playlist id should be set for this request." userInfo:nil]);
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (page > 0) {
        [parameters setObject:@(page) forKey:kKPRequestParameterPage];
    }
    
    if (pageSize > 0 && pageSize <= kKPPageSizeMax) {
        [parameters setObject:@(pageSize) forKey:kKPRequestParameterPageSize];
    } else if (pageSize <= 0) {
        [parameters setObject:@(kKPPageSizeDefault) forKey:kKPRequestParameterPageSize];
    } else {
        [parameters setObject:@(kKPPageSizeMax) forKey:kKPRequestParameterPageSize];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kKPRequestPathVideos, objectId];
    
    [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject) {
            
            NSArray *data = responseObject[@"data"];
            __block NSMutableArray *videosArray = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dataDictionary, NSUInteger idx, BOOL *stop) {
                KPVideo *video = [KPVideo objectWithDictionary:dataDictionary];
                
                [videosArray addObject:video];
                
            }];
            
            success(task, videosArray);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}
- (void)getVideosByPlaylistId:(NSString *)objectId page:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getVideosByPlaylistId:objectId page:page pageSize:kKPPageSizeDefault success:success failure:failure];
}
- (void)getVideosByPlaylistId:(NSString *)objectId pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getVideosByPlaylistId:objectId page:kKPPageDefault pageSize:pageSize success:success failure:failure];
}
- (void)getVideosByPlaylistId:(NSString *)objectId success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getVideosByPlaylistId:objectId page:kKPPageDefault pageSize:kKPPageSizeDefault success:success failure:failure];
}

#pragma mark - Music Playlist

- (void)getMusicPlaylistsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (page > kKPPageDefault) {
        [parameters setObject:@(page) forKey:kKPRequestParameterPage];
    }
    
    if (pageSize > 0 && pageSize <= kKPPageSizeMax) {
        [parameters setObject:@(pageSize) forKey:kKPRequestParameterPageSize];
    } else if (pageSize <= 0) {
        [parameters setObject:@(kKPPageSizeDefault) forKey:kKPRequestParameterPageSize];
    } else {
        [parameters setObject:@(kKPPageSizeMax) forKey:kKPRequestParameterPageSize];
    }
    
    [self GET:kKPRequestPathMusics parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject) {
            
            NSArray *data = responseObject[@"data"];
            __block NSMutableArray *playlistsArray = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dataDictionary, NSUInteger idx, BOOL *stop) {
                KPMusicPlaylist *playlist = [KPMusicPlaylist objectWithDictionary:dataDictionary];
                
                [playlistsArray addObject:playlist];
                
            }];
            
            success(task, playlistsArray);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}
- (void)getMusicPlaylistsWithPage:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getMusicPlaylistsWithPage:page pageSize:kKPPageSizeDefault success:success failure:failure];
}
- (void)getMusicPlaylistsWithPageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getMusicPlaylistsWithPage:kKPPageDefault pageSize:pageSize success:success failure:failure];
}
- (void)getMusicPlaylistsWithSuccess:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getMusicPlaylistsWithPage:kKPPageDefault pageSize:kKPPageSizeDefault success:success failure:failure];
}

#pragma mark - Music List

- (void)getMusicsByPlaylistId:(NSString *)objectId page:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    
    if ( ! objectId) {
        @throw([NSException exceptionWithName:@"kKPRequestPlaylistIdNotSetException" reason:@"Playlist id should be set for this request." userInfo:nil]);
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (page > 0) {
        [parameters setObject:@(page) forKey:kKPRequestParameterPage];
    }
    
    if (pageSize > 0 && pageSize <= kKPPageSizeMax) {
        [parameters setObject:@(pageSize) forKey:kKPRequestParameterPageSize];
    } else if (pageSize <= 0) {
        [parameters setObject:@(kKPPageSizeDefault) forKey:kKPRequestParameterPageSize];
    } else {
        [parameters setObject:@(kKPPageSizeMax) forKey:kKPRequestParameterPageSize];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kKPRequestPathMusics, objectId];
    
    [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject) {
            
            NSArray *data = responseObject[@"data"];
            __block NSMutableArray *musicArray = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dataDictionary, NSUInteger idx, BOOL *stop) {
                KPMusic *music = [KPMusic objectWithDictionary:dataDictionary];
                
                [musicArray addObject:music];
                
            }];
            
            success(task, musicArray);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}
- (void)getMusicsByPlaylistId:(NSString *)objectId page:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getMusicsByPlaylistId:objectId page:page pageSize:kKPPageSizeDefault success:success failure:failure];
}
- (void)getMusicsByPlaylistId:(NSString *)objectId pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getMusicsByPlaylistId:objectId page:kKPPageDefault pageSize:pageSize success:success failure:failure];
}
- (void)getMusicsByPlaylistId:(NSString *)objectId success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure
{
    [self getMusicsByPlaylistId:objectId page:kKPPageDefault pageSize:kKPPageSizeDefault success:success failure:failure];
}

@end
