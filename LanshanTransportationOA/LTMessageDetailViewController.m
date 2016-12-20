//
//  LTMessageDetailViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/20.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTMessageDetailViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"

@interface LTMessageDetailViewController ()

@end

@implementation LTMessageDetailViewController

@synthesize infoDictionary;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    contentWeb.delegate = self;
    
    [self getDetails];
}

- (void)getDetails{
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/tongzhi.php?act=show&uid=%ld&id=%@",
                           API_DOMAIN,uid,[infoDictionary objectForKey:@"id"]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",[responseObject JSONValue]);
        NSMutableDictionary *resultDict = [responseObject JSONValue];
        NSDictionary *dict = [resultDict objectForKey:@"info"];
        //        if ([array count] > 0) {
        //            NSDictionary *dict = [array objectAtIndex:0];
        
        NSString *title = [dict objectForKey:@"title"];
        NSString *content = [dict objectForKey:@"content"];
        NSString *addtime = [dict objectForKey:@"addtime"];
        NSString *fileNameStr = [dict objectForKey:@"OldName"];
        NSArray *fileNameArray = [fileNameStr componentsSeparatedByString:@"|"];
        if (fileNameArray.count > 1) {
            NSString *newContent = @"";
            NSArray *contentArray = [content componentsSeparatedByString:@"</a>"];
            for (int i = 0; i < contentArray.count; i++) {
                NSString *fileName = @"";
                if (i < fileNameArray.count) {
                    fileName = fileNameArray[i];
                }
                if (i == 0) {
                    newContent = [NSString stringWithFormat:@"%@%@</a>", contentArray[i], fileName];
                }else{
                    newContent = [NSString stringWithFormat:@"%@%@%@</a>", newContent, fileNameArray[i], fileName];
                }
            }
            content = newContent;
        }
        
        titleLabel.text = title;
        
        CGSize constraint = CGSizeMake(_MainScreen_Width-26, 200);
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
        titleHeightConstraint.constant = size.height;
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSInteger t = [addtime integerValue];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:t];
        timeLabel.text = [formatter stringFromDate:confromTimesp];
        
        [contentWeb loadHTMLString:content baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
        //        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)refreshDetail:(id)sender{
    [self getDetails];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }else{
        return YES;
    }
}

@end
