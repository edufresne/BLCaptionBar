//
//  ViewController.m
//  BLCaptionBar
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import "ViewController.h"
#import "BLCaptionBar.h"
#import "BLStaticCaptionBar.h"

@interface ViewController ()
@property (strong, nonatomic) BLCaptionBar *captionBar;
@property (strong, nonnull) BLStaticCaptionBar *staticCaptionBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = true;
    /*
    self.captionBar = [[BLCaptionBar alloc] init];
    [self.view addSubview:self.captionBar];
     */
    self.staticCaptionBar = [[BLStaticCaptionBar alloc] initWithText:@"Hello World" locationFraction:0.25];
    [self.view addSubview:self.staticCaptionBar];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    /*
    if (self.captionBar.isShowing){
        [self.captionBar slideDown];
    }
    else{
        [self.captionBar slideUp];
    }
     */
}


@end
