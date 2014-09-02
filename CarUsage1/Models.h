//
//  Models.h
//  CarUsage1
//
//  Created by Kenneth on 9/1/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cars, Series;

@interface Models : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Cars *typeOfCar;
@property (nonatomic, retain) Series *series;

@end
