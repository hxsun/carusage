//
//  BinaryStringHandlerTestCase.m
//  CarUsage1
//
//  Created by Kenneth on 9/5/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BinaryStringHandler.h"

@interface BinaryStringHandlerTestCase : XCTestCase

@end

@implementation BinaryStringHandlerTestCase

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

- (void)testBinaryStringToIntWithBinaryString {
    BinaryStringHandler *handler = [BinaryStringHandler new];
    
    XCTAssertEqual([handler binaryStringToInt:@"10000"], 16, @"Should match");
}

@end
