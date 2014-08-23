//
//  MainServiceViewController.m
//  eTIS-Bank
//
//  Created by Rodolphe on 16/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "MainServiceViewController.h"

@interface MainServiceViewController ()

@property (assign, nonatomic) CATransform3D initialTransformation;


@end

@implementation MainServiceViewController

NSArray *tableData;
CGFloat cell_size = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews*100; i++) {
        CGFloat yOrigin = i * 220;
        UIImageView *preview;
        
        if (i%3 == 0)
        {
            preview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Balance PreView"]];
            preview.frame =CGRectMake(0, yOrigin, self.view.frame.size.width, 220);
        }
        else if (i%3 == 1)
        {
            preview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WireTRansfer Preview 2"]];
            preview.frame =CGRectMake(0, yOrigin, self.view.frame.size.width, 220);
        }
        else
        {
            preview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Card Preview"]];
            preview.frame =CGRectMake(0, yOrigin, self.view.frame.size.width, 220);
        }
        
        [_mainDetailedView addSubview:preview];
    }
    
    _mainDetailedView.contentSize = CGSizeMake(self.view.frame.size.width , 220* numberOfViews* 100 );
    _mainDetailedView.pagingEnabled = TRUE;
    _mainDetailedView.alwaysBounceHorizontal = NO;
    _mainDetailedView.bounces = NO;
    _mainDetailedView.delegate = self;
    _mainDetailedView.userInteractionEnabled = false;
    
    _mainServicesList.delegate = self;
    _mainServicesList.dataSource = self;
  //  _mainServicesList.pagingEnabled = true;

    
    tableData = [NSArray arrayWithObjects:@"Account", @"Transfers", @"Credit Cards", nil];
    
    self.title = @"Services";
    
    
    CGFloat rotationAngleDegrees = -15;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(-20, -20);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
    _initialTransformation = transform;
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    
    

}

- (void) viewDidAppear:(BOOL)animated
{
    
    

}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self scrollViewDidScroll:_mainServicesList];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row% [tableData count]];
    cell_size = cell.frame.size.height;
    
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count]* 1000;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    
    if ([scrollView_ isEqual: _mainServicesList])
    {
    CGFloat actualPosition = scrollView_.contentOffset.y;
    CGFloat contentHeight = scrollView_.contentSize.height - ([tableData count]);
        
        
         
    if (actualPosition >= contentHeight) {
        
        [self.mainServicesList reloadData];
        
        }
        CGPoint offset = _mainDetailedView.contentOffset;
        
        offset.y = (_mainServicesList.contentOffset.y * (220/cell_size));
        [_mainDetailedView setContentOffset:(offset)];
        
        
        }
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if(decelerate) return;
    
    [self scrollViewDidEndDecelerating:scrollView];
}


- (void)scrollViewDidEndDecelerating:(UITableView *)scrollView {
    
    
    if ([scrollView isEqual:_mainServicesList])
    {
    [scrollView scrollToRowAtIndexPath:[scrollView indexPathForRowAtPoint: CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+scrollView.rowHeight/2)] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
    if ([scrollView isEqual:_mainServicesList])
    {
        
    if (_mainDetailedView.contentOffset.y <=([tableData count]-1)*220) {
        [_mainDetailedView setContentOffset:CGPointMake(0,([tableData count]+([tableData count]-1))*220)];
    }
    else if (_mainDetailedView.contentOffset.y >=(2*([tableData count]))*220) {
        [_mainDetailedView setContentOffset:CGPointMake(0,([tableData count])*220)];
    }
    }
}

- (void) AutheSelectExit
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row%[tableData count]) == 0)
    {
        UIStoryboard *storyboard =
        [UIStoryboard storyboardWithName:@"Main"
                                  bundle:[NSBundle mainBundle]];
        UIViewController * accountdetails;
        
        accountdetails = [storyboard
                          instantiateViewControllerWithIdentifier:@"AccountDetails"];

        [self.navigationController pushViewController:accountdetails animated:TRUE];
        
        
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
