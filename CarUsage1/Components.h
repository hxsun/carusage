//
//  Components.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/13/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MaintenanceHistory;

@interface Components : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * compDescription;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) MaintenanceHistory *replacedAt;

@end
