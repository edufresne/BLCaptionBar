//
//  BLCaptionBar.h
//  BLCaptionBar
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCaptionBar : UITextView <UITextViewDelegate>

//Use this instead of 'delegate' to receive events unless you want to override the built in delegate features.
//The 'delegate' attribute manages new line characters as well as sliding after the return key is pressed
@property (assign, nonatomic) id<UITextViewDelegate> uiDelegate;

//true or false value on whether the bar is visible or not. Defaults to false but does change if slideUp() is called
@property (readonly, nonatomic) BOOL isShowing;

//Animation time in seconds in which the bar slides up and down.
@property (assign, nonatomic) NSTimeInterval animationTime;

//UIView Animation options that are used during the slide up/down animation.
@property (assign, nonatomic) UIViewAnimationOptions animationOptions;

//This is the fraction of where the caption bar is located in the screen. This is used to preserve user drags.
//0 represents the top of the superview and 1 represents the bottom. Defaults to 0.5 (middle)
@property (assign, nonatomic) CGFloat captionLocationFraction;

//This should be called when creating an instance. Not any super methods
-(id)init;

//Slides the caption bar up. Recommended to put the below two methods in touchesEnded but can be put anywhere.
-(void)slideUp;

//Slides the caption bar down.
-(void)slideDown;
@end
