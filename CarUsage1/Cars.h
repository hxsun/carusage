//
//  Cars.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/13/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MaintenanceHistory, Models, UpdateHistory;

@interface Cars : NSManagedObject

@property (nonatomic, retain) NSDate * addedDate;
@property (nonatomic, retain) NSNumber * initialMilage;
@property (nonatomic, retain) NSDate * purchaseDate;
@property (nonatomic, retain) NSSet *hasMaintenanceHistories;
@property (nonatomic, retain) NSSet *hasUpdateHistories;
@property (nonatomic, retain) Models *whichModel;
@end

@interface Cars (CoreDataGeneratedAccessors)

- (void)addHasMaintenanceHistoriesObject:(MaintenanceHistory *)value;
- (void)removeHasMaintenanceHistoriesObject:(MaintenanceHistory *)value;
- (void)addHasMaintenanceHistories:(NSSet *)values;
- (void)removeHasMaintenanceHistories:(NSSet *)values;

- (void)addHasUpdateHistoriesObject:(UpdateHistory *)value;
- (void)removeHasUpdateHistoriesObject:(UpdateHistory *)value;
- (void)addHasUpdateHistories:(NSSet *)values;
- (void)removeHasUpdateHistories:(NSSet *)values;

@end
