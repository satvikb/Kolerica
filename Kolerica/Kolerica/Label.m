//
//  Label.m
//  Kolerica
//
//  Created by Satvik Borra on 9/13/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import "Label.h"
#import "Storage.h"

@implementation Label

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectIntegral(frame)];
    
    [self updateDarkMode];
    
    return self;
}

-(void)updateDarkMode{
    self.layer.borderColor = [Storage getDarkModeEnabled] == true ? UIColor.whiteColor.CGColor : UIColor.blackColor.CGColor;
    self.layer.backgroundColor = [Storage getDarkModeEnabled] == true ? UIColor.blackColor.CGColor : UIColor.whiteColor.CGColor;
    self.textColor = [Storage getDarkModeEnabled] == true ? UIColor.whiteColor : UIColor.blackColor;
}

@end
