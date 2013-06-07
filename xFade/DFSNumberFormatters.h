//
//  DFSNumberFormatters.h
//  xFade
//
//  Created by Dave Krawczyk on 6/7/13.
//  Copyright (c) 2013 deck5 Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFSNumberFormatters : NSObject

@property (nonatomic, retain) NSNumberFormatter *numberFormatPercentDecimals;
@property (nonatomic, retain) NSNumberFormatter *numberFormatDecimals;

-(NSNumberFormatter *)numberFormatPercentageWithDecimals:(NSUInteger)decimals;
-(NSNumberFormatter *)numberFormatNoDecimals:(NSUInteger)decimals;

+(id) defaultFormatters;

@end
