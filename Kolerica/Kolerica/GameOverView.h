//
//  GameOverView.h
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Functions.h"
#import "Button.h"
@protocol GameOverViewDelegate;

@interface GameOverView : UIView

@property (nonatomic, strong) id<GameOverViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame score:(int)score newHighScore:(bool)newHighScore;

@end

@protocol GameOverViewDelegate <NSObject>
-(void)switchFrom:(AppState)currentState to:(AppState)newState;
-(void)childPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
@end
