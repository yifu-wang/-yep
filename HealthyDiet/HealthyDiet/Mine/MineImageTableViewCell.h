//
//  MineImageTableViewCell.h
//  HealthyDiet
//
//  Created by ByteDance on 2024/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineImageTableViewCell : UITableViewCell <UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic, strong) UILabel *userLabel;//名字label
@property (nonatomic, strong) UIImageView *headImageView;//头像ImageView
@property (nonatomic, strong) UIButton *imageButton;
//换头像回调
@property (nonatomic, copy) void(^didTapButtonBlock)(MineImageTableViewCell *cell);


@end

NS_ASSUME_NONNULL_END
