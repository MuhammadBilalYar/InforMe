//
//  AudioTableViewCell.h
//  inforMe
//
//  Created by BSSE on 09/06/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureTableViewCell.h"
@interface AudioTableViewCell : UITableViewCell
@property (nonatomic, retain) id<changePictureProtocol> delegate;
@property (strong ,nonatomic)NSString *audioUrl,*StatusId,*UserId;

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *txtProfileName;
@property (weak, nonatomic) IBOutlet UILabel *txtLocation;
@property (weak, nonatomic) IBOutlet UILabel *txtRemainingTime;
@property (weak, nonatomic) IBOutlet UILabel *txtCategory;
@property (weak, nonatomic) IBOutlet UILabel *txtNotesDetails;

@property (weak, nonatomic) IBOutlet UILabel *txtLike;
@property (weak, nonatomic) IBOutlet UILabel *txtDislike;
@property (weak, nonatomic) IBOutlet UILabel *txtComment;
@property (weak, nonatomic) IBOutlet UILabel *txtReport;
//Commenting Modules
- (IBAction)btnLike:(id)sender;
- (IBAction)btnDislike:(id)sender;
- (IBAction)btnComment:(id)sender;
- (IBAction)btnReport:(id)sender;
@end
