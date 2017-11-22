//
//  AudioTableViewCell.m
//  inforMe
//
//  Created by BSSE on 09/06/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "AudioTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+animatedGIF.h"
#import "loginUser.h"
#import "RestAPI.h"
@interface AudioTableViewCell()<RestAPIDelegate>
{
    UIImageView *_thumbnailView;
    UIButton *_btnPlay;
    UIButton *_btnPause;
    AVAudioPlayer *_audioPlayer;
    NSString *mainUrl;
    int likes,dislike,report;
    BOOL like,isReported;
}
@property(nonatomic,strong) RestAPI *respApi;
@end
@implementation AudioTableViewCell
-(RestAPI *)respApi{
    if(!_respApi){
        _respApi=[[RestAPI alloc]init];
    }
    return _respApi;
}
- (void)awakeFromNib {
    like=isReported=NO;
    const int X=10;
    const int Y=170;
    const int H= 150;
    const int W= self.frame.size.width;
    _thumbnailView=[[UIImageView alloc]initWithFrame:CGRectMake(X, Y, W-20, H)];
    [_thumbnailView setImage:[UIImage imageNamed:@"audio.gif"]];
    
    [self addSubview:_thumbnailView];
    [self addPlaybtn:W/2-60 yPosition:190 height:100 width:100 ];
    
    self.imgProfile.layer.cornerRadius=self.imgProfile.frame.size.width/2;
    self.imgProfile.clipsToBounds=YES;
    self.imgProfile.layer.borderWidth = 1.0f;
    self.imgProfile.layer.borderColor = [UIColor grayColor].CGColor;

}
-(void) addPlaybtn:(int)x yPosition: (int)y height: (int)h width:(int) w{
    _btnPlay =[[UIButton alloc]initWithFrame:CGRectMake(x,y, h, w)];
    [_btnPlay setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    [self addSubview:_btnPlay];
    [_btnPlay addTarget:self action:@selector(playAudioInSameView:)    forControlEvents:UIControlEventTouchUpInside];
}
-(void) addPausebtn:(int)x yPosition: (int)y height: (int)h width:(int) w{
    _btnPause =[[UIButton alloc]initWithFrame:CGRectMake(x,y, h, w)];
    [_btnPause setImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
    [self addSubview:_btnPause];
    [_btnPause addTarget:self action:@selector(pauseAudioInSameView:)    forControlEvents:UIControlEventTouchUpInside];
}
-(void) playAudioInSameView:(id *)sender{
    [_btnPlay setHidden:YES];
    [self addPausebtn:self.frame.size.width/2-60 yPosition:190 height:100 width:100 ];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"audio" withExtension:@"gif"];
    _thumbnailView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],_audioUrl];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
     [_audioPlayer play];
    
//    UISlider *slider= [[UISlider alloc]initWithFrame:CGRectMake(10, 300, self.frame.size.width-20, 20)];
//    slider.minimumValue=0.0;
//    slider.maximumValue=_audioPlayer.duration;
//    for (int i=0; i<_audioPlayer.duration; i++) {
//        slider.value=_audioPlayer.currentTime;
//    }
//    [self addSubview:slider];
}
-(void) pauseAudioInSameView:(id *)sender{
    if (_audioPlayer.playing) {
        [_btnPause setHidden:YES];
        [_thumbnailView setImage:[UIImage imageNamed:@"audio.gif"]];
        [self addPlaybtn:self.frame.size.width/2-60 yPosition:190 height:100 width:100 ];
        [_audioPlayer pause];
        printf("%f",_audioPlayer.currentTime);
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
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
