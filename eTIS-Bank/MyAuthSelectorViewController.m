//
//  MyAuthSelectorViewController.m
//  eTIS-Bank
//
//  Created by Rodolphe on 13/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "MyAuthSelectorViewController.h"

@interface MyAuthSelectorViewController ()

@end

@implementation MyAuthSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login Background.png"]];
    
    [background sizeToFit];
    [background setFrame:self.view.frame];
    [background setBounds:self.view.bounds];
    
//    [[self view] setBackgroundColor:[[UIColor alloc] initWithPatternImage:background.image]];
//    [[self view] setBackgroundColor:[UIColor clearColor]];
   

    UIStoryboard *storyboard =
    [UIStoryboard storyboardWithName:@"Main"
                              bundle:[NSBundle mainBundle]];
    PinViewController = [storyboard
                         instantiateViewControllerWithIdentifier:@"PinPadAuth"];
    
    FaceViewController =[storyboard
                         instantiateViewControllerWithIdentifier:@"FaceAuth"];
    
    [PinViewController view];
    [FaceViewController view];
    
    
    [self.view addSubview:background];

    background.layer.zPosition = -1;
    
    NSLog(@"view controllers instantiated");
    
    self.dataSource = self;
    
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:PinViewController, nil];
    
    
    [self setViewControllers:viewControllers
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:YES
                             completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    
    if (index == 0)
        return PinViewController;
    else if (index == 1)
        return FaceViewController;
    else
        return nil;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    if (viewController == PinViewController)
        return 0;
    else if (viewController == FaceViewController)
        return 1;
    else return 0;
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerBeforeViewController:
(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    NSLog(@"After - Index:%i",index);
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        viewController];
    if (index == NSNotFound) {
        return nil;
    }
    NSLog(@"After - Index:%i",index);
    index++;
    
    return [self viewControllerAtIndex:index];
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
