//
//  signUpViewController.m
//  inforMe
//
//  Created by BSSE on 29/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "signUpViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RestAPI.h"
@interface signUpViewController ()<RestAPIDelegate>
{
    NSString *imgurl;
}
@property(nonatomic,strong) RestAPI *respApi;
@end

@implementation signUpViewController

-(RestAPI *)respApi{
    if(!_respApi){
        _respApi=[[RestAPI alloc]init];
    }
    return _respApi;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customUIView.layer.cornerRadius=20.0f;
    self.customUIView.clipsToBounds=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnSelectImage:(id)sender {
    UIImagePickerController *selectpic= [[UIImagePickerController alloc]init];
    selectpic.delegate=self;
    selectpic.allowsEditing=YES;
    selectpic.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:selectpic animated:YES completion:nil];

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *choseImage=info[UIImagePickerControllerEditedImage];
    self.txtImageView.image=choseImage;
    self.txtImageView.layer.cornerRadius=self.txtImageView.frame.size.width/2;
    self.txtImageView.clipsToBounds=YES;
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
- (IBAction)btnSignUp:(id)sender {
    if ([self validation]) {
        [self httpPostRequest];
    }else{
        [self showAlertMessageInAlertStyle:@"Validation" setError:@"Some fields are empty"];
    }
}
- (BOOL) validation{
    if ([_txtFirstName.text isEqualToString:@""] || [_txtLastName.text isEqualToString:@""] || [_txtEmail.text isEqualToString:@""]||[_txtPassword.text isEqualToString:@""]|| (imgurl ==nil)) {
        return false;
    }
    return true;
}
-(void)showAlertMessageInAlertStyle:(NSString *)Title setError:(NSString*)errorMessage{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:Title message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void) httpPostRequest{
    NSString* paramete=[NSString stringWithFormat:@"firstName=%@&lastName=%@&email=%@&password=%@&img=%@",_txtFirstName.text,_txtLastName.text,_txtEmail.text,_txtPassword.text,imgurl];
    NSString *url=@"http://localhost/inforMe/signup.php";
    NSURL *requestUrl=[NSURL URLWithString:url];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    
    [request setHTTPMethod:POST];
    [request setHTTPBody:[paramete dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.respApi.delegate =self;
    [self.respApi httpRequest:request];
}
//Method Custom Protocol

-(void)getRecivedData:(NSMutableData *)data sender:(RestAPI *)sender{
    NSError *error=nil;
    NSDictionary *reciveData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    _txtFirstName.text=@"";
    _txtLastName.text=@"";
    _txtEmail.text=@"";
    _txtPassword.text=@"";
    imgurl=@"";
    [self showAlertMessageInAlertStyle:@"Information" setError:[reciveData objectForKey:@"Message"]];
    
}
/*
- (void)sendImageToServer {
    UIImage *yourImage= [UIImage imageNamed:@"notes.jpg"];
    NSData *imageData = UIImagePNGRepresentation(yourImage);
    NSString *postLength = [NSString stringWithFormat:@"%d", [imageData length]];
    
    // Init the URLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:[NSString stringWithString:@"http://localhost/"]]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:imageData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        // response data of the request
    }
}*/
@end
