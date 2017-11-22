//
//  LayoutContainnerView.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//


#import "LayoutContainerView.h"
#import "LayoutView.h"
#import "CommentModel.h"
#import "Constant.h"
@interface LayoutContainerView()

@property (nonatomic,strong) UILabel      *nameLabel;
@property (nonatomic,strong) UILabel      *timeLabel;
@property (nonatomic,strong) UIImageView  *headImageView;
@property (nonatomic,strong) CommentModel *model;

@end

@implementation LayoutContainerView

-(void)updateWithModelArray:(NSMutableArray *)sortedArray{
    
    int i = 0;
    id lastView = nil;
    float lastH = 0;
    CommentModel *lastModel = [sortedArray lastObject];
    for (CommentModel *model in sortedArray) {
        
        CGRect r = CGRectMake(44+ i*OverlapSpace, 60 + i*OverlapSpace, ScreenWidth - 44 -10 - 2*(i * OverlapSpace), 0);
        CGSize sz = [model sizeWithConstrainedToSize:CGSizeMake(r.size.width-10, MAXFLOAT)];
        r.size.height = sz.height +lastH + 55;
        
        LayoutView *vi =[[LayoutView alloc] initWithFrame:r model:model parentView:lastView isLast:[lastModel isEqual: model]];
        
        lastH =  r.size.height;
        
        if (lastView) {
            [self insertSubview:vi belowSubview:lastView];
        }else{
            [self addSubview:vi];
        }
        lastView = vi;
    }
    
    self.frame = CGRectMake(0, 0,ScreenWidth, lastH+44);
    
    
}
-(instancetype)initWithModelArray:(NSArray *)model{
    
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = CellBackgroundColor;
        NSMutableArray *ar =[NSMutableArray arrayWithArray:model];
        self.model = [ar lastObject];
        
        self.backgroundColor = CellBackgroundColor;
        
        _headImageView  =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        CommentModel *cModel=model[0];
        _headImageView.image =[UIImage imageNamed:cModel.userImage];
        
        self.headImageView.layer.cornerRadius=self.headImageView.frame.size.width/2;
        self.headImageView.clipsToBounds=YES;
        self.headImageView.layer.borderWidth = .5f;
        self.headImageView.layer.borderColor = [UIColor grayColor].CGColor;
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = AddressFont;
        _timeLabel.textColor =[UIColor grayColor];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = NameFont;
        _nameLabel.textColor = NameColor;
        
        _nameLabel.text = self.model.name;
        _timeLabel.text = self.model.time;
        
        [self addSubview:_headImageView];
        [self addSubview:_nameLabel];
        [self addSubview:_timeLabel];

        [self updateWithModelArray:ar];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(10, 10, 30, 30);
    _nameLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 4, 10 ,self.frame.size.width - 10, 34);
    _timeLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.frame.size.width + 4, 30 ,self.frame.size.width - 10, 34);
}
@end
