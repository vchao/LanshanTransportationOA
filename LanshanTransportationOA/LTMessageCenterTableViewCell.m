//
//  LTMessageCenterTableViewCell.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/20.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTMessageCenterTableViewCell.h"

@implementation LTMessageCenterTableViewCell

- (void)initWithDictionary:(NSDictionary *)cellDictionary {
    NSString *cont = [cellDictionary objectForKey:@"title"];
    cont = [cont stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    titleLabel.text = cont;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSInteger t = [[cellDictionary objectForKey:@"addtime"] integerValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:t];
    timeLabel.text = [formatter stringFromDate:confromTimesp];
}

@end
