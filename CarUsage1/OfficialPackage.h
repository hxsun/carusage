//
//  OfficialPackage.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/13/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComponentEntry, Models;

@interface OfficialPackage : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * officialSchedule;
@property (nonatomic, retain) NSOrderedSet *containsComponents;
@property (nonatomic, retain) Models *belongsToModel;
@end

@interface OfficialPackage (CoreDataGeneratedAccessors)

- (void)insertObject:(ComponentEntry *)value inContainsComponentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromContainsComponentsAtIndex:(NSUInteger)idx;
- (void)insertContainsComponents:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeContainsComponentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInContainsComponentsAtIndex:(NSUInteger)idx withObject:(ComponentEntry *)value;
- (void)replaceContainsComponentsAtIndexes:(NSIndexSet *)indexes withContainsComponents:(NSArray *)values;
- (void)addContainsComponentsObject:(ComponentEntry *)value;
- (void)removeContainsComponentsObject:(ComponentEntry *)value;
- (void)addContainsComponents:(NSOrderedSet *)values;
- (void)removeContainsComponents:(NSOrderedSet *)values;
@end
