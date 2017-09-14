//
//  GameOverView.m
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "GameOverView.h"
#import "Storage.h"

@implementation GameOverView {
    UILabel* mainLabel;
    UILabel* scoreLabel;
    UILabel* newHighScoreLabel;
    
    Button* replayButton;
    Button* shareButton;
    Button* menuButton;
    
    int score;
}

-(instancetype)initWithFrame:(CGRect)frame score:(int)_score newHighScore:(bool)newHighScore{
    self = [super initWithFrame:frame];
    
    score = _score;
    
    mainLabel = [[UILabel alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.1, 0.9, 0.15)]];
    mainLabel.textAlignment = NSTextAlignmentCenter;
    mainLabel.text = @"game over";
//    mainLabel.layer.borderWidth = [Storage getCurrentBorderWidth];
    mainLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:40]];
    mainLabel.tag = 1;
    [self addSubview:mainLabel];
    
    scoreLabel = [[UILabel alloc] initWithFrame:[self propToRect:CGRectMake(0.1, 0.3, 0.8, 0.1)]];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.text = [NSString stringWithFormat:@"score: %i", score];
    scoreLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:40]];
    scoreLabel.tag = 1;
    [self addSubview:scoreLabel];
    
    newHighScoreLabel = [[UILabel alloc] initWithFrame:[self propToRect:CGRectMake(0.1, 0.4, 0.8, 0.075)]];
    newHighScoreLabel.textAlignment = NSTextAlignmentCenter;
    newHighScoreLabel.text = newHighScore == true ? @"new high score!" : @"";
    newHighScoreLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:30]];
    newHighScoreLabel.adjustsFontSizeToFitWidth = true;
    [self addSubview:newHighScoreLabel];
    
    replayButton = [[Button alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.5, 0.9, 0.1)] withBlock:^{
        [self.delegate switchFrom:GameOver to:Game];
    } text:@"play again"];
    replayButton.layer.borderWidth = [Storage getCurrentBorderWidth];
    [self addSubview:replayButton];
    
    shareButton = [[Button alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.65, 0.9, 0.1)] withBlock:^{
        [self shareSheet];
    } text:@"share"];
    shareButton.layer.borderWidth = [Storage getCurrentBorderWidth];
    [self addSubview:shareButton];
    
    menuButton = [[Button alloc] initWithFrame:[self propToRect:CGRectMake(0.05, 0.8, 0.9, 0.1)] withBlock:^{
        [self.delegate switchFrom:GameOver to:Menu];
    } text:@"menu"];
    menuButton.layer.borderWidth = [Storage getCurrentBorderWidth];
    [self addSubview:menuButton];
    
    return self;
}

-(void)shareSheet {
    NSString *textToShare = [NSString stringWithFormat:@"i just got %i in kolerica", score];
    NSURL *myWebsite = [NSURL URLWithString:@"http://apple.co/2x20KMQ"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo,
                                   @"com.apple.mobilenotes.SharingExtension",
                                   @"com.apple.reminders.RemindersEditorExtension",
                                   @"com.google.Drive.ShareExtension"
                                   ];
    
    activityVC.excludedActivityTypes = excludeActivities;

    [self.delegate childPresentViewController:activityVC animated:YES completion:nil];
}

- (CGRect) propToRect: (CGRect)prop {
    CGRect viewSize = self.frame;
    CGRect real = CGRectMake(prop.origin.x*viewSize.size.width, prop.origin.y*viewSize.size.height, prop.size.width*viewSize.size.width, prop.size.height*viewSize.size.height);
    return CGRectIntegral(real);
}

@end
