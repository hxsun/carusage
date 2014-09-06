//
//  MaintenanceRule.h
//  CarUsage1
//
//  Created by Kenneth on 9/6/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdateHistory.h"

@interface MaintenanceRuleItem : NSObject

@property (nonatomic, assign) NSUInteger indexInOfficalTemplate; // for the initial item;
@property (nonatomic, assign) NSUInteger mileage;
@property (nonatomic, assign) NSUInteger month;
@property (nonatomic, assign, getter = isInitialItem) BOOL initialItem;
@property (nonatomic, strong) NSString *ruleItemString;
@property (nonatomic, assign) NSUInteger totalMileage; // of the noninitialItem;

- (instancetype)initWithRuleItemString:(NSString *)ruleItemString;

@end

@interface MaintenanceRule : NSObject

@property (nonatomic, strong, readonly) NSArray *terms; // of maintenaceItem
@property (nonatomic, strong) NSString *ruleString;

- (instancetype)initWithRuleString:(NSString *)ruleString;

- (MaintenanceRuleItem *)getNextMaintenanceItem:(NSUInteger)currentMileage;

- (NSDate *)getNextEstimatedDate:(NSUInteger)currentMileage lastUpdateHistory:(UpdateHistory *)updateHistory;

@end
