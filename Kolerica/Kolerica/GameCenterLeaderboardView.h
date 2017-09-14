//
//  GameCenterLeaderboardView.h
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Functions.h"
#import <GameKit/GKPlayer.h>
#import <GameKit/GKScore.h>
#import <GameKit/GKLocalPlayer.h>

@protocol GameCenterLeaderboardViewDelegate;

@interface GameCenterLeaderboardView : UIView

@property (nonatomic, strong) id<GameCenterLeaderboardViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame scores:(NSArray*)scores localPlayerScore:(GKScore*)localPlayerScore;
-(void)createLocalScore;
-(void)onAdDissapear;
-(void)onAdAppear;
@end

@protocol GameCenterLeaderboardViewDelegate <NSObject>
-(void)switchFrom:(AppState)currentState to:(AppState)newState;
-(bool)adDisplayed;
-(CGFloat)bannerHeight;

@end
