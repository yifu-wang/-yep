//
//  MainViewCollectionViewCell.m
//  HealthyDiet
//
//  Created by ByteDance on 2024/3/6.
//

#import "MainViewCollectionViewCell.h"

@implementation MainViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化imageView
//        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.foodLabel];
    }
    return self;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
//        CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width / 2; // You may adjust this value based on your layout
//        CGFloat scaleFactor = cellWidth / self.imageView.bounds.size.width;
//        CGFloat cellHeight = self.imageView.bounds.size.height * scaleFactor;
//        self.imageView.bounds = CGRectMake(self.imageView.bounds.origin.x,
//                                             self.imageView.bounds.origin.y,
//                                             cellWidth,
//                                             cellHeight);
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    }
    
    return _imageView;
    
}

- (UILabel *)foodLabel {
    if (_foodLabel == nil) {
        _foodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        _foodLabel.textColor = [UIColor blackColor];
    }
    return _foodLabel;
}

@end
