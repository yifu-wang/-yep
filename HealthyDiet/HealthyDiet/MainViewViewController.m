//
//  MainViewViewController.m
//  HealthyDiet
//
//  Created by ByteDance on 2024/3/6.
//

#import "MainViewViewController.h"
#import "MainViewFlowLayout.h"
#import "MainViewCollectionViewCell.h"
#include "LMHWaterFallLayout.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface MainViewViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MainViewFlowLayoutDataSource, WaterFlowLayoutDelegate, LMHWaterFallLayoutDeleaget>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imagesHeight;

@property (nonatomic, weak) id<LMHWaterFallLayoutDeleaget> delegate;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *titleArray;



@end

@implementation MainViewViewController
- (void)viewDidLoad {
    [super viewDidLoad];
      
    // 创建自定义布局
    _imagesHeight = [[NSMutableArray alloc] init];
    MainViewFlowLayout *layout = [[MainViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10; // 列间距
    layout.minimumLineSpacing = 10; // 行间距
    layout.imageHeight = _imagesHeight;
    
    
    LMHWaterFallLayout *newLayout = [[LMHWaterFallLayout alloc] init];
//    newLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    newLayout.minimumInteritemSpacing = 10; // 列间距
//    newLayout.minimumLineSpacing = 10; // 行间距
    newLayout.delegate = self;
         
    // 创建collectionView
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2000) collectionViewLayout:layout];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:newLayout];
    //self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 40) collectionViewLayout:newLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
//    self.delegate = self;
    //self.collectionView.backgroundColor = [UIColor blueColor];
    
    [self.collectionView registerClass:[MainViewCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    self.imagesArray = [[NSArray alloc] initWithObjects:@"food1.jpeg", @"food2.jpeg", @"food3.jpeg", @"food4.jpeg", @"food5.jpeg", @"food6.jpeg", @"food7.jpeg", @"food8.jpeg", @"food9.jpeg", nil];
    
    self.titleArray = [[NSArray alloc] initWithObjects:@"来一碗油泼面，秦人集合！", @"水煮牛肉也太下饭了", @"不知道吃啥就来一碗卤肉饭吧", @"减脂低卡的番茄丸子锅", @"香喷喷的小猪盖被", @"老北京炸酱面，那叫一个地道",  @"教你来做家庭版的支竹烧牛腩", @"中国人的意大利面", @"到了一定年纪就要开始养生了", nil];
        
    // 添加collectionView到view
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];

}
     
#pragma mark - UICollectionViewDataSource
     
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1; // 假设只有一个section
}
     
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 返回你的数据数量
    return self.imagesArray.count;
}
  
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
      
    // 配置cell，例如加载图片
    //cell.backgroundColor = [UIColor redColor];
  //  NSString *foodName = [[NSString alloc] initWithFormat:@"food%ld.jpeg", indexPath.row + 1];
    //NSString *foodName = [[NSString alloc] init];
//    foodName = self.imagesArray[ind]
    cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    CALayer *layer = cell.layer;
         
    // 设置圆角的半径
    layer.cornerRadius = 10.0; // 你可以根据需要调整这个值
         
    // 设置masksToBounds为YES，以确保内容被裁剪到边界内，从而显示圆角效果
    layer.masksToBounds = YES;
         
    // 如果需要边框效果，可以设置borderWidth和borderColor
    layer.borderWidth = 0.5;
    layer.borderColor = [UIColor whiteColor].CGColor;
    cell.imageView.image = [UIImage imageNamed:self.imagesArray[indexPath.row]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.imageView.clipsToBounds = true;
//    if (indexPath.row > 6) {
//        cell.imageView.image = [UIImage imageNamed:@"gjj.jpg"];
//    } 
//    
    cell.foodLabel.text = self.titleArray[indexPath.row];
    CGFloat height = cell.imageView.image.size.height;
    [_imagesHeight addObject:@(height)];
    return cell;
}
  
#pragma mark - UICollectionViewDelegateFlowLayout
  
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    // 根据需要调整每个item的尺寸
//    NSString *foodName = [[NSString alloc] initWithFormat:@"food%ld.jpeg", indexPath.row + 1];
//    UIImage *image = [UIImage imageNamed:foodName];
//    CGFloat imageHeight = image.size.height;
//    CGFloat imageWidth = image.size.width;
//    
//    CGFloat cellWidth = collectionView.bounds.size.width / 2; // You may adjust this value based on your layout
//    CGFloat scaleFactor = cellWidth / imageWidth;
//    CGFloat cellHeight = imageHeight * scaleFactor + 50;
//    return CGSizeMake(cellWidth, cellHeight);
////    return CGSizeMake((collectionView.bounds.size.width - 20) / 2, collectionView.bounds.size.height - 20);
//    // 假设左右边距和上下边距各为10
//}


  
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    // 设置section的间距
//    return UIEdgeInsetsMake(10, 10, 10, 10); // 上下左右边距各为10
//}

  
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 处理选中事件
    // 例如跳转到详情页
} 

//- (CGFloat)waterFallLayout:(MainViewFlowLayout *)layout itemHeightForItemWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
//    NSString *foodName = [[NSString alloc] initWithFormat:@"food%ld.jpeg", indexPath.row + 1];
//    UIImage *image = [UIImage imageNamed:foodName];
//    CGFloat imageHeight = image.size.height;
//    return imageHeight;
//}
//- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *foodName = [[NSString alloc] initWithFormat:@"food%ld.jpeg", indexPath.row + 1];
//    UIImage *image = [UIImage imageNamed:foodName];
//    CGFloat imageHeight = image.size.height;
//    return imageHeight;
//}

- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth {
    NSString *foodName = [[NSString alloc] initWithFormat:@"food%ld.jpeg", indexPath + 1];
    UIImage *image = [UIImage imageNamed:foodName];
    CGFloat imageHeight = image.size.height;
    return imageHeight;
}

- (CGSize)layout:(LMHWaterFallLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *foodName = [[NSString alloc] initWithFormat:@"food%ld.jpeg", indexPath.row + 1];
    UIImage *image = [UIImage imageNamed:foodName];
    CGFloat imageHeight = image.size.height;
    CGFloat imageWidth = image.size.width;
    return CGSizeMake(imageWidth, imageHeight);
}
@end
