//
//  CarInfoForm.h
//  CarUsage1
//
//  Created by Kenneth on 9/4/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInfoForm : NSObject

@property (nonatomic, strong) NSString *carStructure;
@property (nonatomic, strong) NSString *engine;
@property (nonatomic, strong) NSString *driveType;

@property (nonatomic, strong) NSString *transmissionType;
@property (nonatomic, strong) NSString *warranty;

@property (nonatomic, assign) BOOL allMonth;
@property (nonatomic, strong) NSDate *dateOfPurchase;
@property (nonatomic, assign) NSUInteger mileage;

@property (nonatomic, assign) BOOL loadInitialPackage;


@end
