//
//  settingTableViewController.m
//  inforMe
//
//  Created by BSSE on 27/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "settingTableViewController.h"
#import "loginUser.h"
#import "RestAPI.h"
@interface settingTableViewController ()<RestAPIDelegate>{
    loginUser *user;
    BOOL updation;
}
@property(nonatomic,strong) RestAPI *respApi;
@end

@implementation settingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    updation=NO;
    user=[loginUser getUser];
    [self httpPostRequest];
}
-(RestAPI *)respApi{
    if(!_respApi){
        _respApi=[[RestAPI alloc]init];
    }
    return _respApi;
}
-(void) httpPostRequest{
    
    NSString *url=[NSString stringWithFormat:@"http://localhost/inforMe/getSubcribed.php?UserId=%@",user.userId];
    NSURL *requestUrl=[NSURL URLWithString:url];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    
    [request setHTTPMethod:GET];
    
    self.respApi.delegate =self;
    [self.respApi httpRequest:request];
}

-(void)getRecivedData:(NSMutableData *)data sender:(RestAPI *)sender{
    NSError *error=nil;
    NSArray *rData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (updation) {
        [self.tableView reloadData];
    }else{
        [self setUserSubcribetionSetting:rData];
    }
}
-(void)setUserSubcribetionSetting:(NSArray *)Subcribed{
    for (int i=0; i<Subcribed.count; i++) {
        NSDictionary *dic=Subcribed[i];
        if ([dic[@"CategoryId"]isEqualToString:@"1"] && [dic[@"Active"]isEqualToString:@"YES"]) {
            [_txtPicnic setOn:YES];
        }else if([dic[@"CategoryId"]isEqualToString:@"2"] && [dic[@"Active"]isEqualToString:@"YES"]) {
            [_txtFood setOn:YES];
        }else if([dic[@"CategoryId"]isEqualToString:@"3"] && [dic[@"Active"]isEqualToString:@"YES"]) {
            [_txtHospital setOn:YES];
        }else if([dic[@"CategoryId"]isEqualToString:@"4"] && [dic[@"Active"]isEqualToString:@"YES"]) {
            [_txtShopping setOn:YES];
        }else if([dic[@"CategoryId"]isEqualToString:@"5"] && [dic[@"Active"]isEqualToString:@"YES"]) {
            [_txtRestaurents setOn:YES];
        }else if([dic[@"CategoryId"]isEqualToString:@"6"] && [dic[@"Active"]isEqualToString:@"YES"]) {
            [_txtFurniture setOn:YES];
        }else if([dic[@"CategoryId"]isEqualToString:@"7"] && [dic[@"Active"]isEqualToString:@"YES"]) {
            [_txtFashion setOn:YES];
        }else if([dic[@"CategoryId"]isEqualToString:@"8"] && [dic[@"Active"]isEqualToString:@"YES"]) {
            [_txtedu setOn:YES];
        }else if([dic[@"CategoryId"]isEqualToString:@"9"] && [dic[@"Active"]isEqualToString:@"YES"]) {
            [_txtEntertainment setOn:YES];
        }
    }
}
-(void)showAlertMessageInAlertStyle:(NSString *)Title setError:(NSString*)errorMessage{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:Title message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)btnSetting:(id)sender {
    updation=YES;
    NSInteger catId = [sender tag];
    NSString *active=@"NO";
    if ([sender isOn]) {
        active=@"YES";
    }
    NSString *url=[NSString stringWithFormat:@"http://localhost/inforMe/updateSubcribetion.php?UserId=%@&CategoryId=%d&Active=%@",user.userId,(int)catId,active];
    NSURL *requestUrl=[NSURL URLWithString:url];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    
        [request setHTTPMethod:GET];
        updation=YES;
        self.respApi.delegate =self;
        [self.respApi httpRequest:request];
    
}

@end
