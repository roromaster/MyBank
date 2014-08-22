//
//  MyPinAuthViewController.m
//  eTIS-Bank
//
//  Created by Rodolphe on 13/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "MyPinAuthViewController.h"

@interface MyPinAuthViewController ()

@end

NSString * pinValue;


@implementation MyPinAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Pin Did Load");
    // Do any additional setup after loading the view.
    _pinButton1x1.alpha = 0;
    _pinButton1x2.alpha = 0;
    _pinButton1x3.alpha = 0;
    _pinButton1x4.alpha = 0;
    _pinButton2x1.alpha = 0;
    _pinButton2x2.alpha = 0;
    _pinButton2x3.alpha = 0;
    _pinButton2x4.alpha = 0;
    _pinButton3x1.alpha = 0;
    _pinButton3x2.alpha = 0;
    _pinButton3x3.alpha = 0;
    _pinButton3x4.alpha = 0;
    _pinButton4x1.alpha = 0;
    _pinButton4x2.alpha = 0;
    _pinButton4x3.alpha = 0;
    _pinButtonOK.hidden = true;
    _backspace.hidden = true;
    
    
    pinValue = @"";
    
}

-(void) viewWillLayoutSubviews
{
    
    [super viewWillLayoutSubviews];
    [UIView animateWithDuration:2.0f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionAllowAnimatedContent
                     animations:^ {
                         _pinButton1x1.alpha = 1;
                         _pinButton1x2.alpha = 1;
                         _pinButton1x3.alpha = 1;
                         _pinButton1x4.alpha = 1;
                         _pinButton2x1.alpha = 1;
                         _pinButton2x2.alpha = 1;
                         _pinButton2x3.alpha = 1;
                         _pinButton2x4.alpha = 1;
                         _pinButton3x1.alpha = 1;
                         _pinButton3x2.alpha = 1;
                         _pinButton3x3.alpha = 1;
                         _pinButton3x4.alpha = 1;
                         _pinButton4x1.alpha = 1;
                         _pinButton4x2.alpha = 1;
                         _pinButton4x3.alpha = 1;
                         _pinButtonOK.alpha = 1;
                         
                     }
                     completion:^(BOOL completed){
                         if (completed == TRUE)
                             NSLog(@"Animation Pin finished");
                     }
     ];
    
    
    
}
- (void) viewDidAppear:(BOOL)animated
{
    
    //    [super viewDidAppear:animated];
    
    NSLog(@"Pin Did Appear");
    
    [self shufflePin];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) shufflePin
{
    NSArray *buttonList = [[NSArray alloc] initWithObjects:_pinButton1x1, _pinButton1x2,_pinButton1x3, _pinButton1x4,_pinButton2x1, _pinButton2x2,_pinButton2x3, _pinButton2x4,_pinButton3x1, _pinButton3x2,_pinButton3x3, _pinButton3x4,_pinButton4x1, _pinButton4x2,_pinButton4x3, nil ];
    
    NSMutableArray *valueList= [[NSMutableArray alloc] initWithObjects: @"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"blank",@"blank",@"blank",@"blank",@"blank",nil];
    
    CATransition *animation2 = [CATransition animation];
    animation2.duration = 1.0;
    animation2.type = kCATransitionReveal;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    
    for (int buttonIndex=0; buttonIndex <[buttonList count]; buttonIndex++)
    {
        NSInteger random = arc4random() % ([buttonList count] - buttonIndex);
        UIButton *currentButton = buttonList[buttonIndex];
        NSString *value2Assign =valueList[random];
       
        [valueList removeObjectAtIndex:random];
        
        if ([value2Assign isEqualToString:@"blank"])
        {
            currentButton.hidden = true;
             [currentButton setTitle:@"" forState: UIControlStateNormal];
        }
        else
        {
          [currentButton setTitle:value2Assign forState: UIControlStateNormal];
            currentButton.hidden = false;
        }
        
        [currentButton.layer addAnimation:animation2 forKey:@"Transition"];
    }
}


-(IBAction)buttonTapped:(id)sender
{
    UIButton *buttonpushed = (UIButton*)sender;
    
    NSLog(@"Button Pushed");
    
  //  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    if ([buttonpushed isEqual:_pinButtonOK])
    {
        //OK Button pushed
        
            NSArray *buttonList = [[NSArray alloc] initWithObjects:_pinButton1x1, _pinButton1x2,_pinButton1x3, _pinButton1x4,_pinButton2x1, _pinButton2x2,_pinButton2x3, _pinButton2x4,_pinButton3x1, _pinButton3x2,_pinButton3x3, _pinButton3x4,_pinButton4x1, _pinButton4x2,_pinButton4x3, nil ];
        
        for (UIButton* button in buttonList)
        {
            button.layer.doubleSided = TRUE;
            button.layer.zPosition = 850;
            [self spinLayer:button.layer duration:0.2 direction:1];
        }
        
    }
    
    else if ([buttonpushed isEqual:_backspace])
    {
        pinValue = [pinValue substringToIndex:[pinValue length] - 1];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 1.0;
        animation.type = kCATransitionFromRight;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_pinValue.layer addAnimation:animation forKey:@"changeTextTransition"];
        
        // Change the text
        
        _pinValue.text = [_pinValue.text substringToIndex:[_pinValue.text length] -1];
        
        if ([pinValue length]<4)
        {
            
            CATransition *animation3 = [CATransition animation];
            animation3.duration = 1.0;
            animation3.type = kCATransitionReveal;
            animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [_pinButtonOK.layer addAnimation:animation3 forKey:@"Transition"];
            _pinButtonOK.hidden = true;
        }
        
        if ([pinValue isEqualToString:@""])
        {
            
            CATransition *animation2 = [CATransition animation];
            animation2.duration = 1.0;
            animation2.type = kCATransitionPush;
            animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [_backspace.layer addAnimation:animation2 forKey:@"Transition"];
            _backspace.hidden = true;
        }
    }
    
    else
    {
        
        if ([buttonpushed.titleLabel.text isEqual:@""])
            return;
        
        NSString *newvalue;
        NSString *pinValueHint;
        [_pinValue setFont:[UIFont systemFontOfSize:80]];
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(securepinAnimation) userInfo:nil repeats:NO];
        
        newvalue = [NSString stringWithFormat:@"%@%@",pinValue, buttonpushed.titleLabel.text];
        
        if ([pinValue length] > 0)
            pinValueHint = [NSString stringWithFormat:@"%@%@",_pinValue.text,buttonpushed.titleLabel.text];
        else
            pinValueHint = [NSString stringWithFormat:@"%@",buttonpushed.titleLabel.text];
        
        pinValue = newvalue;
        
        CATransition *animation = [CATransition animation];
        animation.duration = 1.0;
        animation.type = kCATransitionFade;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_pinValue.layer addAnimation:animation forKey:@"changeTextTransition"];
        
        // Change the text
        _pinValue.text = pinValueHint;
        
        if (([pinValue length]>3) & (_pinButtonOK.hidden))
        {
            CATransition *animation3 = [CATransition animation];
            animation3.duration = 1.0;
            animation3.type = kCATransitionMoveIn;
            animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [_pinButtonOK.layer addAnimation:animation3 forKey:@"changeTextTransition"];
            _pinButtonOK.hidden = false;
        }
        
        if (_backspace.hidden)
        {
        CATransition *animation2 = [CATransition animation];
        animation2.duration = 1.0;
        animation2.type = kCATransitionMoveIn;
        animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_backspace.layer addAnimation:animation2 forKey:@"changeTextTransition"];
        _backspace.hidden = false;
        }
        
        
        
    }
    
}

