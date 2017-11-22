//
//  LayoutView.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//

#import "LayoutView.h"
#import "LayoutContainerView.h"
#import "Constant.h"
@interface LayoutView()

@property (nonatomic,strong) CommentModel *model;
@property (nonatomic,strong) UILabel      *nameLabel;
@property (nonatomic,strong) UILabel      *commentLabel;
@property (nonatomic,strong) UILabel      *timeLabel;
@property (nonatomic,assign) UIView       *parent;
@property (nonatomic,assign) BOOL         isLastFloor;

@end

@implementation LayoutView

- (instancetype)initWithFrame:(CGRect)frame model:(CommentModel *)amodel parentView:(UIView*)p isLast:(BOOL)isLast
{
    if (self = [super initWithFrame:frame]) {
        self.isLastFloor = isLast;
        self.parent = p;
        self.model = amodel;
        if (!self.isLastFloor) {
            self.layer.borderWidth = LayoutBordWidth;
            self.layer.borderColor = LayoutBordColor.CGColor;
            self.backgroundColor = LayoutBackgroundColor;
        }
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = self.model.name;
        _nameLabel.font = NameFont;
        _nameLabel.textColor = NameColor;
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor =[UIColor grayColor];
        _timeLabel.text = self.model.time;
        _timeLabel.font = AddressFont;
        
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.numberOfLines =0;
        _commentLabel.font = CommentFont;
        _commentLabel.text = self.model.comment;
        
        _nameLabel.frame = CGRectMake(5, self.parent.frame.size.height ,self.frame.size.width - 10, 34);
        _timeLabel.frame = CGRectMake(_nameLabel.frame.origin.x, self.parent.frame.size.height + 20 ,self.frame.size.width - 10, 34);
        _commentLabel.frame =  CGRectMake(5, self.parent.frame.size.height+40 ,self.frame.size.width - 10,self.frame.size.height - self.parent.frame.size.height - 40);
       

        [self addSubview:_nameLabel];
        [self addSubview:_timeLabel];
        [self addSubview:_commentLabel];
        
        if (self.isLastFloor) {
            _nameLabel.hidden = YES;
            _timeLabel.hidden = YES;
            _commentLabel.frame = CGRectMake(5, self.parent.frame.size.height+5 ,self.frame.size.width - 10,self.frame.size.height - self.parent.frame.size.height - 40);
        }
        
    }
    return self;
}

@end
