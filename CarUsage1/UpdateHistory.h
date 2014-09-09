//
//  UpdateHistory.h
//  CarUsage1
//
//  Created by Kenneth on 9/8/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cars;

@interface UpdateHistory : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * mileage;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) Cars *updateTakenByCar;

@end
