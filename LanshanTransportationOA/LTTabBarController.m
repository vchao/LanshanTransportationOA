//
//  LTTabBarController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/14.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTTabBarController.h"

@interface LTTabBarController ()

@end

@implementation LTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UITabBarItem *item in self.tabBar.items) {
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
