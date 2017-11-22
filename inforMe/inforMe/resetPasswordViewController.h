//
//  resetPasswordViewController.h
//  inforMe
//
//  Created by BSSE on 29/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface resetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtemail;

@property (weak, nonatomic) IBOutlet UIView *customeUIView;
- (IBAction)btnResetPassword:(id)sender;
- (IBAction)btnClose:(id)sender;
@end
