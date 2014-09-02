//
//  ModelStepsNavController.h
//  CarUsage1
//
//  Created by Kenneth on 8/29/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "RMStepsController.h"
#import <CoreData/CoreData.h>

@interface ModelStepsNavController : RMStepsController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
