//
//  MainViewFlowLayout.m
//  HealthyDiet
//
//  Created by ByteDance on 2024/3/6.
//

#import "MainViewFlowLayout.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface MainViewFlowLayout ()

//section的数量
@property (nonatomic) NSInteger numberOfSections;

//section中Cell的数量
@property (nonatomic) NSInteger numberOfCellsInSections;

//瀑布流的行数
@property (nonatomic) NSInteger columnCount;

//cell边距
@property (nonatomic) NSInteger padding;

//cell的最小高度
@property (nonatomic) NSInteger cellMinHeight;

//cell的最大高度，最大高度比最小高度小，以最小高度为准
@property (nonatomic) NSInteger cellMaxHeight;

//cell的宽度
@property (nonatomic) CGFloat cellWidth;

//存储每列Cell的X坐标
@property (strong, nonatomic) NSMutableArray *cellXArray;

//存储每个cell的随机高度，避免每次加载的随机高度都不同
@property (strong, nonatomic) NSMutableArray *cellHeightArray;

//记录每列Cell的最新Cell的Y坐标
@property (strong, nonatomic) NSMutableArray *cellYArray;

/// attributes数组
@property (nonatomic, strong) NSMutableArray *attributesArray;




@end

@implementation MainViewFlowLayout

#pragma mark -- <UICollectionViewLayout>虚基类中重写的方法

/**
 * 该方法是预加载layout, 只会被执行一次
 */
- (void)prepareLayout{
    [super prepareLayout];
    
    [self initData];
    
    [self initCellWidth];
    
    //[self initCellHeight];
    
}

/** 懒加载 */
-(NSMutableDictionary *)maxYDic
{
    if (!_maxYDic)
    {
        _maxYDic = [NSMutableDictionary dictionary];
    }
    return _maxYDic;
}

/** 懒加载 */
-(NSMutableArray *)cellHeightArray
{
    if (!_cellHeightArray)
    {
        _cellHeightArray = [NSMutableArray array];
    }
    return _cellHeightArray;
}


/**
 * 该方法返回CollectionView的ContentSize的大小
 */
- (CGSize)collectionViewContentSize{
    
    CGFloat height = [self maxCellYArrayWithArray:_cellYArray];
    
    return CGSizeMake(SCREEN_WIDTH,  height);
}
/**
 * 初始化相关数据
 */
- (void)initData {
    _numberOfSections = [self.collectionView numberOfSections];
    _numberOfCellsInSections = [self.collectionView numberOfItemsInSection:0];
    _columnCount = 2;
    _padding = 2;
    _cellMinHeight = 50;
    _cellMaxHeight = 200;
    _imageHeight = [[NSMutableArray alloc] init];
    for (int i = 0; i < _numberOfCellsInSections; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

/**
 * 根据Cell的列数求出Cell的宽度
 */

- (void)initCellWidth{
    //计算每个Cell的宽度
    _cellWidth = (SCREEN_WIDTH - (_columnCount -1) * _padding) / _columnCount;
    
    //为每个Cell计算X坐标
    _cellXArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
    for (int i = 0; i < _columnCount; i ++) {
        
        CGFloat tempX = i * (_cellWidth + _padding);
        
        [_cellXArray addObject:@(tempX)];
    }
    
}

/**
 * 随机生成Cell的高度
 */
//- (void)initCellHeight {
//    
//    //随机生成Cell的高度
//    _cellHeightArray = [[NSMutableArray alloc] initWithCapacity:_numberOfCellsInSections];
//    for (int i = 0; i < _numberOfCellsInSections; i ++) {
//        //CGFloat cellHeight = arc4random() % (_cellMaxHeight - _cellMinHeight) + _cellMinHeight;
//        
//        //        id cellHeight = self.imageHeight[i];
//        CGFloat cellHeight = 300;
//        [_cellHeightArray addObject:@(cellHeight)];
//    }
//    
//}

/**
 * 初始化每列Cell的Y轴坐标
 */
- (void) initCellYArray{
    if (_cellYArray == nil) {
        _cellYArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
        
    }
    for (int i = 0; i < _columnCount; i ++) {
        _cellYArray[i] = @(0);
    }
    
}



/**
 * 求CellY数组中的最大值并返回
 */
- (CGFloat) maxCellYArrayWithArray: (NSMutableArray *) array{
    if (array.count == 0) {
        return 0.0f;
    }
    
    CGFloat max = [array[0] floatValue];
    for (NSNumber *number in array) {
        
        CGFloat temp = [number floatValue];
        
        if (max < temp) {
            max = temp;
        }
    }
    
    return max;
}

/**
 * 求CellY数组中的最小值的索引
 */
- (CGFloat) minCellYArrayWithArray: (NSMutableArray *) array{
    
    if (array.count == 0) {
        return 0.0f;
    }
    
    NSInteger minIndex = 0;
    CGFloat min = [array[0] floatValue];
    
    for (int i = 0; i < array.count; i ++) {
        CGFloat temp = [array[i] floatValue];
        
        if (min > temp) {
            min = temp;
            minIndex = i;
        }
    }
    
    return minIndex;
}

/**
 * 该方法为每个Cell绑定一个Layout属性~
 */


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect frame = CGRectZero;
    CGFloat itemWidth = self.itemWidth;
    //CGFloat cellHeight = [_cellHeightArray[indexPath.row] floatValue];
    CGFloat cellHeight = [self.delegatel heightForItemAtIndexPath:indexPath];
    //CGFloat cellheight = [self.dataSource waterFallLayout:self itemHeightForItemWidth:itemWidth atIndexPath:attributes.indexPath];
    
    NSInteger minYIndex = [self minCellYArrayWithArray:_cellYArray];
    
    CGFloat tempX = [_cellXArray[minYIndex] floatValue];
    
    CGFloat tempY = [_cellYArray[minYIndex] floatValue];
    
    frame = CGRectMake(tempX, tempY, _cellWidth, cellHeight);
    
    //更新相应的Y坐标
    _cellYArray[minYIndex] = @(tempY + cellHeight + _padding);
    
    //计算每个Cell的位置
    attributes.frame = frame;
    
    return attributes;
}

/**
 * 该方法为每个Cell绑定一个Layout属性~
 */
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    
//    [self initCellYArray];
//    
//    NSMutableArray *array = [NSMutableArray array];
//    
//    //add cells
//    for (int i=0; i < _numberOfCellsInSections; i++)
//    {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        
//        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
//        
//        [array addObject:attributes];
//    }
//    
//    return array;
//    
//}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray<UICollectionViewLayoutAttributes *> *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *newAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        UICollectionViewLayoutAttributes *newAttribute = [attribute copy];
        if (newAttribute.representedElementCategory == UICollectionElementCategoryCell) {
            UIEdgeInsets insets = self.sectionInset;
            newAttribute.frame = CGRectMake(attribute.frame.origin.x, attribute.frame.origin.y, attribute.frame.size.width, attribute.frame.size.height);
            [newAttributes addObject:newAttribute];
        }
    }
    return newAttributes;
}


@end
