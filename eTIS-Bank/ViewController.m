//
//  ViewController.m
//  eTIS-Bank
//
//  Created by Rodolphe on 10/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.navigationController.navigationBarHidden = false;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor clearColor]};

    //Init settings button animation :)
    
    NSArray *imageNames = @[@"blue-morpho1.png", @"blue-morpho2.png", @"blue-morpho3.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    self.settingsButton.imageView.animationImages = images;
    self.settingsButton.imageView.animationDuration = 0.5;
    
    [self.settingsButton.imageView startAnimating];
    
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingPushed:(UIButton *)sender {
}
@end
