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
   

    UIStoryboard *storyboard =
    [UIStoryboard storyboardWithName:@"Main"
                              bundle:[NSBundle mainBundle]];
    PinViewController = [storyboard
                         instantiateViewControllerWithIdentifier:@"PinPadAuth"];
    
    FaceViewController =[storyboard
                         instantiateViewControllerWithIdentifier:@"FaceAuth"];
    
    
    [self.view addSubview:background];

    background.layer.zPosition = -1;
    
    BackButton = [[UIButton alloc] initWithFrame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 50, 60, 60)];
    
    [BackButton setTitle:@"Back" forState:nil];
    [BackButton addTarget:self
                 action:@selector(AutheSelectExit)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:BackButton];
    
    //Make the Navigation Bar Translucent
    
    NSLog(@"view controllers instantiated");
    
    self.dataSource = self;
    
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:PinViewController, nil];
    
    
    [self setViewControllers:viewControllers
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:YES
                             completion:nil];

        [PinViewController view];
        [FaceViewController view];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}


- (void) AutheSelectExit
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
    NSLog(@"%s", __FUNCTION__);
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    NSLog(@"%s", __FUNCTION__);
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
