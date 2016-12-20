//
//  LTFileReceiveRegisterViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/16.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTFileReceiveRegisterViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"
#import "LTAlertView.h"
#import "AssetsLibrary/AssetsLibrary.h"

@interface LTFileReceiveRegisterViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>{
    UIScrollView *scrollView;
    UITextField *bianhaoField;
    UITextField *wenhaoField;
    UITextField *fenshuField;
    UITextField *titleField;
    UITextView  *contentTextView;
    UITextView  *feedbackTextView;//拟办意见
    UIView      *fujianView;
    UIView      *fileLineHView;
    
    UIView      *bottomView;
    UILabel     *shenheLabel;
    UIButton    *submitBtn;
    
    NSArray     *typeArray;
    NSDictionary *nibanDict;
    
    NSArray     *fromArray;
}

@property (nonatomic, strong) NSDictionary *typeItem;
@property (nonatomic, strong) UILabel     *typeField;
@property (nonatomic, strong) NSDictionary *fromItem;
@property (nonatomic, strong) UILabel     *fromField;
@property (nonatomic, strong) UILabel     *timeField;
@property (nonatomic, strong) UITextField *jiezhiField;
@property (nonatomic, strong) NSMutableArray *fileArray;
@property (nonatomic, strong) NSMutableArray *fileNameArray;

@end

