//
//  GarageTableViewController.h
//  CarUsage1
//
//  Created by Kenneth on 8/27/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataTableViewController.h"

@interface GarageTableViewController : CoreDataTableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
