//
//  PhotoViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate ,UINavigationControllerDelegate>


- (IBAction)selectPhoto:(id)sender;
- (IBAction)takePicture:(id)sender;

- (IBAction)btnDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnTake;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (strong) NSString *multimediaType;
@end
