//
//  LTLoginViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/15.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTLoginViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "NSObject+SBJson.h"

static NSString *SETTINT_REMBER_PASSWORD = @"SETTINT_REMBER_PASSWORD";
static NSString *SETTINT_USERNAME = @"SETTINT_USERNAME";
static NSString *SETTINT_PASSWORD = @"SETTINT_PASSWORD";

@interface LTLoginViewController ()

@end

@implementation LTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self OriginImage:SY_IMAGE(@"pic_loginbg") scaleToSize:CGSizeMake(_MainScreen_Width, _MainScreen_Height)]];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    // Do any additional setup after loading the view, typically from a nib.
    loginLeftConstraint.constant = (_MainScreen_Width-292)/2;
    logoLeftConstraint.constant = (_MainScreen_Width-100)/2-16;
    
    UIImage *inputBg = SY_IMAGE(@"登录输入框");
    UIEdgeInsets insets = UIEdgeInsetsMake(3, 3, 3, 3);
    inputBg = [inputBg resizableImageWithCapInsets:insets];
    inputBgView.image = inputBg;
    
    UIImage *loginBg = SY_IMAGE(@"pic_btn_normal");
    UIEdgeInsets logininsets = UIEdgeInsetsMake(3, 3, 3, 3);
    loginBg = [loginBg resizableImageWithCapInsets:logininsets];
    [loginBtn setBackgroundImage:loginBg forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[SY_IMAGE(@"pic_btn_pressed") resizableImageWithCapInsets:logininsets] forState:UIControlStateHighlighted];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL remberPass = [userDefaults boolForKey:SETTINT_REMBER_PASSWORD];
    NSString *username = [userDefaults stringForKey:SETTINT_USERNAME];
    if (remberPass) {
        [remPassBtn setSelected:YES];
        NSString *password = [userDefaults stringForKey:SETTINT_PASSWORD];
        if (password && password.length>0) {
            passField.text = password;
        }
    }else{
        [remPassBtn setSelected:NO];
    }
    if (username && username.length > 0) {
        usernameField.text = username;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if (usernameField.isFirstResponder) {
        [usernameField resignFirstResponder];
    }else if (passField.isFirstResponder) {
        [passField resignFirstResponder];
    }
}

- (IBAction)tapPlayerButton:(id)sender {
    if (usernameField.text.length > 0) {
        if (passField.text.length > 0) {
            [SVProgressHUD showWithStatus:@"登录中..."];
            NSString *URLString = [NSString stringWithFormat:@"%@/login.php",
                                   API_DOMAIN];
            NSDictionary *parameters = @{@"username": usernameField.text,
                                         @"password": passField.text};
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [SVProgressHUD dismiss];
                NSLog(@"%@",[responseObject JSONValue]);
                NSDictionary *resultDict = [responseObject JSONValue];
                NSInteger uid = [[resultDict objectForKey:@"uid"] integerValue];
                if (uid > 0) {
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    NSString *name = [resultDict objectForKey:@"name"];
                    NSString *ldhdUser = [resultDict objectForKey:@"ldhd_user"];
                    NSString *ldhdSort = [resultDict objectForKey:@"ldhd_sort"];
                    [userDefaults setObject:name?name:@"" forKey:USER_REAL_NAME];
                    [userDefaults setInteger:uid forKey:USER_ID];
                    [userDefaults setObject:ldhdUser?ldhdUser:@"" forKey:USER_LDHD];//不为空则是领导，显示领导活动模块
                    [userDefaults setObject:ldhdSort?ldhdSort:@"" forKey:USER_LDHD_SORT];
                    
                    if(remPassBtn.isSelected){
                        [userDefaults setObject:usernameField.text forKey:SETTINT_USERNAME];
                        [userDefaults setObject:passField.text forKey:SETTINT_PASSWORD];
                        [userDefaults setBool:YES forKey:SETTINT_REMBER_PASSWORD];
                    }else{
                        [userDefaults setObject:usernameField.text forKey:SETTINT_USERNAME];
                        [userDefaults setObject:@"" forKey:SETTINT_PASSWORD];
                        [userDefaults setBool:NO forKey:SETTINT_REMBER_PASSWORD];
                    }
                    [(AppDelegate*)[UIApplication sharedApplication].delegate gotoMainWindow];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"登录失败"];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [SVProgressHUD showErrorWithStatus:@"登录失败"];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
    }
}

- (IBAction)tapRemberPassword:(id)sender{
    if (remPassBtn.isSelected) {
        [remPassBtn setSelected:NO];
    }else{
        [remPassBtn setSelected:YES];
    }
}

- (IBAction)tapResetTextField:(id)sender{
    usernameField.text = @"";
    passField.text = @"";
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
