//
//  LTContactsViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/14.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTContactsViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"
#import "LTContactsTableViewCell.h"
#import "LTAlertView.h"

@interface LTContactsViewController ()

@property (strong, nonatomic) IBOutlet UITableView *contactsTableView;

@property (nonatomic, strong) LTAlertView *alertView;

@end

@implementation LTContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getContactsList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = [_dataList objectAtIndex:section];
    NSArray *userArray = [dict objectForKey:@"user"];
    return [userArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = [_dataList objectAtIndex:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, _MainScreen_Width-24, 30)];
    label.font = [UIFont systemFontOfSize:15.f];
    label.text = [dict objectForKey:@"name"];
    [view addSubview:label];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LTContactsTableViewCell";
    LTContactsTableViewCell *cell = (LTContactsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    NSArray *list = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"user"];
    NSDictionary *dict = [list objectAtIndex:indexPath.row];
    cell.nameLabel.text = [dict objectForKey:@"realname"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *list = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"user"];
    NSDictionary *dict = [list objectAtIndex:indexPath.row];
    LTAlertView *alertView = [[LTAlertView alloc] initWithDict:dict];
    __weak typeof(self)weakself = self;
    alertView.cancelButtonClicked = ^{
        [weakself.alertView removeFromSuperview];
    };
    alertView.contactButtonClicked = ^{
        [weakself.alertView removeFromSuperview];
    };
    alertView.sendMsgButtonClicked = ^{
        [weakself.alertView removeFromSuperview];
    };
    [self.navigationController.view addSubview:alertView];
}

- (void)getContactsList{
    if ([_dataList count] == 0) {
        [SVProgressHUD showWithStatus:@"加载中..."];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.xml",
                          [NSString stringWithFormat:@"%@/Documents/ProtocolCaches", NSHomeDirectory()], @"contactInfolist"];
    NSString *URLString = [NSString stringWithFormat:@"%@/gongwen.php?act=groupfb&id=7&uid=1",
                           API_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([_dataList count] == 0) {
            [SVProgressHUD dismiss];
        }
        NSLog(@"%@",[responseObject JSONValue]);
        NSDictionary *resultDict = [responseObject JSONValue];
        if ([resultDict count] > 1) {
//            NSDictionary *departDict = [resultArray objectAtIndex:0];
//            NSDictionary *userDict = [resultArray objectAtIndex:1];
            
            NSMutableArray *departArray = [resultDict objectForKey:@"depart"];
            NSMutableArray *userArray = [resultDict objectForKey:@"user"];
            _dataList = [[NSMutableArray alloc] init];
            for (int i=0; i<[departArray count]; i++) {
                NSDictionary *depart = [departArray objectAtIndex:i];
                NSInteger departID = [[depart objectForKey:@"id"] integerValue];
                
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:depart];
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (int j=0; j<[userArray count]; j++) {
                    NSDictionary *user = [userArray objectAtIndex:j];
                    NSInteger type = [[user objectForKey:@"depart"] integerValue];
                    if (departID == type) {
                        [array addObject:user];
                    }
                }
                [dict setObject:array forKey:@"user"];
                [_dataList addObject:dict];
            }
            [self.contactsTableView reloadData];
            
            [resultDict writeToFile:fileName atomically:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}



@end
