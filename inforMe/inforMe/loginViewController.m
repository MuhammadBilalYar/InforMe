//
//  loginViewController.m
//  inforMe
//
//  Created by BSSE on 29/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "loginViewController.h"
#import "RestAPI.h"
#import "loginUser.h"
@interface loginViewController ()<RestAPIDelegate>
@property(nonatomic,strong) RestAPI *respApi;
@end

@implementation loginViewController

-(RestAPI *)respApi{
    if(!_respApi){
        _respApi=[[RestAPI alloc]init];
    }
    return _respApi;
}
-(void)viewDidLoad{
    [super loadView];
    self.CustomeUIView.layer.cornerRadius=20.0f;
    self.CustomeUIView.clipsToBounds=YES;
}
-(void) httpGetRequest{
    NSString* paramete=[NSString stringWithFormat:@"?email=%@&password=%@",_txtEmail.text,_txtPassword.text];
    NSString *url=[NSString stringWithFormat:@"http://localhost/inforMe/signin.php%@",paramete];
    NSURL *requestUrl=[NSURL URLWithString:url];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    
    [request setHTTPMethod:GET];
    self.respApi.delegate =self;
    [self.respApi httpRequest:request];
}

-(void) httpPostRequest{
    NSString* paramete=[NSString stringWithFormat:@"email=%@&password=%@",_txtEmail.text,_txtPassword.text];
    NSString *url=@"http://localhost/inforMe/signin.php";
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
    NSArray *reciveData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    loginUser *user=[[loginUser alloc]init];
    if (reciveData.count>0) {
        NSDictionary *obj=[reciveData objectAtIndex:0];
        user.firstName=[obj objectForKey:@"FirstName"];
        user.lastName=[obj objectForKey:@"LastName"];
        user.email=[obj objectForKey:@"Email"];
        user.imageUrl=[obj objectForKey:@"ImageUrl"];
        user.password=[obj objectForKey:@"Password"];
        user.userId=[obj objectForKey:@"UserId"];
    }
    [loginUser setUser:user];
    [self userAuthuntication];
    
}
- (IBAction)btnLogin:(id)sender {
    [self httpPostRequest];
}

- (void) userAuthuntication{
    loginUser *user= [loginUser getUser];
    if (user!=nil && [user.email isEqualToString:_txtEmail.text]&&[user.password isEqualToString:_txtPassword.text]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"Home"];
        [self presentViewController:ivc animated:NO completion:nil];
    }
    else{
        [self showAlertMessageInAlertStyle:@"ERROR" setError:@"Username or password incorrect"];
    }
}
-(void)showAlertMessageInAlertStyle:(NSString *)Title setError:(NSString*)errorMessage{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:Title message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
