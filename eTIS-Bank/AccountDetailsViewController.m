//
//  AccountDetailsTableViewController.m
//  eTIS-Bank
//
//  Created by Rodolphe on 18/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "AccountDetailsViewController.h"

@interface AccountDetailsViewController ()

@end


NSArray *transactionList;

@implementation AccountDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    transactionList = @[
                        @[ @"01/01/14", @"FNAC.COM", @"+120.49 €",@"logo-fnac.png" ],
                        @[ @"01/02/14", @"Amazon SA", @"+120.49 €" ,@"amazon.png"],
                        @[ @"01/03/14", @"EDF", @"-160 €",@"Logo_Edf.png" ],
                        @[ @"01/04/14", @"Bank of America SubPrime", @"-34 120.49 €",@"bank-of-america-logo.png" ],
                        @[ @"01/05/14", @"Morpho", @"+5 680 €",@"morpho-logo.jpeg" ],
                        @[ @"01/01/14", @"FNAC.COM", @"+120.49 €",@"logo-fnac.png" ],
                        @[ @"01/02/14", @"Amazon SA", @"+120.49 €" ,@"amazon.png"],
                        @[ @"01/03/14", @"EDF", @"-160 €",@"Logo_Edf.png" ],
                        @[ @"01/04/14", @"Bank of America SubPrime", @"-34 120.49 €",@"bank-of-america-logo.png" ],
                        @[ @"01/05/14", @"Morpho", @"+5 680 €",@"morpho-logo.jpeg" ],
                        @[ @"01/01/14", @"FNAC.COM", @"+120.49 €",@"logo-fnac.png" ],
                        @[ @"01/02/14", @"Amazon SA", @"+120.49 €" ,@"amazon.png"],
                        @[ @"01/03/14", @"EDF", @"-160 €",@"Logo_Edf.png" ],
                        @[ @"01/04/14", @"Bank of America SubPrime", @"-34 120.49 €",@"bank-of-america-logo.png" ],
                        @[ @"01/05/14", @"Morpho", @"+5 680 €",@"morpho-logo.jpeg" ],
                        @[ @"01/01/14", @"FNAC.COM", @"+120.49 €",@"logo-fnac.png" ],
                        @[ @"01/02/14", @"Amazon SA", @"+120.49 €" ,@"amazon.png"],
                        @[ @"01/03/14", @"EDF", @"-160 €",@"Logo_Edf.png" ],
                        @[ @"01/04/14", @"Bank of America SubPrime", @"-34 120.49 €",@"bank-of-america-logo.png" ],
                        @[ @"01/05/14", @"Morpho", @"+5 680 €",@"morpho-logo.jpeg" ],

];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [transactionList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    
    if (indexPath.row % 2)
        cell = [tableView dequeueReusableCellWithIdentifier:@"OperationDetail1"];
    else
         cell = [tableView dequeueReusableCellWithIdentifier:@"OperationDetail2"];
    
    // Configure Cell
    UILabel *date = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *operationLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *operationAmount = (UILabel *)[cell.contentView viewWithTag:3];
    
    NSString *dateString = [[transactionList objectAtIndex:indexPath.row] objectAtIndex:0];
    NSString *operationString = [[transactionList objectAtIndex:indexPath.row] objectAtIndex:1];
    NSString *amountString = [[transactionList objectAtIndex:indexPath.row] objectAtIndex:2];
   
    if ([amountString hasPrefix:@"-"])
        [operationAmount setTextColor:[UIColor redColor]];
    else
      [operationAmount setTextColor:[[UIColor alloc] initWithRed:0.2 green:0.8 blue:0.2 alpha:1]];
    
    date.text = dateString;
    operationLabel.text = operationString;
    operationAmount.text = amountString;
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure Cell

    
    NSString *dateString = [[transactionList objectAtIndex:indexPath.row] objectAtIndex:0];
    NSString *operationString = [[transactionList objectAtIndex:indexPath.row] objectAtIndex:1];
    NSString *amountString = [[transactionList objectAtIndex:indexPath.row] objectAtIndex:2];
    NSString *operationImageString =[[transactionList objectAtIndex:indexPath.row] objectAtIndex:3];
    
    
    if ([amountString hasPrefix:@"-"])
        [_operationDetailAmount setTextColor:[UIColor redColor]];
    else
        [_operationDetailAmount setTextColor:[UIColor greenColor]];
    
    _operationDetailsDate.text = dateString;
    _operationDetailLabel.text = operationString;
    _operationDetailAmount.text = amountString;
    _operationDetailImage.image = [UIImage imageNamed:operationImageString];
    
    
    CALayer *layer = _operationDetailsView.layer;
    [layer pop_removeAllAnimations];
    
    POPSpringAnimation *xAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    POPSpringAnimation *sizeAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    
    xAnim.fromValue = @(320);
    xAnim.springBounciness = 15;
    xAnim.springSpeed = 10;
    
    sizeAnim.fromValue = [NSValue valueWithCGSize:CGSizeMake(64, 114)];
    
    xAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        NSLog(@"Working");
    };
    
    [layer pop_addAnimation:xAnim forKey:@"position"];
    [layer pop_addAnimation:sizeAnim forKey:@"size"];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
