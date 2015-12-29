//
//  CERefreshView.m
//  refreshTest
//
//  Created by zzf073 on 15/12/15.
//  Copyright (c) 2015年 zzf073. All rights reserved.
//

#import "CERefreshView.h"

@interface CERefreshView()

@property(nonatomic, strong) UILabel *tipLabl;

@property(nonatomic, strong) UIImageView *pullArrow;

@property(nonatomic, strong) UIImageView *statusIcon;

@property(nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation CERefreshView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self addTipView];
        [self addActivityView];
        
        self.pullArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        self.pullArrow.center = self.activityView.center;
        [self addSubview:self.pullArrow];
        
        self.statusIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"status"]];
        self.statusIcon.center = self.activityView.center;
        [self addSubview:self.statusIcon];
        
        self.refreshState = -1;
        
        self.refreshState = refreshStateNormal;
    }
    
    return self;
}

-(void)addTipView
{
    self.tipLabl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
    
    self.tipLabl.font = [UIFont systemFontOfSize:16];
    
    self.tipLabl.textColor = [UIColor colorWithRed:0x66/255.0f green:0x66/255.0f blue:0x66/255.0f alpha:1.0];
    
    self.tipLabl.textAlignment = NSTextAlignmentCenter;
    
    self.tipLabl.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.tipLabl];
}

-(void)addActivityView
{
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.hidden = NO;
    self.activityView.center = CGPointMake(self.tipLabl.center.x - 60, self.tipLabl.center.y);
    
    [self addSubview:self.activityView];
}

-(void)setRefreshState:(RefreshState)refreshState
{
    if(_refreshState == refreshState)
    {
        return;
    }
    
    [self.activityView stopAnimating];
    
    self.activityView.hidden = YES;
    self.pullArrow.hidden = YES;
    self.statusIcon.hidden = YES;
    
    _refreshState = refreshState;
    
    switch (refreshState) {
        case refreshStateNormal:
        {
            self.pullArrow.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.pullArrow.transform = CGAffineTransformMakeRotation(0.000001);
            }];
            self.tipLabl.text = @"下拉可以刷新";
        }
            break;
        case refreshStatePulling:
        {
            self.tipLabl.text = @"松开刷新数据";
            
            self.pullArrow.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.pullArrow.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
        }
            break;
        case refreshStateRefreshing:
        {
            self.activityView.hidden = NO;
            [self.activityView startAnimating];
            self.tipLabl.text = @"数据更新中...";
        }
            break;
        case refreshStateSuccess:
        {
            self.tipLabl.text = @"更新成功";
            self.statusIcon.hidden = NO;
        }
            break;
        case refreshStateFail:
        {
            self.tipLabl.text = @"更新失败";
            self.statusIcon.hidden = NO;
        }
            break;
        
            
        default:
            break;
    }
    
    self.tipLabl.frame = CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40);
    [self.tipLabl sizeToFit];
    
    self.tipLabl.center = CGPointMake(self.frame.size.width/2  + 20, self.frame.size.height - 30);
    
    self.activityView.center = CGPointMake(self.tipLabl.frame.origin.x - 20, self.tipLabl.center.y);
    self.pullArrow.center = self.activityView.center;
    self.statusIcon.center = self.activityView.center;
}

@end