- (void) securepinAnimation
{
    NSMutableString *pinValueforScreen = [[NSMutableString alloc] init];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_pinValue.layer addAnimation:animation forKey:@"changeTextTransition"];
    for (int i=0;i< [pinValue length];i++)
        [pinValueforScreen appendString:@"*"];
    _pinValue.text = pinValueforScreen;
    
}

- (void)spinLayer:(CALayer *)inLayer duration:(CFTimeInterval)inDuration
        direction:(int)direction
{

//    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scale.fromValue = @0.75; // Your from value (not obvious from the question)
//    scale.toValue = @2.0;
//    scale.duration = 2;
//    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//
    
    CAKeyframeAnimation * flipToBackAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    flipToBackAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    flipToBackAnimation.removedOnCompletion = YES;
    flipToBackAnimation.duration = inDuration; /* Usually 0.5 */
    flipToBackAnimation.values = [NSArray arrayWithObjects:
                                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 1, 0)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.5 * M_PI, 0, 1, 0)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2*M_PI, 0, 1, 0)],
                                  nil];
    
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = -1.0f / 2000;
    
    inLayer.sublayerTransform = perspectiveTransform;
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = YES;
    scaleAnimation.duration = inDuration; /* Usually 0.5 */
    scaleAnimation.values = [NSArray arrayWithObjects:
                             [NSValue valueWithCATransform3D:CATransform3DIdentity],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(.95, .95, .95)],
                             [NSValue valueWithCATransform3D:CATransform3DIdentity],
                             nil];
    
 
    
    inLayer.transform = [[flipToBackAnimation.values lastObject] CATransform3DValue];
    flipToBackAnimation.repeatCount = 30;
    [inLayer addAnimation:flipToBackAnimation forKey:kCATransition];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
