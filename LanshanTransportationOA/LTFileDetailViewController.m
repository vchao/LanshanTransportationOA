//
//  LTFileDetailViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/17.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTFileDetailViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"

@interface LTFileDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeStrLabel;
@property (nonatomic, strong) UILabel *fileTypeStrLabel;
@property (nonatomic, strong) UILabel *fileCTimeLabel;
@property (nonatomic, strong) UILabel *sendFromLabel;
@property (nonatomic, strong) UILabel *bianhaoLabel;
@property (nonatomic, strong) UILabel *fileCountLabel;
@property (nonatomic, strong) UILabel *fileNumLabel;//文件号
@property (nonatomic, strong) UILabel *endTimeLabel;//截止日期
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSArray *urlArray;

@end

@implementation LTFileDetailViewController

@synthesize infoDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
    [self.view addSubview:self.scrollView];
    
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, 32)];
    tLabel.font = [UIFont systemFontOfSize:16.f];
    tLabel.textColor = [UIColor blackColor];
    tLabel.text = @"文件（文电）处理单";
    tLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:tLabel];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tLabel.frame), _MainScreen_Width, 0.5)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView1];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tLabel.frame), 80, 40)];
    timeLabel.font = [UIFont systemFontOfSize:14.f];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.text = @"收文时间";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:timeLabel];
    
    UIView *lineHView = [[UIView alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(tLabel.frame)+4, 0.5, 32)];
    lineHView.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineHView];
    
    _timeStrLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, CGRectGetMaxY(tLabel.frame), _MainScreen_Width-96, 40)];
    _timeStrLabel.textColor = [UIColor grayColor];
    _timeStrLabel.font = [UIFont systemFontOfSize:14.f];
    [_scrollView addSubview:_timeStrLabel];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(timeLabel.frame), _MainScreen_Width-8, 0.5)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView2];
    
    UILabel *fileTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeLabel.frame), 80, 40)];
    fileTypeLabel.font = [UIFont systemFontOfSize:14.f];
    fileTypeLabel.textColor = [UIColor grayColor];
    fileTypeLabel.text = @"来文方式";
    fileTypeLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:fileTypeLabel];
    
    UIView *lineHView2 = [[UIView alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(timeLabel.frame)+4, 0.5, 32)];
    lineHView2.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineHView2];
    
    _fileTypeStrLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, CGRectGetMaxY(timeLabel.frame), _MainScreen_Width-96, 40)];
    _fileTypeStrLabel.textColor = [UIColor grayColor];
    _fileTypeStrLabel.font = [UIFont systemFontOfSize:14.f];
    [_scrollView addSubview:_fileTypeStrLabel];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fileTypeLabel.frame)-0.5, _MainScreen_Width, 0.5)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView3];
    
    UIView *bottomView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView3.frame), _MainScreen_Width, 4)];
    bottomView1.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0];
    [_scrollView addSubview:bottomView1];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomView1.frame), _MainScreen_Width, 0.5)];
    lineView4.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView4];
    
    UILabel *fileCLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomView1.frame), 80, 40)];
    fileCLabel.font = [UIFont systemFontOfSize:14.f];
    fileCLabel.textColor = [UIColor grayColor];
    fileCLabel.text = @"成文日期";
    fileCLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:fileCLabel];
    
    UIView *lineHView3 = [[UIView alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(bottomView1.frame)+4, 0.5, 32)];
    lineHView3.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineHView3];
    
    _fileCTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, CGRectGetMaxY(bottomView1.frame), _MainScreen_Width-96, 40)];
    _fileCTimeLabel.textColor = [UIColor grayColor];
    _fileCTimeLabel.font = [UIFont systemFontOfSize:14.f];
    [_scrollView addSubview:_fileCTimeLabel];
    
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(fileCLabel.frame), _MainScreen_Width-8, 0.5)];
    lineView5.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView5];
    
    UILabel *fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fileCLabel.frame), 80, 40)];
    fromLabel.font = [UIFont systemFontOfSize:14.f];
    fromLabel.textColor = [UIColor grayColor];
    fromLabel.text = @"来文机关";
    fromLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:fromLabel];
    
    UIView *lineHView4 = [[UIView alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(fileCLabel.frame)+4, 0.5, 32)];
    lineHView4.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineHView4];
    
    _sendFromLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, CGRectGetMaxY(fileCLabel.frame), _MainScreen_Width-96, 40)];
    _sendFromLabel.textColor = [UIColor redColor];
    _sendFromLabel.font = [UIFont systemFontOfSize:14.f];
    [_scrollView addSubview:_sendFromLabel];
    
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(fromLabel.frame)-0.5, _MainScreen_Width-8, 0.5)];
    lineView6.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView6];
    
    UILabel *fileBHLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fromLabel.frame), 80, 40)];
    fileBHLabel.font = [UIFont systemFontOfSize:14.f];
    fileBHLabel.textColor = [UIColor grayColor];
    fileBHLabel.text = @"编    号";
    fileBHLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:fileBHLabel];
    
    UIView *lineHView5 = [[UIView alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(fromLabel.frame)+4, 0.5, 32)];
    lineHView5.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineHView5];
    
    _bianhaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, CGRectGetMaxY(fromLabel.frame), _MainScreen_Width-96, 40)];
    _bianhaoLabel.textColor = [UIColor grayColor];
    _bianhaoLabel.font = [UIFont systemFontOfSize:14.f];
    [_scrollView addSubview:_bianhaoLabel];
    
    UIView *lineView7 = [[UIView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(fileBHLabel.frame)-0.5, _MainScreen_Width-8, 0.5)];
    lineView7.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView7];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fileBHLabel.frame), 80, 40)];
    countLabel.font = [UIFont systemFontOfSize:14.f];
    countLabel.textColor = [UIColor grayColor];
    countLabel.text = @"来文份数";
    countLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:countLabel];
    
    UIView *lineHView6 = [[UIView alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(fileBHLabel.frame)+4, 0.5, 32)];
    lineHView6.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineHView6];
    
    _fileCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, CGRectGetMaxY(fileBHLabel.frame), _MainScreen_Width-96, 40)];
    _fileCountLabel.textColor = [UIColor grayColor];
    _fileCountLabel.font = [UIFont systemFontOfSize:14.f];
    [_scrollView addSubview:_fileCountLabel];
    
    UIView *lineView8 = [[UIView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(countLabel.frame)-0.5, _MainScreen_Width-8, 0.5)];
    lineView8.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView8];
    
    UILabel *fileNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(countLabel.frame), 80, 40)];
    fileNumLabel.font = [UIFont systemFontOfSize:14.f];
    fileNumLabel.textColor = [UIColor grayColor];
    fileNumLabel.text = @"文 件 号";
    fileNumLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:fileNumLabel];
    
    UIView *lineHView7 = [[UIView alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(countLabel.frame)+4, 0.5, 32)];
    lineHView7.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineHView7];
    
    _fileNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, CGRectGetMaxY(countLabel.frame), _MainScreen_Width-96, 40)];
    _fileNumLabel.textColor = [UIColor redColor];
    _fileNumLabel.font = [UIFont systemFontOfSize:14.f];
    [_scrollView addSubview:_fileNumLabel];
    
    UIView *lineView9 = [[UIView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(fileNumLabel.frame)-0.5, _MainScreen_Width-8, 0.5)];
    lineView9.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView9];
    
    UILabel *endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fileNumLabel.frame), 80, 40)];
    endTimeLabel.font = [UIFont systemFontOfSize:14.f];
    endTimeLabel.textColor = [UIColor grayColor];
    endTimeLabel.text = @"截止日期";
    endTimeLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:endTimeLabel];
    
    UIView *lineHView8 = [[UIView alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(fileNumLabel.frame)+4, 0.5, 32)];
    lineHView8.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineHView8];
    
    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, CGRectGetMaxY(fileNumLabel.frame), _MainScreen_Width-96, 40)];
    _endTimeLabel.textColor = [UIColor grayColor];
    _endTimeLabel.font = [UIFont systemFontOfSize:14.f];
    [_scrollView addSubview:_endTimeLabel];
    
    UIView *lineView10 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(endTimeLabel.frame)-0.5, _MainScreen_Width, 0.5)];
    lineView10.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView10];
    
    UIView *bottomView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView10.frame), _MainScreen_Width, 4)];
    bottomView2.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0];
    [_scrollView addSubview:bottomView2];
    
    UIView *lineView11 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomView2.frame), _MainScreen_Width, 0.5)];
    lineView11.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView11];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomView2.frame), _MainScreen_Width, 40)];
    _titleLabel.font = [UIFont systemFontOfSize:14.f];
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 2;
    [_scrollView addSubview:_titleLabel];
    
    UIView *lineView12 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), _MainScreen_Width, 0.5)];
    lineView12.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView12];

    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_titleLabel.frame)+10, _MainScreen_Width-24, 20)];
    _contentLabel.font = [UIFont systemFontOfSize:14.f];
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.numberOfLines = 0;
    [_scrollView addSubview:_contentLabel];
    _contentLabel.text = @"来文内容:";
    [_contentLabel sizeToFit];
    
    UIView *lineView13 = [[UIView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(_contentLabel.frame)+10, _MainScreen_Width-8, 0.5)];
    lineView13.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView13];
    
    [self getInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger uid = [userDefaults integerForKey:USER_ID];
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSString *URLString = [NSString stringWithFormat:@"%@/gongwen.php?act=show&uid=%ld&id=%@",
                           API_DOMAIN,uid,[infoDictionary objectForKey:@"id"]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",[responseObject JSONValue]);
        contentDict = [responseObject JSONValue];
        
        NSDictionary *info = [contentDict objectForKey:@"value"][0];
        _timeStrLabel.text = [info objectForKey:@"swtime"];
        _fileTypeStrLabel.text = [info objectForKey:@"swtype"];
//        _fileCTimeLabel.text = [info objectForKey:@"cwtime"]?[info objectForKey:@"cwtime"]:@"";
        _sendFromLabel.text = [info objectForKey:@"danwei"];
        _bianhaoLabel.text = [info objectForKey:@"bianhao"];
        _fileCountLabel.text = [info objectForKey:@"fenshu"];
        _fileNumLabel.text = [info objectForKey:@"wenhao"];
        _endTimeLabel.text = [info objectForKey:@"jztime"];
        
        _titleLabel.text = [info objectForKey:@"title"];
//        _contentLabel.text = [NSString stringWithFormat:@"来文内容：%@",[info objectForKey:@"cwtime"]];
        NSString *OldName = [info objectForKey:@"OldName"];
        NSString *NewName = [info objectForKey:@"NewName"];
        NSArray *nameArray = [OldName componentsSeparatedByString:@"|"];
        _urlArray = [NewName componentsSeparatedByString:@"|"];
        UIView *fileView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_contentLabel.frame)+10, _MainScreen_Width, 40*nameArray.count)];
        [_scrollView addSubview:fileView];
        
        CGFloat fileH = 0;
        for (int i = 0; i < nameArray.count; i++) {
            NSString *fileName = [nameArray objectAtIndex:i];
            if (fileName && fileName.length > 0) {
                NSString *fileName = [[_urlArray objectAtIndex:i] lastPathComponent];
                NSString *imgName = @"file_attach_other";
                if ([fileName hasSuffix:@"pdf"] || [fileName hasSuffix:@"PDF"]) {
                    imgName = @"file_attach_pdf";
                }else if ([fileName hasSuffix:@"doc"] || [fileName hasSuffix:@"DOC"]) {
                    imgName = @"file_attach_doc";
                }else if ([fileName hasSuffix:@"png"] || [fileName hasSuffix:@"PNG"] || [fileName hasSuffix:@"jpg"] || [fileName hasSuffix:@"JPG"] || [fileName hasSuffix:@"jpeg"] || [fileName hasSuffix:@"JPEG"] || [fileName hasSuffix:@"pmg"] || [fileName hasSuffix:@"PMG"]) {
                    imgName = @"file_attach_img";
                }else if ([fileName hasSuffix:@"ppt"] || [fileName hasSuffix:@"PPT"]) {
                    imgName = @"file_attach_ppt";
                }else if ([fileName hasSuffix:@"rar"] || [fileName hasSuffix:@"zip"] || [fileName hasSuffix:@"RAR"] || [fileName hasSuffix:@"ZIP"]) {
                    imgName = @"file_attach_rar";
                }else if ([fileName hasSuffix:@"txt"] || [fileName hasSuffix:@"TXT"]) {
                    imgName = @"file_attach_txt";
                }else if ([fileName hasSuffix:@"xls"] || [fileName hasSuffix:@"XLS"]) {
                    imgName = @"file_attach_xls";
                }
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, i*40+10, 20, 20)];
                imageView.image = [UIImage imageNamed:imgName];
                [fileView addSubview:imageView];
                
                UILabel *fileNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+8, i*40, _MainScreen_Width-CGRectGetMaxX(imageView.frame)-8, 40)];
                fileNameLabel.font = [UIFont systemFontOfSize:14.f];
                fileNameLabel.textColor = [UIColor grayColor];
                fileNameLabel.text = nameArray[i];
                [fileView addSubview:fileNameLabel];
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(12, i*40, _MainScreen_Width-24, 40)];
                btn.backgroundColor = [UIColor clearColor];
