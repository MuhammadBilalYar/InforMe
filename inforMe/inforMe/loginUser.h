//
//  loginUser.h
//  inforMe
//
//  Created by BSSE on 31/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginUser : NSObject
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *firstName;
@property (nonatomic,strong)NSString *lastName;
@property (nonatomic,strong)NSString *email;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)NSString *imageUrl;

+(void) setUser:(loginUser*) user;
+(loginUser *) getUser;
@end
