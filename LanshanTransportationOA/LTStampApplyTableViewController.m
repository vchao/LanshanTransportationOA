//
//  LTStampApplyTableViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/19.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTStampApplyTableViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"
#import "LTAlertView.h"
#import "AssetsLibrary/AssetsLibrary.h"

@interface LTStampApplyTableViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>{
    UIScrollView *scrollView;
    UITextField *danweiField;
    UITextField *shiyouField;
    
    UIView      *fujianView;
    UIView      *fileLineHView;
    
    UIView      *bottomView;
    UIButton    *submitBtn;
    
    NSArray     *stampTypeArray;
    NSArray     *stampItemArray;
    NSArray     *shenpiArray;
    
    NSArray     *fromArray;
}

@property (nonatomic, strong) UILabel     *timeLabel;
@property (nonatomic, strong) NSString    *timeStr;
@property (nonatomic, strong) NSArray     *typeItemArray;
@property (nonatomic, strong) UILabel     *typeLabel;//印鉴类型
@property (nonatomic, strong) NSArray     *itemItemArray;
@property (nonatomic, strong) UILabel     *itemLabel;//事项分类

@property (nonatomic, strong) NSMutableArray *fileArray;
@property (nonatomic, strong) NSMutableArray *fileNameArray;

@property (nonatomic, strong) NSArray     *shenpiItemArray;
@property (nonatomic, strong) UILabel     *shenpiLabel;//审批人

@end

