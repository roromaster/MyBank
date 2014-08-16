//
//  MainServiceViewController.m
//  eTIS-Bank
//
//  Created by Rodolphe on 16/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "MainServiceViewController.h"

@interface MainServiceViewController ()

@end

@implementation MainServiceViewController

 NSArray *tableData;
CGFloat cell_size = 0;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews*100; i++) {
        CGFloat yOrigin = i * 200;
        UIImageView *preview;
        
        if (i%3 == 0)
        {
            preview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Balance PreView"]];
            preview.frame =CGRectMake(0, yOrigin, self.view.frame.size.width, 200);
            
        }
        else if (i%3 == 1)
        {
            preview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WireTRansfer Preview 2"]];
            preview.frame =CGRectMake(0, yOrigin, self.view.frame.size.width, 200);
            

        }
        else
        {
            preview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Balance PreView"]];
            preview.frame =CGRectMake(0, yOrigin, self.view.frame.size.width, 200);

        }
        
        [_mainDetailedView addSubview:preview];
    }
    
    _mainDetailedView.contentSize = CGSizeMake(self.view.frame.size.width , 200* numberOfViews* 100 );
    _mainDetailedView.pagingEnabled = TRUE;
    _mainDetailedView.alwaysBounceHorizontal = NO;
    _mainDetailedView.bounces = NO;
    _mainDetailedView.delegate = self;
    _mainDetailedView.userInteractionEnabled = false;
    
    _mainServicesList.delegate = self;
    _mainServicesList.dataSource = self;
  //  _mainServicesList.pagingEnabled = true;



    
    tableData = [NSArray arrayWithObjects:@"Account", @"Transfers", @"Credit Cards", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        offset.y = (_mainServicesList.contentOffset.y * (200/cell_size));
        [_mainDetailedView setContentOffset:(offset)];
    
        }
    
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
    if (_mainDetailedView.contentOffset.y <=([tableData count]-1)*200) {
        [_mainDetailedView setContentOffset:CGPointMake(0,([tableData count]+([tableData count]-1))*200)];
    }
    else if (_mainDetailedView.contentOffset.y >=(2*([tableData count]))*200) {
        [_mainDetailedView setContentOffset:CGPointMake(0,([tableData count])*200)];
    }
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
