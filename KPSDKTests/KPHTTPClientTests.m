//
//  KPHTTPClientTests.m
//  KPSDK
//
//  Created by vincent on 2014/08/23.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+AsyncTesting.h"
#import "KPSDK.h"

@interface KPHTTPClientTests : XCTestCase

@end

@implementation KPHTTPClientTests

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

#pragma mark - Lifecycle

- (void)testSharedClientIsInitiated
{
    XCTAssertNotNil([KPHTTPClient sharedClient]);
}

- (void)testIsSharedClients
{
    KPHTTPClient *client1 = [KPHTTPClient sharedClient];
    KPHTTPClient *client2 = [KPHTTPClient sharedClient];
    
    XCTAssertEqualObjects(client1, client2);
}


#pragma mark - Category

- (void)testGetCategoryRequest
{
    KPHTTPClient *client = [KPHTTPClient sharedClient];
    
    __block NSDictionary *result;
    
    [client getCategoriesWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        result = responseObject;
        [self XCA_notify:XCTAsyncTestCaseStatusSucceeded];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (error) {
            [self XCA_notify:XCTAsyncTestCaseStatusFailed];
        }
        
    }];
    
    [self XCA_waitForTimeout:10];
    
    XCTAssertNotNil(result, @"Result was nil");
}

@end
