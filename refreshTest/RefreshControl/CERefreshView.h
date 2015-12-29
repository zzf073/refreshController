//
//  CERefreshView.h
//  refreshTest
//
//  Created by zzf073 on 15/12/15.
//  Copyright (c) 2015年 zzf073. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum HeaderRefreshState
{
    refreshStateNormal = 0,
    refreshStatePulling,
    refreshStateRefreshing,
    refreshStateSuccess,
    refreshStateFail
}RefreshState;

@interface CERefreshView : UIView

@property(nonatomic, assign) RefreshState refreshState;

@end
