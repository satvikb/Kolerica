//
//  Settings.m
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "Storage.h"
#import "Lockbox.h"

@implementation Storage

static NSString* const fontId = @"font";
static NSString* const borderId = @"border";
static NSString* const tutorialId = @"tutorial";
static NSString* const adsId = @"ads";
static NSString* const currentGames = @"currentGames";
static NSString* const showScoreInMainCircle = @"scoreInMainCircle";

+(bool)saveHighScore:(int)score{
    int currentHighScore = [self getSavedHighScore];
    if(currentHighScore < score){
        NSNumber* s = [NSNumber numberWithInt:score];
        [Lockbox archiveObject:s forKey:@"highscore"];
        return true;
    }
    return false;
}

+(int)getSavedHighScore {
    NSNumber* currentHighScore = [Lockbox unarchiveObjectForKey:@"highscore"];
    if(currentHighScore == nil){
        return 0;
    }
    return currentHighScore.intValue;
}

+(int)getCurrentFont {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
  
    return (int)[defaults integerForKey:fontId];
}

+(void)setCurrentFont:(int)font{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:font forKey:fontId];
}

+(int)getCurrentBorderWidth {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    return (int)[defaults integerForKey:borderId];
}

+(void)setBorderWidth:(int)width{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:width > 7 ? 7 : width < 0 ? 0 : width forKey:borderId];
}

+(bool)getDidCompleteTutorial {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults boolForKey:tutorialId];
}

+(void)setDidCompleteTutorial{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:true forKey:tutorialId];
}

+(void)setDidNotCompleteTutorial{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:false forKey:tutorialId];
}

+(bool)getShowScoreInMainCircle {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults boolForKey:showScoreInMainCircle];
}

+(void)setShouldShowScoreInMainCircle:(bool)shouldShow{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:shouldShow forKey:showScoreInMainCircle];
}

+(bool)setAdsState:(int)state{
    NSNumber* s = [NSNumber numberWithInt:state];
    [Lockbox archiveObject:s forKey:adsId];
    return true;
}

+(int)getAdsState {
    NSNumber* currentAdState = [Lockbox unarchiveObjectForKey:adsId];
    if(currentAdState == nil){
        return 0;
    }
    return currentAdState.intValue;
}

+(bool)addToGamesPlayed{
    NSNumber* s = [NSNumber numberWithInt:([self getCurrentGamesPlayed]+1)];
    [Lockbox archiveObject:s forKey:currentGames];
    return true;
}

+(int)getCurrentGamesPlayed {
    NSNumber* currentGamesPlayed = [Lockbox unarchiveObjectForKey:currentGames];
    if(currentGamesPlayed == nil){
        return 0;
    }
    return currentGamesPlayed.intValue;
}

+(NSString*)getFontNameFromNumber:(int)number{
    switch (number) {
        case 0:
            return @"Avenir";
        case 1:
            return @"Helvetica";
        case 2:
            return @"Pixel_3";
        case 3:
            return @"Didot";
        case 4:
            return @"GillSans";
        case 5:
            return @"AmericanTypewriter";
        default:
            return @"Helvetica";
            break;
    }
}

@end
