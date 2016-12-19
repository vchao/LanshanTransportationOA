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
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:32.f/255.f green:148.f/255.f blue:254/255.f alpha:1.f]]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, 32, 32);
    [btn setBackgroundImage:[UIImage imageNamed:@"home_nav_left"] forState:UIControlStateNormal];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=item;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, _MainScreen_Width, 32)];
    topView.backgroundColor = [UIColor colorWithRed:52.f/255.f green:157.f/255.f blue:254/255.f alpha:1.f];
    [self.view addSubview:topView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, _MainScreen_Width-24, 32)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:16.f];
    nameLabel.text = [NSString stringWithFormat:@"欢迎您：%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_REAL_NAME]];
    [topView addSubview:nameLabel];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 96, _MainScreen_Width, _MainScreen_Height-96-49)];
    scrollView.contentSize = CGSizeMake(_MainScreen_Width, _MainScreen_Height-96-49);
    [self.view addSubview:scrollView];
    
    CGFloat btnY = 14;
    CGFloat btnW = 50;
    if (iPhone6) {
        btnW = 72;
    }else if (iPhone6plus) {
        btnW = 72;
    }else{
        btnW = 50;
    }
    CGFloat left = (_MainScreen_Width-btnW*3)/6.f;
    CGFloat btnX = left;
    CGFloat btnS = btnX*2.f;
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnW)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setBackgroundImage:[UIImage imageNamed:[dict objectForKey:@"icon"]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i+1;
        [scrollView addSubview:btn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btnX, CGRectGetMaxY(btn.frame)+8.f, btnW, 14.f)];
        label.font = [UIFont systemFontOfSize:14.f];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [dict objectForKey:@"title"];
        [scrollView addSubview:label];
        
        btnX += (btnS+btnW);
        if (i%3 == 2) {
            btnX = left;
            btnY += (btnW+22.f+12.f);
        }
    }
    scrollView.contentSize = CGSizeMake(_MainScreen_Width, btnY+btnW+22+12);
}

- (void)buttonAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1001) {
        //来文管理
        [self performSegueWithIdentifier:@"pushToReviceFile" sender:@"tapCell"];
    }else if (btn.tag == 1002) {
        //发文管理
    }else if (btn.tag == 1003) {
        //事物审批
    }else if (btn.tag == 1004) {
        //印鉴使用
    }else if (btn.tag == 1005) {
        //邮件管理
        [self performSegueWithIdentifier:@"pushToMailList" sender:@"tapCell"];
    }else if (btn.tag == 1006) {
        //会议通知
    }else if (btn.tag == 1007) {
        //信息中心
    }else if (btn.tag == 1008) {
        //外出报备
    }else if (btn.tag == 1009) {
        //考勤管理
    }else if (btn.tag == 1010) {
        //公路保养
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 导航

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *viewController = segue.destinationViewController;
    viewController.hidesBottomBarWhenPushed = YES;
    if ([sender isEqualToString:@"tapCell"]) {
        
    }
}

@end
