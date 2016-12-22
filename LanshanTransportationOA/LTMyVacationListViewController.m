//
//  LTMyVacationListViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/22.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTMyVacationListViewController.h"

@interface LTMyVacationListViewController (){
    NSString    *pageType;
}

@property (nonatomic, copy) NSString      *pageType;

@end

@implementation LTMyVacationListViewController

@synthesize pageType;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([pageType isEqualToString:@"vacation"]) {
        self.title = @"我的休假查询";
    }else if ([pageType isEqualToString:@"leave"]) {
        self.title = @"我的请假查询";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
