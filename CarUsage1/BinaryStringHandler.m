//
//  BinaryStringHandler.m
//  CarUsage1
//
//  Created by Kenneth on 9/5/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "BinaryStringHandler.h"

@implementation BinaryStringHandler

- (int) binaryStringToInt: (NSString *) binaryString {
    unichar aChar;
    int value = 0;
    int index;
    for (index = 0; index < [binaryString length]; index ++) {
        aChar = [binaryString characterAtIndex:index];
        if (aChar == '1') {
            value += 1;
        }
        if (index+1 < [binaryString length]) {
            value = value << 1;
        }
    }
    
    return value;
}

@end
