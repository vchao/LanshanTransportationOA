//
//  LTReviceFileViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/16.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTReviceFileViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"
#import "LTReviceFileTableViewCell.h"
#import "LTAlertView.h"
//#import "ZXLiuchengViewController.h"
//#import "ZXWorkShenpiViewController.h"

@interface LTReviceFileViewController ()

@end

@implementation LTReviceFileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    workTableView.dataSource = self;
    workTableView.delegate = self;
    searchBar.delegate = self;
    
    doArray = [[NSArray alloc] init];
    listArray = [[NSArray alloc] init];
    searchArray = [[NSMutableArray alloc] init];
    //    [self getDoList];
    
    openInfo = [[NSMutableDictionary alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self getDoList];
//    [self getAllList];
}

- (IBAction)tapReviceMail:(id)sender{
    NSInteger selectedIndex = [segmentedControl selectedSegmentIndex];
    [searchArray removeAllObjects];
    [workTableView reloadData];
    if (selectedIndex == 0) {//待办文件
        searchBar.text = @"";
        searchArray = [[NSMutableArray alloc] initWithArray:doArray];
        [workTableView reloadData];
    }else if (selectedIndex == 1) {//查询文件
        searchBar.text = @"";
        if ([listArray count] == 0) {
            [self getAllList];
        }else{
            searchArray = [[NSMutableArray alloc] initWithArray:listArray];
            [workTableView reloadData];
        }
    }else if (selectedIndex == 2) {//正在办理
        searchBar.text = @"";
    }else if (selectedIndex == 1) {//截止日期
        searchBar.text = @"";
    }
}

- (void)getDoList{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/gongwen.php?act=dolist&id=7&uid=%ld",
                           API_DOMAIN,uid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (result.length > 20) {
            NSLog(@"%@",[responseObject JSONValue]);
            NSMutableDictionary *resultDict = [responseObject JSONValue];
            if (![[resultDict objectForKey:@"value"] isEqualToString:@""]) {
                doArray = [resultDict objectForKey:@"value"];
                if (doArray && [doArray count] > 0) {
                    NSInteger selectedIndex = [segmentedControl selectedSegmentIndex];
                    if (selectedIndex == 0) {//收件箱
                        searchArray = [[NSMutableArray alloc] initWithArray:doArray];
                        [workTableView reloadData];
                    }else{//发件箱
                        
                    }
                }
            }
        }else{
            searchArray = [[NSMutableArray alloc] init];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)getAllList{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/gongwen.php?act=list&uid=%ld",
                           API_DOMAIN,uid];
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
            NSInteger selectedIndex = [segmentedControl selectedSegmentIndex];
            if (selectedIndex == 1) {
                searchArray = [[NSMutableArray alloc] initWithArray:listArray];
                [workTableView reloadData];
            }
        }else{
            searchArray = [[NSMutableArray alloc] init];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSInteger selectedIndex = [segmentedControl selectedSegmentIndex];
    if (selectedIndex == 0) {
        if (searchText.length>0 && [doArray count] > 0) {
            [searchArray removeAllObjects];
            for (int i=0; i<[doArray count]; i++) {
                NSDictionary *info = [doArray objectAtIndex:i];
                NSString *cont = [info objectForKey:@"title"];
                if ([cont rangeOfString:searchText].length > 0) {
                    [searchArray addObject:info];
                }
            }
            [workTableView reloadData];
        }else if ([doArray count] > 0) {
            searchArray = [[NSMutableArray alloc] initWithArray:doArray];
            [workTableView reloadData];
        }
    }else if (selectedIndex == 1) {
        if (searchText.length>0 && [listArray count] > 0) {
            [searchArray removeAllObjects];
            for (int i=0; i<[listArray count]; i++) {
                NSDictionary *info = [listArray objectAtIndex:i];
                NSString *cont = [info objectForKey:@"title"];
                if ([cont rangeOfString:searchText].length > 0) {
                    [searchArray addObject:info];
                }
            }
            [workTableView reloadData];
        }else if ([listArray count] > 0) {
            searchArray = [[NSMutableArray alloc] initWithArray:listArray];
            [workTableView reloadData];
        }
    }else if (selectedIndex == 2) {
        
    }else if (selectedIndex == 3) {
        
    }
    //关键字改变
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return searchArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"reviceFileTableViewCell";
    LTReviceFileTableViewCell *cell = (LTReviceFileTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LTReviceFileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *info = [searchArray objectAtIndex:indexPath.row];
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
    
    openInfo = searchArray[indexPath.row];
    [self performSegueWithIdentifier:@"pushToWorkDetail" sender:@"tapPishi"];
}

- (void)showLiucheng:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tagID = btn.tag;
    liuchengID = [NSString stringWithFormat:@"%ld",tagID];
    
    [self getLCList:tagID];
    
//    [self performSegueWithIdentifier:@"pushToLiucheng" sender:@"tapLiucheng"];
}

- (void)getLCList:(NSInteger)lcID{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/gongwen.php?act=liucheng&uid=%ld&id=%ld",
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

- (IBAction)rightItemAction:(id)sender {
    [self performSegueWithIdentifier:@"pushToReceiveRegistration" sender:@"tapRightItem"];
}

#pragma mark - 导航

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *viewController = segue.destinationViewController;
    if ([sender isEqualToString:@"tapPishi"]) {
        if ([viewController respondsToSelector:@selector(setInfoDictionary:)]) {
            [viewController setValue:openInfo forKey:@"infoDictionary"];
        }
    } else if ([sender isEqualToString:@"tapLiucheng"]) {
        if ([viewController respondsToSelector:@selector(setLcID:)]) {
            [viewController setValue:liuchengID forKey:@"lcID"];
        }
        if ([viewController respondsToSelector:@selector(setLcType:)]) {
            [viewController setValue:@"gongwen" forKey:@"lcType"];
        }
    }
}

@end
