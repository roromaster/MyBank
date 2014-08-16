//
//  MyAuthSelectorViewController.h
//  eTIS-Bank
//
//  Created by Rodolphe on 13/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFaceAuthViewController.h"
#import "MyPinAuthViewController.h"

@interface MyAuthSelectorViewController : UIPageViewController<UIPageViewControllerDataSource, UINavigationBarDelegate>
{

    MyPinAuthViewController *PinViewController;
    MyFaceAuthViewController *FaceViewController;
    UIButton *BackButton;
    
}
@end
