//
//  LTMessageAddViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/20.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTMessageAddViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "NSObject+SBJson.h"
#import "LTAlertView.h"
#import "AssetsLibrary/AssetsLibrary.h"

@interface LTMessageAddViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UITextField *titleField;
    UITextView  *contentTextView;
    
    UIView      *fujianView;
    UIView      *fileLineHView;
    
    UIView      *bottomView;
    UIButton    *submitBtn;
}

@property (nonatomic, strong) UILabel        *typeLabel;
@property (nonatomic, strong) UILabel        *seeLabel;
@property (nonatomic, strong) NSMutableArray *selectSeeArray;
@property (nonatomic, strong) NSMutableArray *contactsArray;

@property (nonatomic, strong) NSMutableArray *fileArray;
@property (nonatomic, strong) NSMutableArray *fileNameArray;

@end

@implementation LTMessageAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getContactsArray];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.contactsArray = [NSMutableArray new];
    self.selectSeeArray = [NSMutableArray new];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _MainScreen_Width, _MainScreen_Height)];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    UILabel *typeDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    typeDescLabel.text = @"文章类型";
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
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, 0, _MainScreen_Width-106, 40)];
    self.typeLabel.text = @"通知公告";
    self.typeLabel.tintColor = [UIColor grayColor];
    self.typeLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:self.typeLabel];
    UIView *typeTapView = [[UIView alloc] initWithFrame:self.typeLabel.frame];
    [scrollView addSubview:typeTapView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecteType)];
    [typeTapView addGestureRecognizer:tap];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, _MainScreen_Width, 0.5)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView1];
    
    UILabel *titleDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(typeDescLabel.frame), 80, 40)];
    titleDescLabel.text = @"文章标题";
    titleDescLabel.textColor = [UIColor grayColor];
    titleDescLabel.textAlignment = NSTextAlignmentCenter;
    titleDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:titleDescLabel];
    
    UILabel *xingLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(typeDescLabel.frame), 14, 40)];
    xingLabel2.text = @"*";
    xingLabel2.textColor = [UIColor redColor];
    xingLabel2.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:xingLabel2];
    
    UIView *lineHView2 = [[UIView alloc] initWithFrame:CGRectMake(90, 4+CGRectGetMaxY(typeDescLabel.frame), 0.5, 32)];
    lineHView2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineHView2];
    
    titleField = [[UITextField alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(typeDescLabel.frame)+4, _MainScreen_Width-106, 32)];
    titleField.placeholder = @"请输入标题";
    titleField.tintColor = [UIColor grayColor];
    titleField.font = [UIFont systemFontOfSize:14.f];
    titleField.layer.borderColor = [UIColor grayColor].CGColor;
    titleField.layer.borderWidth = 0.5;
    [scrollView addSubview:titleField];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleDescLabel.frame), _MainScreen_Width, 0.5)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:lineView2];
    
    UILabel *contentDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleDescLabel.frame), 80, 40)];
    contentDescLabel.text = @"文章内容";
    contentDescLabel.textColor = [UIColor grayColor];
    contentDescLabel.textAlignment = NSTextAlignmentCenter;
    contentDescLabel.font = [UIFont systemFontOfSize:14.f];
    [scrollView addSubview:contentDescLabel];
    
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(contentDescLabel.frame), _MainScreen_Width-24, 88)];
//    contentTextView.placeholder = @"请输入内容";
    contentTextView.tintColor = [UIColor grayColor];
    contentTextView.font = [UIFont systemFontOfSize:14.f];
    contentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    contentTextView.layer.borderWidth = 0.5;
    [scrollView addSubview:contentTextView];
    
    UILabel *fjDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(contentTextView.frame), _MainScreen_Width-24, 40)];
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
    shDescLabel.text = @"权限查看";
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
    
    self.seeLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, CGRectGetMaxY(lineView10.frame)+4, _MainScreen_Width-106, 32)];
    self.seeLabel.textColor = [UIColor orangeColor];
    self.seeLabel.font = [UIFont systemFontOfSize:14.f];
    self.seeLabel.text = @"请选择接收人";
    [bottomView addSubview:self.seeLabel];
    
    UIView *shenpiView = [[UIView alloc] initWithFrame:self.seeLabel.frame];
    [bottomView addSubview:shenpiView];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkReviceUser)];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selecteType{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    NSArray *array = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:@"通知公告",@"name", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"学习材料",@"name", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"领导讲话",@"name", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"相关文件",@"name", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"机关党建",@"name", nil], nil];
    LTListAlertView *alertView = [[LTListAlertView alloc] initWithArray:array title:@"选择类型"];
    __weak typeof(self)weakself = self;
    alertView.checkItemClicked = ^(NSDictionary *dict){
        weakself.typeLabel.text = [dict objectForKey:@"name"];
    };
    alertView.cancelButtonClicked = ^{
        
    };
    [self.navigationController.view addSubview:alertView];
}