@implementation LTStampApplyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _fileArray = [NSMutableArray new];
    _fileNameArray = [NSMutableArray new];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    UILabel *timeDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    timeDescLabel.text = @"时      间";
    timeDescLabel.textColor = [UIColor grayColor];
    timeDescLabel.textAlignment = NSTextAlignmentCenter;
    timeDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:timeDescLabel];
    
    UILabel *xingLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 14, 40)];
    xingLabel1.text = @"*";
    xingLabel1.textColor = [UIColor redColor];
    xingLabel1.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel1];
    
    UIView *lineHView1 = [[UIView alloc] initWithFrame:CGRectMake(90, 4, 0.5, 32)];
    lineHView1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView1];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, 0, _MainScreen_Width-106, 40)];
    self.timeLabel.text = @"请选择时间";
    self.timeLabel.tintColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:self.timeLabel];
    UIView *timeTapView = [[UIView alloc] initWithFrame:self.timeLabel.frame];
    [scrollView addSubview:timeTapView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecteDateTime)];
    [timeTapView addGestureRecognizer:tap];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, _MainScreen_Width, 0.5)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView1];
    
    UILabel *danweiDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeDescLabel.frame), 80, 40)];
    danweiDescLabel.text = @"用印单位";
    danweiDescLabel.textColor = [UIColor grayColor];
    danweiDescLabel.textAlignment = NSTextAlignmentCenter;
    danweiDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:danweiDescLabel];
    
    UILabel *xingLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(timeDescLabel.frame), 14, 40)];
    xingLabel2.text = @"*";
    xingLabel2.textColor = [UIColor redColor];
    xingLabel2.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel2];
    
    UIView *lineHView2 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(timeDescLabel.frame), 0.5, 32)];
    lineHView2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView2];
    
    danweiField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(timeDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    danweiField.placeholder = @"请输入用印单位";
    danweiField.tintColor = [UIColor grayColor];
    danweiField.font = [UIFont systemFontOfSize:14.f];
    danweiField.layer.borderColor = [UIColor grayColor].CGColor;
    danweiField.layer.borderWidth = 0.5;
    [scrollView addSubview:danweiField];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(danweiDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView2];
    
    UILabel *shiyouDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(danweiDescLabel.frame), 80, 40)];
    shiyouDescLabel.text = @"事      由";
    shiyouDescLabel.textColor = [UIColor grayColor];
    shiyouDescLabel.textAlignment = NSTextAlignmentCenter;
    shiyouDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:shiyouDescLabel];
    
    UILabel *xingLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(danweiDescLabel.frame), 14, 40)];
    xingLabel3.text = @"*";
    xingLabel3.textColor = [UIColor redColor];
    xingLabel3.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel3];
    
    UIView *lineHView3 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(danweiDescLabel.frame), 0.5, 32)];
    lineHView3.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView3];
    
    shiyouField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(danweiDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    shiyouField.placeholder = @"请输入事由";
    shiyouField.tintColor = [UIColor grayColor];
    shiyouField.font = [UIFont systemFontOfSize:14.f];
    shiyouField.layer.borderColor = [UIColor grayColor].CGColor;
    shiyouField.layer.borderWidth = 0.5;
    [scrollView addSubview:shiyouField];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shiyouDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView3];
    
    UILabel *typeDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shiyouDescLabel.frame), 80, 40)];
    typeDescLabel.text = @"印鉴类型";
    typeDescLabel.textColor = [UIColor grayColor];
    typeDescLabel.textAlignment = NSTextAlignmentCenter;
    typeDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:typeDescLabel];
    
    UILabel *xingLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(shiyouDescLabel.frame), 14, 40)];
    xingLabel4.text = @"*";
    xingLabel4.textColor = [UIColor redColor];
    xingLabel4.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel4];
    
    UIView *lineHView4 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(shiyouDescLabel.frame), 0.5, 32)];
    lineHView4.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView4];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(shiyouDescLabel.frame), _MainScreen_Width-106, 40)];
    self.typeLabel.textColor = [UIColor grayColor];
    self.typeLabel.font = [UIFont systemFontOfSize:14.f];
    self.typeLabel.text = @"请选择印鉴类型";
    [scrollView addSubview:self.typeLabel];
    
    UIView *typeView = [[UIView alloc] initWithFrame:self.typeLabel.frame];
    [scrollView addSubview:typeView];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkStampType)];
    [typeView addGestureRecognizer:tap2];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(typeDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView4.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView4];
    
    UILabel *shixiangDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(typeDescLabel.frame), 80, 40)];
    shixiangDescLabel.text = @"事项分类";
    shixiangDescLabel.textColor = [UIColor grayColor];
    shixiangDescLabel.textAlignment = NSTextAlignmentCenter;
    shixiangDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:shixiangDescLabel];
    
    UILabel *xingLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(typeDescLabel.frame), 14, 40)];
    xingLabel5.text = @"*";
    xingLabel5.textColor = [UIColor redColor];
    xingLabel5.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel5];
    
    UIView *lineHView5 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(typeDescLabel.frame), 0.5, 32)];
    lineHView5.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView5];
    
    self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(typeDescLabel.frame), _MainScreen_Width-106, 40)];
    self.itemLabel.textColor = [UIColor grayColor];
    self.itemLabel.font = [UIFont systemFontOfSize:14.f];
    self.itemLabel.text = @"请选择事项分类";
    [scrollView addSubview:self.itemLabel];
    
    UIView *itemView = [[UIView alloc] initWithFrame:self.itemLabel.frame];
    [scrollView addSubview:itemView];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkStampItem)];
    [itemView addGestureRecognizer:tap3];
    
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shixiangDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView5.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView5];
    
    UILabel *fjDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(shixiangDescLabel.frame), _MainScreen_Width-24, 40)];
    fjDescLabel.textColor = [UIColor grayColor];
    fjDescLabel.font = [UIFont systemFontOfSize:14.f];
    fjDescLabel.text = @"附件格式：img,ong,gif,jpg,jpeg,doc,docx,pdf,xls,xlsx";
    [scrollView addSubview:fjDescLabel];
    
    UIView *lineView9 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fjDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView9.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView9];
    
    UIButton *fjBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(fjDescLabel.frame)+4, 32, 32)];
    [fjBtn setImage:[UIImage imageNamed:@"ic_doc_add_attach"] forState:UIControlStateNormal];
    [fjBtn setImage:[UIImage imageNamed:@"ic_doc_add_attach"] forState:UIControlStateHighlighted];
    [fjBtn addTarget:self action:@selector(fujianAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:fjBtn];
    
    fileLineHView = [[UIView alloc] initWithFrame:CGRectMake(60, 4+CGRectGetMaxY(fjDescLabel.frame), 0.5, 32)];
    fileLineHView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:fileLineHView];
    
    fujianView = [[UIView alloc] initWithFrame:CGRectMake(72, CGRectGetMaxY(fjDescLabel.frame), _MainScreen_Width-80, 40)];
    [scrollView addSubview:fujianView];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fujianView.frame), _MainScreen_Height, 96)];
    [scrollView addSubview:bottomView];
    
    UIView *lineView10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, 0.5)];
    lineView10.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:lineView10];
    
    UILabel *shDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView10.frame), 80, 40)];
    shDescLabel.text = @"审  批  人";
    shDescLabel.textColor = [UIColor grayColor];
    shDescLabel.textAlignment = NSTextAlignmentCenter;
    shDescLabel.font = [UIFont systemFontOfSize:14.f];
    [bottomView addSubview:shDescLabel];
    
    UILabel *xingLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(shDescLabel.frame), 14, 40)];
    xingLabel6.text = @"*";
    xingLabel6.textColor = [UIColor redColor];
    xingLabel6.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel6];
    
    UIView *lineHView10 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(lineView10.frame), 0.5, 32)];
    lineHView10.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:lineHView10];
    
    self.shenpiLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(lineView10.frame)+4, _MainScreen_Width-106, 32)];
    self.shenpiLabel.textColor = [UIColor orangeColor];
    self.shenpiLabel.font = [UIFont systemFontOfSize:14.f];
    self.shenpiLabel.text = @"请选择审批人";
    [bottomView addSubview:self.shenpiLabel];
    
    UIView *shenpiView = [[UIView alloc] initWithFrame:self.shenpiLabel.frame];
    [bottomView addSubview:shenpiView];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkStampShenpi)];
    [shenpiView addGestureRecognizer:tap4];
    
    UIView *lineView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView11.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:lineView11];
    
    submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(lineView11.frame)+8, _MainScreen_Width-16, 40)];
    submitBtn.backgroundColor = [UIColor colorWithRed:32.f/255.f green:148.f/255.f blue:254/255.f alpha:1.f];
    submitBtn.layer.cornerRadius = 4.f;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submitBtn];
    
    scrollView.contentSize = CGSizeMake(_MainScreen_Width, CGRectGetMaxY(bottomView.frame));
    
    [self getStampType];
}

