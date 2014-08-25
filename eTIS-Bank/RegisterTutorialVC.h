//
//  RegisterTutorialVC.h
//  eTIS-Bank
//
//  Created by Rodolphe on 25/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTutorialVC : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *tutorialpagecontrol;
@property (weak, nonatomic) IBOutlet UIScrollView *tutorialScrollView;

@property (weak, nonatomic) IBOutlet UILabel *tutorialHInt;


@end
