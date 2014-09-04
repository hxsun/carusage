//
//  NSMutableArray+KSSorted.h
//  CarUsage1
//
//  Created by Kenneth on 9/4/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (KSSorted)

- (void)addObject:(id)anObject withComparator:(NSComparator)comparator;

- (void)addObjectWithAscendingOrder:(id)anObject;

@end
