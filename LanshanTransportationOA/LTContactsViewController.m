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

@interface LTContactsViewController ()

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
//            [self.contactsTableView reloadData];
            
            [resultDict writeToFile:fileName atomically:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
