//
//  LTMessageCenterViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/20.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTMessageCenterViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"
#import "LTMessageCenterTableViewCell.h"

@interface LTMessageCenterViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *messageArray;
    
    NSDictionary *openInfo;
}

@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

@end

@implementation LTMessageCenterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _messageTableView.dataSource = self;
    _messageTableView.delegate = self;
    
    messageArray = [[NSArray alloc] init];
    [self getTZGGList];
    
    openInfo = [[NSDictionary alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)getTZGGList{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/tongzhi.php?act=list&uid=%ld",
                           API_DOMAIN,uid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",[responseObject JSONValue]);
        NSMutableDictionary *resultDict = [responseObject JSONValue];
        messageArray = [resultDict objectForKey:@"info"];
        [_messageTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"tzggCell";
    LTMessageCenterTableViewCell *cell = (LTMessageCenterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LTMessageCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *info = [messageArray objectAtIndex:indexPath.row];
    [cell initWithDictionary:info];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    openInfo = [messageArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"pushToMessageDetail" sender:@"tapCell"];
}

#pragma mark - 导航

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *viewController = segue.destinationViewController;
    if ([sender isEqualToString:@"tapCell"]) {
        if ([viewController respondsToSelector:@selector(setInfoDictionary:)]) {
            [viewController setValue:openInfo forKey:@"infoDictionary"];
        }
    }
}

@end
