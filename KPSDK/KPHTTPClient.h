//
//  KPHTTPClient.h
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "AFNetworking.h"

@class KPCategory;
@class KPAlbum;
@class KPPlaylist;
@class KPMusicPlaylist;

typedef void (^KPHTTPClientSuccess)(NSURLSessionDataTask *task, id responseObject); //! @typedef KPHTTPClientSuccess the success callback
typedef void (^KPHTTPClientFailure)(NSURLSessionDataTask *task, NSError *error);    //! @typedef KPHTTPClientFailure the falure callback

@interface KPHTTPClient : AFHTTPSessionManager

#pragma mark - Client Lifecycle

/*! Use client as singleton */
+ (KPHTTPClient *)sharedClient;
/*! Access official api version */
+ (NSString *)apiVersion;

/*! Set the api key in order to send request
 @param apiKey send a string as apiKey
 */
- (void)setAPIKey:(NSString *)apiKey;
/*! Get current using api key */
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
- (void)getArticlesByCategory:(KPCategory *)category page:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getArticlesByCategory:(KPCategory *)category page:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getArticlesByCategory:(KPCategory *)category pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getArticlesByCategory:(KPCategory *)category success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;

#pragma mark - Album

/*!
 Get album list
 @param page as NSUInteger, default is 0.
 @param pageSize as NSUInteger, default is 100, max is 500, giving 0 to got default 100 records.
 @param success success callback, will return the operation and category array for response object if has any.
 @param failur failure callback, will return the operation and the error if has any.
 */
- (void)getAlbumsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getAlbumsWithPage:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getAlbumsWithPageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getAlbumsWithSuccess:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;

#pragma mark - Photo List

/*!
 Get photo list by album id
 
 @param objectId as NSString, the id of album.
 @param page as NSUInteger, default is 0.
 @param pageSize as NSUInteger, default is 100, max is 500, giving 0 to got default 100 records.
 @param success success callback, will return the operation and category array for response object if has any.
 @param failur failure callback, will return the operation and the error if has any.
 */
- (void)getPhotosByAlbum:(KPAlbum *)album page:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getPhotosByAlbum:(KPAlbum *)album page:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getPhotosByAlbum:(KPAlbum *)album pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getPhotosByAlbum:(KPAlbum *)album success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;

#pragma mark - Playlist

/*!
 Get playlist list
 @param page as NSUInteger, default is 0.
 @param pageSize as NSUInteger, default is 100, max is 500, giving 0 to got default 100 records.
 @param success success callback, will return the operation and category array for response object if has any.
 @param failur failure callback, will return the operation and the error if has any.
 */
- (void)getPlaylistsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getPlaylistsWithPage:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getPlaylistsWithPageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getPlaylistsWithSuccess:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;

#pragma mark - video List

/*!
 Get video list by playlist id
 
 @param objectId as NSString, the id of album.
 @param page as NSUInteger, default is 0.
 @param pageSize as NSUInteger, default is 100, max is 500, giving 0 to got default 100 records.
 @param success success callback, will return the operation and category array for response object if has any.
 @param failur failure callback, will return the operation and the error if has any.
 */
- (void)getVideosByPlaylist:(KPPlaylist *)playlist page:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getVideosByPlaylist:(KPPlaylist *)playlist page:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getVideosByPlaylist:(KPPlaylist *)playlist pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getVideosByPlaylist:(KPPlaylist *)playlist success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;

#pragma mark - Music Playlist

/*!
 Get music playlist list
 @param page as NSUInteger, default is 0.
 @param pageSize as NSUInteger, default is 100, max is 500, giving 0 to got default 100 records.
 @param success success callback, will return the operation and category array for response object if has any.
 @param failur failure callback, will return the operation and the error if has any.
 */
- (void)getMusicPlaylistsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getMusicPlaylistsWithPage:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getMusicPlaylistsWithPageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getMusicPlaylistsWithSuccess:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;

#pragma mark - Music List

/*!
 Get music list by playlist id
 
 @param objectId as NSString, the id of music playlist.
 @param page as NSUInteger, default is 0.
 @param pageSize as NSUInteger, default is 100, max is 500, giving 0 to got default 100 records.
 @param success success callback, will return the operation and category array for response object if has any.
 @param failur failure callback, will return the operation and the error if has any.
 */
- (void)getMusicsByPlaylist:(KPPlaylist *)playlist page:(NSInteger)page pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getMusicsByPlaylist:(KPPlaylist *)playlist page:(NSInteger)page success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getMusicsByPlaylist:(KPPlaylist *)playlist pageSize:(NSInteger)pageSize success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;
- (void)getMusicsByPlaylist:(KPPlaylist *)playlist success:(KPHTTPClientSuccess)success failure:(KPHTTPClientFailure)failure;

@end
