//
//  ComponentEntry.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/13/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Components.h"


@interface ComponentEntry : Components

@property (nonatomic, retain) NSString * compMake;
@property (nonatomic, retain) NSString * compModel;
@property (nonatomic, retain) NSManagedObject *belongsTo;

@end
