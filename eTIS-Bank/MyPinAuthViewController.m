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

@implementation MyPinAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self shufflePin];
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
    _pinButtonOK.alpha = 0;
    
}

-(void) viewWillLayoutSubviews
{
    [UIView animateWithDuration:2.0f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
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
    
    
    [UIView animateWithDuration:4.0f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self shufflePin];
                     }
                     completion:nil];

    
}
- (void) viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
    NSLog(@"Pin Did Appear");
   
    
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
    
    NSMutableArray *valueList= [[NSMutableArray alloc] initWithObjects: @"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"",@"",@"",@"",@"",nil];
    
    for (int buttonIndex; buttonIndex <[buttonList count]; buttonIndex++)
    {
        NSInteger random = arc4random() % ([buttonList count] - buttonIndex);
        UIButton *currentButton = buttonList[buttonIndex];
        [currentButton setTitle:valueList[random] forState: UIControlStateNormal];
        [valueList removeObjectAtIndex:random];
    }
    
    
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
