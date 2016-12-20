//
//  LTStampApprovalViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/20.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTStampApprovalViewController.h"
#import "LTReviceFileTableViewCell.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"
#import "LTAlertView.h"

@interface LTStampApprovalViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *listArray;
    NSMutableDictionary *openInfo;
    NSString *liuchengID;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LTStampApprovalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getDoList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDoList{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/stamp.php?act=dolist&uid=%ld", API_DOMAIN,uid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (result.length > 20) {
            NSLog(@"%@",[responseObject JSONValue]);
            NSMutableDictionary *resultDict = [responseObject JSONValue];
            listArray = [resultDict objectForKey:@"value"];
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"reviceFileTableViewCell";
    LTReviceFileTableViewCell *cell = (LTReviceFileTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LTReviceFileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *info = [listArray objectAtIndex:indexPath.row];
    [cell initWithDictionary:info];
    [cell.liuchengBtn addTarget:self action:@selector(showLiucheng:) forControlEvents:UIControlEventTouchUpInside];
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
    
    openInfo = listArray[indexPath.row];
    [self performSegueWithIdentifier:@"pushToStampApprovalDetail" sender:@"tapDetail"];
}

- (void)showLiucheng:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tagID = btn.tag;
    liuchengID = [NSString stringWithFormat:@"%ld",tagID];
    
    [self getLCList:tagID];
}

- (void)getLCList:(NSInteger)lcID{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/stamp.php?act=liucheng&uid=%ld&id=%ld",
                           API_DOMAIN,uid,(long)lcID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *resultDict = [responseObject JSONValue];
        NSArray *lcArray = [resultDict objectForKey:@"info"];
        
        LTLiuchengAlertView *alertView = [[LTLiuchengAlertView alloc] initWithArray:lcArray];
        alertView.cancelButtonClicked = ^{
            
        };
        [self.navigationController.view addSubview:alertView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - 导航

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *viewController = segue.destinationViewController;
    if ([sender isEqualToString:@"tapDetail"]) {
        if ([viewController respondsToSelector:@selector(setInfoDictionary:)]) {
            [viewController setValue:openInfo forKey:@"infoDictionary"];
        }
    }
}

@end
