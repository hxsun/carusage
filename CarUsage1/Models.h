//
//  Models.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/14/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cars, OfficialPackage, Series;

@interface Models : NSManagedObject

@property (nonatomic, retain) NSString * carStructure;
@property (nonatomic, retain) NSString * driveType;
@property (nonatomic, retain) NSString * engine;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * onsale;
@property (nonatomic, retain) NSDate * publishedYear;
@property (nonatomic, retain) NSString * transmissionType;
@property (nonatomic, retain) NSString * warranty;
@property (nonatomic, retain) OfficialPackage *hasPackage;
@property (nonatomic, retain) Series *series;
@property (nonatomic, retain) Cars *typeOfCar;

@end
