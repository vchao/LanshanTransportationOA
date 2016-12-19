//
//  LTMailDetailViewController.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/19.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTMailDetailViewController : UIViewController <UIWebViewDelegate>{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *senderLabel;
    IBOutlet UILabel *revicerLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UIWebView *contentWeb;
    
    IBOutlet UIButton *replayBtn;
    IBOutlet UIButton *zhuanfaBtn;
    IBOutlet UIButton *zhuanfaBtn2;
    
    IBOutlet NSLayoutConstraint *zhuanfaWidthConstraint;
    IBOutlet NSLayoutConstraint *zhuanfaLeftConstraint;
    
    NSDictionary *infoDictionary;
    
    BOOL isLoaded;
    
    NSMutableDictionary *detailDict;
}

@property (nonatomic, copy) NSDictionary *infoDictionary;

@end
