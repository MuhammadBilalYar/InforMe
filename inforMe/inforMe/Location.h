//
//  Location.h
//  inforMe
//
//  Created by BSSE on 11/06/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Location : NSObject<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong) NSString *longitude,*latitude,*address;
@property (nonatomic,strong) Location *location;

-(void) setCurrentLocation:(NSString*) lon latitude:(NSString *)lat address:(NSString*)add;
-(Location *) getCurrentLocation;
@end
