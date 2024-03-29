//
//  LoginViewController.m
//  HealthyDiet
//
//  Created by ByteDance on 2024/3/4.
//

#import "LoginViewController.h"
#import "MainViewViewController.h"
#import "MineViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
  
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *loginButton;
  
@end
  
@implementation LoginViewController
  
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置视图背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
      
    // 创建用户名文本框
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 4, 140, self.view.frame.size.width / 2, 40)];
    self.usernameField.placeholder = @"Username";
    //self.usernameField.text = @"Username";
    self.usernameField.delegate = self;
    self.usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.usernameField.layer.borderWidth = 1.0f; // 边框宽度
    self.usernameField.layer.borderColor = [UIColor blackColor].CGColor; // 边框颜色
    self.usernameField.layer.cornerRadius = 5.0f; // 边框圆角

    [self.view addSubview:self.usernameField];
      
    // 创建密码文本框
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 4, self.usernameField.frame.origin.y + self.usernameField.frame.size.height + 10, self.view.frame.size.width / 2, 40)];
    self.passwordField.placeholder = @"Password";
    self.passwordField.secureTextEntry = YES;
    self.passwordField.layer.borderWidth = 1.0f; // 边框宽度
    self.passwordField.layer.borderColor = [UIColor blackColor].CGColor; // 边框颜色
    self.passwordField.layer.cornerRadius = 5.0f; // 边框圆角
    [self.view addSubview:self.passwordField];
      
    // 创建登录按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton setFrame:CGRectMake(0, self.passwordField.frame.origin.y + self.passwordField.frame.size.height, self.view.frame.size.width, 40)];
    [self.loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
      
    // 设置Auto Layout约束
    NSDictionary *views = @{
        @"usernameField": self.usernameField,
        @"passwordField": self.passwordField,
        @"loginButton": self.loginButton
    };
      
    // 垂直约束
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[usernameField(40)]-[passwordField(40)]-[loginButton(40)]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views];
    [self.view addConstraints:verticalConstraints];
      
    // 水平约束
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[usernameField]|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:views];
    [self.view addConstraints:horizontalConstraints];
      
    // 添加更多水平约束，例如密码字段和登录按钮
    horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[passwordField]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:views];
    [self.view addConstraints:horizontalConstraints];
      
    horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[loginButton]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:views];
    [self.view addConstraints:horizontalConstraints];
}
  
- (void)loginButtonPressed {
    // 登录按钮点击事件处理
    NSLog(@"Login button pressed");
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
      
          
    // 判空处理
    if ([username length] == 0 || [password length] == 0) {
        [self showAlertWithTitle:@"错误" message:@"用户名和密码不能为空"];
        return;
    }
          
    // 模拟验证用户信息，实际应用中这里应该是与服务器通信
    BOOL isUserValid = [self validateUser:username password:password];
          
    if (!isUserValid) {
        // 判断用户不存在或密码错误
        if ([username isEqualToString:@"nonexistent"]) {
            [self showAlertWithTitle:@"错误" message:@"用户不存在"];
        } else {
            [self showAlertWithTitle:@"错误" message:@"密码错误"];
        }
        return;
    }
          
    // 登录成功处理
    [self loginSuccessfulWithUser:username];
}
      
// 模拟验证用户信息的方法，实际应用中应该替换为与服务器通信的代码
- (BOOL)validateUser:(NSString *)username password:(NSString *)password {
    if ([username isEqualToString:@"1"] && [password isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
}
// 显示弹窗的方法
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 处理用户点击"确定"按钮后的逻辑
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
      
// 登录成功后的处理方法
- (void)loginSuccessfulWithUser:(NSString *)username {
    // 这里可以添加登录成功后的逻辑，比如跳转到其他页面
    MainViewViewController *mainView = [[MainViewViewController alloc] init];
    MineViewController *mineView = [[MineViewController alloc] init];
    
    mainView.title = @"主页";
    mineView.title = @"我的";
    
    UITabBarController* tbController = [[UITabBarController alloc] init];
    
    NSArray *viewArray = [NSArray arrayWithObjects:mainView, mineView, nil];
    tbController.viewControllers = viewArray;
        
    tbController.selectedIndex = 0;
    //设置分栏控制器的工具栏的透明度
    tbController.tabBar.translucent = YES;
        
    //改变工具栏颜色
//    tbController.tabBar.barTintColor = [UIColor redColor];
    //更改按钮风格颜色
    tbController.tabBar.tintColor = [UIColor blackColor];
    
//    MainViewViewController *mainView = [[MainViewViewController alloc] init];
//    mainView.modalPresentationStyle = UIModalPresentationFullScreen;
    tbController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:tbController animated:YES completion:nil];
    NSLog(@"登录成功，用户：%@", username);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 当用户开始编辑时，清空文本字段
    if ([textField.text isEqualToString:@"Username"]) {
        textField.text = @"";
    }
}

  
@end
