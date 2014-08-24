//
//  faceRegisterVC.m
//  eTIS-Bank
//
//  Created by Rodolphe on 23/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "faceRegisterVC.h"

@interface faceRegisterVC ()
{


}
@end

@implementation faceRegisterVC

NSMutableArray *progressionImages;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      NSArray *images_name= @[@"face-10%.png",
                              @"face-20%.png",
                              @"face-30%.png",
                              @"face-40%.png",
                              @"face-50%.png",
                              @"face-60%.png",
                              @"face-70%.png",
                              @"face-80%.png",
                              @"face-90%.png",
                              @"face-100%.png"
                              ];
    
    progressionImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < images_name.count; i++) {
        [progressionImages addObject:[UIImage imageNamed:[images_name objectAtIndex:i]]];
    }

    _registerProgressionImage.animationImages = progressionImages;
    _registerProgressionImage.animationDuration = 10.0;

    
    [_registerProgressionImage startAnimating];

    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login Background.png"]];
    
    [background sizeToFit];
    [background setFrame:self.view.frame];
    [background setBounds:self.view.bounds];
    
    [self.view addSubview:background];
    
    background.layer.zPosition = -1;
    

    
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
