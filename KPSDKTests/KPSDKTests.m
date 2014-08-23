//
//  KPSDKTests.m
//  KPSDKTests
//
//  Created by vincent on 2014/08/22.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KPSDK.h"

@interface KPSDKTests : XCTestCase

@end

@implementation KPSDKTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithAPIKey
{
    [KPSDK setAPIKey:@"testAPIKey"];
    
    XCTAssertEqualObjects([KPSDK getAPIKey], @"testAPIKey");
}

@end
