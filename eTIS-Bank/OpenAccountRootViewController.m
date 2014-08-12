//
//  OpenAccountRootViewController.m
//  eTIS-Bank
//
//  Created by Rodolphe on 10/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "OpenAccountRootViewController.h"

@interface OpenAccountRootViewController ()

@end

@implementation OpenAccountRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createContentPages];

    
    NSDictionary *options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                        forKey: UIPageViewControllerOptionSpineLocationKey];
    
    _pageController = [[UIPageViewController alloc]
                       initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                       navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                       options: options];
    
    _pageController.dataSource = self;
//    [[_pageController view] setFrame:[[self view] bounds]];
     [[_pageController view] setFrame:CGRectMake(0, 120, 320, 320)];
    OpenAccountPresentationViewController *initialViewController =
    [self viewControllerAtIndex:0];
    NSArray *viewControllers =
    [NSArray arrayWithObject:initialViewController];
    
    [_pageController setViewControllers:viewControllers
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    
    
    self.MypageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.MypageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.MypageControl.backgroundColor =[UIColor clearColor];

    [self.view bringSubviewToFront:self.MypageControl];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createContentPages
{
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    for (int i = 1; i < 5; i++)
    {
        NSString *contentString = [[NSString alloc]
                                   initWithFormat:@"AccountOpeningPresentation%d", i];
        [pageStrings addObject:contentString];
    }
    _pageContent = [[NSArray alloc] initWithArray:pageStrings];
}

- (OpenAccountPresentationViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([self.pageContent count] == 0) ||
        (index >= [self.pageContent count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    /*
     ContentViewController *dataViewController =
     [[ContentViewController alloc] init];
     */
    
    UIStoryboard *storyboard =
    [UIStoryboard storyboardWithName:@"Main"
                              bundle:[NSBundle mainBundle]];
    
    OpenAccountPresentationViewController *dataViewController =
    [storyboard
     instantiateViewControllerWithIdentifier:@"OpenAccountPresenationContent"];
    
    dataViewController.dataObject = _pageContent[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(OpenAccountPresentationViewController *)viewController
{
    return [_pageContent indexOfObject:viewController.dataObject];
}


- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerBeforeViewController:
(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        (OpenAccountPresentationViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        (OpenAccountPresentationViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [_pageContent count];
  
    
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return  0;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
