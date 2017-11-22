//
//  CommentModel.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//
#import "Constant.h"
#import "CommentModel.h"

@implementation CommentModel

-(instancetype)initWithDict:(NSDictionary *)dic{
    
//    if (self = [super init]) {
//        self.name =dic[@"name"];
//        self.time =dic[@"t"];
//        self.comment =dic[@"commentBody"];
//    }
    if (self = [super init]) {
        NSDictionary *user=[dic objectForKey:@"user"];
        NSDictionary *fb=[dic objectForKey:@"FeedBack"];
        self.name =[NSString stringWithFormat:@"%@ %@", user[@"FirstName"],user[@"LastName"]];
        self.userImage=user[@"ImageUrl"];
        self.time =fb[@"Time"];
        self.comment =fb[@"FeedBackBody"];
    }
    return self;
    
}
- (CGSize)sizeWithConstrainedToSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: CommentFont};
    CGSize textSize         = [self.comment boundingRectWithSize:CGSizeMake(size.width, 0)
                                                 options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                              attributes:attribute
                                                 context:nil].size;
    return textSize;
}
@end
