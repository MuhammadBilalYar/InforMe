//
//  signUpViewController.h
//  inforMe
//
//  Created by BSSE on 29/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface signUpViewController : UIViewController<UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *customUIView;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIImageView *txtImageView;
- (IBAction)btnClose:(id)sender;

- (IBAction)btnSelectImage:(id)sender;

- (IBAction)btnSignUp:(id)sender;

@end
