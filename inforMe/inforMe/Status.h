//
//  Status.h
//  inforMe
//
//  Created by BSSE on 10/06/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Status : NSObject
//Status 
@property (nonatomic,strong) NSString *StatusId, *StatusText, *UpdatingTime, *StatusLike, *StatusDislike, *CategoryId, *UserId, *LocationId, *AudioUrl, *VideoUrl, *ImageUrl,*feedBacks,*Reports;
//User
@property (nonatomic,strong) NSString *firstName, *lastName, *userImageUrl;

//Location
@property (nonatomic,strong) NSString *Latitude,*Longitude,*Address;

//Category
@property (nonatomic,strong) NSString *CategoryName;

-(instancetype)initWithDict:(NSDictionary *)dic;
@end