- (void)selecteDateTime{
    UIAlertController *alert = nil;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [alert.view addSubview:datePicker];
        __weak typeof(self)weakself = self;
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSDate *date = datePicker.date;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSString *dateString = [dateFormatter stringFromDate:date];
            weakself.timeLabel.text = dateString;
            weakself.timeStr = dateString;
        }];
        [alert addAction:cancel];
    }
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (void)fujianAction:(id)sender
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    choiceSheet.tag = 102;
    [choiceSheet showInView:self.view];
}

- (void)submitAction
{
    if (!self.timeStr || self.timeStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择用印时间"];
    }else if (!self.typeItemArray || self.typeItemArray.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择印鉴类型"];
    }if (!self.itemItemArray || self.itemItemArray.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择事项分类"];
    }if (!danweiField.text || danweiField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入用印单位"];
    }if (!shiyouField.text || shiyouField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入事由"];
    }else{
        [SVProgressHUD showWithStatus:@"提交中..."];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSInteger uid = [userDefaults integerForKey:USER_ID];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/stamp.php?act=add&uid=%ld", API_DOMAIN, uid];
        
        NSString *typeStr = @"";
        for (int i = 0; i < self.typeItemArray.count; i++) {
            NSDictionary *dict = [self.typeItemArray objectAtIndex:i];
            if (i == 0) {
                typeStr = [dict objectForKey:@"id"];
            }else{
                typeStr = [NSString stringWithFormat:@"%@|%@",typeStr, [dict objectForKey:@"id"]];
            }
        }
        NSString *itemStr = @"";
        for (int i = 0; i < self.itemItemArray.count; i++) {
            NSDictionary *dict = [self.itemItemArray objectAtIndex:i];
            if (i == 0) {
                itemStr = [dict objectForKey:@"id"];
            }else{
                itemStr = [NSString stringWithFormat:@"%@|%@",itemStr, [dict objectForKey:@"id"]];
            }
        }
        NSString *appUserStr = @"";
        for (int i = 0; i < self.shenpiItemArray.count; i++) {
            NSDictionary *dict = [self.shenpiItemArray objectAtIndex:i];
            if (i == 0) {
                appUserStr = [dict objectForKey:@"id"];
            }else{
                appUserStr = [NSString stringWithFormat:@"%@|%@",appUserStr, [dict objectForKey:@"id"]];
            }
        }
        NSDictionary *parameters = @{@"type": typeStr,
                                     @"time": self.timeStr,
                                     @"danwei": danweiField.text?danweiField.text:@"",
                                     @"item": itemStr,
                                     @"shiyou": shiyouField.text?shiyouField.text:@"",
                                     @"appuser": appUserStr};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (int i = 0; i < _fileArray.count; i++) {
                NSData *dd = _fileArray[i];
                NSString *name = _fileNameArray[i];
                if (dd && name) {
                    [formData appendPartWithFileData:dd name:[NSString stringWithFormat:@"file[%d]", i] fileName:name mimeType:@"image/jpeg"];
                }
            }
        } success:^(AFHTTPRequestOperation *operation,id responseObject) {
            [SVProgressHUD dismiss];
            //            NSDictionary *resultDict = [responseObject JSONValue];
            //            if ([[resultDict objectForKey:@"state"] isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
            //            }
        } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD showSuccessWithStatus:@"提交失败"];
        }];
    }
}

