//
//  ViewController.m
//  BLCaptionBar
//
//  Created by Eric Dufresne on 2016-12-26.
//  Copyright © 2016 Eric Dufresne. All rights reserved.
//

#import "ViewController.h"
#import "BLCaptionBar.h"

@interface ViewController ()
@property (strong, nonatomic) BLCaptionBar *captionBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = true;
    self.captionBar = [[BLCaptionBar alloc] init];
    [self.view addSubview:self.captionBar];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.captionBar.isShowing){
        [self.captionBar slideDown];
    }
    else{
        [self.captionBar slideUp];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
