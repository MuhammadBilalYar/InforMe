//
//  MainViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface addNotesViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,CLLocationManagerDelegate>{
    NSMutableArray *catogryArry;
    NSMutableArray *catogryId;
}
//for Location
@property(nonatomic,strong)CLLocationManager *locationManager;
//for Notes
@property (weak, nonatomic) IBOutlet UILabel *txtSelectedFile;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITextView *txtNotesDetails;
@property (weak, nonatomic) IBOutlet UIButton *imgUserProfile;

@property (weak, nonatomic) IBOutlet UIButton *imgAnomyous;

@property (weak, nonatomic) IBOutlet UIPickerView *myPicker;
@property (weak, nonatomic) IBOutlet UILabel *txtAddress;
@property (weak, nonatomic) IBOutlet UILabel *txtlongitude;
@property (weak, nonatomic) IBOutlet UILabel *txtlatitude;
@property (weak, nonatomic) IBOutlet UILabel *txtPostAs;
- (IBAction)btnAnonymous:(id)sender;
- (IBAction)btnAddNotesAsUser:(id)sender;

@end
