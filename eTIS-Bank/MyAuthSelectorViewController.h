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
#import "MyTouchIDAuthVC.h"
#import "MyFingerprintAuthVC.h"



@interface MyAuthSelectorViewController : UIPageViewController<UIPageViewControllerDataSource>
{

    BOOL pinEnabled;
    BOOL faceEnabled;
    BOOL touchIDEnabled;
    BOOL fingersEnabled;
    MyPinAuthViewController *PinViewController;
    MyFaceAuthViewController *FaceViewController;
    MyTouchIDAuthVC *touchIDViewController;
    MyFingerprintAuthVC *fingersViewController;
    
    NSMutableArray *authListVC;

}
@end

