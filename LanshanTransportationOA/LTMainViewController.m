//
//  LTMainViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/14.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTMainViewController.h"

@interface LTMainViewController ()

@end

@implementation LTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    
    NSArray *array = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:@"home_document", @"icon", @"来文管理", @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"ic_send_document", @"icon", @"发文管理", @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"home_service", @"icon", @"事务批办", @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"ic_in_doc", @"icon", @"印鉴使用", @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"home_mail", @"icon", @"邮件管理", @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"home_meeting", @"icon", @"会议通知", @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"home_read", @"icon", @"信息中心", @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"home_attendance", @"icon", @"外出报备", @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"home_signin", @"icon", @"考勤管理", @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"home_office", @"icon", @"公路保养", @"title", nil], nil];
    for (int i = 0; i < array.count; i++) {
        
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
