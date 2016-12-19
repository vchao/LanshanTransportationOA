//
//  LTMailSendViewController.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/19.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTMailSendViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIWebViewDelegate> {
    IBOutlet UITextField *revicerField;
    IBOutlet UIButton    *selectRevBtn;
    IBOutlet UITextField *titleField;
    IBOutlet UITextView  *contentView;
    IBOutlet UITextField *fileField;
    IBOutlet UIButton    *selectFileBtn;
    IBOutlet UIButton    *sendMsgBtn;
    IBOutlet UIButton    *sendBtn;
    IBOutlet UIButton    *delFileBtn;
    UIWebView *fjWebView;
    
    UITableView *personTableView;
    
    BOOL sendMsg;
    
    NSMutableDictionary *dic;//存对应的数据
    NSMutableArray *selectedArr;//二级列表是否展开状态
    NSMutableArray *titleDataArray;
    NSArray *dataArray;//数据源，显示每个cell的数据
    NSMutableArray *grouparr0;
    NSMutableArray *grouparr1;
    NSMutableArray *grouparr2;
    NSMutableArray *grouparr3;
    
    NSMutableArray *selectedArray;
    
    NSString *uploadFileName;
    
    NSDictionary *infoDictionary;
    
    NSString *zfFileId;
    
    BOOL isLoaded;
    IBOutlet NSLayoutConstraint *fjTopConstraint;
}

@property (nonatomic, copy) NSDictionary *infoDictionary;

@end
