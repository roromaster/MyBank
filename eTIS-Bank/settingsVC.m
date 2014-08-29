//
//  settingsVC.m
//  eTIS-Bank
//
//  Created by Rodolphe on 23/08/2014.
//  Copyright (c) 2014 Rodolphe Hugel. All rights reserved.
//

#import "settingsVC.h"
#import "RegisterTutorialVC.h"

@interface settingsVC ()


@end

@implementation settingsVC

NSArray *section_list;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    
    section_list= @[@"Active Auth", @"Server Settings", @"Reset Settings"];
    

    self.navigationController.navigationBar.topItem.title = @"eTIS-Bank Settings";
    self.navigationController.navigationBar.titleTextAttributes = @{NSBackgroundColorAttributeName: [UIColor whiteColor]};

}


- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [section_list count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section_list[section];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    header.contentView.backgroundColor = [UIColor orangeColor];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath*)indexPath
{
   if (indexPath.section != 1) {
        return 44;
    }
   else if (indexPath.section == 1 & indexPath.row == 1) {
        return 100;
    }
    else
        return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 2;
            
        case 2 :
            return 1;
            
        default:
            return 0;
            break;
    }
    
}

- (void) togglePIN:(UISwitch*)sender {
    [[NSUserDefaults standardUserDefaults]
     setBool:sender.on forKey:@"PIN"];
}

- (void) toggleFace:(UISwitch*)sender {
    [[NSUserDefaults standardUserDefaults]
     setBool:sender.on forKey:@"FACE"];
}

- (void) toggleFingerprint:(UISwitch*)sender {
    [[NSUserDefaults standardUserDefaults]
     setBool:sender.on forKey:@"FINGERPRINT"];
}

- (void) toggleTouchID:(UISwitch*)sender {
    [[NSUserDefaults standardUserDefaults]
     setBool:sender.on forKey:@"TOUCHID"];
}

- (void) toggleOnline:(UISwitch*)sender {
    [[NSUserDefaults standardUserDefaults]
     setBool:sender.on forKey:@"ONLINE"];
}

- (void) updateURL: (UITextField*)sender{
    [[NSUserDefaults standardUserDefaults]
     setValue:sender.text forKey:@"SERVICE_URL"];
    
}

- (void) viewTutorialFaceRegister
{
    UIStoryboard *storyboard =
    [UIStoryboard storyboardWithName:@"Main"
                              bundle:[NSBundle mainBundle]];
    
    RegisterTutorialVC *TutorialViewController =[storyboard
                         instantiateViewControllerWithIdentifier:@"RegisterFaceTutorial"];
    
    [self.navigationController pushViewController:TutorialViewController animated:true];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=nil;
    
    switch (indexPath.section) {
        case 0:
        {
            //Active Auth Section
     
            cell = [tableView dequeueReusableCellWithIdentifier:@"option-on-off" forIndexPath:indexPath];
            
            // Configure Cell
            UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
            UISwitch *switch_option = (UISwitch *)[cell.contentView viewWithTag:2];

            switch (indexPath.row) {
                case 0:
                    label.text = @"PIN";
                    [switch_option addTarget:self action:@selector(togglePIN:) forControlEvents:UIControlEventValueChanged];
                    switch_option.on = [[NSUserDefaults standardUserDefaults] boolForKey:
                                   @"PIN"];
                    break;
                    
                case 1:
                    
                    label.text = @"Face";
                    [switch_option addTarget:self action:@selector(toggleFace:) forControlEvents:UIControlEventValueChanged];
                    switch_option.on = [[NSUserDefaults standardUserDefaults] boolForKey:
                                        @"FACE"];

                    
                    break;
                    
                    
                case 2:
                    
                    label.text = @"Fingerprint";
                    [switch_option addTarget:self action:@selector(toggleFingerprint:) forControlEvents:UIControlEventValueChanged];
                    switch_option.on = [[NSUserDefaults standardUserDefaults] boolForKey:
                                        @"FINGERPRINT"];
                    

                    break;
                    
                case 3:
                    
                    label.text = @"TouchID";
                  
                    [switch_option addTarget:self action:@selector(toggleTouchID:) forControlEvents:UIControlEventValueChanged];
                    switch_option.on = [[NSUserDefaults standardUserDefaults] boolForKey:
                                        @"TOUCHID"];
                    
                      break;
                    

                    default:
                    cell = nil;
                    break;
            }
            
            break;
        }
            
        case 1:
        {
            
            switch (indexPath.row) {
                case 0:
                {
    
                    cell = [tableView dequeueReusableCellWithIdentifier:@"option-on-off" forIndexPath:indexPath];
                    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
                    UISwitch *switch_option = (UISwitch *)[cell.contentView viewWithTag:2];
                    label.text = @"Online mode";
                    [switch_option addTarget:self action:@selector(toggleOnline:) forControlEvents:UIControlEventValueChanged];
                    switch_option.on = [[NSUserDefaults standardUserDefaults] boolForKey:
                                        @"ONLINE"];
                    break;
                }
                    
                case 1:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"enter-url" forIndexPath:indexPath];
                    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
                    UITextField *url = (UITextField *)[cell.contentView viewWithTag:2];
                    label.text = @"Server URL";
                
                    url.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"SERVICE_URL"];
                    [url addTarget:self action:@selector(updateURL:) forControlEvents:UIControlEventEditingDidEnd|UIControlEventEditingDidEndOnExit];
                    
                    break;
                }
            }
            break;
            
        }
            
        case 2:
        {
            
            switch (indexPath.row) {
                case 0:
                {
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:@"Reset" forIndexPath:indexPath];
                    UILabel *label = (UILabel *)[cell.contentView viewWithTag:2];
                    UIButton *register_tutorial_button = (UIButton *)[cell.contentView viewWithTag:1];
                    
                    label.text = @"Face Tutorial";
                    [register_tutorial_button addTarget:self action:@selector(viewTutorialFaceRegister) forControlEvents:UIControlEventTouchUpInside];
                    
                    [register_tutorial_button setTitle:@"View" forState:UIControlStateNormal];
                    break;
                }
                    
            }
            
        }

            
        default:
            break;
    }
    // Configure the cell...
    
    if (cell == nil)
        cell = [tableView dequeueReusableCellWithIdentifier:@"option-on-off" forIndexPath:indexPath];
    
    
    return cell;
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
