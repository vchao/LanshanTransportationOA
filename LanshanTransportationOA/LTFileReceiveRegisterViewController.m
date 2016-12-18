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

@interface LTFileReceiveRegisterViewController (){
    UITextField *timeField;
    UITextField *bianhaoField;
    UITextField *wenhaoField;
    UITextField *fenshuField;
    UITextField *titleField;
    UITextField *jiezhiField;
    UITextView  *contentTextView;
    UITextView  *feedbackTextView;//拟办意见
    UILabel     *fujianLabel;
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

@end

@implementation LTFileReceiveRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
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
    
    timeField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(typeDescLabel.frame), _MainScreen_Width-106, 40)];
    timeField.text = dateString;
    timeField.tintColor = [UIColor grayColor];
    timeField.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:timeField];
    
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
    
//    UILabel *xingLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(bhDescLabel.frame), 14, 40)];
//    xingLabel5.text = @"*";
//    xingLabel5.textColor = [UIColor redColor];
//    xingLabel5.font = [UIFont systemFontOfSize:14.f];
//    [scrollView addSubview:xingLabel5];
    
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
    
    jiezhiField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(titleDescLabel.frame)+4, _MainScreen_Width-106-80, 32)];
    jiezhiField.tintColor = [UIColor grayColor];
    jiezhiField.placeholder = @"没有请填 无";
    jiezhiField.font = [UIFont systemFontOfSize:14.f];
    jiezhiField.layer.borderColor = [UIColor grayColor].CGColor;
    jiezhiField.layer.borderWidth = 0.5;
    [scrollView addSubview:jiezhiField];
    
    UIButton *tapDateBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jiezhiField.frame), CGRectGetMaxY(titleDescLabel.frame), 80, 40)];
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
    [fjBtn setImage:[UIImage imageNamed:@"file_attach_icon_normal"] forState:UIControlStateNormal];
    [fjBtn setImage:[UIImage imageNamed:@"file_attach_icon_pressed"] forState:UIControlStateHighlighted];
    [fjBtn addTarget:self action:@selector(fujianAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:fjBtn];
    
    UIView *lineHView9 = [[UIView alloc] initWithFrame:CGRectMake(60, 4+CGRectGetMaxY(fjDescLabel.frame), 0.5, 32)];
    lineHView9.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView9];
    
    UIView *lineView10 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineHView9.frame)+4, _MainScreen_Width, 0.5)];
    lineView10.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView10];
    
    UILabel *shDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView10.frame), 80, 40)];
    shDescLabel.text = @"审  核  人";
    shDescLabel.textColor = [UIColor grayColor];
    shDescLabel.textAlignment = NSTextAlignmentCenter;
    shDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:shDescLabel];
    
    UIView *lineHView10 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(lineView10.frame), 0.5, 32)];
    lineHView10.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView10];
    
    shenheLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(lineView10.frame)+4, _MainScreen_Width-106, 32)];
    shenheLabel.textColor = [UIColor orangeColor];
    shenheLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:shenheLabel];
    
    UIView *lineView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView11.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView11];
    
    submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(lineView11.frame)+8, _MainScreen_Width-16, 40)];
    submitBtn.backgroundColor = [UIColor colorWithRed:32.f/255.f green:148.f/255.f blue:254/255.f alpha:1.f];
    submitBtn.layer.cornerRadius = 4.f;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submitBtn];
    
    scrollView.contentSize = CGSizeMake(_MainScreen_Width, CGRectGetMaxY(submitBtn.frame)+8);
    
    [self getFileAddDetail];
}

- (void)selecteDateTime{
    UIAlertController *alert = nil;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];//初始化一个标题为“选择时间”，风格是ActionSheet的UIAlertController，其中"\n"是为了给DatePicker腾出空间
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //点击确定按钮的事件处理
        }];
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];//初始化一个UIDatePicker
        datePicker.datePickerMode = UIDatePickerModeDate;
        [alert.view addSubview:datePicker];//将datePicker添加到UIAlertController实例中
        [alert addAction:cancel];//将确定按钮添加到UIAlertController实例中
    }
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (void)oneDatePickerValueChanged:(UIDatePicker *) sender
{

}

- (void)fujianAction:(id)sender
{

}

- (void)submitAction
{

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

@end
