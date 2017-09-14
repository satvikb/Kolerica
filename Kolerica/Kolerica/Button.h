//
//  Button.h
//  Letterama
//
//  Created by Satvik Borra on 9/11/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Functions.h"

typedef void (^ButtonPress)(void);

@interface Button : UIView
@property (nonatomic, copy) ButtonPress block;
@property (nonatomic, strong) UILabel* textLabel;

-(id)initWithFrame:(CGRect)frame withBlock:(ButtonPress)pressDown text:(NSString*)text;

@end
