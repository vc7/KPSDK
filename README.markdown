:warning: The source api has been closed ([announcement](https://www.facebook.com/groups/unlimited.kptaipei.tw/permalink/416276855205003/)), this KLSDK is no longer uasable.

# KPSDK

This is the SDK for the "柯文哲 野生官網 Unlimited" api ([http://unlimited.kptaipei.tw/](http://unlimited.kptaipei.tw/)), the right of the data is belongs to the orgnization. 

**Attention** This is just the data portal for now, if you want to access the music hosted by SoundCould, please refer to their [Developer Page](https://developers.soundcloud.com/), we may deal this to easy access in the future.

## Rock N Roll

### Install

The best way to using this SDK is install via CocoaPods:

``` ruby
platform :ios, '7.0'

pod 'KPSDK', :git => 'git@github.com:vc7/KPSDK.git'
```

### Import and Registering API Key

After do the `pod install`, you can add to access full functionalities.

``` objc
#import "KPSDK.h"
```

### Registering Your API Key

``` objc
[KPSDK setAPIKey:@"<#YOUR_API_KEY#>"];
```

### The Request Client

``` objc
KPHTTPClient *client = [KPHTTPClient sharedClient];
```

Using this singleton object to send request.

Let's it, and have fun!!

## Docs

The main interface is `KPHTTPClient`, all the methods are block-base, this SDK has help you wrap the response JSON into related object array and pass back.

### Models

All the data models are `KPObject`, including:

- `KPCategory`
- `KPArticle`
- `KPAlbum`
- `KPPhoto`
- `KPPlaylist`
- `KPVideo`
- `KPMusicPlaylist`
- `KPMusic`

And a video thumbnail class to maintain its image data.

- `KPVideoThumbnail`

### Category

Get Category list.

- `- getCategoriesWithSuccess:failure:`

### Article

Giving `KPCategory` object to request its articles, you have options to specify page, pageSize or not.

- `- getArticlesByCategory:page:pageSize:success:failure:`
- `- getArticlesByCategory:page:success:failure:`
- `- getArticlesByCategory:pageSize:success:failure:`
- `- getArticlesByCategory:success:failure:`

### Album

Get Album list.

- `- getAlbumsWithPage:pageSize:success:failure:`
- `- getAlbumsWithPage:success:failure:`
- `- getAlbumsWithPageSize:success:failure:`
- `- getAlbumsWithSuccess:failure:`

### Photo List

Get Photo list by given Album.

- `- getPhotosByAlbum:page:pageSize:success:failure:`
- `- getPhotosByAlbum:page:success:failure:`
- `- getPhotosByAlbum:pageSize:success:failure:`
- `- getPhotosByAlbum:success:failure:`

### Playlist

Get Video Playlist list.

- `- getPlaylistsWithPage:pageSize:success:failure:`
- `- getPlaylistsWithPage:success:failure:`
- `- getPlaylistsWithPageSize:success:failure:`
- `- getPlaylistsWithSuccess:failure:`

### Video List

Get Video List by given Playlist.

- `- getVideosByPlaylist:page:pageSize:success:failure:`
- `- getVideosByPlaylist:page:success:failure:`
- `- getVideosByPlaylist:pageSize:success:failure:`
- `- getVideosByPlaylist:success:failure:`

### Music Playlist

Get Music Playlist list.

- `- getMusicPlaylistsWithPage:pageSize:success:failure:`
- `- getMusicPlaylistsWithPage:success:failure:`
- `- getMusicPlaylistsWithPageSize:success:failure:`
- `- getMusicPlaylistsWithSuccess:failure:`

### Music List

Get Music by given Playlist.

- `- getMusicsByPlaylist:page:pageSize:success:failure:`
- `- getMusicsByPlaylist:page:success:failure:`
- `- getMusicsByPlaylist:pageSize:success:failure:`
- `- getMusicsByPlaylist:success:failure:`

## LICENSE

Please go to the LICENSE file for more.
