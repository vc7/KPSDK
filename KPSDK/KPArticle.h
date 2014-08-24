//
//  KPArticle.h
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "KPObject.h"

@class KPCategory;

@interface KPArticle : KPObject

@property (nonatomic, strong) KPCategory *category;

// original format is UTC: "2014-08-19T01:40:22.000Z"
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *plainContent;
@property (nonatomic, strong, readonly) NSString *originURL;

@end
