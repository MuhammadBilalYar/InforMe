//
//  loginUser.m
//  inforMe
//
//  Created by BSSE on 31/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "loginUser.h"

@implementation loginUser

static loginUser *CurrentUser;

+(void) setUser:(loginUser*) user{
    CurrentUser=user;
}

+(loginUser *) getUser{
    return CurrentUser;
}
@end
