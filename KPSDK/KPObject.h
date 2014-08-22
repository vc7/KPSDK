//
//  KPObject.h
//  This is the root model object.
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPObject : NSObject

#pragma mark - Properties

/*!
 The class name of the object.
 */
@property (readonly) NSString *kpClassName;

/*!
 The id of the object.
 */
@property (nonatomic, strong) NSString *objectId;

@end
