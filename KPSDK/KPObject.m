//
//  KPObject.m
//  This is the root model object.
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "KPObject.h"

@interface KPObject ()

@property (readwrite) NSString *kpClassName;

@end

@implementation KPObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.objectId = nil;
    }
    return self;
}

+ (NSString *)kpClassName
{
    return @"Object";
}

+ (id)objectWithDictionary:(NSDictionary *)dictionary
{
    if ( ! dictionary) {
        return nil;
    }
    
    KPObject *object = [KPObject new];
    
    return object;
}

@end
