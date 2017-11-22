//
//  Location.m
//  inforMe
//
//  Created by BSSE on 11/06/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "Location.h"

@implementation Location
{
    CLGeocoder *coder;
    CLPlacemark *placeMark;
}
//Get Current Location
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
-(void)getLocation:(NSString*)device
{
    coder =[[CLGeocoder alloc]init];
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    //IS_OS_8_OR_LATER
    if(device){
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
    NSLog(@"%@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        _location.latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        _location.longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        [coder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error ==nil && placemarks.count>0) {
                placeMark=[placemarks lastObject];
                _location.address=[NSString stringWithFormat:@"%@ %@ \n %@ %@\n%@\n%@",placeMark.subThoroughfare,placeMark.thoroughfare,placeMark.postalCode,placeMark.locality,placeMark.administrativeArea,placeMark.country];
            }
            else{
                NSLog(@"%@",error.debugDescription);
            }
        }];
    }
}

-(Location *)getCurrentLocation{
    [self getLocation:@"IS_OS_8_OR_LATER"];
    return _location;
}
@end
