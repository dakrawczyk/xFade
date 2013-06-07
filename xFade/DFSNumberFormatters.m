//
//  DFSNumberFormatters.m
//  xFade
//
//  Created by Dave Krawczyk on 6/7/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import "DFSNumberFormatters.h"

@implementation DFSNumberFormatters

-(id) init {
    self=[super init];
    return self;
}

+(id) defaultFormatters
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}


-(NSNumberFormatter *)numberFormatNoDecimals:(NSUInteger)decimals {
    if (!self.numberFormatDecimals) {
        self.numberFormatDecimals=[[NSNumberFormatter alloc] init];
        [self.numberFormatDecimals setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [self.numberFormatDecimals setMaximumFractionDigits:0];
    }
    
    [self.numberFormatDecimals setMaximumFractionDigits:decimals];
    return self.numberFormatDecimals;
}


-(NSNumberFormatter *)numberFormatPercentageWithDecimals:(NSUInteger)decimals {
    if (!self.numberFormatPercentDecimals) {
        self.numberFormatPercentDecimals=[[NSNumberFormatter alloc] init];
        [self.numberFormatPercentDecimals setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [self.numberFormatPercentDecimals setNumberStyle:NSNumberFormatterPercentStyle];
        [self.numberFormatPercentDecimals setMaximumFractionDigits:0];
    }
    
    [self.numberFormatPercentDecimals setMaximumFractionDigits:decimals];
    return self.numberFormatPercentDecimals;
}


@end
