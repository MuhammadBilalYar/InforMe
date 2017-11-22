//
//  PictureTableViewCell.m
//  inforMe
//
//  Created by BSSE on 26/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "PictureTableViewCell.h"
#import "MainTableViewController.h"
#import "RestAPI.h"
#import "loginUser.h"
#import "CommentViewController.h"

@interface PictureTableViewCell()<RestAPIDelegate>
{
    int likes,dislike,report;
    BOOL like,isReported;
    NSString *mainUrl;
}
@property(nonatomic,strong) RestAPI *respApi;
@end

@implementation PictureTableViewCell
-(RestAPI *)respApi{
    if(!_respApi){
        _respApi=[[RestAPI alloc]init];
    }
    return _respApi;
}
- (void)awakeFromNib {
    like=isReported=NO;
    //for circular profile images;
    self.imgProfile.layer.cornerRadius=self.imgProfile.frame.size.width/2;
    self.imgProfile.clipsToBounds=YES;
    self.imgProfile.layer.borderWidth = 1.0f;
    self.imgProfile.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnLike:(id)sender {
    if (!like) {
        likes=[_txtLike.text intValue]+1;
        NSString* paramete=[NSString stringWithFormat:@"?like=%d&id=%@",likes,_StatusId];
        mainUrl=[NSString stringWithFormat:@"http://localhost/inforMe/like.php%@",paramete];
        [self httpGetRequest];
    }
}

- (IBAction)btnDislike:(id)sender {
    if (!like) {
        dislike=[_txtDislike.text intValue]+1;
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
        report=[_txtReport.text intValue]+1;
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
            _txtLike.text=[NSString stringWithFormat:@"%d",likes];
            like=YES;
        }else if ([[reciveData objectForKey:@"Message"] isEqualToString:@"Dislike"]){
            _txtDislike.text=[NSString stringWithFormat:@"%d",dislike];
            like=YES;
        }else if ([[reciveData objectForKey:@"Message"] isEqualToString:@"Reported"]){
            _txtReport.text=[NSString stringWithFormat:@"%d",report];
            isReported=YES;
        }
    }
}
@end
