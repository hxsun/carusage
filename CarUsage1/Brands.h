//
//  Brands.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/13/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brands, Series;

@interface Brands : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * isSubbrand;
@property (nonatomic, retain) NSData * logo;
@property (nonatomic, retain) NSString * logoURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * origName;
@property (nonatomic, retain) NSString * pinyinName;
@property (nonatomic, retain) NSSet *childBrands;
@property (nonatomic, retain) Brands *parentBrand;
@property (nonatomic, retain) NSSet *series;
@end

@interface Brands (CoreDataGeneratedAccessors)

- (void)addChildBrandsObject:(Brands *)value;
- (void)removeChildBrandsObject:(Brands *)value;
- (void)addChildBrands:(NSSet *)values;
- (void)removeChildBrands:(NSSet *)values;

- (void)addSeriesObject:(Series *)value;
- (void)removeSeriesObject:(Series *)value;
- (void)addSeries:(NSSet *)values;
- (void)removeSeries:(NSSet *)values;

@end
