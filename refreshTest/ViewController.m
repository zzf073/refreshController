//
//  ViewController.m
//  refreshTest
//
//  Created by zzf073 on 15/12/15.
//  Copyright (c) 2015年 zzf073. All rights reserved.
//

#import "ViewController.h"
#import "CERefreshControl.h"

@interface ViewController ()

@property(nonatomic, strong) CERefreshControl *refreshCtr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *scrollview = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    scrollview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:scrollview];
    
    UIView *tip = [[UIView alloc] initWithFrame:CGRectMake(79, 79, 40, 40)];
    tip.backgroundColor = [UIColor redColor];
    
    [scrollview addSubview:tip];
    
    self.refreshCtr = [CERefreshControl refreshControlWithParent:scrollview];
    
    [self addRefreshConttol];
    
}

-(void)addRefreshConttol
{
    self.refreshCtr.refreshDone = ^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.refreshCtr endRefreshing];
        });
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
