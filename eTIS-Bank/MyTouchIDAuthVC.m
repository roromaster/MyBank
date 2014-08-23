//
//  MyTouchIDAuthVC.m
//  eTIS-Bank
//
//  Created by Rodolphe on 23/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "MyTouchIDAuthVC.h"
#import "POP/Pop.h"

@interface MyTouchIDAuthVC ()

@end

@implementation MyTouchIDAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSTimer *animationLoop =   [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(animateView)userInfo:nil repeats:INFINITY];
    
    // Do any additional setup after loading the view.
    
    
}

- (void) animateView
{
    const CGFloat LargeSize = 256.0f;
    const CGFloat SmallSize = 240.0f;
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    
    if (self.touchIDImage.frame.size.width >= LargeSize) {
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, SmallSize, SmallSize)];
    } else {
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, LargeSize, LargeSize)];
    }
    
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    
    [self.touchIDImage.layer pop_addAnimation:anim forKey:@"scale"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
