//
//  ColorCircle.m
//  Kolerica
//
//  Created by Satvik Borra on 9/13/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "ColorCircle.h"
#import "Functions.h"
#import "Storage.h"

@implementation ColorCircle

@synthesize block;
@synthesize textLabel;
@synthesize currentColor;

-(id)initWithFrame:(CGRect)frame withBlock:(CirclePress)pressDown text:(NSString*)text color:(UIColor*)col{
    CGFloat width = fminf(frame.size.width, frame.size.height);
    
    CGRect nF = CGRectMake(frame.origin.x, frame.origin.y, width, width);
    self = [super initWithFrame:CGRectIntegral(nF)];
    block = pressDown;
    [self setColor:col];
    
    self.layer.cornerRadius = self.frame.size.width/2;
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(0, 0, nF.size.width, nF.size.height))];
    self.textLabel.text = text;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:30]];
    self.textLabel.adjustsFontSizeToFitWidth = true;
    self.layer.zPosition = 100;
    [self addSubview:self.textLabel];
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    block();
}

-(void)setColor:(UIColor*)col{
    currentColor = col;
    self.layer.backgroundColor = col.CGColor;
}

@end
