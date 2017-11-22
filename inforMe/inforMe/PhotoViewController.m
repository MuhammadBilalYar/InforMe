//
//  PhotoViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "PhotoViewController.h"
#import "SWRevealViewController.h"
#import "addNotesViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface PhotoViewController ()
{
    NSString *imgurl;
}
@end

@implementation PhotoViewController{
    UIImageView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_multimediaType isEqualToString:@"Photo"]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0,100.0,325.0,325.0)];
        [self.view addSubview:imageView];
    }
    [_btnTake setTitle:[NSString stringWithFormat:@"Take %@",_multimediaType ] forState:UIControlStateNormal];
    [_btnSelect setTitle:[NSString stringWithFormat:@"Select %@",_multimediaType ] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectPhoto:(id)sender {
    if ([_multimediaType isEqualToString:@"Audio"]) {
        [self showAlertMessageInAlertStyle:@"WARNING" setError:@"Simulater don't have Audio files"];
    }else if ([_multimediaType isEqualToString:@"Video"]) {
         [self showAlertMessageInAlertStyle:@"WARNING" setError:@"Simulater don't have Video files"];
    }else{
    UIImagePickerController *selectpic= [[UIImagePickerController alloc]init];
    selectpic.delegate=self;
    selectpic.allowsEditing=YES;
    selectpic.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:selectpic animated:YES completion:nil];
    }
}

- (IBAction)takePicture:(id)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

        //Display Error in Alert view
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Camera ERROR" message:@"Sorry your simulater don't have camera" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
    else{
    UIImagePickerController *takePhoto=[[UIImagePickerController alloc]init];
    takePhoto.delegate=self;
    takePhoto.allowsEditing=YES;
    takePhoto.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:takePhoto animated:YES completion:nil];
    }
}

- (IBAction)btnDone:(id)sender {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedFile" object:imgurl];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *choseImage=info[UIImagePickerControllerEditedImage];
    imageView.image=choseImage;

    [self dismissViewControllerAnimated:YES completion:nil];
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        imgurl= [imageRep filename];
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];

}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)showAlertMessageInAlertStyle:(NSString *)Title setError:(NSString*)errorMessage{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:Title message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end