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



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