@implementation LTFileReceiveRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fileArray = [NSMutableArray new];
    _fileNameArray = [NSMutableArray new];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    UILabel *typeDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    typeDescLabel.text = @"来文类型";
    typeDescLabel.textColor = [UIColor grayColor];
    typeDescLabel.textAlignment = NSTextAlignmentCenter;
    typeDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:typeDescLabel];
    
    UILabel *xingLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 14, 40)];
    xingLabel1.text = @"*";
    xingLabel1.textColor = [UIColor redColor];
    xingLabel1.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel1];
    
    UIView *lineHView1 = [[UIView alloc] initWithFrame:CGRectMake(90, 4, 0.5, 32)];
    lineHView1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView1];
    
    self.typeField = [[UILabel alloc] initWithFrame:CGRectMake(98, 0, _MainScreen_Width-106, 40)];
    self.typeField.text = @"请选择收文类型";
    self.typeField.tintColor = [UIColor grayColor];
    self.typeField.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:self.typeField];
    UIView *typeView = [[UIView alloc] initWithFrame:self.typeField.frame];
    [scrollView addSubview:typeView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkFileType)];
    [typeView addGestureRecognizer:tap];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, _MainScreen_Width, 0.5)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView1];
    
    UILabel *timeDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(typeDescLabel.frame), 80, 40)];
    timeDescLabel.text = @"收文日期";
    timeDescLabel.textColor = [UIColor grayColor];
    timeDescLabel.textAlignment = NSTextAlignmentCenter;
    timeDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:timeDescLabel];
    
    UILabel *xingLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(typeDescLabel.frame), 14, 40)];
    xingLabel2.text = @"*";
    xingLabel2.textColor = [UIColor redColor];
    xingLabel2.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel2];
    
    UIView *lineHView2 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(typeDescLabel.frame), 0.5, 32)];
    lineHView2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView2];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    self.timeField = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(typeDescLabel.frame), _MainScreen_Width-106, 40)];
    self.timeField.text = dateString;
    self.timeField.tintColor = [UIColor grayColor];
    self.timeField.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:self.timeField];
    
    UIView *timeView = [[UIView alloc] initWithFrame:self.timeField.frame];
    [scrollView addSubview:timeView];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkReviceTime)];
    [timeView addGestureRecognizer:tap3];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView2];
    
    UILabel *fromDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeDescLabel.frame), 80, 40)];
    fromDescLabel.text = @"来文机关";
    fromDescLabel.textColor = [UIColor grayColor];
    fromDescLabel.textAlignment = NSTextAlignmentCenter;
    fromDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:fromDescLabel];
    
    UILabel *xingLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(timeDescLabel.frame), 14, 40)];
    xingLabel3.text = @"*";
    xingLabel3.textColor = [UIColor redColor];
    xingLabel3.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel3];
    
    UIView *lineHView3 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(timeDescLabel.frame), 0.5, 32)];
    lineHView3.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView3];
    
    self.fromField = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(timeDescLabel.frame), _MainScreen_Width-106, 40)];
    self.fromField.text = @"请选择来文机关";
    self.fromField.tintColor = [UIColor grayColor];
    self.fromField.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:self.fromField];
    
    UIView *fromView = [[UIView alloc] initWithFrame:self.fromField.frame];
    [scrollView addSubview:fromView];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkFileFrom)];
    [fromView addGestureRecognizer:tap2];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fromDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView3];
    
    UILabel *bhDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fromDescLabel.frame), 80, 40)];
    bhDescLabel.text = @"编      号";
    bhDescLabel.textColor = [UIColor grayColor];
    bhDescLabel.textAlignment = NSTextAlignmentCenter;
    bhDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:bhDescLabel];
    
    UILabel *xingLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(fromDescLabel.frame), 14, 40)];
    xingLabel4.text = @"*";
    xingLabel4.textColor = [UIColor redColor];
    xingLabel4.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel4];
    
    UIView *lineHView4 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(fromDescLabel.frame), 0.5, 32)];
    lineHView4.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView4];
    
    bianhaoField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(fromDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    bianhaoField.tintColor = [UIColor grayColor];
    bianhaoField.font = [UIFont systemFontOfSize:14.f];
    bianhaoField.layer.borderColor = [UIColor grayColor].CGColor;
    bianhaoField.layer.borderWidth = 0.5;
    [scrollView addSubview:bianhaoField];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bhDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView4.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView4];
    
    UILabel *whDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bhDescLabel.frame), 80, 40)];
    whDescLabel.text = @"文  件  号";
    whDescLabel.textColor = [UIColor grayColor];
    whDescLabel.textAlignment = NSTextAlignmentCenter;
    whDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:whDescLabel];
    
    UIView *lineHView5 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(bhDescLabel.frame), 0.5, 32)];
    lineHView5.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView5];
    
    wenhaoField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(bhDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    wenhaoField.tintColor = [UIColor grayColor];
    wenhaoField.font = [UIFont systemFontOfSize:14.f];
    wenhaoField.layer.borderColor = [UIColor grayColor].CGColor;
    wenhaoField.layer.borderWidth = 0.5;
    [scrollView addSubview:wenhaoField];
    
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(whDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView5.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView5];
    
    UILabel *fsDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(whDescLabel.frame), 80, 40)];
    fsDescLabel.text = @"来文份数";
    fsDescLabel.textColor = [UIColor grayColor];
    fsDescLabel.textAlignment = NSTextAlignmentCenter;
    fsDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:fsDescLabel];
    
    UILabel *xingLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(whDescLabel.frame), 14, 40)];
    xingLabel6.text = @"*";
    xingLabel6.textColor = [UIColor redColor];
    xingLabel6.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel6];
    
    UIView *lineHView6 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(whDescLabel.frame), 0.5, 32)];
    lineHView6.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView6];
    
    fenshuField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(whDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    fenshuField.tintColor = [UIColor grayColor];
    fenshuField.font = [UIFont systemFontOfSize:14.f];
    fenshuField.layer.borderColor = [UIColor grayColor].CGColor;
    fenshuField.layer.borderWidth = 0.5;
    [scrollView addSubview:fenshuField];
    
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fsDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView6.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView6];
    
    UILabel *titleDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fsDescLabel.frame), 80, 40)];
    titleDescLabel.text = @"文件标题";
    titleDescLabel.textColor = [UIColor grayColor];
    titleDescLabel.textAlignment = NSTextAlignmentCenter;
    titleDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:titleDescLabel];
    
    UILabel *xingLabel7 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(fsDescLabel.frame), 14, 40)];
    xingLabel7.text = @"*";
    xingLabel7.textColor = [UIColor redColor];
    xingLabel7.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel7];
    
    UIView *lineHView7 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(fsDescLabel.frame), 0.5, 32)];
    lineHView7.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView7];
    
    titleField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(fsDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    titleField.tintColor = [UIColor grayColor];
    titleField.font = [UIFont systemFontOfSize:14.f];
    titleField.layer.borderColor = [UIColor grayColor].CGColor;
    titleField.layer.borderWidth = 0.5;
    [scrollView addSubview:titleField];
    
    UIView *lineView7 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView7.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView7];
    
    UILabel *jzDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleDescLabel.frame), 80, 40)];
    jzDescLabel.text = @"截止日期";
    jzDescLabel.textColor = [UIColor grayColor];
    jzDescLabel.textAlignment = NSTextAlignmentCenter;
    jzDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:jzDescLabel];
    
    UIView *lineHView8 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(titleDescLabel.frame), 0.5, 32)];
    lineHView8.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView8];
    
    self.jiezhiField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(titleDescLabel.frame)+4, _MainScreen_Width-106-80, 32)];
    self.jiezhiField.tintColor = [UIColor grayColor];
    self.jiezhiField.placeholder = @"没有请填 无";
    self.jiezhiField.font = [UIFont systemFontOfSize:14.f];
    self.jiezhiField.layer.borderColor = [UIColor grayColor].CGColor;
    self.jiezhiField.layer.borderWidth = 0.5;
    [scrollView addSubview:self.jiezhiField];
    
    UIButton *tapDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.jiezhiField.frame), CGRectGetMaxY(titleDescLabel.frame), 80, 40)];
    tapDateBtn.backgroundColor = [UIColor clearColor];
    [tapDateBtn setTitle:@"请选择日期" forState:UIControlStateNormal];
    [tapDateBtn addTarget:self action:@selector(selecteDateTime) forControlEvents:UIControlEventTouchUpInside];
    [tapDateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    tapDateBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:tapDateBtn];
    
    UIView *lineView8 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(jzDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView8.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView8];
    
    UILabel *contentDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(jzDescLabel.frame), 80, 40)];
    contentDescLabel.textAlignment = NSTextAlignmentCenter;
    contentDescLabel.textColor = [UIColor grayColor];
    contentDescLabel.font = [UIFont systemFontOfSize:14.f];
    contentDescLabel.text = @"来文内容";
    [scrollView addSubview:contentDescLabel];
    
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(contentDescLabel.frame), _MainScreen_Width-24, 80)];
    contentTextView.layer.cornerRadius = 4.f;
    contentTextView.layer.masksToBounds = YES;
    contentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    contentTextView.layer.borderWidth = 0.5;
    contentTextView.font = [UIFont systemFontOfSize:14.f];
    contentTextView.textColor = [UIColor grayColor];
    [scrollView addSubview:contentTextView];
    
    UILabel *fdDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentTextView.frame), 80, 40)];
    fdDescLabel.textAlignment = NSTextAlignmentCenter;
    fdDescLabel.textColor = [UIColor grayColor];
    fdDescLabel.font = [UIFont systemFontOfSize:14.f];
    fdDescLabel.text = @"拟办意见";
    [scrollView addSubview:fdDescLabel];
    
    feedbackTextView = [[UITextView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(fdDescLabel.frame), _MainScreen_Width-24, 80)];
    feedbackTextView.layer.cornerRadius = 4.f;
    feedbackTextView.layer.masksToBounds = YES;
    feedbackTextView.layer.borderColor = [UIColor grayColor].CGColor;
    feedbackTextView.layer.borderWidth = 0.5;
    feedbackTextView.font = [UIFont systemFontOfSize:14.f];
    feedbackTextView.textColor = [UIColor grayColor];
    [scrollView addSubview:feedbackTextView];
    
    UILabel *fjDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(feedbackTextView.frame), _MainScreen_Width-24, 40)];
