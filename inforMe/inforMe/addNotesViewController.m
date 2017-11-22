//
//  MainViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "addNotesViewController.h"
#import "SWRevealViewController.h"
#import "PhotoViewController.h"
#import "loginUser.h"
#import "RestAPI.h"
@interface addNotesViewController ()<RestAPIDelegate>{
    NSString *selectedCategory,*mainUrl;
    CLGeocoder *coder;
    CLPlacemark *placeMark;
    BOOL audio,image,video;
}
@property(nonatomic,strong) RestAPI *respApi;
@end

@implementation addNotesViewController
-(RestAPI *)respApi{
    if(!_respApi){
        _respApi=[[RestAPI alloc]init];
    }
    return _respApi;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    image=audio=video=NO;
    [self getCurrentLocation];
    coder =[[CLGeocoder alloc]init];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.title = @"Pin Notes";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"selectedFile" object:nil];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //add Notes Text area border
    self.txtNotesDetails.layer.borderWidth = 1.0f;
    self.txtNotesDetails.layer.borderColor = [[UIColor grayColor] CGColor];
    self.txtNotesDetails.layer.cornerRadius=10;
    self.txtNotesDetails.clipsToBounds=YES;
    
    
    loginUser *user=[loginUser getUser];
    self.imgUserProfile.layer.cornerRadius=self.imgUserProfile.frame.size.width/2;
    self.imgUserProfile.clipsToBounds=YES;
    [self.imgUserProfile setBackgroundImage:[UIImage imageNamed:user.imageUrl] forState:UIControlStateNormal];
    self.imgAnomyous.layer.cornerRadius=self.imgAnomyous.frame.size.width/2;
    self.imgAnomyous.clipsToBounds=YES;
    self.txtPostAs.text=[NSString stringWithFormat:@"Post as %@ %@ or anonymous",user.firstName,user.lastName];
    
    //Category Picker
    catogryArry=[[NSMutableArray alloc]initWithObjects:@"Education",@"Entertainment",@"Fashion",@"Food",@"Furniture",@"Hospital",@"Picknic Point",@"Restaurents",@"Shopping Mall", nil];
    catogryId=[[NSMutableArray alloc]initWithObjects:@"8", @"9", @"7", @"2",@"6", @"3",@"1", @"5", @"4", nil];
    _myPicker.delegate=self;
}
-(void)dataReceived:(NSNotification *)noti
{
    _txtSelectedFile.text=noti.object;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  [catogryArry count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedCategory=[catogryId objectAtIndex:row];
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [catogryArry objectAtIndex:row];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PhotoViewController *destViewController = segue.destinationViewController;
    if ([[segue identifier] isEqualToString:@"Photo"]) {
        image=YES;
        audio=NO;
        video=NO;
        destViewController.multimediaType=@"Photo";
    }else if([[segue identifier] isEqualToString:@"Audio"]){
        image=NO;
        audio=YES;
        video=NO;
        destViewController.multimediaType=@"Audio";
    }else{
        image=NO;
        audio=NO;
        video=YES;
        destViewController.multimediaType=@"Video";
    }
}
//Get Current Location
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
-(void)getCurrentLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self showAlertMessageInAlertStyle:@"Error" setError:error.description];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        _txtlongitude.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        _txtlatitude.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        [coder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error ==nil && placemarks.count>0) {
                placeMark=[placemarks lastObject];
                NSString *add=[NSString stringWithFormat:@"%@ %@ \n %@ %@\n%@\n%@",placeMark.subThoroughfare,placeMark.thoroughfare,placeMark.postalCode,placeMark.locality,placeMark.administrativeArea,placeMark.country];
                //_txtAddress.text=add;
            }
            else{
                NSLog(@"%@",error.debugDescription);
            }
        }];
    }
}
-(void)showAlertMessageInAlertStyle:(NSString *)Title setError:(NSString*)errorMessage{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:Title message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//Post Data To PHP SERVER
-(void) httpPostRequest{
    //Location
    NSString *location=[NSString stringWithFormat:@"Latitude=%@&Longitude=%@&Address=%@",_txtlatitude.text,_txtlongitude.text,_txtAddress.text];
    
    //current Time
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    NSString *date=[dateFormatter stringFromDate:[NSDate date]];
    
    //Notes
    NSString* paramete;
    if (image) {
        paramete=[NSString stringWithFormat:@"StatusText=%@&UpdatingTime=%@&CategoryId=%@&ImageUrl=%@&AudioUrl=&VideoUrl=",_txtNotesDetails.text,date,selectedCategory,_txtSelectedFile.text];
    }else if (audio){
        paramete=[NSString stringWithFormat:@"StatusText=%@&UpdatingTime=%@&CategoryId=%@&AudioUrl=%@&ImageUrl=&VideoUrl=",_txtNotesDetails.text,date,selectedCategory,_txtSelectedFile.text];
    }else if(video){
         paramete=[NSString stringWithFormat:@"StatusText=%@&UpdatingTime=%@&CategoryId=%@&VideoUrl=%@&ImageUrl=&AudioUrl=",_txtNotesDetails.text,date,selectedCategory,_txtSelectedFile.text];
    }
    mainUrl=[NSString stringWithFormat:@"%@&%@&%@",paramete,location,mainUrl];
    NSString *url=@"http://localhost/inforMe/addStatus.php";
    NSURL *requestUrl=[NSURL URLWithString:url];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    
    [request setHTTPMethod:POST];
    [request setHTTPBody:[mainUrl dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.respApi.delegate =self;
    [self.respApi httpRequest:request];
}
//Method Custom Protocol

-(void)getRecivedData:(NSMutableData *)data sender:(RestAPI *)sender{
    NSError *error=nil;
    NSDictionary *reciveData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

    [self showAlertMessageInAlertStyle:@"Information" setError:[reciveData objectForKey:@"Message"]];
    _txtSelectedFile.text=@"";
    _txtNotesDetails.text=@"";
}
- (IBAction)btnAnonymous:(id)sender {
    mainUrl=@"UserId=17";
    [self httpPostRequest];
}

- (IBAction)btnAddNotesAsUser:(id)sender {
    // Login User
    loginUser *user=[loginUser getUser];

    mainUrl=[NSString stringWithFormat:@"UserId=%@",user.userId];
    [self httpPostRequest];
}
@end
