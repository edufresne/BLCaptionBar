//
//  BLStaticCaptionBar.h
//  BLCaptionBar
//
//  Created by Eric Dufresne on 2017-01-04.
//  Copyright © 2017 Eric Dufresne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLStaticCaptionBar : UITextView

@property (assign, nonatomic) CGFloat captionLocationFraction;

-(id)initWithText:(NSString*)text locationFraction:(CGFloat)fraction;

@end
