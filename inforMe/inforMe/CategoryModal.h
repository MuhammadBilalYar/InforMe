//
//  CategoryModal.h
//  inforMe
//
//  Created by BSSE on 10/06/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModal : NSObject
@property (nonatomic,strong)NSString *catId;

+(void) setCat:(CategoryModal*) cat;
+(CategoryModal *) getCat;
@end
