//
//  MainViewFlowLayout.h
//  HealthyDiet
//
//  Created by ByteDance on 2024/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol WaterFlowLayoutDelegate <NSObject>

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@class MainViewFlowLayout;

@protocol MainViewFlowLayoutDataSource <NSObject>

@required
/// 获取item高度，返回itemWidth和indexPath去获取
- (CGFloat)waterFallLayout: (MainViewFlowLayout *)layout itemHeightForItemWidth: (CGFloat)itemWidth atIndexPath: (NSIndexPath *)indexPath;

@end

@interface MainViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) id<WaterFlowLayoutDelegate>delegatel;
@property (nonatomic, weak) id<MainViewFlowLayoutDataSource> dataSource;
@property (nonatomic, readonly) CGFloat itemWidth;

/** 存放每一个item的布局属性 */
@property (nonatomic, strong) NSMutableArray *imageHeight;

@property (nonatomic, strong) NSMutableDictionary *maxYDic;



@end

NS_ASSUME_NONNULL_END
