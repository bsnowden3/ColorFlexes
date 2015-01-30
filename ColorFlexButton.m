//
//  ColorFlexButton.m
//  ColorFlexes
//
//  Created by Bernard Snowden III on 9/1/12.
//  Copyright (c) 2012 Bernard Snowden III. All rights reserved.
//



#import "ColorFlexButton.h"

@implementation ColorFlexButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImage *buttonImage = [[UIImage alloc]initWithContentsOfFile:@"blue.png"];
       
        [self setImage:buttonImage forState:UIControlStateNormal];
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc{
    
    
    
}
@end
