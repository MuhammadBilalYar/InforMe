//
//  CategoryModal.m
//  inforMe
//
//  Created by BSSE on 10/06/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "CategoryModal.h"

@implementation CategoryModal
static CategoryModal *Cat;

+(void) setCat:(CategoryModal*) user{
    Cat=user;
}

+(CategoryModal *) getCat{
    return Cat;
}

@end
