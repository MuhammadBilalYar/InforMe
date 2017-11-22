//
//  RestAPI.h
//  URLConnection
//
//  Created by BSSE on 01/10/2015.
//  Copyright © 2015 BSSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//define delegate method
@class RestAPI;
@protocol RestAPIDelegate

-(void)getRecivedData:(NSMutableData *)data sender:(RestAPI *)sender;

@end

//public method and properties
@interface RestAPI :NSObject

-(void)httpRequest:(NSMutableURLRequest*) request;

@property (nonatomic ,weak)id<RestAPIDelegate>delegate;

@end

#define POST @"POST"
#define GET @"GET"