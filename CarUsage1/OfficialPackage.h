//
//  OfficialPackage.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/14/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Models, PackageComponentEntry;

@interface OfficialPackage : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * officialSchedule;
@property (nonatomic, retain) NSSet *belongsToModels;
@property (nonatomic, retain) NSSet *containsComponents;
@end

@interface OfficialPackage (CoreDataGeneratedAccessors)

- (void)addBelongsToModelsObject:(Models *)value;
- (void)removeBelongsToModelsObject:(Models *)value;
- (void)addBelongsToModels:(NSSet *)values;
- (void)removeBelongsToModels:(NSSet *)values;

- (void)addContainsComponentsObject:(PackageComponentEntry *)value;
- (void)removeContainsComponentsObject:(PackageComponentEntry *)value;
- (void)addContainsComponents:(NSSet *)values;
- (void)removeContainsComponents:(NSSet *)values;

@end
