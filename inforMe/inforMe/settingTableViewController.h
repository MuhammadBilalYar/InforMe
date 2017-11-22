//
//  settingTableViewController.h
//  inforMe
//
//  Created by BSSE on 27/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settingTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISwitch *txtedu;
@property (weak, nonatomic) IBOutlet UISwitch *txtFood;
@property (weak, nonatomic) IBOutlet UISwitch *txtFurniture;
@property (weak, nonatomic) IBOutlet UISwitch *txtHospital;
@property (weak, nonatomic) IBOutlet UISwitch *txtPicnic;
@property (weak, nonatomic) IBOutlet UISwitch *txtShopping;
@property (weak, nonatomic) IBOutlet UISwitch *txtRestaurents;
@property (weak, nonatomic) IBOutlet UISwitch *txtFashion;
@property (weak, nonatomic) IBOutlet UISwitch *txtEntertainment;



- (IBAction)btnSetting:(id)sender;

@end
