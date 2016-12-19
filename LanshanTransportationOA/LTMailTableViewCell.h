//
//  LTMailTableViewCell.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/19.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTMailTableViewCell : UITableViewCell {
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *senderLabel;
    IBOutlet UILabel *timeLabel;
}

- (void)initWithDictionary:(NSDictionary *)cellDictionary;

@end
