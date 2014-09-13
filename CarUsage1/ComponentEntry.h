//
//  ComponentEntry.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/14/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Components, MaintenanceHistory;

@interface ComponentEntry : NSManagedObject

@property (nonatomic, retain) NSString * compMake;
@property (nonatomic, retain) NSString * compModel;
@property (nonatomic, retain) NSNumber * suggestedPrice;
@property (nonatomic, retain) Components *compType;
@property (nonatomic, retain) MaintenanceHistory *replacedAt;

@end
