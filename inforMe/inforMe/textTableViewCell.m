//
//  textTableViewCell.m
//  inforMe
//
//  Created by BSSE on 28/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "textTableViewCell.h"
#import "loginUser.h"
#import "RestAPI.h"
@interface textTableViewCell()<RestAPIDelegate>
{
    int likes,dislike,report;
    BOOL like,isReported;
    NSString *mainUrl;
}
@property(nonatomic,strong) RestAPI *respApi;
@end
@implementation textTableViewCell
-(RestAPI *)respApi{
    if(!_respApi){
        _respApi=[[RestAPI alloc]init];
    }
    return _respApi;
}
- (void)awakeFromNib {
    like=isReported=NO;
    mainUrl=@"";
    //for circular profile images;
    self.imgUserProfile.layer.cornerRadius=self.imgUserProfile.frame.size.width/2;
    self.imgUserProfile.clipsToBounds=YES;
    self.imgUserProfile.layer.borderWidth = 1.0f;
    self.imgUserProfile.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnLike:(id)sender {
    if (!like) {
        likes=[_btnLike.text intValue]+1;
        NSString* paramete=[NSString stringWithFormat:@"?like=%d&id=%@",likes,_StatusId];
        mainUrl=[NSString stringWithFormat:@"http://localhost/inforMe/like.php%@",paramete];
        [self httpGetRequest];
    }
}

- (IBAction)btnDislike:(id)sender {
    if (!like) {
        dislike=[_btnDislike.text intValue]+1;
        NSString* paramete=[NSString stringWithFormat:@"?dislike=%d&id=%@",dislike,_StatusId];
        mainUrl=[NSString stringWithFormat:@"http://localhost/inforMe/dislike.php%@",paramete];
        [self httpGetRequest];
    }
}

- (IBAction)btnComment:(id)sender {
    CommentViewController *cvc = [[CommentViewController alloc]init];
    cvc.sId=_StatusId;
    [self.delegate loadNewScreen:cvc];
}

- (IBAction)btnReport:(id)sender {
    if (!isReported) {
        report=[_btnReport.text intValue]+1;
        NSString* paramete=[NSString stringWithFormat:@"?report=%d&id=%@",report,_StatusId];
        mainUrl=[NSString stringWithFormat:@"http://localhost/inforMe/report.php%@",paramete];
        [self httpGetRequest];
    }
}
-(void) httpGetRequest{
    NSURL *requestUrl=[NSURL URLWithString:mainUrl];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    
    [request setHTTPMethod:GET];
    self.respApi.delegate =self;
    [self.respApi httpRequest:request];
}
-(void)getRecivedData:(NSMutableData *)data sender:(RestAPI *)sender{
    NSError *error=nil;
    NSDictionary *reciveData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (reciveData.count>0) {
        if ([[reciveData objectForKey:@"Message"] isEqualToString:@"Like"]) {
            _btnLike.text=[NSString stringWithFormat:@"%d",likes];
            like=YES;
        }else if ([[reciveData objectForKey:@"Message"] isEqualToString:@"Dislike"]){
            _btnDislike.text=[NSString stringWithFormat:@"%d",dislike];
            like=YES;
        }else if ([[reciveData objectForKey:@"Message"] isEqualToString:@"Reported"]){
            _btnReport.text=[NSString stringWithFormat:@"%d",report];
            isReported=YES;
        }
    }
}
@end
