//
//  MaintenanceHistory.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/14/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UpdateHistory.h"

@class Cars, ComponentEntry;

@interface MaintenanceHistory : UpdateHistory

@property (nonatomic, retain) NSData * location;
@property (nonatomic, retain) NSSet *replaceComponents;
@property (nonatomic, retain) Cars *maintenanceTakenByCar;
@end

@interface MaintenanceHistory (CoreDataGeneratedAccessors)

- (void)addReplaceComponentsObject:(ComponentEntry *)value;
- (void)removeReplaceComponentsObject:(ComponentEntry *)value;
- (void)addReplaceComponents:(NSSet *)values;
- (void)removeReplaceComponents:(NSSet *)values;

@end
