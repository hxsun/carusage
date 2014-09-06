//
//  MaintenanceRule.m
//  CarUsage1
//
//  Created by Kenneth on 9/6/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "MaintenanceRule.h"

@implementation MaintenanceRuleItem

NSString *const RULE_ITEM_STRING_SEPARATOR = @":";
NSString *const MULTIPLE_ITEM_INDICATOR = @"*";
NSUInteger const NUMBER_OF_TOKENS = 2;

@synthesize ruleItemString = _ruleItemString;

- (instancetype)initWithRuleItemString:(NSString *)ruleItemString {
    self = [super init];
    if (self) {
        self.ruleItemString = ruleItemString;
    }

    return self;
}

- (void)setRuleItemString:(NSString *)ruleItemString {
    _ruleItemString = ruleItemString;
    NSArray *tokenStringArray = [_ruleItemString componentsSeparatedByString:RULE_ITEM_STRING_SEPARATOR];
    if (NUMBER_OF_TOKENS != [tokenStringArray count]) {
        DLog(@"Parsing rule item string failed. %@", ruleItemString);
        _ruleItemString = nil;
        return;
    }
    
    NSString *mileageString = tokenStringArray[0];
    NSString *monthString = tokenStringArray[1];
    
    if ([[mileageString substringToIndex:[MULTIPLE_ITEM_INDICATOR length]] isEqualToString:MULTIPLE_ITEM_INDICATOR]) {
        self.mileage = [[mileageString substringFromIndex:[MULTIPLE_ITEM_INDICATOR length]] integerValue];
        self.initialItem = FALSE;
    } else {
        self.mileage = [mileageString integerValue];
        self.initialItem = TRUE;
        self.totalMileage = [mileageString integerValue];
    }
    
    self.month = [monthString integerValue];
}


@end

@interface MaintenanceRule ()

@property (nonatomic, strong) NSMutableArray *itemsArray;

@end

@implementation MaintenanceRule

@synthesize itemsArray;
@synthesize ruleString = _ruleString;

NSString *const RULE_STRING_SEPARATOR = @"-";

- (instancetype)initWithRuleString:(NSString *)ruleString {
    self = [super init];
    if (self) {
        self.ruleString = ruleString;
    }
    return self;
}

- (void)setRuleString:(NSString *)ruleString {
    if (!itemsArray) {
        itemsArray = [NSMutableArray new];
    }
    _ruleString = ruleString;
    [self parseRule:ruleString];
}

- (void)parseRule:(NSString *)ruleString {
    NSArray *itemStringArray = [ruleString componentsSeparatedByString:RULE_STRING_SEPARATOR];
    [itemStringArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MaintenanceRuleItem *ruleItem = [[MaintenanceRuleItem alloc] initWithRuleItemString:obj];
        ruleItem.indexInOfficalTemplate = idx;
        // ruleItem.multiple = 1;
        [itemsArray insertObject:ruleItem atIndex:idx];
    }];
}

- (NSArray *)terms {
    return itemsArray;
}

- (MaintenanceRuleItem *)getNextMaintenanceItem:(NSUInteger)currentMileage {
    
    __block MaintenanceRuleItem *tempItem = nil;
    [itemsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MaintenanceRuleItem *ruleItem = (MaintenanceRuleItem *)obj;
        if (ruleItem.totalMileage) {
            if (ruleItem.totalMileage > currentMileage) {
                tempItem = obj;
                *stop = YES;
            }
        } else {
            for (int i = 1; ; i++) {
                NSUInteger totalMileage = i * ruleItem.mileage + ((MaintenanceRuleItem *)itemsArray[idx - 1]).totalMileage;
                if (totalMileage > currentMileage) {
                    tempItem = obj;
                    tempItem.totalMileage = totalMileage;
                    break;
                }
            }
        }
        
    }];
    return tempItem;
}

- (NSDate *)getNextEstimatedDate:(NSUInteger)currentMileage lastUpdateHistory:(UpdateHistory *)updateHistory {
    return [NSDate date];
}


@end
