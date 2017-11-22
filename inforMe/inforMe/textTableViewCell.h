//
//  textTableViewCell.h
//  inforMe
//
//  Created by BSSE on 28/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureTableViewCell.h"
@interface textTableViewCell : UITableViewCell
@property (nonatomic, retain) id<changePictureProtocol> delegate;
@property (strong,nonatomic)NSString *StatusId,*UserId;
@property (weak, nonatomic) IBOutlet UIImageView *imgUserProfile;
@property (weak, nonatomic) IBOutlet UILabel *txtUserName;
@property (weak, nonatomic) IBOutlet UILabel *txtLocation;
@property (weak, nonatomic) IBOutlet UILabel *txtRemainingTime;
@property (weak, nonatomic) IBOutlet UILabel *txtCategory;
@property (weak, nonatomic) IBOutlet UILabel *txtNotesText;

@property (weak, nonatomic) IBOutlet UILabel *btnLike;
@property (weak, nonatomic) IBOutlet UILabel *btnDislike;
@property (weak, nonatomic) IBOutlet UILabel *btnComment;
@property (weak, nonatomic) IBOutlet UILabel *btnReport;

- (IBAction)btnLike:(id)sender;
- (IBAction)btnDislike:(id)sender;
- (IBAction)btnComment:(id)sender;
- (IBAction)btnReport:(id)sender;

@end
