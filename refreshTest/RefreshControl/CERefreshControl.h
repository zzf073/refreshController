//
//  CERefreshControl.h
//  refreshTest
//
//  Created by zzf073 on 15/12/15.
//  Copyright (c) 2015年 zzf073. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CERefreshControl : NSObject

@property(nonatomic, copy) void(^refreshDone)();

+(instancetype)refreshControlWithParent:(UITableView*)parent;

-(void)endRefreshing;

-(void)endRefreshing:(BOOL)status;

@end
