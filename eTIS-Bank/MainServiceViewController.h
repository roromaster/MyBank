//
//  MainServiceViewController.h
//  eTIS-Bank
//
//  Created by Rodolphe on 16/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainServiceViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UIButton *BackButton;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainDetailedView;
@property (weak, nonatomic) IBOutlet UITableView *mainServicesList;

@end
