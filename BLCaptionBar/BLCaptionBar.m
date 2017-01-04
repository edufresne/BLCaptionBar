
//
//  BLCaptionBar.m
//  BLCaptionBar
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import "BLCaptionBar.h"

@interface BLCaptionBar ()
@property (strong, nonatomic) UIPanGestureRecognizer *gesture;
@end

@implementation BLCaptionBar
@synthesize isShowing = _isShowing;
-(id)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, 0, 30)]){
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.textColor = [UIColor whiteColor];
        self.animationTime = 0.25;
        self.animationOptions = UIViewAnimationOptionCurveEaseOut;
        self.textAlignment = NSTextAlignmentCenter;
        _isShowing = NO;
        self.userInteractionEnabled = NO;
        self.delegate = self;
        self.text = @"";
        self.returnKeyType = UIReturnKeyDone;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.captionLocationFraction = 0.5;
        self.gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userDragged)];
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
        self.center = CGPointMake(self.superview.center.x, self.superview.frame.size.height+self.frame.size.height/2);
    }
}

#pragma mark - User Methods
-(void)slideUp{
    if (!_isShowing){
        _isShowing = YES;
        [self becomeFirstResponder];
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (UIDeviceOrientationIsPortrait(orientation)){
            [UIView animateWithDuration:self.animationTime delay:0 options:self.animationOptions animations:^{
                self.center = self.superview.center;
            } completion:nil];
        }
        else{
            [UIView animateWithDuration:self.animationTime delay:0 options:self.animationOptions animations:^{
                self.center = CGPointMake(self.superview.center.x, self.superview.center.y/2);
            } completion:nil];
        }
        
    }
}
-(void)slideDown{
    if (_isShowing){
        _isShowing = NO;
        self.text = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self resignFirstResponder];
        if (self.text.length == 0){
            [self removeGestureRecognizer:self.gesture];
            self.userInteractionEnabled = NO;
            self.captionLocationFraction = 0.5;
            [UIView animateWithDuration:self.animationTime delay:0 options:self.animationOptions animations:^{
                self.center = CGPointMake(self.superview.center.x, self.superview.frame.size.height+self.frame.size.height/2);
            } completion:nil];
        }
        else{
            self.userInteractionEnabled = YES;
            [self addGestureRecognizer:self.gesture];
            [UIView animateWithDuration:self.animationTime delay:0 options:self.animationOptions animations:^{
                self.center = CGPointMake(self.superview.center.x, self.superview.frame.size.height*_captionLocationFraction);
            } completion:nil];
        }
    }
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    CGFloat fixedWidth = self.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
    if (self.uiDelegate && [self.uiDelegate respondsToSelector:@selector(textViewDidChange:)]){
        [self.uiDelegate textViewDidChange:textView];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.uiDelegate && [self.uiDelegate respondsToSelector:@selector(textViewDidEndEditing:)]){
        [self.uiDelegate textViewDidEndEditing:textView];
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.uiDelegate && [self.uiDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]){
        [self.uiDelegate textViewDidBeginEditing:textView];
    }
}
-(void)textViewDidChangeSelection:(UITextView *)textView{
    if (self.uiDelegate && [self.uiDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]){
        [self.uiDelegate textViewDidChangeSelection:textView];
    }
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (self.uiDelegate && [self.uiDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]){
        return [self.uiDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (self.uiDelegate && [self.uiDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]){
        return [self.uiDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self slideDown];
        if (self.uiDelegate && [self.uiDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]){
            [self.uiDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
        }
        return NO;
    }
    else if (self.uiDelegate && [self.uiDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]){
        return [self.uiDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

#pragma mark - Listener Methods
-(void)userDragged{
    if (!self.isFirstResponder){
        CGPoint location = [self.gesture locationInView:self.superview];
        self.center = CGPointMake(self.center.x, location.y);
        self.captionLocationFraction = self.center.y/self.superview.frame.size.height;
    }
}
-(void)orientationDidChange{    
    if (self.superview != nil){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.superview.frame.size.width, self.frame.size.height);
        if (self.text.length != 0){
            if (!self.isFirstResponder)
                self.center = CGPointMake(self.superview.center.x, self.captionLocationFraction*self.superview.frame.size.height);
        }
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (self.isFirstResponder){
            if (UIDeviceOrientationIsPortrait(orientation)){
                self.center = CGPointMake(self.superview.center.x, self.superview.center.y);
            }
            else{
                self.center = CGPointMake(self.superview.center.x, self.superview.center.y/2);
            }
        }
    }
    
}

@end