- (void)checkStampType
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    LTMultiSelectAlertView *alertView = [[LTMultiSelectAlertView alloc] initWithArray:stampTypeArray title:@"选择印鉴类型"];
    __weak typeof(self)weakself = self;
    alertView.confirmButtonClicked = ^(NSArray *array){
        if (array.count) {
            weakself.typeItemArray = array;
            NSString *typeStr = @"";
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dict = array[i];
                if (i == 0) {
                    typeStr = [dict objectForKey:@"name"];
                }else{
                    typeStr = [NSString stringWithFormat:@"%@,%@", typeStr, [dict objectForKey:@"name"]];
                }
            }
            weakself.typeLabel.text = typeStr;
        }
    };
    alertView.cancelButtonClicked = ^{
        
    };
    [self.navigationController.view addSubview:alertView];
}

- (void)checkStampItem
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    LTMultiSelectAlertView *alertView = [[LTMultiSelectAlertView alloc] initWithArray:stampItemArray title:@"选择事项分类"];
    __weak typeof(self)weakself = self;
    alertView.confirmButtonClicked = ^(NSArray *array){
        if (array.count) {
            weakself.itemItemArray = array;
            NSString *typeStr = @"";
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dict = array[i];
                if (i == 0) {
                    typeStr = [dict objectForKey:@"name"];
                }else{
                    typeStr = [NSString stringWithFormat:@"%@,%@", typeStr, [dict objectForKey:@"name"]];
                }
            }
            weakself.itemLabel.text = typeStr;
        }
    };
    alertView.cancelButtonClicked = ^{
        
    };
    [self.navigationController.view addSubview:alertView];
}

