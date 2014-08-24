//
//  faceRegisterVC.h
//  eTIS-Bank
//
//  Created by Rodolphe on 23/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface faceRegisterVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *registerProgressionImage;
@property (weak, nonatomic) IBOutlet UIImageView *faceOverlay;
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIImageView *scanningBar;

@end
