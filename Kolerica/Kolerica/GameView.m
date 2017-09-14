//
//  GameView.m
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "GameView.h"
#import "Storage.h"
#import "ColorCircle.h"
#import "Label.h"

@implementation GameView {
    Label* scoreLabel;
    ColorCircle* mainCircle;
    NSMutableArray<ColorCircle*>* colorCircles;
    
    CADisplayLink* gameTimer;
    CGFloat timePerColor;
    CGFloat currentTimer;
    
    UIView* timerBar;
    
    UIColor* currentMainColor;
    
    bool gameOverHappening;
}

@synthesize score;
@synthesize newHighScore;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.tag = 2;
    self.backgroundColor = [Storage getDarkModeEnabled] == true ? UIColor.blackColor : UIColor.whiteColor;

    score = 0;
    newHighScore = false;
    colorCircles = [[NSMutableArray alloc] init];
    
    timePerColor = 3;

    if([Storage getDidCompleteTutorial] == true){
        [self startGame];
    }else{
        UIView* tutorialView = [[UIView alloc] initWithFrame:[self propToRect:CGRectMake(0.1, 0.2, 0.8, 0.6)]];
        tutorialView.layer.backgroundColor = [Storage getDarkModeEnabled] == true ? UIColor.blackColor.CGColor : UIColor.whiteColor.CGColor;
        tutorialView.layer.borderWidth = 5;
        tutorialView.layer.borderColor = [Storage getDarkModeEnabled] == true ? UIColor.whiteColor.CGColor : UIColor.blackColor.CGColor;

        Label* mainLabel = [[Label alloc] initWithFrame:CGRectIntegral(CGRectMake(tutorialView.frame.size.width*0.05, tutorialView.frame.size.height*0.05, tutorialView.frame.size.width*0.9, tutorialView.frame.size.height*0.7))];
        mainLabel.text = @"select the cirlce that is the same color as the circle above";
        mainLabel.numberOfLines = 5;
        mainLabel.textAlignment = NSTextAlignmentCenter;
        mainLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:27]];
        mainLabel.adjustsFontSizeToFitWidth = true;
//        mainLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        mainLabel.layer.borderWidth = 2;
        [tutorialView addSubview:mainLabel];
        
        [self addSubview:tutorialView];
        
        [self performSelector:@selector(showTutorialDissapearButton:) withObject:tutorialView afterDelay:3];
    }
    
    return self;
}

-(void)startGame{
    [self createMainCircle];
    [self createScoreLabel];
    [self createTimerBar];
    [self createAllDigitButtons];
    [self createNewColor];

    if([Storage getDidCompleteTutorial] == true){
        [self startGameLoop];
    }
}

-(void)createScoreLabel{
    scoreLabel = [[Label alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.05, 0.9, 0.1)]];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:50]];
    scoreLabel.adjustsFontSizeToFitWidth = true;
    scoreLabel.text = @"0";
    scoreLabel.tag = 1;
    if([Storage getShowScoreInMainCircle] == false){
        [self addSubview:scoreLabel];
    }else{
        mainCircle.textLabel.text = @"0";
    }
}

-(void)createTimerBar {
    timerBar = [[UIView alloc] initWithFrame:[self propToRect:CGRectMake(0, 0.31875, 1, 0.0375)]];
    timerBar.backgroundColor = UIColor.blackColor;
    [self addSubview:timerBar];
}

-(void)createMainCircle {
    CGFloat width = [self propToRect:CGRectMake(0, 0, 0, [Storage getShowScoreInMainCircle] == true ? 0.25 : 0.15)].size.height;
    CGPoint origin = [self propToRect:CGRectMake(0.5, [Storage getShowScoreInMainCircle] == true ? 0.05 : 0.15, 0, 0)].origin;
    origin.x -= width/2;
    
    mainCircle = [[ColorCircle alloc] initWithFrame:CGRectIntegral(CGRectMake(origin.x, origin.y, width, width)) withBlock:^{} text:@"" color:UIColor.whiteColor];
    mainCircle.layer.borderWidth = [Storage getCurrentBorderWidth];
    mainCircle.textLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:60]];
    [self addSubview:mainCircle];
}

-(void)showTutorialDissapearButton:(UIView*)tutorialView {
    Button* doneBtn = [[Button alloc] initWithFrame:CGRectIntegral(CGRectMake(tutorialView.frame.size.width*0.1, tutorialView.frame.size.height-(tutorialView.frame.size.height*0.2), tutorialView.frame.size.width*0.8, tutorialView.frame.size.height*0.15)) withBlock:^void{
        [tutorialView removeFromSuperview];
        [self startGame];
    } text:@"play"];
    [tutorialView addSubview:doneBtn];
}

-(void)createNewColor{
    UIColor *color = [Functions randomColor];
    
    [mainCircle setColor:color];
    currentMainColor = color;
    
    [self resetCircleColorsWithRandomAnswer];
    
    currentTimer = 0;
    
    CGRect f = timerBar.frame;
    f.size = CGSizeMake([self propToRect:CGRectMake(0, 0, 1, 1)].size.width, f.size.height);
    timerBar.frame = f;
    
    timerBar.backgroundColor = currentMainColor;
    
    [timerBar.layer removeAllAnimations];
    
    if([Storage getDidCompleteTutorial] == true){
        [self startAnimatingBarDown];
    }
}

