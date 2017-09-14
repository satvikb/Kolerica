//
//  ColorCircle.h
//  Kolerica
//
//  Created by Satvik Borra on 9/13/17.
//  Copyright © 2017 satvik borra. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CirclePress)(void);

@interface ColorCircle : UIView

@property (nonatomic, copy) CirclePress block;
@property (nonatomic, strong) UILabel* textLabel;
@property (nonatomic, strong) UIColor* currentColor;

-(id)initWithFrame:(CGRect)frame withBlock:(CirclePress)pressDown text:(NSString*)text color:(UIColor*)col;
-(void)setColor:(UIColor*)col;
@end
