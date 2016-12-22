//
//  LTVacationApplyViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/22.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTVacationApplyViewController.h"
#import "LTAlertView.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"

@interface LTVacationApplyViewController ()
{
    UIScrollView *scrollView;
    UITextField *nameField;
    UITextField *shiyouField;
    
    UILabel     *startDateLabel;
    UILabel     *startTimeLabel;
    
    UILabel     *endDateLabel;
    UILabel     *endTimeLabel;
    
    UITextField *dayField;
    
    UILabel     *shenpiLabel;//审批人
    
    UIView      *bottomView;
    UIButton    *resetBtn;
    UIButton    *submitBtn;
    
    NSArray     *shenpiArray;
    
    NSString    *pageType;
}

@property (nonatomic, strong) NSArray     *shenpiItemArray;
@property (nonatomic, copy) NSString      *pageType;

@end

@implementation LTVacationApplyViewController

@synthesize pageType;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height-56)];
    [self.view addSubview:scrollView];
    
    shenpiArray = [NSMutableArray new];
    
    UILabel *nameDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    nameDescLabel.text = @"请假人员";
    nameDescLabel.textColor = [UIColor grayColor];
    nameDescLabel.textAlignment = NSTextAlignmentCenter;
    nameDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:nameDescLabel];
    
    UILabel *xingLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 14, 40)];
    xingLabel1.text = @"*";
    xingLabel1.textColor = [UIColor redColor];
    xingLabel1.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel1];
    
    UIView *lineHView1 = [[UIView alloc] initWithFrame:CGRectMake(90, 4, 0.5, 32)];
    lineHView1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView1];
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(98, 4, _MainScreen_Width-106, 32)];
    nameField.placeholder = @"请输入请假人员";
    nameField.tintColor = [UIColor grayColor];
    nameField.font = [UIFont systemFontOfSize:14.f];
    nameField.layer.borderColor = [UIColor grayColor].CGColor;
    nameField.layer.borderWidth = 0.5;
    [scrollView addSubview:nameField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, _MainScreen_Width, 0.5)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView1];
    
    UILabel *shiyouDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameDescLabel.frame), 80, 40)];
    shiyouDescLabel.text = @"请假事由";
    shiyouDescLabel.textColor = [UIColor grayColor];
    shiyouDescLabel.textAlignment = NSTextAlignmentCenter;
    shiyouDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:shiyouDescLabel];
    
    UILabel *xingLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(nameDescLabel.frame), 14, 40)];
    xingLabel2.text = @"*";
    xingLabel2.textColor = [UIColor redColor];
    xingLabel2.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel2];
    
    UIView *lineHView2 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(nameDescLabel.frame), 0.5, 32)];
    lineHView2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView2];
    
    shiyouField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(nameDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    shiyouField.placeholder = @"请输入请假事由";
    shiyouField.tintColor = [UIColor grayColor];
    shiyouField.font = [UIFont systemFontOfSize:14.f];
    shiyouField.layer.borderColor = [UIColor grayColor].CGColor;
    shiyouField.layer.borderWidth = 0.5;
    [scrollView addSubview:shiyouField];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shiyouDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView2];
    
    UILabel *startDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shiyouDescLabel.frame), 80, 40)];
    startDescLabel.text = @"开始时间";
    startDescLabel.textColor = [UIColor grayColor];
    startDescLabel.textAlignment = NSTextAlignmentCenter;
    startDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:startDescLabel];
    
    UILabel *xingLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(shiyouDescLabel.frame), 14, 40)];
    xingLabel4.text = @"*";
    xingLabel4.textColor = [UIColor redColor];
    xingLabel4.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel4];
    
    UIView *lineHView4 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(shiyouDescLabel.frame), 0.5, 32)];
    lineHView4.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView4];
    
    CGFloat timeW = (_MainScreen_Width-106)/2.f;
    startDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(shiyouDescLabel.frame), timeW, 40)];
    startDateLabel.userInteractionEnabled = YES;
    startDateLabel.textColor = [UIColor grayColor];
    startDateLabel.font = [UIFont systemFontOfSize:14.f];
    startDateLabel.textAlignment = NSTextAlignmentCenter;
    startDateLabel.text = @"选择日期";
    [scrollView addSubview:startDateLabel];
    UITapGestureRecognizer *tapStartDate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecteDateAction:)];
    [startDateLabel addGestureRecognizer:tapStartDate];
    
    UIView *lineHViewTime1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startDateLabel.frame), 4+CGRectGetMaxY(shiyouDescLabel.frame), 0.5, 32)];
    lineHViewTime1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHViewTime1];
    
    startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startDateLabel.frame), CGRectGetMaxY(shiyouDescLabel.frame), timeW, 40)];
    startTimeLabel.textColor = [UIColor grayColor];
    startTimeLabel.userInteractionEnabled = YES;
    startTimeLabel.font = [UIFont systemFontOfSize:14.f];
    startTimeLabel.textAlignment = NSTextAlignmentCenter;
    startTimeLabel.text = @"选择时间";
    [scrollView addSubview:startTimeLabel];
    UITapGestureRecognizer *tapStartTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecteTimeAction:)];
    [startTimeLabel addGestureRecognizer:tapStartTime];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(startDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView4.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView4];
    
    UILabel *endDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(startDescLabel.frame), 80, 40)];
    endDescLabel.text = @"结束时间";
    endDescLabel.textColor = [UIColor grayColor];
    endDescLabel.textAlignment = NSTextAlignmentCenter;
    endDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:endDescLabel];
    
    UILabel *xingLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(startDescLabel.frame), 14, 40)];
    xingLabel5.text = @"*";
    xingLabel5.textColor = [UIColor redColor];
    xingLabel5.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel5];
    
    UIView *lineHView5 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(startDescLabel.frame), 0.5, 32)];
    lineHView5.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView5];
    
    endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(startDescLabel.frame), timeW, 40)];
    endDateLabel.userInteractionEnabled = YES;
    endDateLabel.textColor = [UIColor grayColor];
    endDateLabel.font = [UIFont systemFontOfSize:14.f];
    endDateLabel.textAlignment = NSTextAlignmentCenter;
    endDateLabel.text = @"选择日期";
    [scrollView addSubview:endDateLabel];
    UITapGestureRecognizer *tapEndDate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecteDateAction:)];
    [endDateLabel addGestureRecognizer:tapEndDate];
    
    UIView *lineHViewTime2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(endDateLabel.frame), 4+CGRectGetMaxY(startDescLabel.frame), 0.5, 32)];
    lineHViewTime2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHViewTime2];
    
    endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(endDateLabel.frame), CGRectGetMaxY(startDescLabel.frame), timeW, 40)];
    endTimeLabel.userInteractionEnabled = YES;
    endTimeLabel.textColor = [UIColor grayColor];
    endTimeLabel.font = [UIFont systemFontOfSize:14.f];
    endTimeLabel.textAlignment = NSTextAlignmentCenter;
    endTimeLabel.text = @"选择时间";
    [scrollView addSubview:endTimeLabel];
    UITapGestureRecognizer *tapEndTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecteTimeAction:)];
    [endTimeLabel addGestureRecognizer:tapEndTime];
    
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(endDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView5.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView5];
    
    UILabel *dayDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(endDescLabel.frame), 80, 40)];
    dayDescLabel.text = @"请假天数";
    dayDescLabel.textColor = [UIColor grayColor];
    dayDescLabel.textAlignment = NSTextAlignmentCenter;
    dayDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:dayDescLabel];
    
    UILabel *xingLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(endDescLabel.frame), 14, 40)];
    xingLabel6.text = @"*";
    xingLabel6.textColor = [UIColor redColor];
    xingLabel6.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel6];
    
    UIView *lineHView6 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(endDescLabel.frame), 0.5, 32)];
    lineHView6.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView6];
    
    dayField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(endDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    dayField.placeholder = @"请输入请假天数";
    dayField.tintColor = [UIColor grayColor];
    dayField.font = [UIFont systemFontOfSize:14.f];
    dayField.layer.borderColor = [UIColor grayColor].CGColor;
    dayField.layer.borderWidth = 0.5;
    [scrollView addSubview:dayField];
    
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dayDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView6.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView6];
    
    UILabel *shDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dayDescLabel.frame), 80, 40)];
    shDescLabel.text = @"审  批  人";
    shDescLabel.textColor = [UIColor grayColor];
    shDescLabel.textAlignment = NSTextAlignmentCenter;
    shDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:shDescLabel];
    
    UILabel *xingLabel7 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(dayDescLabel.frame), 14, 40)];
    xingLabel7.text = @"*";
    xingLabel7.textColor = [UIColor redColor];
    xingLabel7.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel7];
    
    UIView *lineHView10 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(dayDescLabel.frame), 0.5, 32)];
    lineHView10.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView10];
    
    shenpiLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(dayDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    shenpiLabel.userInteractionEnabled = YES;
    shenpiLabel.textColor = [UIColor orangeColor];
    shenpiLabel.font = [UIFont systemFontOfSize:14.f];
    shenpiLabel.text = @"请选择审批人";
    [scrollView addSubview:shenpiLabel];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkShenpiAction:)];
    [shenpiLabel addGestureRecognizer:tap4];
    
    UIView *lineView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView11.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView11];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _MainScreen_Height-56, _MainScreen_Height, 56)];
    [self.view addSubview:bottomView];
    
    CGFloat btnW = (_MainScreen_Width-24)/2.f;
    submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 8, btnW, 40)];
    submitBtn.backgroundColor = [UIColor colorWithRed:32.f/255.f green:148.f/255.f blue:254/255.f alpha:1.f];
    submitBtn.layer.cornerRadius = 4.f;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submitBtn];
    
    resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(16+btnW, 8, btnW, 40)];
    resetBtn.backgroundColor = [UIColor whiteColor];
    resetBtn.layer.cornerRadius = 4.f;
    resetBtn.layer.masksToBounds = YES;
    resetBtn.layer.borderColor = [UIColor grayColor].CGColor;
    resetBtn.layer.borderWidth = 0.5;
    [resetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:resetBtn];
    
    scrollView.contentSize = CGSizeMake(_MainScreen_Width, CGRectGetMaxY(lineView11.frame));
    
    if ([pageType isEqualToString:@"vacation"]) {
        self.title = @"休假申请";
        nameDescLabel.text = @"休假人员";
        nameField.placeholder = @"请输入休假人员";
        shiyouDescLabel.text = @"休假事由";
        shiyouField.placeholder = @"请输入休假事由";
        dayDescLabel.text = @"休假天数";
        dayField.placeholder = @"请输入休假天数";
    }else if ([pageType isEqualToString:@"leave"]) {
        self.title = @"请假申请";
        nameDescLabel.text = @"请假人员";
        nameField.placeholder = @"请输入请假人员";
        shiyouDescLabel.text = @"请假事由";
        shiyouField.placeholder = @"请输入请假事由";
        dayDescLabel.text = @"请假天数";
        dayField.placeholder = @"请输入请假天数";
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardShow:(NSNotification *)notif {
    NSDictionary *userInfo = [notif userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    scrollView.frame = CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height-keyboardRect.size.height-56);
    bottomView.frame = CGRectMake(0, _MainScreen_Height-56-keyboardRect.size.height, _MainScreen_Width, 56);
}

- (void)keyboardWillHide:(NSNotification *)notif {
    scrollView.frame = CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height-56);
    bottomView.frame = CGRectMake(0, _MainScreen_Height-56, _MainScreen_Width, 56);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selecteDateAction:(UITapGestureRecognizer *)gusture{
    UIAlertController *alert = nil;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [alert.view addSubview:datePicker];
        __block UILabel *label = (UILabel *)gusture.view;
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSDate *date = datePicker.date;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSString *dateString = [dateFormatter stringFromDate:date];
            label.text = dateString;
        }];
        [alert addAction:cancel];
    }
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (void)selecteTimeAction:(UITapGestureRecognizer *)gusture
{
    UIAlertController *alert = nil;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeTime;
        [alert.view addSubview:datePicker];
        __block UILabel *label = (UILabel *)gusture.view;
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSDate *date = datePicker.date;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm:ss"];
            NSString *dateString = [dateFormatter stringFromDate:date];
            label.text = dateString;
        }];
        [alert addAction:cancel];
    }
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (void)checkShenpiAction:(UITapGestureRecognizer *)gusture
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    __block UILabel *label = (UILabel *)gusture.view;
    LTMultiSelectAlertView *alertView = [[LTMultiSelectAlertView alloc] initWithArray:shenpiArray title:@"选择审批人" listTitlekey:@"realname" canSelectAll:NO];
    __weak typeof(self)weakself = self;
    alertView.confirmButtonClicked = ^(NSArray *array){
        if (array.count) {
            weakself.shenpiItemArray = array;
            NSString *typeStr = @"";
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dict = array[i];
                if (i == 0) {
                    typeStr = [dict objectForKey:@"realname"];
                }else{
                    typeStr = [NSString stringWithFormat:@"%@,%@", typeStr, [dict objectForKey:@"realname"]];
                }
            }
            label.text = typeStr;
        }
    };
    alertView.cancelButtonClicked = ^{
        
    };
    [self.navigationController.view addSubview:alertView];
}

