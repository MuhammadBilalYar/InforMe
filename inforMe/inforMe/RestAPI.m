//
//  RestAPI.m
//  URLConnection
//
//  Created by BSSE on 01/10/2015.
//  Copyright © 2015 BSSE. All rights reserved.
//

#import "RestAPI.h"
@interface RestAPI() <NSURLConnectionDataDelegate>

@property (nonatomic,strong)NSMutableData *reciveData;
@property (nonatomic ,strong)NSURLConnection *requestConnection;

@end

@implementation RestAPI

//setter for recieving data
-(NSMutableData *)reciveData{
    if(!_reciveData){
        _reciveData =[[NSMutableData alloc]init];
    }
    return _reciveData;
}

//setter for requesting url connection  
-(NSURLConnection *)requestConnection{
    if (!_requestConnection) {
        _requestConnection =[[NSURLConnection alloc]init];
    }
    return _requestConnection;
}

-(void)httpRequest:(NSMutableURLRequest*) request{
    self.requestConnection=[NSURLConnection connectionWithRequest:request delegate:self];
}

//this method is used for receiving data from url and appending eexisting data in recieve data object
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.reciveData appendData:data];
}

//this will show description of any type of error if any occoure
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self showUIAlertViewMessage:error.description andTitle:@"ERROE"];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //here i'm calling my custom define delegate method
    
    [self.delegate getRecivedData:self.reciveData sender:self];
    self.delegate=nil;
    self.reciveData=nil;
    self.requestConnection=nil;
}
-(void)showUIAlertViewMessage:(NSString *)message andTitle:(NSString *)title{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title
                                                 message:message
                                                delegate:self
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [alert show];
}
@end
