//
//  PackageComponentEntry.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/13/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ComponentEntry.h"

@class OfficialPackage;

@interface PackageComponentEntry : ComponentEntry

@property (nonatomic, retain) NSNumber * officialSchedule;
@property (nonatomic, retain) OfficialPackage *belongsToPackage;

@end
