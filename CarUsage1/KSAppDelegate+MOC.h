//
//  KSAppDelegate+MOC.h
//  CarUsage1
//
//  Created by Kenneth on 8/27/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "KSAppDelegate.h"

@interface KSAppDelegate (MOC)

- (NSManagedObjectContext *)createMainQueueManagedObjectContext;

@end
