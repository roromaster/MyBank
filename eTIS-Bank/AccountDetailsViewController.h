//
//  AccountDetailsTableViewController.h
//  eTIS-Bank
//
//  Created by Rodolphe on 18/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Pop/POP.h>

@interface AccountDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *operationDetailsView;
@property (weak, nonatomic) IBOutlet UILabel *operationDetailsDate;
@property (weak, nonatomic) IBOutlet UIImageView *operationDetailImage;
@property (weak, nonatomic) IBOutlet UILabel *operationDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *operationDetailAmount;

@end