- (void)checkReviceUser{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    LTMultiSelectAlertView *alertView = [[LTMultiSelectAlertView alloc] initWithArray:self.contactsArray title:@"选择接收人" listTitlekey:@"realname" canSelectAll:YES];
    __weak typeof(self)weakself = self;
    alertView.confirmButtonClicked = ^(NSArray *array){
        if (array.count) {
            weakself.selectSeeArray = [NSMutableArray arrayWithArray:array];
            NSString *typeStr = @"";
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dict = array[i];
                if (i == 0) {
                    typeStr = [dict objectForKey:@"realname"];
                }else{
                    typeStr = [NSString stringWithFormat:@"%@,%@", typeStr, [dict objectForKey:@"realname"]];
                }
            }
            weakself.seeLabel.text = typeStr;
        }
    };
    alertView.cancelButtonClicked = ^{
        
    };
    [self.navigationController.view addSubview:alertView];
}

- (void)getContactsArray{
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.xml",
                          [NSString stringWithFormat:@"%@/Documents/ProtocolCaches", NSHomeDirectory()], @"contactInfolist"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *dirPath = [NSString stringWithFormat:@"%@/Documents/ProtocolCaches", NSHomeDirectory()];
    BOOL isDir = YES;
    if (![fm fileExistsAtPath:dirPath isDirectory:&isDir]) {
        [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSArray *array = [self getArrayFromFile:fileName];
    if ([array count] > 1) {
        NSDictionary *userDict = [array objectAtIndex:1];
        self.contactsArray = [userDict objectForKey:@"user"];
    }
    [self getContactsList];
}

- (void)getContactsList
{
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.xml",
                          [NSString stringWithFormat:@"%@/Documents/ProtocolCaches", NSHomeDirectory()], @"contactInfolist"];
    NSString *URLString = [NSString stringWithFormat:@"%@/user.php",
                           API_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",[responseObject JSONValue]);
        NSDictionary *resultDict = [responseObject JSONValue];
        if ([resultDict count] > 1) {
            self.contactsArray = [resultDict objectForKey:@"user"];
            [resultDict writeToFile:fileName atomically:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (NSArray *)getArrayFromFile:(NSString *)fileName {
    NSArray *array = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if ([fm fileExistsAtPath:fileName isDirectory:&isDir]) {
        array = [[NSArray alloc] initWithContentsOfFile:fileName];
    }
    return array;
}

- (void)submitAction
{
    if (!self.typeLabel.text || self.typeLabel.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择文章类型"];
    }else if (!titleField.text || titleField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入文章标题"];
    }else{
        [SVProgressHUD showWithStatus:@"提交中..."];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSInteger uid = [userDefaults integerForKey:USER_ID];
        
        NSString *URLString = [NSString stringWithFormat:@"%@/tongzhi.php?act=add&uid=%ld", API_DOMAIN, uid];
        
        NSString *seeIDStr = @"";
        for (int i = 0; i < self.selectSeeArray.count; i++) {
            NSDictionary *dict = [self.selectSeeArray objectAtIndex:i];
            if (i == 0) {
                seeIDStr = [dict objectForKey:@"id"];
            }else{
                seeIDStr = [NSString stringWithFormat:@"%@|%@",seeIDStr, [dict objectForKey:@"id"]];
            }
        }
        NSDictionary *parameters = @{@"type": self.typeLabel.text?self.typeLabel.text:@"",
                                     @"title": titleField.text?titleField.text:@"",
                                     @"content": contentTextView.text?contentTextView.text:@"",
                                     @"memberlist": seeIDStr};
        
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
