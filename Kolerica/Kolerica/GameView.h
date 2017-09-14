//
//  GameView.h
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"

@protocol GameViewDelegate;

@interface GameView : UIView

@property (nonatomic, strong) id<GameViewDelegate> delegate;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) bool newHighScore;

-(instancetype)initWithFrame:(CGRect)frame;

@end

@protocol GameViewDelegate <NSObject>
-(void)switchFrom:(AppState)currentState to:(AppState)newState;
-(void)gcReportScore:(int)s;

@end
