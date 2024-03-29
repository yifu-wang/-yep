//
//  MineImageTableViewCell.m
//  HealthyDiet
//
//  Created by ByteDance on 2024/3/25.
//

#import "MineImageTableViewCell.h"


#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@implementation MineImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.userLabel];
        //[self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.imageButton];
    }
    
    return self;
}

- (UIButton *)imageButton {
    if (_imageButton == nil) {
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.frame = CGRectMake(0, 25, 100.0, 100.0);
        _imageButton.layer.cornerRadius = _imageButton.frame.size.width / 2;
        _imageButton.center = CGPointMake(screenWidth / 2, 45);
        _imageButton.layer.masksToBounds = YES;
        [_imageButton addTarget:self action:@selector(changeHeadImage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _imageButton;
}

- (void)changeHeadImage:(UIButton *)imageButton {
    if (self.didTapButtonBlock) {
        self.didTapButtonBlock(self);
    }
}

//- (UIImageView *)headImageView
//{
//    
//    if(_headImageView == nil){
//        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 100.0, 100.0)];
//        _headImageView.layer.cornerRadius = _headImageView.frame.size.width / 2;
////        _headImageView.contentMode =  UIViewContentModeCenter;
//        _headImageView.center = CGPointMake(screenWidth / 2, 45);
//
//        _headImageView.layer.masksToBounds = YES;
//        
//    }
//    
//    return _headImageView;
//    
//}

-(UILabel *)userLabel
{
    
    if(_userLabel == nil){
        _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2.16, 100, 100, 40)];
        _userLabel.textAlignment = NSTextAlignmentCenter;
        _userLabel.textColor = [UIColor blackColor];
        _userLabel.font = [UIFont systemFontOfSize:17];
        _userLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _userLabel;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
