//
//  CERefreshControl.m
//  refreshTest
//
//  Created by zzf073 on 15/12/15.
//  Copyright (c) 2015年 zzf073. All rights reserved.
//

#import "CERefreshControl.h"
#import "CERefreshView.h"

#define TrigerValue 60

@interface CERefreshControl()

@property(nonatomic, weak) CERefreshView *refreshView;

@property(nonatomic, weak) UITableView *parentView;

@end

@implementation CERefreshControl

-(void)dealloc
{
    NSLog(@"ddddd");
}

+(instancetype)refreshControlWithParent:(UITableView*)parent
{
    CERefreshControl *ctr = [[CERefreshControl alloc] init];
    
    ctr.parentView = parent;
    
    [parent addObserver:ctr forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [parent.panGestureRecognizer addObserver:ctr forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    
    CERefreshView *refreshView = [[CERefreshView alloc] initWithFrame:CGRectMake(0, -900, parent.frame.size.width, 900)];
    
    //refreshView.backgroundColor = [UIColor redColor];
    
    [parent addSubview:refreshView];
    
    ctr.refreshView = refreshView;
    
    return ctr;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.parentView.contentOffset.y > 0)
        return;
    
    if(self.refreshView.refreshState == refreshStateRefreshing || self.refreshView.refreshState == refreshStateSuccess || self.refreshView.refreshState == refreshStateFail)
    {
        return;
    }
    
    if([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint new = [change[@"new"] CGPointValue];
        
        if(new.y < -TrigerValue)
        {
            self.refreshView.refreshState = refreshStatePulling;
        }
        else
        {
            self.refreshView.refreshState = refreshStateNormal;
        }
    }
    else if([keyPath isEqualToString:@"state"])
    {
        NSInteger new = [change[@"new"] integerValue];
        
        if(new == 3)
        {
            if(self.parentView.contentOffset.y < -TrigerValue)
            {
                self.refreshView.refreshState = refreshStateRefreshing;
                
                [UIView animateWithDuration:0.5 animations:^(){
                    self.parentView.contentInset = UIEdgeInsetsMake(TrigerValue, 0, 0, 0);
                } completion:^(BOOL finished) {
                    if(self.refreshDone)
                    {
                        self.refreshDone();
                    }

                }];
                
                
            }
        }
    }
}

-(void)endRefreshing
{
    [self endRefreshing:YES];
}

-(void)endRefreshing:(BOOL)status
{
    self.refreshView.refreshState = status?refreshStateSuccess:refreshStateFail;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^(){
            self.parentView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            self.refreshView.refreshState = refreshStateNormal;
        }];
    });
}

@end
