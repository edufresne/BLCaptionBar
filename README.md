# BLCaptionBar
This is a reusable UITextView subclass for all iOS versions that is inspired by Snapchat's caption bar. The bar can be added to any view and can be shown with a single call. BLCaptionBar works for both portrait and landscape orientations and can be customized just like UITextView such as changing background colors, text colors, opacity, and animation settings. The bar can be vertically dragged and is hidden when no text is inputted.

### Example Usage ###
Below is a sample usage inside of your custom View Controller
* Swift *
```swift
var captionBar : BLCaptionBar!
override func viewDidLoad(){
  super.viewDidLoad()
  self.view.userInteractionEnabled = true
  captionBar = BLCaptionBar()
  //Customization
  captionBar.animationTime = 0.35
  captionBar.uiDelegate = self
  self.addSubview(captionBar)
}
override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?){
  captionBar.slideUp()
}
override func someOtherMethod(){
  captionBar.slideDown()
}
```
* Objective C *
```objc
BLCaptionBar *captionBar;
-(void)viewDidLoad{
  [super viewDidLoad];
  self.view.userInteractionEnabled = YES;
  captionBar = [[BLCaptionBar alloc] init];
  //Customization
  captionBar.animationTime = 0.35;
  captionBar.uiDelegate = self;
  [self addSubview: captionBar];
}
-(void)touchesEnded:( NSSet<UITouch*>*)touches withEvent:(UIEvent*)event{
  [captionBar slideUp];
}
-(void)someOtherMethod{
  [captionBar slideDown];
}
```
