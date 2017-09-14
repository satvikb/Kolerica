//
//  Settings.h
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Storage : UIView

+(bool)saveHighScore:(int)score;
+(int)getSavedHighScore;
    
+(int)getCurrentFont;
+(void)setCurrentFont:(int)font;

+(int)getCurrentBorderWidth;
+(void)setBorderWidth:(int)width;

+(bool)getDidCompleteTutorial;
+(void)setDidCompleteTutorial;
+(void)setDidNotCompleteTutorial;

+(bool)setAdsState:(int)state;
+(int)getAdsState;

+(bool)addToGamesPlayed;
+(int)getCurrentGamesPlayed;

+(bool)getShowScoreInMainCircle;
+(void)setShouldShowScoreInMainCircle:(bool)shouldShow;

+(NSString*)getFontNameFromNumber:(int)number;

@end
