//
//  LTReviceFileTableViewCell.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/16.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTReviceFileTableViewCell.h"

@implementation LTReviceFileTableViewCell

@synthesize liuchengBtn;

- (void)initWithDictionary:(NSDictionary *)cellDictionary {
    NSString *cont = [cellDictionary objectForKey:@"title"];
    cont = [cont stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    contentLabel.text = cont;
    
    wenhaoLabel.text = [NSString stringWithFormat:@"【%@】",[cellDictionary objectForKey:@"wenhao"]];
    userLabel.text = [cellDictionary objectForKey:@"danwei"];
    
    //    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterMediumStyle];
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //    NSInteger t = [[cellDictionary objectForKey:@"addtime"] integerValue];
    //    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:t];
    timeLabel.text = [cellDictionary objectForKey:@"swtime"];
    
    UIImage *loginBg = SY_IMAGE(@"pic_btn_normal_gray");
    UIEdgeInsets logininsets = UIEdgeInsetsMake(5, 5, 5, 5);
    loginBg = [loginBg resizableImageWithCapInsets:logininsets];
    [liuchengBtn setBackgroundImage:loginBg forState:UIControlStateNormal];
    [liuchengBtn setBackgroundImage:[SY_IMAGE(@"pic_btn_pressed_gray") resizableImageWithCapInsets:logininsets] forState:UIControlStateHighlighted];
    liuchengBtn.tag = [[cellDictionary objectForKey:@"id"] integerValue];
}

@end
