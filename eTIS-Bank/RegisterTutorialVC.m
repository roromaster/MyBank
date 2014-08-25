//
//  RegisterTutorialVC.m
//  eTIS-Bank
//
//  Created by Rodolphe on 25/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "RegisterTutorialVC.h"

@interface RegisterTutorialVC ()



@end

@implementation RegisterTutorialVC

NSArray *labelArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Load Tutorial Images
   
    for (int i=1; i < 5; i++) {
        
        float xOrigin = (i-1)* _tutorialScrollView.frame.size.width;
        
        UIImageView *tutorialImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"AccountOpeningPresentation%i",i]]];
        
         tutorialImage.frame =CGRectMake(xOrigin, self.view.frame.origin.y, _tutorialScrollView.frame.size.width, _tutorialScrollView.frame.size.height);
        
        [_tutorialScrollView addSubview:tutorialImage];
    }

    _tutorialScrollView.contentSize = CGSizeMake(_tutorialScrollView.frame.size.width * 4, _tutorialScrollView.frame.size.height);
    _tutorialScrollView.pagingEnabled = TRUE;
    _tutorialScrollView.delegate = self;
    _tutorialScrollView.userInteractionEnabled = true;
    
    //Load page control

    _tutorialpagecontrol.numberOfPages = 4;
    
    labelArray = [NSArray arrayWithObjects:@"Keep your Face steady in front of the camera",@"Make sure the lighening is suitable (not to bright not to dark)",@"Keep a neutral expression (no smile, eyes open)",@"Don't move your face or the phone during the process", nil];
    
    _tutorialHInt.text = labelArray[0];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    
        CGFloat actualPosition = scrollView_.contentOffset.x;
    
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{ _tutorialpagecontrol.currentPage = actualPosition/self.view.frame.size.width;} completion:nil];
    
    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations: ^{ _tutorialHInt.text = labelArray[@(actualPosition/self.view.frame.size.width).intValue];} completion:nil];
    

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
