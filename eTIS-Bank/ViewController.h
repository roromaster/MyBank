//
//  ViewController.h
//  eTIS-Bank
//
//  Created by Rodolphe on 10/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate,UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

- (IBAction)settingPushed:(UIButton *)sender;

@end
UINavigationController *navigationController;