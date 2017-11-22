//
//  videoTableViewCell.m
//  inforMe
//
//  Created by BSSE on 28/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "videoTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RestAPI.h"
#import "loginUser.h"
@interface videoTableViewCell()<RestAPIDelegate> {
    MPMoviePlayerController *_playerControllar;
    UIImageView *_thumbnailView;
    UIButton *_btnPlay;
    int likes,dislike,report;
    BOOL like,isReported;
    NSString *mainUrl;
}
@property(nonatomic,strong) RestAPI *respApi;
@end


@implementation videoTableViewCell
-(RestAPI *)respApi{
    if(!_respApi){
        _respApi=[[RestAPI alloc]init];
    }
    return _respApi;
}
- (void)awakeFromNib {
    like=isReported=NO;
    mainUrl=@"";
    const int X=10;
    const int Y=170;
    const int H= 250;
    const int W= self.frame.size.width;
    _thumbnailView=[[UIImageView alloc]initWithFrame:CGRectMake(X, Y, W-20, H)];
    [_thumbnailView setImage:[UIImage imageNamed:@"videoPreview.png"]];
    [self addSubview:_thumbnailView];
    _btnPlay =[[UIButton alloc]initWithFrame:CGRectMake(W/2-50, 240, 100, 100)];
    [_btnPlay setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    [self addSubview:_btnPlay];
    [_btnPlay addTarget:self action:@selector(playVideoInSameView:)    forControlEvents:UIControlEventTouchUpInside];
    self.imgProfile.layer.cornerRadius=self.imgProfile.frame.size.width/2;
    self.imgProfile.clipsToBounds=YES;
    self.imgProfile.layer.borderWidth = 1.0f;
    self.imgProfile.layer.borderColor = [UIColor grayColor].CGColor;
}

-(void) playVideoInSameView:(id *)sender{
    [_thumbnailView setHidden:YES];
    [_btnPlay setHidden:YES];
    
    NSURL *videoStreamUrl=[NSURL URLWithString:_videoUrl];
    _playerControllar=[[MPMoviePlayerController alloc]initWithContentURL:videoStreamUrl];
    _playerControllar.view.frame=CGRectMake(10, 170, self.frame.size.width-20, 250);
    [self addSubview:_playerControllar.view];
    [_playerControllar play];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
