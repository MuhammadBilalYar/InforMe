//
//  CommentViewController.m
//  inforMe
//
//  Created by BSSE on 06/06/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "LayoutContainerView.h"
#import "CommentModel.h"
#import "RestAPI.h"
#import "loginUser.h"
@interface CommentViewController ()<UITableViewDataSource ,UITableViewDelegate,RestAPIDelegate>
{
    NSMutableArray *_dataSource;
    UITableView    *_tableview;
    UITextField *_txtComment;
    BOOL postfb,getfb;
    loginUser *loginuser;
    NSString *date;
    UINavigationBar *navBar;
}
@property(nonatomic,strong) RestAPI *respApi;
@end

@implementation CommentViewController
-(RestAPI *)respApi{
    if(!_respApi){
        _respApi=[[RestAPI alloc]init];
    }
    return _respApi;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    postfb=getfb=NO;
    loginuser=[loginUser getUser];
    _dataSource = [[NSMutableArray alloc] init];

    [self httpPostRequest];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStylePlain];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableview.backgroundView = nil;
    if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableview];
    
    [self setCommentInput];
    navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    navBar.backgroundColor = [UIColor whiteColor];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    navItem.title = @"Add Comment";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(btnForBackToRootControllar:)];
    navItem.rightBarButtonItem = rightButton;
    
    navBar.items = @[ navItem ];
    
    [self.view addSubview:navBar];
}
- (void) btnForBackToRootControllar:(id *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setCommentInput{
    self.view.backgroundColor=[UIColor whiteColor];
    _txtComment=[[UITextField alloc]initWithFrame:CGRectMake(10, _tableview.frame.size.height+60, _tableview.frame.size.width-70, 40)];
    [_txtComment setPlaceholder:@"Enter Comment here"];
    [self.view addSubview:_txtComment];
    
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(_txtComment.frame.size.width+10,_tableview.frame.size.height+60, 50, 40);
    [myButton setTitle:@"POST" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(myButtonClick:)    forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myButton];
}
-(void) myButtonClick:(NSString *)myString{
    if (_txtComment.text.length>0) {
        [self httpPostRequestForPostingFeedBack];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:_dataSource[indexPath.row]];
    return container.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell * ce =[[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    ce.selectionStyle = UITableViewCellSelectionStyleNone;
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:_dataSource[indexPath.row]];
    [ce.contentView addSubview:container];
    return ce;
    
}
-(void) httpPostRequestForPostingFeedBack{
    postfb=YES;
    getfb=NO;
    //current Time
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    date=[dateFormatter stringFromDate:[NSDate date]];
    
    NSString* paramete=[NSString stringWithFormat:@"FeedBackBody=%@&StatusId=%@&UserId=%@&Time=%@",_txtComment.text,_sId,loginuser.userId,date];
    NSString *url=@"http://localhost/inforMe/postFeedBack.php";
    NSURL *requestUrl=[NSURL URLWithString:url];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    
    [request setHTTPMethod:POST];
    [request setHTTPBody:[paramete dataUsingEncoding:NSUTF8StringEncoding]];
    self.respApi.delegate =self;
    [self.respApi httpRequest:request];
}
-(void) httpPostRequest{
    getfb=YES;
    postfb=NO;
    NSString* parameter=[NSString stringWithFormat:@"http://localhost/inforMe/getAllFeedBack.php?StatusId=%@",_sId];
    NSURL *requestUrl=[NSURL URLWithString:parameter];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:requestUrl];
    
    [request setHTTPMethod:GET];
    
    self.respApi.delegate =self;
    [self.respApi httpRequest:request];
}
//Method Custom Protocol

-(void)getRecivedData:(NSMutableData *)data sender:(RestAPI *)sender{
    NSError *error=nil;
    NSArray *reciveData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if(reciveData.count>0){
        NSDictionary *temp=(NSDictionary*)reciveData;
    if (postfb&&[temp[@"Message"] isEqualToString:@"POSTED"]) {
        [self CurrentObjectinDataSource];
        _txtComment.text=@"";
    }else if(getfb){
            for (NSDictionary *dict in reciveData) {
                CommentModel *model =[[CommentModel alloc] initWithDict:dict];
                NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:model, nil];
                [_dataSource addObject:arr];
            }
    }
    [_tableview reloadData];
    }
}
-(void)showAlertMessageInAlertStyle:(NSString *)Title setError:(NSString*)errorMessage{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:Title message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {

                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)CurrentObjectinDataSource
{
    NSDictionary *FeedBack=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_txtComment.text],@"FeedBackBody",[NSString stringWithFormat:@"%@",date],@"Time", nil];
    
    NSDictionary *user=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",loginuser.firstName],@"FirstName",[NSString stringWithFormat:@"%@",loginuser.lastName],@"LastName",[NSString stringWithFormat:@"%@",loginuser.imageUrl],@"ImageUrl", nil];
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:FeedBack,@"FeedBack",user,@"user", nil];
    
    CommentModel *model =[[CommentModel alloc] initWithDict:dict];
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:model, nil];
    [_dataSource addObject:arr];
    
}
@end


