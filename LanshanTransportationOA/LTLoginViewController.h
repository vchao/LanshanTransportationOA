//
//  LTLoginViewController.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/15.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLoginViewController : UIViewController{
    __weak IBOutlet UIImageView *inputBgView;
    __weak IBOutlet UITextField *usernameField;
    __weak IBOutlet UITextField *passField;
    __weak IBOutlet UIButton *remPassBtn;
    __weak IBOutlet UIButton *loginBtn;
    __weak IBOutlet NSLayoutConstraint *loginLeftConstraint;
    __weak IBOutlet NSLayoutConstraint *logoLeftConstraint;
}

@end
