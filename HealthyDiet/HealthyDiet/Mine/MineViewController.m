//
//  MineViewController.m
//  HealthyDiet
//
//  Created by ByteDance on 2024/3/25.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MineImageTableViewCell.h"
// 系统相机
#import <AVFoundation/AVFoundation.h>
// 系统相册
#import <AssetsLibrary/AssetsLibrary.h>
@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
//    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 20)];
//    usernameLabel.text = @"张三"; // 假设这是从服务器获取的用户名
//    usernameLabel.textColor = [UIColor blackColor];
//    [self.view addSubview:usernameLabel];
    _titleString = [NSArray arrayWithObjects:@"我的信息", @"版本更新", @"我上传的", @"我的菜谱", @"设置", @"退出", nil];
    
    self.mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    self.mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.mineTableView.delegate = self;
    self.mineTableView.dataSource = self;
    self.chageHeadImage = [UIImage imageNamed:@"gjj.jpg"];

    
    [self.view addSubview:self.mineTableView];
    
    [self.mineTableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"mineTableViewCell"];
    [self.mineTableView registerClass:[MineImageTableViewCell class] forCellReuseIdentifier:@"mineImageTableViewCell"];
    
   
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MineImageTableViewCell *mineImageTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"mineImageTableViewCell" forIndexPath:indexPath];
        mineImageTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        mineImageTableViewCell.userLabel.text = @"Yep";
        [mineImageTableViewCell.imageButton setImage:self.chageHeadImage forState:UIControlStateNormal];
        //[mineImageTableViewCell.headImageView setImage:[UIImage imageNamed:@"gjj.jpg"]];
        //[mineImageTableViewCell.imageButton addTarget:self action:@selector(changeHeadImage:) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
        mineImageTableViewCell.didTapButtonBlock = ^(MineImageTableViewCell *cell) {
            __strong typeof(self) strongSelf = weakSelf;

            [strongSelf changeHeadImage];
//            [strongSelf.mineTableView reloadData];
        };
        return mineImageTableViewCell;
    } else {
        MineTableViewCell *mineTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"mineTableViewCell" forIndexPath:indexPath];
        mineTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *name = [[NSString alloc] initWithFormat:@"image%ld.png", indexPath.row + 1];
        [mineTableViewCell.headView setImage:[UIImage imageNamed:name]];
        mineTableViewCell.nameLabel.text = _titleString[indexPath.row];
        return mineTableViewCell;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 6;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 60;
    }
}

- (void)changeHeadImage {
    NSLog(@"用户请求更换头像");
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    //创建sheet提示框，提示选择相机还是相册
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请选择照片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //选择相机时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
      //    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //跳转到UIImagePickerController控制器弹出相机
        [self presentViewController:imagePicker animated:YES completion:nil];
       
    }];

    //相册选项
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        //选择相册时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //跳转到UIImagePickerController控制器弹出相册
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];

    //取消按钮
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
        //添加各个按钮事件
        [alert addAction:camera];
        [alert addAction:photo];
        [alert addAction:cancel];
        //弹出sheet提示框
        [self presentViewController:alert animated:YES completion:nil];

  
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    self.chageHeadImage = image;
    [self.mineTableView reloadData];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