//    fjDescLabel.textAlignment = NSTextAlignmentCenter;
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
    shDescLabel.text = @"审  核  人";
    shDescLabel.textColor = [UIColor grayColor];
    shDescLabel.textAlignment = NSTextAlignmentCenter;
    shDescLabel.font = [UIFont systemFontOfSize:14.f];
    [bottomView addSubview:shDescLabel];
    
    UIView *lineHView10 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(lineView10.frame), 0.5, 32)];
    lineHView10.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:lineHView10];
    
    shenheLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(lineView10.frame)+4, _MainScreen_Width-106, 32)];
    shenheLabel.textColor = [UIColor orangeColor];
    shenheLabel.font = [UIFont systemFontOfSize:14.f];
    [bottomView addSubview:shenheLabel];
    
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
    
    [self getFileAddDetail];
}

- (void)checkReviceTime
{
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
            weakself.timeField.text = dateString;
        }];
        [alert addAction:cancel];
    }
    [self presentViewController:alert animated:YES completion:^{
    }];
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
            weakself.jiezhiField.text = dateString;
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
    if (!self.typeItem || self.typeItem.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择收文类别"];
    }else if (!self.fromItem || self.fromItem.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择来文机关"];
    }else if (!bianhaoField.text || bianhaoField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入编号"];
    }else if (!fenshuField.text || fenshuField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入来文份数"];
    }else if (!titleField.text || titleField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入文件标题"];
    }else{
        [SVProgressHUD showWithStatus:@"提交中..."];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSInteger uid = [userDefaults integerForKey:USER_ID];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/add.php?act=add&uid=%ld", API_DOMAIN, uid];
        
        NSDictionary *parameters = @{@"type": _typeItem[@"id"],
                                     @"swtime": self.timeField.text?self.timeField.text:@"",
                                     @"danwei": _fromItem[@"name"]?_fromItem[@"name"]:@"",
                                     @"bianhao": bianhaoField.text?bianhaoField.text:@"",
                                     @"wenhao": wenhaoField.text?wenhaoField.text:@"",
                                     @"fenshu": fenshuField.text?fenshuField.text:@"",
                                     @"title": titleField.text?titleField.text:@"",
                                     @"jttime": _jiezhiField.text?_jiezhiField.text:@"",
                                     @"cont": contentTextView.text?contentTextView.text:@"",
                                     @"user": nibanDict[@"name"]?nibanDict[@"name"]:@""};
        
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

- (void)checkFileType
{
    LTListAlertView *listAlertView = [[LTListAlertView alloc] initWithArray:typeArray title:@"选择收文类别"];
    __weak typeof(self)weakself = self;
    listAlertView.checkItemClicked = ^(NSDictionary *item){
        weakself.typeItem = item;
        weakself.typeField.text = [item objectForKey:@"name"];
    };
    listAlertView.cancelButtonClicked = ^{
        
    };
    [self.navigationController.view addSubview:listAlertView];
}

- (void)checkFileFrom
{
    if (!self.typeItem || self.typeItem.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择收文类别"];
    }else{
        [SVProgressHUD showWithStatus:@"加载中..."];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/add.php?act=get_type&type=%@",
                               API_DOMAIN, [self.typeItem objectForKey:@"id"]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD dismiss];
            NSMutableDictionary *resultDict = [responseObject JSONValue];
            NSArray *array = [resultDict objectForKey:@"type"];
            NSMutableArray *fArray = [NSMutableArray new];
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array[i], @"name", nil];
                [fArray addObject:dict];
            }
            fromArray = fArray;
            
            LTListAlertView *listAlertView = [[LTListAlertView alloc] initWithArray:fromArray title:@"选择来文机关"];
            __weak typeof(self)weakself = self;
            listAlertView.checkItemClicked = ^(NSDictionary *item){
                weakself.fromItem = item;
                weakself.fromField.text = [item objectForKey:@"name"];
            };
            listAlertView.cancelButtonClicked = ^{
                
            };
            [self.navigationController.view addSubview:listAlertView];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getFileAddDetail{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSString *URLString = [NSString stringWithFormat:@"%@/add.php",
                           API_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *resultDict = [responseObject JSONValue];
        typeArray = [resultDict objectForKey:@"type"];
        nibanDict = [resultDict objectForKey:@"niban"];
        
        shenheLabel.text = [nibanDict objectForKey:@"name"];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