//                [btn setTitle:nameArray[i] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
                btn.tag = 1000+i;
                [btn addTarget:self action:@selector(fileAction:) forControlEvents:UIControlEventTouchUpInside];
                [fileView addSubview:btn];
                
                fileH += 40;
                
                UIView *lineView13 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)-0.5, _MainScreen_Width, 0.5)];
                lineView13.backgroundColor = [UIColor lightGrayColor];
                [fileView addSubview:lineView13];
            }
        }
        fileView.frame = CGRectMake(0, CGRectGetMaxY(_contentLabel.frame)+10, _MainScreen_Width, fileH);
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fileView.frame), _MainScreen_Width, 4)];
        bottomView.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0];
        [_scrollView addSubview:bottomView];
        
        UIView *lineView13 = [[UIView alloc] initWithFrame:CGRectMake(0, 4-0.5, _MainScreen_Width, 0.5)];
        lineView13.backgroundColor = [UIColor lightGrayColor];
        [bottomView addSubview:lineView13];
        
        NSArray *value1 = [contentDict objectForKey:@"value1"];
        NSArray *value2 = [contentDict objectForKey:@"value2"];
        NSArray *value3 = [contentDict objectForKey:@"value3"];
        NSArray *value4 = [contentDict objectForKey:@"value4"];
        
        UIView *valueView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomView.frame), _MainScreen_Width, 60*(value1.count?value1.count:1)+16)];
        valueView1.backgroundColor = [UIColor colorWithRed:250/255.f green:240/255.f blue:230/255.f alpha:1.0];
        [_scrollView addSubview:valueView1];
        
        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        titleLabel1.font = [UIFont systemFontOfSize:14.f];
        titleLabel1.textColor = [UIColor grayColor];
        titleLabel1.text = @"拟办意见:";
        titleLabel1.textAlignment = NSTextAlignmentCenter;
        [valueView1 addSubview:titleLabel1];
        
        UIImage * img= [UIImage imageNamed:@"checked_normald"];
        img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(20, 8, 9, 2)];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 4, _MainScreen_Width-80, valueView1.frame.size.height-8)];
        bgImageView.image = img;
        [valueView1 addSubview:bgImageView];
        
        CGFloat value1H = 0;
        for (int i = 0; i < value1.count; i++) {
            if (i != 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(94, value1H+4, _MainScreen_Width-96, 0.5)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                [valueView1 addSubview:lineView];
            }
            NSDictionary *dict = value1[i];
            
            UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(92, value1H+4, _MainScreen_Width-100, 60)];
            [valueView1 addSubview:contentView];
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 2, contentView.frame.size.width-12, 20)];
            contentLabel.font = [UIFont systemFontOfSize:14];
            contentLabel.textColor = [UIColor grayColor];
            contentLabel.numberOfLines = 0;
            contentLabel.text = [dict objectForKey:@"content"];
            [contentView addSubview:contentLabel];
            [contentLabel sizeToFit];
            
            UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(contentLabel.frame)>10?CGRectGetMaxY(contentLabel.frame):20, contentView.frame.size.width-8, 20)];
            userLabel.font = [UIFont systemFontOfSize:12];
            userLabel.textColor = [UIColor grayColor];
            userLabel.textAlignment = NSTextAlignmentRight;
            userLabel.text = [dict objectForKey:@"adduser"];
            [contentView addSubview:userLabel];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(userLabel.frame), contentView.frame.size.width-8, 20)];
            timeLabel.font = [UIFont systemFontOfSize:12];
            timeLabel.textColor = [UIColor grayColor];
            timeLabel.textAlignment = NSTextAlignmentRight;
            timeLabel.text = [dict objectForKey:@"addtime"];
            [contentView addSubview:timeLabel];
            contentView.frame = CGRectMake(92, value1H+4, _MainScreen_Width-100, CGRectGetMaxY(timeLabel.frame));
            
            value1H += CGRectGetMaxY(timeLabel.frame);
        }
        if (value1H == 0) {
            value1H = 60;
        }
        valueView1.frame = CGRectMake(0, CGRectGetMaxY(bottomView.frame), _MainScreen_Width, value1H+16);
        bgImageView.frame = CGRectMake(80, 4, _MainScreen_Width-80, value1H+8);
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(valueView1.frame)-0.5, _MainScreen_Width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [_scrollView addSubview:lineView];
        
        UIView *valueView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(valueView1.frame), _MainScreen_Width, 60*(value2.count?value2.count:1)+16)];
        valueView2.backgroundColor = [UIColor colorWithRed:250/255.f green:235/255.f blue:215/255.f alpha:1.0];
        [_scrollView addSubview:valueView2];
        
        UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        titleLabel2.font = [UIFont systemFontOfSize:14.f];
        titleLabel2.textColor = [UIColor grayColor];
        titleLabel2.text = @"领导批示:";
        titleLabel2.textAlignment = NSTextAlignmentCenter;
        [valueView2 addSubview:titleLabel2];
        
        UIImageView *bgImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 4, _MainScreen_Width-80, valueView2.frame.size.height-8)];
        bgImageView2.image = img;
        [valueView2 addSubview:bgImageView2];
        
        CGFloat value2H = 0;
        for (int i = 0; i < value2.count; i++) {
            if (i != 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(94, value2H+4, _MainScreen_Width-96, 0.5)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                [valueView2 addSubview:lineView];
            }
            NSDictionary *dict = value2[i];
            
            UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(92, value2H+4, _MainScreen_Width-100, 60)];
            [valueView2 addSubview:contentView];
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 2, contentView.frame.size.width-8, 20)];
            contentLabel.font = [UIFont systemFontOfSize:14];
            contentLabel.textColor = [UIColor grayColor];
            contentLabel.text = [dict objectForKey:@"content"]?[dict objectForKey:@"content"]:@" ";;
            contentLabel.numberOfLines = 0;
            [contentView addSubview:contentLabel];
            [contentLabel sizeToFit];
            
            UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(contentLabel.frame)>10?CGRectGetMaxY(contentLabel.frame):20, contentView.frame.size.width-8, 20)];
            userLabel.font = [UIFont systemFontOfSize:12];
            userLabel.textColor = [UIColor grayColor];
            userLabel.textAlignment = NSTextAlignmentRight;
            userLabel.text = [dict objectForKey:@"adduser"];
            [contentView addSubview:userLabel];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(userLabel.frame), contentView.frame.size.width-8, 20)];
            timeLabel.font = [UIFont systemFontOfSize:12];
            timeLabel.textColor = [UIColor grayColor];
            timeLabel.textAlignment = NSTextAlignmentRight;
            timeLabel.text = [dict objectForKey:@"addtime"];
            [contentView addSubview:timeLabel];
            contentView.frame = CGRectMake(92, value2H+4, _MainScreen_Width-100, CGRectGetMaxY(timeLabel.frame));
            
            value2H += CGRectGetMaxY(timeLabel.frame);
        }
        if (value2H == 0) {
            value2H = 60;
        }
        valueView2.frame = CGRectMake(0, CGRectGetMaxY(valueView1.frame), _MainScreen_Width, value2H+16);
        bgImageView2.frame = CGRectMake(80, 4, _MainScreen_Width-80, value2H+8);
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(valueView2.frame)-0.5, _MainScreen_Width, 0.5)];
        lineView2.backgroundColor = [UIColor lightGrayColor];
        [_scrollView addSubview:lineView2];
        
        UIView *valueView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(valueView2.frame), _MainScreen_Width, 60*(value3.count?value3.count:1)+16)];
        valueView3.backgroundColor = [UIColor colorWithRed:250/255.f green:240/255.f blue:230/255.f alpha:1.0];
        [_scrollView addSubview:valueView3];
        
        UILabel *titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        titleLabel3.font = [UIFont systemFontOfSize:14.f];
        titleLabel3.textColor = [UIColor grayColor];
        titleLabel3.text = @"领导阅示:";
        titleLabel3.textAlignment = NSTextAlignmentCenter;
        [valueView3 addSubview:titleLabel3];
        
        UIImageView *bgImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 4, _MainScreen_Width-80, valueView3.frame.size.height-8)];
        bgImageView3.image = img;
        [valueView3 addSubview:bgImageView3];
        
        CGFloat value3H = 0;
        for (int i = 0; i < value3.count; i++) {
            if (i != 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(94, value3H+4, _MainScreen_Width-96, 0.5)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                [valueView3 addSubview:lineView];
            }
            NSDictionary *dict = value3[i];
            
            UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(92, value3H+4, _MainScreen_Width-100, 60)];
            [valueView3 addSubview:contentView];
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 2, contentView.frame.size.width-8, 20)];
            contentLabel.font = [UIFont systemFontOfSize:14];
            contentLabel.textColor = [UIColor grayColor];
            contentLabel.numberOfLines = 0;
            contentLabel.text = [dict objectForKey:@"content"]?[dict objectForKey:@"content"]:@" ";;
            [contentView addSubview:contentLabel];
            [contentLabel sizeToFit];
            
            UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(contentLabel.frame)>10?CGRectGetMaxY(contentLabel.frame):20, contentView.frame.size.width-8, 20)];
            userLabel.font = [UIFont systemFontOfSize:12];
            userLabel.textColor = [UIColor grayColor];
            userLabel.textAlignment = NSTextAlignmentRight;
            userLabel.text = [dict objectForKey:@"adduser"];
            [contentView addSubview:userLabel];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(userLabel.frame), contentView.frame.size.width-8, 20)];
            timeLabel.font = [UIFont systemFontOfSize:12];
            timeLabel.textColor = [UIColor grayColor];
            timeLabel.textAlignment = NSTextAlignmentRight;
            timeLabel.text = [dict objectForKey:@"addtime"];
            [contentView addSubview:timeLabel];
            contentView.frame = CGRectMake(92, value3H+4, _MainScreen_Width-100, CGRectGetMaxY(timeLabel.frame));
            
            value3H += CGRectGetMaxY(timeLabel.frame);
        }
        if (value3H == 0) {
            value3H = 60;
        }
        valueView3.frame = CGRectMake(0, CGRectGetMaxY(valueView2.frame), _MainScreen_Width, value3H+16);
        bgImageView3.frame = CGRectMake(80, 4, _MainScreen_Width-80, value3H+8);
        
        UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(valueView3.frame)-0.5, _MainScreen_Width, 0.5)];
        lineView3.backgroundColor = [UIColor lightGrayColor];
        [_scrollView addSubview:lineView3];
        
        UIView *valueView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(valueView3.frame), _MainScreen_Width, 60*(value4.count?value4.count:1)+16)];
        valueView4.backgroundColor = [UIColor colorWithRed:250/255.f green:235/255.f blue:215/255.f alpha:1.0];
        [_scrollView addSubview:valueView4];
        
        UILabel *titleLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        titleLabel4.font = [UIFont systemFontOfSize:14.f];
        titleLabel4.textColor = [UIColor grayColor];
        titleLabel4.text = @"办理结果:";
        titleLabel4.textAlignment = NSTextAlignmentCenter;
        [valueView4 addSubview:titleLabel4];
        
        UIImageView *bgImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 4, _MainScreen_Width-80, valueView4.frame.size.height-8)];
        bgImageView4.image = img;
        [valueView4 addSubview:bgImageView4];
        
        CGFloat value4H = 0;
        for (int i = 0; i < value4.count; i++) {
            if (i != 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(94, value4H+4, _MainScreen_Width-96, 0.5)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                [valueView4 addSubview:lineView];
            }
            NSDictionary *dict = value4[i];
            
            UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(92, value4H+4, _MainScreen_Width-100, 60)];
            [valueView4 addSubview:contentView];
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 2, contentView.frame.size.width-8, 20)];
            contentLabel.font = [UIFont systemFontOfSize:14];
            contentLabel.textColor = [UIColor grayColor];
            contentLabel.numberOfLines = 0;
            contentLabel.text = [dict objectForKey:@"content"]?[dict objectForKey:@"content"]:@" ";
            [contentView addSubview:contentLabel];
            [contentLabel sizeToFit];
            
            UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(contentLabel.frame)>10?CGRectGetMaxY(contentLabel.frame):20, contentView.frame.size.width-8, 20)];
            userLabel.font = [UIFont systemFontOfSize:12];
            userLabel.textColor = [UIColor grayColor];
            userLabel.textAlignment = NSTextAlignmentRight;
            userLabel.text = [dict objectForKey:@"adduser"];
            [contentView addSubview:userLabel];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(userLabel.frame), contentView.frame.size.width-8, 20)];
            timeLabel.font = [UIFont systemFontOfSize:12];
            timeLabel.textColor = [UIColor grayColor];
            timeLabel.textAlignment = NSTextAlignmentRight;
            timeLabel.text = [dict objectForKey:@"addtime"];
            [contentView addSubview:timeLabel];
            contentView.frame = CGRectMake(92, value4H+4, _MainScreen_Width-100, CGRectGetMaxY(timeLabel.frame));
            
            value4H += CGRectGetMaxY(timeLabel.frame);
        }
        if (value4H == 0) {
            value4H = 60;
        }
        valueView4.frame = CGRectMake(0, CGRectGetMaxY(valueView3.frame), _MainScreen_Width, value4H+16);
        bgImageView4.frame = CGRectMake(80, 4, _MainScreen_Width-80, value4H+8);
        
        _scrollView.contentSize = CGSizeMake(_MainScreen_Width, CGRectGetMaxY(valueView4.frame));
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)fileAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSString *urlStr = [_urlArray objectAtIndex:btn.tag-1000];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

-(NSString *)MIMEType:(NSString *)urlStr{
    // 1.根据当前文件创建URL
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    // 2.根据URL创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3.发送请求
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

@end
