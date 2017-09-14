//
//  Button.m
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "Button.h"
#import "Storage.h"

@implementation Button
@synthesize block;
@synthesize textLabel;

-(id)initWithFrame:(CGRect)frame withBlock:(ButtonPress)pressDown text:(NSString*)text{
    self = [super initWithFrame:CGRectIntegral(frame)];
    block = pressDown;
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(0, 0, frame.size.width, frame.size.height))];
    self.textLabel.text = text;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont fontWithName:[Storage getFontNameFromNumber:[Storage getCurrentFont]] size:[Functions fontSize:30]];
    self.textLabel.adjustsFontSizeToFitWidth = true;
    [self addSubview:self.textLabel];
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    block();
}
@end
