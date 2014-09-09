//
//  MaintenanceHistory.h
//  CarUsage1
//
//  Created by Kenneth on 9/8/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UpdateHistory.h"

@class Cars, Components;

@interface MaintenanceHistory : UpdateHistory

@property (nonatomic, retain) NSData * location;
@property (nonatomic, retain) NSSet *hasUpdated;
@property (nonatomic, retain) Cars *maintenanceTakenByCar;
@end

@interface MaintenanceHistory (CoreDataGeneratedAccessors)

- (void)addHasUpdatedObject:(Components *)value;
- (void)removeHasUpdatedObject:(Components *)value;
- (void)addHasUpdated:(NSSet *)values;
- (void)removeHasUpdated:(NSSet *)values;

@end
