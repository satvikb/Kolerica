//
//  GameCenterLeaderboardView.m
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "GameCenterLeaderboardView.h"
#import "Storage.h"
#import "Button.h"
#import "Label.h"

@implementation GameCenterLeaderboardView {
    UIScrollView* scroll;
    Button* backButton;
    
    GKScore* localScore;
    CGSize cellSize;
    
    UIView* localScoreView;
}

-(instancetype)initWithFrame:(CGRect)frame scores:(NSArray*)scores localPlayerScore:(GKScore*)localPlayerScore{
    self = [super initWithFrame:frame];
    self.backgroundColor = [Storage getDarkModeEnabled] == true ? UIColor.blackColor : UIColor.whiteColor;

    localScore = localPlayerScore;
    
    cellSize = [self propToRect:CGRectMake(0, 0, 1, 0.1)].size;
    
    scroll = [[UIScrollView alloc] initWithFrame:[self propToRect:CGRectMake(0, 0.125, 1, 0.875)]];
    scroll.contentSize = CGSizeMake(frame.size.width, (scores.count)*cellSize.height);
    [self addSubview:scroll];
    
    for(int i = 0; i < scores.count; i++){
        GKScore* score = [scores objectAtIndex:i%scores.count];
        GKPlayer* player = score.player;
        
        [self addScoreUnitScore:score withPlayer:player i:i];
    }
    
    backButton = [[Button alloc] initWithFrame:[self propToRect:CGRectMake(0.7, 0.05, 0.25, 0.075)] withBlock:^void{
        [self.delegate switchFrom:GamecenterLeaderboard to:Menu];
    } text:@"back"];
    [self addSubview:backButton];
    
    Label* titleLabel = [[Label alloc] initWithFrame:CGRectIntegral([self propToRect:CGRectMake(0.05, 0.05, 0.6, 0.075)])];
    titleLabel.text = @"leaderboard";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:40]];
    titleLabel.adjustsFontSizeToFitWidth = true;
    [self addSubview:titleLabel];
    
    
    return self;
}

-(void)createLocalScore{
    
    CGFloat yOffset = 0;
    if([self.delegate adDisplayed] == true){
        yOffset = -[self.delegate bannerHeight];
    }
    
    CGRect f = scroll.frame;
    f.size = CGSizeMake(f.size.width, f.size.height-cellSize.height+yOffset);
    scroll.frame = f;
    
    localScoreView = [[UIView alloc] initWithFrame:CGRectIntegral(CGRectMake(0, self.frame.size.height-cellSize.height+yOffset, cellSize.width, cellSize.height))];
    localScoreView.layer.borderWidth = 2;
    localScoreView.layer.borderColor = [Storage getDarkModeEnabled] == true ? UIColor.whiteColor.CGColor : UIColor.blackColor.CGColor;
    
    Label* rankLabel = [[Label alloc] initWithFrame:CGRectIntegral(CGRectMake(cellSize.width*0, cellSize.height*0, cellSize.width*0.2, cellSize.height))];
    rankLabel.text = [NSString stringWithFormat:@"%li.", (long)localScore.rank];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    rankLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:20]];
    [localScoreView addSubview:rankLabel];
    
    Label* nameLabel = [[Label alloc] initWithFrame:CGRectIntegral(CGRectMake(cellSize.width*0.2, cellSize.height*0, cellSize.width*0.5, cellSize.height))];
    nameLabel.text = [NSString stringWithFormat:@"%@", [GKLocalPlayer localPlayer].alias];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.adjustsFontSizeToFitWidth = true;
    nameLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:20]];
    [localScoreView addSubview:nameLabel];
    
    Label* scoreLabel = [[Label alloc] initWithFrame:CGRectIntegral(CGRectMake(cellSize.width*0.7, cellSize.height*0, cellSize.width*0.3, cellSize.height))];
    scoreLabel.text = [NSString stringWithFormat:@"%lli", localScore.value];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:40]];
    scoreLabel.adjustsFontSizeToFitWidth = true;
    [localScoreView addSubview:scoreLabel];
    
    [self addSubview:localScoreView];
    
}

-(void)addScoreUnitScore:(GKScore*)score withPlayer:(GKPlayer*)player i:(int)i{
    
    UIView* playerScoreUnit = [[UIView alloc] initWithFrame:CGRectIntegral(CGRectMake(0, cellSize.height*i, cellSize.width, cellSize.height))];
    Label* rankLabel = [[Label alloc] initWithFrame:CGRectIntegral(CGRectMake(cellSize.width*0, cellSize.height*0, cellSize.width*0.2, cellSize.height))];
    rankLabel.text = [NSString stringWithFormat:@"%li.", (long)score.rank];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    rankLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:20]];
    [playerScoreUnit addSubview:rankLabel];
    
    Label* nameLabel = [[Label alloc] initWithFrame:CGRectIntegral(CGRectMake(cellSize.width*0.2, cellSize.height*0, cellSize.width*0.5, cellSize.height))];
    nameLabel.text = [NSString stringWithFormat:@"%@", player.alias];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.adjustsFontSizeToFitWidth = true;
    nameLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:20]];
    [playerScoreUnit addSubview:nameLabel];
    
    Label* scoreLabel = [[Label alloc] initWithFrame:CGRectIntegral(CGRectMake(cellSize.width*0.7, cellSize.height*0, cellSize.width*0.3, cellSize.height))];
    scoreLabel.text = [NSString stringWithFormat:@"%lli", score.value];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:40]];
    scoreLabel.adjustsFontSizeToFitWidth = true;
    [playerScoreUnit addSubview:scoreLabel];
    
    [scroll addSubview:playerScoreUnit];
}

-(void)onAdDissapear {
    CGFloat oldHeight = scroll.frame.size.height;
    CGFloat newHeight = self.frame.size.height-cellSize.height-[self propToRect:CGRectMake(0, 0, 0, 0.125)].size.height;
    
    CGRect f = scroll.frame;
    f.size = CGSizeMake(f.size.width, newHeight);
    scroll.frame = f;
    
    CGRect l = localScoreView.frame;
    l.origin.y = self.frame.size.height-(newHeight-oldHeight);
    localScoreView.frame = l;
}

-(void)onAdAppear {
    
    CGFloat yOffset = 0;
    if([self.delegate adDisplayed] == true){
        yOffset = -[self.delegate bannerHeight];
    }
    CGRect origScrollFrame = [self propToRect:CGRectMake(0, 0.125, 1, 0.875)];
    
    origScrollFrame.size.height = origScrollFrame.size.height-cellSize.height+yOffset;
    scroll.frame = origScrollFrame;
    
    CGRect l = CGRectIntegral(CGRectMake(0, self.frame.size.height-cellSize.height+yOffset, cellSize.width, cellSize.height));
    localScoreView.frame = l;
    
}

- (CGRect) propToRect: (CGRect)prop {
    CGRect viewSize = self.frame;
    CGRect real = CGRectMake(prop.origin.x*viewSize.size.width, prop.origin.y*viewSize.size.height, prop.size.width*viewSize.size.width, prop.size.height*viewSize.size.height);
    return CGRectIntegral(real);
}

@end


