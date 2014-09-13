//
//  Components.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/14/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComponentEntry;

@interface Components : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * compDescription;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *instances;
@end

@interface Components (CoreDataGeneratedAccessors)

- (void)addInstancesObject:(ComponentEntry *)value;
- (void)removeInstancesObject:(ComponentEntry *)value;
- (void)addInstances:(NSSet *)values;
- (void)removeInstances:(NSSet *)values;

@end
