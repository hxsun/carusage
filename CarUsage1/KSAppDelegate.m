//
//  KSAppDelegate.m
//  CarUsage1
//
//  Created by Kenneth on 8/27/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "KSAppDelegate.h"
// #import "KSAppDelegate+MOC.h"
#import "Cars.h"
#import "CarUsageDatabaseAvailability.h"

@interface KSAppDelegate ()

@end

@implementation KSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup CoreData Stack with MagicalRecord.
    [self setupCoreDataStackWithMagicalRecord];
    
    // self.carusageDatabaseContext = [NSManagedObjectContext defaultContext];
    // self.carusageDatabaseContext = [self createMainQueueManagedObjectContext];
    // Override point for customization after application launch.
    return YES;
}

- (void)setupCoreDataStackWithMagicalRecord {

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CarUsage.sqlite"];
    
    // Check whether the normal database exists and if not we copy the data from the preloaded on the normal one.
    // Otherwise, do nothing.
    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
        NSURL *preloadURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CarUsage"
                                                                                   ofType:@"sqlite"]];
        NSLog(@"PreloadURL: %@", preloadURL);
        
        NSError *loadError = nil;
        if (![[NSFileManager defaultManager] copyItemAtURL:preloadURL toURL:storeURL error:&loadError]) {
            NSLog(@"Oops, could not copy preloaded data.");
        }
    }
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"CarUsage.sqlite"];
}

// Returns the URL to the application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
