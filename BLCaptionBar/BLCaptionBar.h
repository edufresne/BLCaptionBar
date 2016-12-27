//
//  BLCaptionBar.h
//  BLCaptionBar
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCaptionBar : UITextView <UITextViewDelegate>

@property (assign, nonatomic) id<UITextViewDelegate> uiDelegate;

@property (readonly, nonatomic) BOOL isShowing;

@property (assign, nonatomic) CGFloat animationTime;

@property (assign, nonatomic) UIViewAnimationOptions animationOptions;

-(id)init;
-(void)slideUp;
-(void)slideDown;
@end
