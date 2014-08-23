//
//  KPObjectTests.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KPObject.h"

@interface KPObjectTests : XCTestCase

@property (nonatomic, strong) KPObject *testObject;

@end

@implementation KPObjectTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.testObject = [[KPObject alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectIsInitiated
{
    XCTAssertNotNil(self.testObject);
}

- (void)testDefaultValues
{
    XCTAssertNil(self.testObject.objectId);
    XCTAssertEqualObjects(self.testObject.kpClassName, @"Object");
}

@end
