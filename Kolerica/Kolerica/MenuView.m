//
//  MenuView.m
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "MenuView.h"
#import "Storage.h"

@implementation MenuView {
    UILabel* titleLabel;
    UILabel* highScoreLabel;
    
    Button* playButton;
    Button* scoreButton;
    Button* settingsButton;
}

@synthesize labelUnderScores;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    titleLabel = [[UILabel alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.1, 0.9, 0.2)]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"kolerica";
    titleLabel.layer.borderWidth = 0;
    titleLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:70]];
    titleLabel.adjustsFontSizeToFitWidth = true;
    titleLabel.tag = 1;
    [self addSubview:titleLabel];
    
    highScoreLabel = [[UILabel alloc] initWithFrame:[self propToRect:CGRectMake(0.1, 0.3, 0.8, 0.1)]];
    highScoreLabel.textAlignment = NSTextAlignmentCenter;
    highScoreLabel.text = [NSString stringWithFormat:@"high score: %i", [Storage getSavedHighScore]];
    highScoreLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:30]];
    highScoreLabel.adjustsFontSizeToFitWidth = true;
    highScoreLabel.tag = 1;
    [self addSubview:highScoreLabel];
    
    playButton = [[Button alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.5, 0.9, 0.1)] withBlock:^{
        [self.delegate switchFrom:Menu to:Game];
    } text:@"play"];
    playButton.layer.borderWidth = [Storage getCurrentBorderWidth];
    [self addSubview:playButton];
    
    scoreButton = [[Button alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.65, 0.9, 0.1)] withBlock:^{
        [self.delegate switchFrom:Menu to:GamecenterLeaderboard];
    } text:@"scores"];
    scoreButton.layer.borderWidth = [Storage getCurrentBorderWidth];
    [self addSubview:scoreButton];
    
    settingsButton = [[Button alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.8, 0.9, 0.1)] withBlock:^{
        [self.delegate switchFrom:Menu to:Settings];
    } text:@"settings"];
    settingsButton.layer.borderWidth = [Storage getCurrentBorderWidth];
    [self addSubview:settingsButton];
    
    labelUnderScores = [[UILabel alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.75, 0.9, 0.05)]];
    labelUnderScores.textAlignment = NSTextAlignmentCenter;
    labelUnderScores.text = @"";
    labelUnderScores.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:20]];
    labelUnderScores.adjustsFontSizeToFitWidth = true;
    [self addSubview:labelUnderScores];
    return self;
}

- (CGRect) propToRect: (CGRect)prop {
    CGRect viewSize = self.frame;
    CGRect real = CGRectMake(prop.origin.x*viewSize.size.width, prop.origin.y*viewSize.size.height, prop.size.width*viewSize.size.width, prop.size.height*viewSize.size.height);
    return CGRectIntegral(real);
}

@end
