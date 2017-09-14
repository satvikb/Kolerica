//
//  SettingsView.h
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "Storage.h"

@protocol SettingsViewDelegate;

@interface SettingsView : UIView <UITextViewDelegate>

@property (nonatomic, strong) id<SettingsViewDelegate> delegate;

@end

@protocol SettingsViewDelegate <NSObject>
-(void)switchAllFontsTo:(NSString*)fontName;
-(void)switchAllBorderWidthTo:(int)borderWidth;
-(void)switchAllBorderColorTo:(UIColor*)borderColor;
-(void)switchFrom:(AppState)currentState to:(AppState)newState;
-(void)initAds;
-(void)removeAds;
@end
