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
    
    
    authListVC = [[NSMutableArray alloc]init];

    // Do any additional setup after loading the view.
    
    faceEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:
                    @"FACE"];
    
    pinEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:
                   @"PIN"];
    
    touchIDEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:
                       @"TOUCHID"];
    fingersEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:
                      @"FINGERPRINT"];
    
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
    
    touchIDViewController = [storyboard instantiateViewControllerWithIdentifier:@"touchIDAuth"];
    
    fingersViewController = [storyboard instantiateViewControllerWithIdentifier:@"FingerprintAuth"];
    
    if (pinEnabled)
    {
        [authListVC addObject:PinViewController];
    }
    if (faceEnabled)
    {
        [authListVC addObject:FaceViewController];
         [FaceViewController view];
    }
    if (touchIDEnabled)
    {
        [authListVC addObject:touchIDViewController];
    }
    if (fingersEnabled)
    {
        [authListVC addObject:fingersViewController];
        [fingersViewController view ];
    }
    
    
    [self.view addSubview:background];

    background.layer.zPosition = -1;
    
    NSLog(@"view controllers instantiated");
    
    self.dataSource = self;

    
   

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:authListVC[0], nil];
    

    [self setViewControllers:viewControllers
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:animated
                  completion:nil];
    
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
    
    if (index >= [authListVC count])
        return nil;
    else
        return authListVC[index];
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    int i=0;
    for (UIViewController *controler in authListVC) {
        if (controler == viewController)
            return i;
        i++;
    }
    return 0;
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
    NSLog(@"After - Index:%lu",(unsigned long)index);
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
    NSLog(@"After - Index:%lu",(unsigned long)index);
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
