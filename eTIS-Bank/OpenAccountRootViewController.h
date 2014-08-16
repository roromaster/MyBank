//
//  OpenAccountRootViewController.h
//  eTIS-Bank
//
//  Created by Rodolphe on 10/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenAccountPresentationViewController.h"

@interface OpenAccountRootViewController : UIViewController<UIPageViewControllerDataSource>
{
    UIButton *BackButton;
}

@property (strong, nonatomic) NSArray *pageContent;
@property (strong, nonatomic) UIPageViewController *pageController;

@property (weak, nonatomic) IBOutlet UIPageControl *MypageControl;



@end
