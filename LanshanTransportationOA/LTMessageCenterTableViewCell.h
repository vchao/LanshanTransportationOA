//
//  LTMessageCenterTableViewCell.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/20.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTMessageCenterTableViewCell : UITableViewCell {
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *timeLabel;
}

- (void)initWithDictionary:(NSDictionary *)cellDictionary;

@end
