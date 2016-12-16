//
//  LTReviceFileTableViewCell.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/16.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTReviceFileTableViewCell : UITableViewCell {
    IBOutlet UILabel *contentLabel;
    IBOutlet UILabel *userLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UIButton *liuchengBtn;
}

@property (nonatomic, retain) UIButton *liuchengBtn;

- (void)initWithDictionary:(NSDictionary *)cellDictionary;

@end
