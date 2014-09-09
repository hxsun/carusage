//
//  Series.h
//  CarUsage1
//
//  Created by Kenneth on 9/8/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brands, Models;

@interface Series : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * rank;
@property (nonatomic, retain) Brands *brand;
@property (nonatomic, retain) NSSet *models;
@end

@interface Series (CoreDataGeneratedAccessors)

- (void)addModelsObject:(Models *)value;
- (void)removeModelsObject:(Models *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
