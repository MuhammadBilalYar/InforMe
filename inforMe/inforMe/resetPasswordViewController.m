//
//  resetPasswordViewController.m
//  inforMe
//
//  Created by BSSE on 29/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "resetPasswordViewController.h"

@interface resetPasswordViewController ()

@end

@implementation resetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customeUIView.layer.cornerRadius=20.0f;
    self.customeUIView.clipsToBounds=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnResetPassword:(id)sender {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Information" message:@"Email send successfully.\n For login use password in email." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *act){}];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)btnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
