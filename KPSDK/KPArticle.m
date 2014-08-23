//
//  KPArticle.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "KPArticle.h"
#import "KPCategory.h"

@interface KPArticle ()

@property (nonatomic, strong, readwrite) NSString *originURL;

@end

@implementation KPArticle

@synthesize objectId;

+ (NSString *)kpClassName
{
    return @"Article";
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary
{
    if ( ! dictionary) {
        return nil;
    }
    
    KPArticle *article = [KPArticle new];
    KPCategory *category = [KPCategory new];
    
    category.objectId = dictionary[@"category_id"];
    category.name = dictionary[@"category_name"];
    
    article.category = category;
    article.objectId = dictionary[@"id"];
    article.title = dictionary[@"title"];
    article.author = dictionary[@"author"];
    article.content = dictionary[@"content"];
    article.plainContent = dictionary[@"plain_content"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssSSS'Z'"];
    
    article.createdAt = [dateFormatter dateFromString:dictionary[@"post_date"]];
    article.updatedAt = [dateFormatter dateFromString:dictionary[@"last_modify"]];
    
    return article;
}

#pragma mark - Accessor

- (void)setObjectId:(NSString *)objectId
{
    [super setObjectId:objectId];
    self.originURL = [NSString stringWithFormat:@"http://kptaipei.tw/?page_id=%@", objectId];
}

@end
