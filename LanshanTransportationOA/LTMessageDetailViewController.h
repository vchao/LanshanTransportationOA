//
//  LTMessageDetailViewController.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/20.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTMessageDetailViewController : UIViewController<UIWebViewDelegate> {
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UIWebView *contentWeb;
    
    IBOutlet NSLayoutConstraint *titleHeightConstraint;
    
    NSDictionary *infoDictionary;
}

@property (nonatomic, copy) NSDictionary *infoDictionary;

@end
