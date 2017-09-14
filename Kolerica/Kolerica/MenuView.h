//
//  MenuView.h
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "Functions.h"
#import "Label.h"

@protocol MenuViewDelegate;

@interface MenuView : UIView

@property (nonatomic, strong) id<MenuViewDelegate> delegate;
@property (nonatomic, strong) Label* labelUnderScores;

@end

@protocol MenuViewDelegate <NSObject>
-(void)switchFrom:(AppState)currentState to:(AppState)newState;
@end
