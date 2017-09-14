//
//  Functions.h
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define DEFAULT_WIDTH 375

#define GAMECENTER_LEADERBOARD_IDENTIFIER (@"CirclesMatched")
#define MAX_NUMBER_OF_LETTERS (9)

#define NUMBER_OF_FONTS (6)
#define MAX_BORDER_WIDTH (7)

@interface Functions : NSObject

typedef enum AppState {
    Menu = 0,
    Game,
    GameOver,
    Settings,
    GamecenterLeaderboard
} AppState;

+ (CGFloat) fontSize:(CGFloat)fontSize;
+ (int)randomNumberBetween:(int)min maxNumber:(int)max;
+ (UIColor*)randomColor;

@end