- (void)resetAction
{
    nameField.text = @"";
    shiyouField.text = @"";
    startDateLabel.text = @"选择日期";
    startTimeLabel.text = @"选择时间";
    endDateLabel.text = @"选择日期";
    endTimeLabel.text = @"选择时间";
    dayField.text = @"";
    shenpiLabel.text = @"请选择审批人";
}

- (void)submitAction
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    NSString *URLString = [NSString stringWithFormat:@"%@/vacation.php?act=add&uid=%ld", API_DOMAIN, uid];
    
    NSString *typeStr = @"休假";
    if ([pageType isEqualToString:@"vacation"]) {
        typeStr = @"休假";
        URLString = [NSString stringWithFormat:@"%@/vacation.php?act=add&uid=%ld", API_DOMAIN, uid];
    }else if ([pageType isEqualToString:@"leave"]) {
        typeStr = @"请假";
        URLString = [NSString stringWithFormat:@"%@/leave.php?act=add&uid=%ld", API_DOMAIN, uid];
    }
    if ([startDateLabel.text isEqualToString:@"选择日期"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择开始日期"];
    }else if ([startTimeLabel.text isEqualToString:@"选择时间"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择开始时间"];
    }else if ([endDateLabel.text isEqualToString:@"选择日期"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择结束日期"];
    }else if ([endTimeLabel.text isEqualToString:@"选择时间"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择结束时间"];
    }else if (!nameField.text || nameField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入%@人员",  typeStr]];
    }else if (!shiyouField.text || shiyouField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入%@事由", typeStr]];
    }else if (!dayField.text || dayField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入%@天数", typeStr]];
    }else if ([shenpiLabel.text isEqualToString:@"请选择审批人"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择审批人"];
    }else{
        [SVProgressHUD showWithStatus:@"提交中..."];
        
        NSString *appUserStr = @"";
        for (int i = 0; i < self.shenpiItemArray.count; i++) {
            NSDictionary *dict = [self.shenpiItemArray objectAtIndex:i];
            if (i == 0) {
                appUserStr = [dict objectForKey:@"id"];
            }else{
                appUserStr = [NSString stringWithFormat:@"%@|%@",appUserStr, [dict objectForKey:@"id"]];
            }
        }
        NSDictionary *parameters = @{@"name": nameField.text?nameField.text:@"",
                                     @"starttime": [NSString stringWithFormat:@"%@ %@", startDateLabel.text, startTimeLabel],
                                     @"endtime": [NSString stringWithFormat:@"%@ %@", endDateLabel.text, endTimeLabel],
                                     @"shiyou": shiyouField.text?shiyouField.text:@"",
                                     @"day": dayField.text?dayField.text:@"",
                                     @"appuser": appUserStr};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
//            [self.navigationController popViewControllerAnimated:YES];
            [self resetAction];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD showSuccessWithStatus:@"提交失败"];
        }];
    }
}

- (IBAction)applyListAction:(id)sender {
    [self performSegueWithIdentifier:@"pushToApplyList" sender:@"applyList"];
}

#pragma mark - 导航

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *viewController = segue.destinationViewController;
    if ([sender isEqualToString:@"applyList"]) {
        if ([viewController respondsToSelector:@selector(setPageType:)]) {
            [viewController setValue:pageType forKey:@"pageType"];
        }
    }
}

@end
