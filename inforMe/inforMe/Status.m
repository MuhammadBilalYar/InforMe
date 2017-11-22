//
//  Status.m
//  inforMe
//
//  Created by BSSE on 10/06/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "Status.h"

@implementation Status

-(instancetype)initWithDict:(NSDictionary *)dic{
    
    NSDictionary *cat=[dic objectForKey:@"cat"];
    NSDictionary *loc=[dic objectForKey:@"loc"];
    NSDictionary *status=[dic objectForKey:@"status"];
    NSDictionary *user=[dic objectForKey:@"user"];
    NSDictionary *fb=[dic objectForKey:@"FeedBack"];
    
    if (self = [super init]) {
        self.CategoryId=[cat objectForKey:@"CategoryId"];
        self.CategoryName=[cat objectForKey:@"CategoryName"];
        
        self.Address=[loc objectForKey:@"Address"];
        self.Latitude=[loc objectForKey:@"Latitude"];
        self.LocationId=[loc objectForKey:@"LocationId"];
        self.Longitude=[loc objectForKey:@"Longitude"];
        
        self.AudioUrl=[status objectForKey:@"AudioUrl"];
        self.ImageUrl=[status objectForKey:@"ImageUrl"];
        self.StatusDislike=[status objectForKey:@"StatusDislike"];
        self.StatusId=[status objectForKey:@"StatusId"];
        self.StatusLike=[status objectForKey:@"StatusLike"];
        self.StatusText=[status objectForKey:@"StatusText"];
        self.UpdatingTime=[status objectForKey:@"UpdatingTime"];
        self.UserId=[status objectForKey:@"UserId"];
        self.VideoUrl=[status objectForKey:@"VideoUrl"];
        self.feedBacks=[fb objectForKey:@"COUNT(StatusId)"];
        self.Reports=[status objectForKey:@"Report"];
        self.firstName=[user objectForKey:@"FirstName"];
        self.lastName=[user objectForKey:@"LastName"];
        self.userImageUrl=[user objectForKey:@"ImageUrl"];
    }
    return self;
    
}
@end
