//
//  NSMutableArray+KSSorted.m
//  CarUsage1
//
//  Created by Kenneth on 9/4/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "NSMutableArray+KSSorted.h"

typedef NSComparisonResult (^NSComparator)(id obj1, id obj2);

@implementation NSMutableArray (KSSorted)

- (void)addObject:(id)anObject withComparator:(NSComparator)comparator {
    NSUInteger index = [self indexOfObject:anObject
                             inSortedRange:(NSRange){0, self.count}
                                   options:NSBinarySearchingInsertionIndex usingComparator:comparator];
    [self insertObject:anObject atIndex:index];

}

- (void)addObjectWithAscendingOrder:(id)anObject {
    NSComparator comparator = ^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    };
    
    [self addObject:anObject withComparator:comparator];
}

@end
