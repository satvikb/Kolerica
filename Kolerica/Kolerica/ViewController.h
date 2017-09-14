//
//  ViewController.h
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

#import "Functions.h"

#import "MenuView.h"
#import "GameView.h"
#import "GameOverView.h"
#import "SettingsView.h"
#import "GameCenterLeaderboardView.h"

@interface ViewController : UIViewController <MenuViewDelegate, GameViewDelegate, GameOverViewDelegate, SettingsViewDelegate, GameCenterLeaderboardViewDelegate>

@property (nonatomic, assign) bool gameCenterEnabled;
@property (nonatomic, assign) bool isAdDisplayed;

@end

