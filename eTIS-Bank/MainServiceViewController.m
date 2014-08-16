//
//  MainServiceViewController.m
//  eTIS-Bank
//
//  Created by Rodolphe on 16/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "MainServiceViewController.h"

@interface MainServiceViewController ()

@end

@implementation MainServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat yOrigin = i * 200;
        UIView *awesomeView = [[UIView alloc] initWithFrame:CGRectMake(0, yOrigin, self.view.frame.size.width, self.view.frame.size.height)];
        awesomeView.backgroundColor = [UIColor colorWithRed:0.5/i green:0.5 blue:0.5 alpha:1];
        [_mainDetailedView addSubview:awesomeView];
    }
    
    _mainDetailedView.contentSize = CGSizeMake(self.view.frame.size.width , self.view.frame.size.height* numberOfViews);
    _mainDetailedView.pagingEnabled = TRUE;
    _mainDetailedView.alwaysBounceHorizontal = NO;
    _mainDetailedView.bounces = NO;
    _mainDetailedView.delegate = self;
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
