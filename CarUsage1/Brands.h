//
//  Brands.h
//  CarUsage1
//
//  Created by Kenneth on 9/1/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brands, Series;

@interface Brands : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSData * logo;
@property (nonatomic, retain) NSString * logoURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * origName;
@property (nonatomic, retain) NSString * pinyinName;
@property (nonatomic, retain) NSNumber * isSubbrand;
@property (nonatomic, retain) NSSet *series;
@property (nonatomic, retain) NSSet *childBrands;
@property (nonatomic, retain) Brands *parentBrand;
@end

@interface Brands (CoreDataGeneratedAccessors)

- (void)addSeriesObject:(Series *)value;
- (void)removeSeriesObject:(Series *)value;
- (void)addSeries:(NSSet *)values;
- (void)removeSeries:(NSSet *)values;

- (void)addChildBrandsObject:(Brands *)value;
- (void)removeChildBrandsObject:(Brands *)value;
- (void)addChildBrands:(NSSet *)values;
- (void)removeChildBrands:(NSSet *)values;

@end