- (void)checkStampShenpi
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    LTMultiSelectAlertView *alertView = [[LTMultiSelectAlertView alloc] initWithArray:shenpiArray title:@"选择审批人"];
    __weak typeof(self)weakself = self;
    alertView.confirmButtonClicked = ^(NSArray *array){
        if (array.count) {
            weakself.shenpiItemArray = array;
            NSString *typeStr = @"";
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dict = array[i];
                if (i == 0) {
                    typeStr = [dict objectForKey:@"name"];
                }else{
                    typeStr = [NSString stringWithFormat:@"%@,%@", typeStr, [dict objectForKey:@"name"]];
                }
            }
            weakself.shenpiLabel.text = typeStr;
        }
    };
    alertView.cancelButtonClicked = ^{
        
    };
    [self.navigationController.view addSubview:alertView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取印鉴类别
- (void)getStampType{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/stamp.php?act=get_type",
                           API_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *resultDict = [responseObject JSONValue];
        stampTypeArray = [resultDict objectForKey:@"info"];
        [self getStampItem];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

//获取印鉴使用事项
- (void)getStampItem{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/stamp.php?act=get_item",
                           API_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *resultDict = [responseObject JSONValue];
        stampItemArray = [resultDict objectForKey:@"info"];
        [self getStampAppuser];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

//获取审批人
- (void)getStampAppuser{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    NSString *URLString = [NSString stringWithFormat:@"%@/stamp.php?act=appuser&uid=%ld", API_DOMAIN, uid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [responseObject JSONValue];
        shenpiArray = [dict objectForKey:@"user"];
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < shenpiArray.count; i++) {
            NSDictionary *d = [shenpiArray objectAtIndex:i];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[d objectForKey:@"id"], @"id", [d objectForKey:@"realname"], @"name", [d objectForKey:@"depart"], @"depart", nil];
            [array addObject:dict];
        }
        shenpiArray = [NSArray arrayWithArray:array];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 102) {//默认是本机
        if (buttonIndex == 0) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            imagePicker.allowsEditing = YES;
            [self presentModalViewController:imagePicker animated:YES];
        }else if (buttonIndex == 1) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            imagePicker.allowsEditing = YES;
            [self presentModalViewController:imagePicker animated:YES];
        }
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *uploadFileName = [representation filename];
        NSLog(@"fileName : %@",uploadFileName);
        UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        
        [self saveImage:image WithName:uploadFileName];
    };
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
    
    //    fileField.text = fullPathToFile;
    UIView *fjView = [[UIView alloc] initWithFrame:CGRectMake(0, self.fileArray.count*40, fujianView.frame.size.width, 40)];
    
    if (!self.fileArray.count) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fjView.frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [fjView addSubview:lineView];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
    imageView.image = [UIImage imageNamed:@"file_attach_img"];
    [fjView addSubview:imageView];
    
    UILabel *fileNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, fjView.frame.size.width-52, 40)];
    fileNameLabel.textColor = [UIColor grayColor];
    fileNameLabel.font = [UIFont systemFontOfSize:14.f];
    fileNameLabel.text = imageName;
    [fjView addSubview:fileNameLabel];
    
    UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fileNameLabel.frame), 10, 20, 20)];
    delBtn.backgroundColor = [UIColor clearColor];
    [delBtn setTitle:@"X" forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(delFileAction:) forControlEvents:UIControlEventTouchUpInside];
    delBtn.tag = self.fileArray.count+2000;
    [fjView addSubview:delBtn];
    
    [_fileArray addObject:imageData];
    [_fileNameArray addObject:imageName];
    
    [fujianView addSubview:fjView];
    CGRect rect = fujianView.frame;
    rect.size.height = (self.fileArray.count?self.fileArray.count:1)*40;
    fujianView.frame = rect;
    fileLineHView.frame = CGRectMake(60, fileLineHView.frame.origin.y, 0.5, rect.size.height-8);
    
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(fujianView.frame), _MainScreen_Height, 96);
    scrollView.contentSize = CGSizeMake(_MainScreen_Width, CGRectGetMaxY(bottomView.frame));
}

- (void)delFileAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger i = btn.tag-2000;
    if (_fileArray.count > i) {
        [_fileArray removeObjectAtIndex:i];
    }
    if (_fileNameArray.count > i) {
        [_fileNameArray removeObjectAtIndex:i];
    }
    
    [fujianView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int j = 0; j < _fileArray.count; j++) {
        UIView *fjView = [[UIView alloc] initWithFrame:CGRectMake(0, j*40, fujianView.frame.size.width, 40)];
        
        if (!j) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fjView.frame.size.width, 0.5)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [fjView addSubview:lineView];
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
        imageView.image = [UIImage imageNamed:@"file_attach_img"];
        [fjView addSubview:imageView];
        
        UILabel *fileNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, fjView.frame.size.width-52, 40)];
        fileNameLabel.textColor = [UIColor grayColor];
        fileNameLabel.font = [UIFont systemFontOfSize:14.f];
        fileNameLabel.text = _fileNameArray[j];
        [fjView addSubview:fileNameLabel];
        
        UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fileNameLabel.frame), 10, 20, 20)];
        delBtn.backgroundColor = [UIColor clearColor];
        [delBtn setTitle:@"X" forState:UIControlStateNormal];
        [delBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(delFileAction:) forControlEvents:UIControlEventTouchUpInside];
        delBtn.tag = self.fileArray.count+2000;
        [fjView addSubview:delBtn];
        
        [fujianView addSubview:fjView];
    }
    
    CGRect rect = fujianView.frame;
    rect.size.height = (self.fileArray.count?self.fileArray.count:1)*40;
    fujianView.frame = rect;
    fileLineHView.frame = CGRectMake(60, fileLineHView.frame.origin.y, 0.5, rect.size.height-8);
    
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(fujianView.frame), _MainScreen_Height, 96);
    scrollView.contentSize = CGSizeMake(_MainScreen_Width, CGRectGetMaxY(bottomView.frame));
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
