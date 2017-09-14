//
//  Functions.m
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "Functions.h"

@implementation Functions

+(CGFloat) fontSize:(CGFloat)fontSize{
    return fontSize*(UIScreen.mainScreen.bounds.size.width/DEFAULT_WIDTH);
}

+(int)randomNumberBetween:(int)min maxNumber:(int)max {
    return arc4random_uniform(max - min + 1) + min;
}

+(UIColor*)randomColor {
    CGFloat r = (CGFloat)[self randomNumberBetween:70 maxNumber:250];
    CGFloat g = (CGFloat)[self randomNumberBetween:70 maxNumber:250];
    CGFloat b = (CGFloat)[self randomNumberBetween:70 maxNumber:250];
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}
@end
