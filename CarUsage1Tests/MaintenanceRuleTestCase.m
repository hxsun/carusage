//
//  MaintenanceRuleTestCase.m
//  CarUsage1
//
//  Created by Kenneth on 9/6/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MaintenanceRule.h"

@interface MaintenanceRuleTestCase : XCTestCase

@end

@implementation MaintenanceRuleTestCase

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

- (void)testInitWithRuleItemString
{
    MaintenanceRuleItem *ruleItem = [[MaintenanceRuleItem alloc] initWithRuleItemString:@"7500:6"];
    
    XCTAssertEqual(ruleItem.mileage, 7500, @"mileage should match.");
    XCTAssertEqual(ruleItem.month, 6, @"month should match.");
    XCTAssertEqual(ruleItem.isInitialItem, YES, @"initialItem should match.");
    XCTAssertEqual(ruleItem.ruleItemString, @"7500:6", @"ruleItemString should match.");
}

- (void)testInitWithRuleString {

    MaintenanceRule *rule = [[MaintenanceRule alloc] initWithRuleString:@"7500:6-15000:12-*10000:12"];
    
    XCTAssertEqual([rule.terms count], 3, @"The number of items should match.");
    
    MaintenanceRuleItem *ruleItem1 = [rule getNextMaintenanceItem:94000];
    XCTAssertEqual(ruleItem1.totalMileage, 95000, @"Nex mileage should match.");
    XCTAssertEqual(ruleItem1.isInitialItem, NO, @"Should not be the initial item.");
    
    MaintenanceRuleItem *ruleItem2 = [rule getNextMaintenanceItem:9000];
    XCTAssertEqual(ruleItem2.totalMileage, 15000, @"Next mileage should match.");
    XCTAssertEqual(ruleItem2.isInitialItem, YES, @"Should be the initial item.");
}

@end
