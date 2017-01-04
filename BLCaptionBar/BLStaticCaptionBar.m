//
//  BLStaticCaptionBar.m
//  BLCaptionBar
//
//  Created by Eric Dufresne on 2017-01-04.
//  Copyright © 2017 Eric Dufresne. All rights reserved.
//

#import "BLStaticCaptionBar.h"

@implementation BLStaticCaptionBar

-(id)initWithText:(NSString *)text locationFraction:(CGFloat)fraction{
    if (self = [super initWithFrame:CGRectZero]){
        self.text = text;
        self.editable = NO;
        self.captionLocationFraction = fraction;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.textColor = [UIColor whiteColor];
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.userInteractionEnabled = NO;
        self.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}
-(void)didMoveToWindow{
    [super didMoveToWindow];
    if (self.window == nil){
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}
-(void)didMoveToSuperview{
    if (self.superview != nil){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.superview.frame.size.width, self.frame.size.height);
        CGFloat fixedWidth = self.frame.size.width;
        CGSize newSize = [self sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = self.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        self.frame = newFrame;
    }
}
-(void)orientationDidChange{
    if (self.superview != nil){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.superview.frame.size.width, self.frame.size.height);
        self.center = CGPointMake(self.superview.center.x, self.captionLocationFraction*self.superview.frame.size.height);
    }
}

@end
