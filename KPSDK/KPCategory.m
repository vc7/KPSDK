//
//  KPCategory.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "KPCategory.h"

@implementation KPCategory

+ (NSString *)kpClassName
{
    return @"Category";
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary
{
    if ( ! dictionary) {
        return nil;
    }
    
    KPCategory *category = [KPCategory new];
    
    category.objectId = dictionary[@"id"];
    category.name = dictionary[@"name"];
    
    return category;
}

@end