-(void)resetCircleColorsWithRandomAnswer{
    int answerCircleIndex = [Functions randomNumberBetween:0 maxNumber:8];
    NSLog(@"ANSWER: %i", answerCircleIndex);
    
    ColorCircle* answerCircle = [colorCircles objectAtIndex:answerCircleIndex];
    [answerCircle setColor:currentMainColor];
    
    for(ColorCircle* c in colorCircles){
        if(c != answerCircle){
            [c setColor:[Functions randomColor]];
        }
    }
}

- (void)createAllDigitButtons{
    int i = 0;
    for(int y = 0; y < 3; y++){
        for(int x = 0; x < 3; x++){
            i++;
            
            CGFloat width = [self propToRect:CGRectMake(0, 0, 0, 0.15)].size.height;
            
//          CGFloat propWidth = width/[self propToRect:CGRectMake(0, 0, 1, 0)].size.width;
            CGFloat paddingWidth = 0.05;
            
            //dont touch plz
            CGPoint origin = [self propToRect:CGRectMake(((x+1)*(0.25)+(paddingWidth*(x-1))), 0.375+(y*0.175), 0, 0)].origin;
            origin.x -= width/2;
            
            ColorCircle* colorCircle = [[ColorCircle alloc] initWithFrame:CGRectMake(origin.x, origin.y, width, width) withBlock:^void{
                
            } text:@"" color:[Functions randomColor]];
            
            colorCircle.layer.borderWidth = [Storage getCurrentBorderWidth];
            
            __unsafe_unretained typeof(ColorCircle*) wb = colorCircle;
            
            [colorCircle setBlock:^void{
//                NSLog(@"Digit Id: %i %i", digitId, currentDigit);
                [self pressCircleButton:wb];
            }];
            
            [self addSubview:colorCircle];
            [colorCircles addObject:colorCircle];
        }
    }
}

-(void)pressCircleButton:(ColorCircle*)btn {
    if(btn.currentColor == currentMainColor){
        NSLog(@"Correct");
        
        if(gameOverHappening == false){
            if([Storage getDidCompleteTutorial] == true){
                score += 1;
                
                if(timePerColor > 0.5){
                    timePerColor -= 0.01;
                }
                
                scoreLabel.text = [NSString stringWithFormat:@"%i", score];
                
                if([Storage getShowScoreInMainCircle] == true){
                    mainCircle.textLabel.text = [NSString stringWithFormat:@"%i", score];
                }
            }else{
                [Storage setDidCompleteTutorial];
            }
            
            [self createNewColor];
            
            btn.layer.borderColor = UIColor.greenColor.CGColor;
            [self performSelector:@selector(resetBorder:) withObject:btn afterDelay:0.5];
        }
    }else{
        NSLog(@"Wrong");
        
        if(gameOverHappening == false){
            btn.layer.borderColor = UIColor.redColor.CGColor;
            timerBar.backgroundColor = UIColor.redColor;
            
            [UIView animateWithDuration:0.5 animations:^void{
                timerBar.layer.opacity = 0;
            }];
            
            [self performSelector:@selector(gameOverAndResetBorder:) withObject:btn afterDelay:0.5];
        }
    }
}

-(void)resetBorder:(ColorCircle*)btn{
    btn.layer.borderColor = [Storage getDarkModeEnabled] == true ? UIColor.whiteColor.CGColor : UIColor.blackColor.CGColor;
}

-(void)gameOverAndResetBorder:(ColorCircle*)btn{
    btn.layer.borderColor = [Storage getDarkModeEnabled] == true ? UIColor.whiteColor.CGColor : UIColor.blackColor.CGColor;
    [self gameOver];
}

-(bool)saveScore{
    if(score > [Storage getSavedHighScore]){
        [Storage saveHighScore:score];
        return true;
    }
    return false;
}

-(void)gameOver{
    
    if(gameOverHappening == false){
        newHighScore = [self saveScore];
        [Storage addToGamesPlayed];
        
        [self.delegate gcReportScore:score];
        
        [self stopGameLoop];
        [self.delegate switchFrom:Game to:GameOver];
        gameOverHappening = true;
    }
}

-(void)startGameLoop {
    gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop:)];
    
    if(SYSTEM_VERSION_GREATER_THAN(@"10.0")) {
        gameTimer.preferredFramesPerSecond = 60;
    } else {
        // Fallback on earlier versions
        gameTimer.frameInterval = 1;
    }
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)stopGameLoop {
    [gameTimer setPaused:true];
    [gameTimer removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    gameTimer = nil;
}

-(void)gameLoop:(CADisplayLink*)tmr {
    CGFloat delta = tmr.duration;
    currentTimer += delta;
    
    if(currentTimer >= timePerColor){
        [self gameOver];
    }
}

-(void)startAnimatingBarDown{
    CGRect f = timerBar.frame;
    f.size = CGSizeMake(0, f.size.height);
    [UIView animateWithDuration:timePerColor delay:0 options:UIViewAnimationOptionCurveLinear animations:^void{
        timerBar.frame = f;

    } completion:nil];
}

- (CGRect) propToRect: (CGRect)prop {
    CGRect viewSize = self.frame;
    CGRect real = CGRectMake(prop.origin.x*viewSize.size.width, prop.origin.y*viewSize.size.height, prop.size.width*viewSize.size.width, prop.size.height*viewSize.size.height);
    return CGRectIntegral(real);
}

@end
